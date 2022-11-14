// ignore_for_file: prefer_const_constructors, sort_child_properties_last, constant_identifier_names, unnecessary_brace_in_string_interps

import 'dart:convert';
import 'dart:developer';
import 'dart:async';
import 'dart:io';
import 'package:alkitab/listrencanauser.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './listalkitab.dart';
import './mergeayat.dart';
import './listcatatan.dart';
import './listrenungan.dart';
import './searchalkitab.dart';
import './loginpage.dart';
import './catatanpage.dart';
import './explore.dart';
import './listkomunitas.dart';
import './logininput.dart';
import './renunganpage.dart';
import './global.dart' as globals;
import './profilepage.dart';
import 'dart:math' as mat;
import 'package:custom_selectable_text/custom_selectable_text.dart';
import 'package:measured_size/measured_size.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flame_audio/flame_audio.dart';

class Stiker {}

// ignore: camel_case_types
class cAyat {
  int? indexAyat_;
  String? status_; //perikop atau isi
  String? isi_;
  bool? selected_ = false;

  cAyat({this.indexAyat_, this.status_, this.isi_});

  // ignore: no_leading_underscores_for_local_identifiers
  set setIndexAyat(int _indexAyat) {
    indexAyat_ = _indexAyat;
  }

  // ignore: no_leading_underscores_for_local_identifiers
  set setStatus(String _status) {
    status_ = _status;
  }

  // ignore: no_leading_underscores_for_local_identifiers
  set setIsi(String _isi) {
    isi_ = _isi;
  }

  set setSelected(bool selected) {
    selected_ = selected;
  }

  get getIndexAyat {
    return indexAyat_;
  }

  get getSelected {
    return selected_;
  }

  get getStatusAyat {
    return status_;
  }

  get getIsiAyat {
    return isi_;
  }
}

// ignore: camel_case_types
class cPasal {
  late final int indexPasal_;
  //int? jumlahPerikop_;
  late final int jumlahAyat_;
  //List<cAyat>? listAyat_;

  cPasal({
    required this.indexPasal_,
    //this.jumlahPerikop_,
    required this.jumlahAyat_,
    //this.listAyat_
  });

  set setIndexPasal(int indexPasal) {
    indexPasal_ = indexPasal;
  }

  // set setJumlahPerikop(int jumlahPerikop){
  //   jumlahPerikop_=jumlahPerikop;
  // }

  // ignore: no_leading_underscores_for_local_identifiers
  set setJumlahAyat(int _jumlahAyat) {
    jumlahAyat_ = _jumlahAyat;
  }

  // set setListAyat(List<cAyat> _listAyat){
  //   listAyat_=_listAyat;
  // }

  int? get getIndexPasal {
    return indexPasal_;
  }

  // int? get getJumlahPerikop{
  //   return jumlahPerikop_;
  // }
  int? get getJumlahAyat {
    return jumlahAyat_;
  }
  // List? get getListAyat{
  //   return listAyat_;
  // }

  // info(){
  //   print("$indexPasal_");
  //   print("$indexPasal_");
  //   print("$indexPasal_");
  // }

}

// ignore: camel_case_types
class cCatatan {
  List<cSelected>? listCatatan;

  cCatatan({this.listCatatan});

  List<cSelected>? get getindexkitab {
    return listCatatan;
  }
}

class Underlined {
  String? namakitab;
  String? pasal;
  String? ayat;
  List? listIsiAyat;

  Underlined({this.namakitab, this.pasal, this.ayat, this.listIsiAyat});

  // String? get getkonten {
  //   return konten;
  // }

  // String? get getnamakitab {
  //   return namaKitab;
  // }

  // Color? get getindexcolor {
  //   return indxColor;
  // }
}

// ignore: camel_case_types
class cSelected {
  int? indxKitab;
  int? indxPasal;
  int? indxAyat;
  Color? indxColor;
  String? konten;
  String? namaKitab;

  cSelected(
      {this.indxKitab,
      this.indxPasal,
      this.indxAyat,
      this.indxColor,
      this.konten,
      this.namaKitab});

  void setColor(Color indexColor) {
    indxColor = indexColor;
  }

  // ignore: no_leading_underscores_for_local_identifiers
  void setKonten(String _konten) {
    konten = _konten;
  }

  int? get getindexkitab {
    return indxKitab;
  }

  int? get getindexpasal {
    return indxPasal;
  }

  int? get getindexayat {
    return indxAyat;
  }

  String? get getkonten {
    return konten;
  }

  String? get getnamakitab {
    return namaKitab;
  }

  Color? get getindexcolor {
    return indxColor;
  }
}

class CSticker {
  double? posisix;
  double? posisiy;
  String? imagepath;
  String? lokasikitab;
  int? lokasipasal;
  Positioned? posisistiker;
  Positioned? stackstiker;
  //String? statusSticker;

  CSticker(
      {this.posisix,
      this.posisiy,
      this.imagepath,
      this.lokasikitab,
      this.lokasipasal,
      this.posisistiker,
      this.stackstiker
      //,this.statusSticker
      });
}

class LogoutTimerModel {
  late DateTime timestamp;

  void updateTimestamp(DateTime timestamp) {
    this.timestamp = timestamp;
  }
}

// ignore: camel_case_types
class cKitab {
  String? namaKitab_;
  int? jumlahPasal_;
  List? listPasal_;
  List<List>? listPasalAyat_;
  //List<cPasal>? listPasal_;//GABISAA DIPAKAI MASIHAN

  cKitab(
      {this.namaKitab_, this.jumlahPasal_, this.listPasal_, this.listPasalAyat_
      //this.listPasal_
      });

  set setNamaKitab(String namaKitab) {
    namaKitab_ = namaKitab;
  }

  // set setListPasal(List<cPasal> listPasal){
  //   listPasal_=listPasal;
  // }

  String? get getNamaKitab {
    return namaKitab_;
  }

  int? get getjumlahPasal {
    return jumlahPasal_;
  }

  List? get getListPasal {
    return listPasal_;
  }

  List<List>? get getListPasalAyat {
    return listPasalAyat_;
  }

  // void setStatusAyat(int indexkitab, int indexpasal, int indexayat, int status){
  //   listPasalAyat_![indexkitab][indexpasal][indexayat] = status;
  // }

  void setListPasal(List listPasalPerKitab) {
    listPasal_ = listPasalPerKitab;
  }

  // void setListPasal(List<cPasal> listPasalPerKitab) {
  //   listPasal_=listPasalPerKitab;
  // }

  //void setListPasal(List<cPasal> listPasalPerKitab) {}

}

// class cAlkitab{
//   List<cKitab>? listKitab_;
//   cAlkitab({
//     this.listKitab_,
//   });

//   set setListKitab(List<cKitab> _listKitab){
//     listKitab_=_listKitab;
//   }

//   get getListKitab{
//     return listKitab_;
//   }
// }

// cPasal pasalC = cPasal();
// List<cPasal> listPasalPerKitab = [];

// cKitab kitabC = cKitab();
// List<cKitab> listNamaKitab = [];

enum MenuSelected { Highlight, Catatan, Renungan }

class HomePage extends StatefulWidget {
  final int? indexKitabdicari;
  final int? pasalKitabdicari;
  final int? ayatKitabdicari;
  final String? daripagemana;
  const HomePage(
      {super.key,
      required this.indexKitabdicari,
      required this.pasalKitabdicari,
      required this.ayatKitabdicari,
      required this.daripagemana});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  late Color screenPickerColor;
  // Color for the picker in a dialog using onChanged.
  //late Color dialogPickerColor;
  // Color for picker using the color select dialog.
  //late Color dialogSelectColor;
  String getNamaKitab(int indexkitab) {
    String namakitabtemp = "lala";
    //int countindexbaru = 0;
    //int jumlahkitab = 0;
    List temp = [];

    for (int i = 0; i < alkitab.length; i++) {
      if (namakitabtemp != alkitab[i]['book']) {
        temp.add(alkitab[i]['book'].toString());
        //countindexbaru++;
        namakitabtemp = alkitab[i]['book'];
        //jumlahkitab++;
      }
    }

    namakitabtemp = temp[indexkitab];

    return namakitabtemp;
  }

  List alkitab = []; //dari json
  List listSemuaNamaKitab = [];

  List selectedAyat = [];
  List highlightUser = [];
  int jumlahHighlightUser = 0;
  int jumlahayatdiselect = 0;
  int indexTerakhirKelompokHighlight = 0;
  int yangSudahDimasukinKeFile = 0;

  // String dataHighlight = '';
  // List listTempHighlightData = [];
  String dataBookMarked = '';
  List listbookMarkedJson = [];
  List listbookMarked = [];
  int jumlahBookMarked = 0;

  //List

  List ayatPerPasal = [];

  String kitabsebelumnya = "";

  late Color mycolor;

  // ignore: non_constant_identifier_names, unnecessary_new
  cKitab Kitab_ = new cKitab();
  // ignore: non_constant_identifier_names, unnecessary_new
  cAyat Ayat_ = new cAyat();

  // // SHARED PREFERENCES AYAT RANDOM BACAAN
  List listAyatBacaanRandomLokal = [
    "TUHAN akan menuntun engkau senantiasadan akan memuaskan hatimu di tanah yang kering, dan akan membaharui kekuatanmu;engkau akan seperti taman yang diairi dengan baik dan seperti mata air yang tidak pernah mengecewakan. Yesaya 58 : 11",
    "Dengan panjang umur akan Kukenyangkan dia, dan akan Kuperlihatkan kepadanya keselamatan dari pada-Ku. Mazmur 91 : 16",
    "sebab malaikat-malaikat-Nya akan diperintahkan-Nya kepadamu untuk menjaga engkau di segala jalanmu. Mazmur 91 : 11"
  ];

  late int indexRandomAyatBacaanSP;
  //List<String> listAyatBacaanRandomSP = [];
  late int indexRandomAyatBacaan;
  late String bacaanRandomHariIni;
  bool resetAyatBacaan = false;

  addAyatBacaanRandomSP() async {
    indexRandomAyatBacaanSP = indexRandomAyatBacaan;
    SharedPreferences ayatBacaanRandomSP =
        await SharedPreferences.getInstance();
    ayatBacaanRandomSP.setInt('AyatBacaanRandom', indexRandomAyatBacaanSP);
    addTanggalSP();
  }

  getAyatBacaanRandomSP() async {
    getTanggalSP();
    SharedPreferences ayatBacaanRandomSP =
        await SharedPreferences.getInstance();
    indexRandomAyatBacaanSP =
        ayatBacaanRandomSP.getInt('AyatBacaanRandom') ?? -99;
    log("add ayat bacaan random $indexRandomAyatBacaanSP");
    return indexRandomAyatBacaanSP;
  }

  late int tanggaldariSP;
  late int tanggal;

  Future<void> gettanggalsekarang() async {
    var date = DateTime.now().toUtc().toIso8601String();
    DateTime dateTime = DateTime.parse(date).toLocal();
    int currentDay = DateTime.now().day;
    tanggal = currentDay;
  }

  addTanggalSP() async {
    await gettanggalsekarang();

    tanggaldariSP = tanggal;
    log("add ayat bacaan random tanggal sekarang $tanggal ");

    SharedPreferences tanggalSP = await SharedPreferences.getInstance();
    tanggalSP.setInt('tanggal', tanggaldariSP);
  }

  getTanggalSP() async {
    await gettanggalsekarang();
    SharedPreferences tanggalSP = await SharedPreferences.getInstance();
    tanggaldariSP = tanggalSP.getInt('tanggal') ?? -99;

    // //log("add ayat bacaan random $indexRandomAyatBacaanSP");
    // return indexRandomAyatBacaanSP;
  }

  Future<void> getAyatHariIni() async {
    if (resetAyatBacaan == true) {
      indexRandomAyatBacaan = 0;
      bacaanRandomHariIni = listAyatBacaanRandomLokal[indexRandomAyatBacaan];
      addAyatBacaanRandomSP();
    }

    await getAyatBacaanRandomSP();
    await getTanggalSP();
    log("add ayat bacaan random $tanggal $tanggaldariSP");

    if (tanggal != tanggaldariSP) {
      setState(() {
        log("add ayat bacaan random  masuk beda hari");
        mat.Random random = mat.Random();
        int randomNumber = random.nextInt(listAyatBacaanRandomLokal.length);
        while (randomNumber == indexRandomAyatBacaanSP) {
          randomNumber = random.nextInt(listAyatBacaanRandomLokal.length);
        }
        indexRandomAyatBacaan = randomNumber;
        bacaanRandomHariIni = listAyatBacaanRandomLokal[randomNumber];
        addAyatBacaanRandomSP();
      });
    } else {
      setState(() {
        log("add ayat bacaan random  masuk hari sama $indexRandomAyatBacaanSP");
        indexRandomAyatBacaan = indexRandomAyatBacaanSP;
        bacaanRandomHariIni = listAyatBacaanRandomLokal[indexRandomAyatBacaan];
      });
    }
  }

  void getAlkitab() {
    //nama2 kitab
    //jumlah pasal
    //jumat ayat

    getAllDataFromJson();

    for (int i = 0; i < alkitab.length; i++) {
      if (alkitab[i]["book"] != kitabsebelumnya) {
        //belom hehe
      }
    }
  }

  PageController pageController = PageController(initialPage: 0);

  // TextEditingController kitabcontroller = TextEditingController();
  // TextEditingController pasalcontroller = TextEditingController();
  // TextEditingController ayatcontroller = TextEditingController();
  // TextEditingController ayatakhircontroller = TextEditingController();
  // String tampilanNamaKitab = 'Kejadian';
  // String tampilanPasalKitab = '1';
  // String tampilanAyat1 = '1';
  // String tampilanAyat2 = '2';
  int indexKitabDiCari = 0;
  // String namakitabdicari = "Kejadian";
  // String pasalkitab = "1";
  // String ayatkitab = "1";

  String namakitabdicari = "Kejadian";
  String pasalkitab = "2";
  String ayatkitab = "2";

  // ignore: non_constant_identifier_names
  final ScrollDirectionn = Axis.vertical;
  late AutoScrollController? controllerscroll;
  //ScrollController scrollController = ScrollController();
  bool fabIsVisible = true;

  late int counttitleuntukscrollviewayat;
  int lastpasal = 0;
  int indexmulaikitab = 0;

  List kitabTertentu = [];
  List<List> satukitabperpasal = [];

  List<Widget> page = [];

  int dataperkitab = 0;
  String namakitabsebelumnya = '';

  //untuk pencarian search dengan ayat berapa sampe berapa
  List pencarianAyatTertentu = [];

  bool stickermode = false;
  int banyakposisi = 0;
  double posx = 0;
  double posy = 0;
  String stickerselected = "";
  String fabopenicon = "assets/heart.png";
  List listposition = [];

  // PageController pageController = PageController(initialPage: 0);
  // List<Widget> page = [];

  //String Txt = "Tap Here To Start!";
  List<Widget> sticker = [];
  int pagesekarang = 0;

  // ignore: non_constant_identifier_names
  bool sticker_mode = true;

  bool backsound_mode = false;
  // final player = AudioPlayer();
  // bool isPlaying = false;

  // AudioPlayer? _player;

  // void _playBackMusic(){
  //   _player!.dispose();
  //   final player = _player = AudioPlayer();
  //   player.play(AssetSource('assets/lagu/hereimtoworship.mp3'));
  // }

  // void deleteStiker(String imagepath, String namakitab, int pasal,
  //     double posisix, double posisiy) async {
  //   log("stiker dihapus masuk func");
  //   late int indexdihapus;
  //   for (int i = 0; i < listposition.length; i++) {
  //     if (listposition[i].imagepath == imagepath &&
  //         listposition[i].lokasikitab == namakitab &&
  //         listposition[i].lokasipasal == pasal &&
  //         listposition[i].posisix == posisix &&
  //         listposition[i].posisiy == posisiy) {
  //       log("stiker dihapussss");
  //       indexdihapus = i;
  //       break;
  //     }
  //   }
  //   listposition.removeAt(indexdihapus);
  //   await updateStickerSP(indexdihapus);
  //   addPages("sticker");
  // }

  void onTapDown(BuildContext context, TapDownDetails details) async {
    final RenderBox box = context.findRenderObject() as RenderBox;
    // find the coordinate
    final Offset localOffset = box.globalToLocal(details.globalPosition);
    // log("scrollcontroller detail -${controllerscroll!.offset} ${controllerscroll!.offset+localOffset.dx} ${controllerscroll!.offset+localOffset.dy}");

    if (stickerselected == "assets/delete.png") {
      late int indexdihapus;
      // creating instance of renderbox

      posx = localOffset.dx;
      posy = localOffset.dy + controllerscroll!.offset;

      //log("stiker dihapus posisi ${posx - 20} ${posy - 105}");

      double rangexminus = posx - 20 - 5;
      double rangexplus = posx - 20 + 25;
      double rangeyminus = posy - 105 - 5;
      double rangeyplus = posy - 105 + 110;
      //log("stiker dihapus posisi $rangexminus $rangexplus $rangeyminus $rangeyplus");

      for (int i = 0; i < listposition.length; i++) {
        if (listposition[i].lokasikitab == namakitabdicari &&
            listposition[i].lokasipasal == pagesekarang) {
          log("stiker dihapus posisi klik ${posx - 20} ${posy - 105}");
          log("stiker dihapus  ${listposition[i].posisix} ${listposition[i].posisiy}");
          //log("stiker dihapus  ${namakitabdicari} ${pagesekarang}");
        }

        if (listposition[i].lokasikitab == namakitabdicari &&
            listposition[i].lokasipasal == pagesekarang &&
            listposition[i].posisix <= rangexplus &&
            listposition[i].posisix >= rangexminus &&
            listposition[i].posisiy >= rangeyminus &&
            listposition[i].posisiy <= rangeyplus) {
          log("stiker dihapus masuk if");
          log("stiker dihapus stiker ke-$i ${listposition[i].imagepath}");
          indexdihapus = i;
          log("ontapdown panjang sebelum dihapus -${listposition.length}");
          listposition.removeAt(indexdihapus);
          log("ontapdown panjang sesudah dihapus -${listposition.length}");
          await updatewriteStickerSP();
          addPages("sticker");
        }
      }
    }
    if (stickerselected.isNotEmpty &&
        stickermode == true &&
        stickerselected != "assets/delete.png") {
      // //log("dihapus - haruse ga masuk sini");
      // // creating instance of renderbox
      // final RenderBox box = context.findRenderObject() as RenderBox;
      // // find the coordinate
      // final Offset localOffset = box.globalToLocal(details.globalPosition);

      posx = localOffset.dx;
      posy = localOffset.dy + controllerscroll!.offset;

      Positioned posisistikeretanpadelete = Positioned(
        left: posx - 20,
        top: posy - 105,
        child: Image.asset(stickerselected),
      );

      Stack stackstiker = Stack(children: [
        Container(child: Image.asset(stickerselected)
            //your code
            ),
        InkWell(
            onTap: () {},
            child: Icon(
              Icons.cancel,
              color: Colors.red,
              size: 40,
            )),
      ]);

      Positioned posisistikere = Positioned(
        left: posx - 20,
        top: posy - 105,
        child: stackstiker,
      );

      var cPost = CSticker(
          posisix: posx,
          posisiy: posy,
          imagepath: stickerselected,
          lokasikitab: namakitabdicari,
          lokasipasal: pagesekarang,
          posisistiker: posisistikeretanpadelete,
          stackstiker: posisistikere);

      listposition.add(cPost);
      await addStickerSP();
      await addPages("sticker");
    }

    addBookMarkedSP(
        indexKitabDiCari.toString(), pasalkitab, ayatkitab, namakitabdicari);
  }

  bool loading = true;
  Future<void> getAllDataFromJson() async {
    if (globals.call == true) {
      alkitab.clear();
      alkitab = jsonDecode(await rootBundle.loadString('assets/Alkitab.json'));
      setState(() {
        globals.call = false;
        globals.alkitab = alkitab;
      });
    } else {
      setState(() {
        alkitab.clear();
        alkitab = globals.alkitab;
      });
    }

    getAllNamaKitabJumlahPasaldanJumlahAyatPerPasal();

    //await readBookMarkedFile();

    if (widget.daripagemana == "listayat") {
      aturSync();
      await getStickerSP();
    } else {
      //PAKE SHARED PREFERENCES UNTUK BOOKMARKED
      await getBookMarkedSP();

      setState(() {
        indexKitabDiCari = int.parse(listindexbookmarked[0]);
        pasalkitab = listindexbookmarked[1];
        ayatkitab = listindexbookmarked[2];
        namakitabdicari = listindexbookmarked[3];
        // indexKitabDiCari = 1;
        // pasalkitab = "1";
        // ayatkitab = "1";
        // namakitabdicari = "Kejadian";

        addBookMarkedSP(indexKitabDiCari.toString(), pasalkitab, ayatkitab,
            namakitabdicari);
        loading = false;
      });

      await addPages("splashscreen");
      log("sampe sini");
    }
  }

  // void getayattertentu(
  //     String namakitab, int pasal, int ayatawal, int ayatterakhir) {
  //   pencarianAyatTertentu.clear();
  //   List jumlahayatperpasal = getjumlahayatperpasalkitab(namakitab);

  //   int lastindex = indexmulaikitab;
  //   int indexayat = 0;

  //   for (int i = 0; i < jumlahayatperpasal.length; i++) {
  //     if (alkitab[lastindex]['verse'] >= ayatawal &&
  //         alkitab[lastindex]['verse'] <= ayatterakhir) {
  //       pencarianAyatTertentu[indexayat].add(alkitab[lastindex]);
  //       indexayat++;
  //       lastindex++;
  //     }
  //     if (indexayat == ayatterakhir - ayatawal) {
  //       break;
  //     }
  //   }
  // }

  void getjumlahdataperkitab(String namakitab) {
    indexmulaikitab = 0;
    dataperkitab = 0;
    namakitabsebelumnya = namakitab;
    //print("kitab namakitab - $namakitabsebelumnya");
    for (int i = 0; i < alkitab.length; i++) {
      if (namakitab == alkitab[i]['book'].toString()) {
        indexmulaikitab = i;
        //print("kitab indexmulaikitab - $indexmulaikitab");
        break;
      }
    }
    for (int i = indexmulaikitab; i < alkitab.length; i++) {
      if (namakitabsebelumnya == alkitab[i]['book'].toString()) {
        dataperkitab++;
      } else {
        break;
      }
    }
  }

  int getIndexMulaiAlkitab(String namakitab) {
    indexmulaikitab = 0;
    dataperkitab = 0;
    namakitabsebelumnya = namakitab;
    //print("kitab namakitab - $namakitabsebelumnya");
    for (int i = 0; i < alkitab.length; i++) {
      if (namakitab == alkitab[i]['book'].toString()) {
        indexmulaikitab = i;
        break;
      }
    }
    //print("Levina - kitab indexmulaikitab - $indexmulaikitab");
    // for (int i = indexmulaikitab; i < alkitab.length; i++) {
    //   if (namakitabsebelumnya == alkitab[i]['book'].toString()) {
    //     dataperkitab++;
    //     //print("jumlahdatakeluaran - $dataperkitab");
    //   }
    //   else{
    //     break;
    //   }

    // }
    // print("kitab jumlahdata KITAB - $dataperkitab");
    return indexmulaikitab;
  }

  int getjumlahpasalkitab(String namakitab) {
    getjumlahdataperkitab(namakitab);
    int pasalterakhir = 0;
    int pasalperkitab = 0;
    namakitabsebelumnya = namakitab;
    for (int i = indexmulaikitab; i < alkitab.length; i++) {
      if (namakitabsebelumnya == alkitab[i]['book'].toString()) {
        if (pasalterakhir.toString() != alkitab[i]['chapter'].toString()) {
          //print(alkitab[i]['chapter'].toString());
          //print("pasal - $namakitabsebelumnya");
          // print("heheh - ${alkitab[i]['book'].toString()}");
          // print("heheh - $i");
          pasalperkitab++;
          pasalterakhir++;
          //print("pasal - $pasalperkitab");

        }
      } else {
        break;
      }
    }
    return pasalperkitab;
  }

  List getJumlahTitlePerPasalKitab(String namakitab) {
    List titleperpasal = [];
    int counttitle = 0;
    int pasalsekarang = 1;
    int countlast = 0;
    getjumlahdataperkitab(namakitab);
    getjumlahpasalkitab(namakitab);

    for (int i = indexmulaikitab; i < dataperkitab + indexmulaikitab; i++) {
      if (alkitab[i]['type'].toString() == 't') {
        counttitle++;
      }

      if (alkitab[i]['book'] != 'Wahyu') {
        if (alkitab[i]['book'] != alkitab[i + 1]['book']) {
          titleperpasal.add(counttitle);

          counttitle = 0;
          pasalsekarang++;
          break;
        }

        if (pasalsekarang.toString() != alkitab[i + 1]['chapter'].toString()) {
          titleperpasal.add(counttitle);
          //titleperpasal.add(counttitle);
          //counttitle=0;
          counttitle = 0;
          pasalsekarang++;
        }
      } else {
        //WAHYU
        if (pasalsekarang.toString() == "22") {
          countlast++;
          if (countlast == 23) {
            titleperpasal.add(counttitle);
            //titleperpasal.add(counttitle);
            //counttitle = 0;
            counttitle = 0;
            break;
          }
        }
        if (pasalsekarang.toString() != alkitab[i + 1]['chapter'].toString()) {
          titleperpasal.add(counttitle);
          //titleperpasal.add(counttitle);
          //counttitle=0;
          counttitle = 0;
          pasalsekarang++;
        }
      }
    }

    return titleperpasal;
  }

  List<List> getjumlahtitle(String namakitab) {
    List<List> titlepasal = [];
    //ayatperpasal.clear();
    //titleperpasal.clear();
    titlepasal.clear();
    //int counttitle = 0;
    // ignore: unused_local_variable
    int countayat = 0;
    int pasalsekarang = 1;
    int countlast = 0;
    getjumlahdataperkitab(namakitab);
    getjumlahpasalkitab(namakitab);
    //print("hayo heem - ${getjumlahpasalkitab(namakitab)}");

    for (int i = 0; i < getjumlahpasalkitab(namakitab); i++) {
      titlepasal.add([]);
      //print("hayo - $i");
    }

    for (int i = indexmulaikitab; i < dataperkitab + indexmulaikitab; i++) {
      // if(alkitab[i]['type'].toString()!='t'){
      //   //countayat++;
      //   print("kitab isinya - ${alkitab[i]['book']}");
      // }

      if (alkitab[i]['type'].toString() == 't') {
        titlepasal[pasalsekarang - 1].add(alkitab[i + 1]['verse']);
        // print("verse - ${titlepasal[pasalsekarang-1]}");
      }

      if (alkitab[i]['book'] != 'Wahyu') {
        if (alkitab[i]['book'] != alkitab[i + 1]['book']) {
          //ayatperpasal.add(countayat);

          //countayat = 0;
          pasalsekarang++;
          break;
        }

        if (pasalsekarang.toString() != alkitab[i + 1]['chapter'].toString()) {
          pasalsekarang++;
        }
      } else {
        //WAHYU
        if (pasalsekarang.toString() == "22") {
          countlast++;
          if (countlast == 23) {
            //ayatperpasal.add(countayat);

            //countayat = 0;
            break;
          }
        }
        if (pasalsekarang.toString() != alkitab[i + 1]['chapter'].toString()) {
          //ayatperpasal.add(countayat);

          //countayat = 0;
          pasalsekarang++;
        }
      }
    }

    return titlepasal;
  }

  List getjumlahayatperpasalkitab(String namakitab) {
    List ayatperpasal = [];
    //ayatperpasal.clear();
    //titleperpasal.clear();
    //titlepasal.clear();
    //int counttitle = 0;
    int countayat = 0;
    int pasalsekarang = 1;
    int countlast = 0;
    getjumlahdataperkitab(namakitab);
    getjumlahpasalkitab(namakitab);
    //print("hayo heem - ${getjumlahpasalkitab(namakitab)}");

    // for(int i =0;i<getjumlahpasalkitab(namakitab);i++){
    //   titlepasal.add([]);
    //   //print("hayo - $i");
    // }

    for (int i = indexmulaikitab; i < dataperkitab + indexmulaikitab; i++) {
      if (alkitab[i]['type'].toString() != 't') {
        countayat++;
        //print("kitab isinya - ${alkitab[i]['book']}");
      }
      // if(alkitab[i]['type'].toString()=='t'){
      //   counttitle++;
      //   //titlepasal[pasalsekarang-1].add(alkitab[i+1]['verse']);
      //   // print("verse - ${titlepasal[pasalsekarang-1]}");
      // }

      if (alkitab[i]['book'] != 'Wahyu') {
        if (alkitab[i]['book'] != alkitab[i + 1]['book']) {
          ayatperpasal.add(countayat);
          //titleperpasal.add(counttitle);
          //counttitle=0;
          countayat = 0;
          pasalsekarang++;
          break;
        }

        if (pasalsekarang.toString() != alkitab[i + 1]['chapter'].toString()) {
          ayatperpasal.add(countayat);
          //titleperpasal.add(counttitle);
          //counttitle=0;
          countayat = 0;
          pasalsekarang++;
        }
      } else {
        //WAHYU
        if (pasalsekarang.toString() == "22") {
          countlast++;
          if (countlast == 23) {
            ayatperpasal.add(countayat);
            //titleperpasal.add(counttitle);
            //counttitle = 0;
            countayat = 0;
            break;
          }
        }
        if (pasalsekarang.toString() != alkitab[i + 1]['chapter'].toString()) {
          ayatperpasal.add(countayat);
          //titleperpasal.add(counttitle);
          //counttitle=0;
          countayat = 0;
          pasalsekarang++;
        }
      }
    }

    return ayatperpasal;
  }

  void getkitabperpasal(String namakitab) {
    List<List> titlepasal = getjumlahtitle(namakitab);
    List jumlahayatperpasal = getjumlahayatperpasalkitab(namakitab);
    satukitabperpasal.clear();
    //getjumlahayatperpasalkitab(namakitab);
    int lastindex = indexmulaikitab;
    int jumlahayat = 0;
    int jumlahpasal = getjumlahayatperpasalkitab(namakitab).length;

    //print("kitab jumlahayatperpasal - ${ayatperpasal.length}");
    //getjumlahpasalkitab(namakitab);
    for (int i = 0; i < jumlahpasal; i++) {
      //print("kitab jumlahtitle = $jumlahtitle");
      //int indextitle=0;
      // titlepasal.add([]);
      satukitabperpasal.add([]);
      jumlahayat = jumlahayatperpasal[i];
      //print("kitab jumlahtitle = ${titleperpasal[i]}");

      for (int j = 0; j < (jumlahayat + titlepasal[i].length); j++) {
        satukitabperpasal[i].add(alkitab[lastindex]);
        //print("hhhh0 - ${alkitab[lastindex]}");
        // if(alkitab[lastindex]['type']=="t"){
        //   titlepasal[i].add(alkitab[lastindex]['verse']);
        //   print("verse - ${alkitab[lastindex]['verse']}");
        // }
        lastindex++;

        //indextitle++;
      }
    }
  }

  List<cPasal> listPasalPerKitab = [];

  List<cKitab> listNamaKitab = [];

  void getAllNamaKitabJumlahPasaldanJumlahAyatPerPasal() {
    //listNamaKitab.clear();
    String namakitabtemp = "lala";
    // ignore: unused_local_variable
    int countindexbaru = 0;
    // ignore: unused_local_variable
    int jumlahkitab = 0;
    List temp = [];

    for (int i = 0; i < alkitab.length; i++) {
      if (namakitabtemp != alkitab[i]['book']) {
        var kitabC = cKitab();
        kitabC.setNamaKitab = alkitab[i]['book'].toString();
        listSemuaNamaKitab.add(alkitab[i]['book'].toString());
        temp.add(kitabC);
        countindexbaru++;
        namakitabtemp = alkitab[i]['book'];
        jumlahkitab++;
      }
    }

    int jumlahpasal = 0;

    for (int i = 0; i < temp.length; i++) {
      listPasalPerKitab.clear();
      jumlahpasal = getjumlahpasalkitab(temp[i].getNamaKitab.toString());
      ayatPerPasal =
          getjumlahayatperpasalkitab(temp[i].getNamaKitab.toString()); //LIST

      //List kosongan = List.filled(jumlahpasal, 0);
      List<List> kosongan = []; //list ayat dalam tiap pasal
      List jumlahAyatPerPasaldantitle = List.filled(jumlahpasal, 0);

      for (int j = 0; j < jumlahpasal; j++) {
        List listAyat = List.filled(ayatPerPasal[j], 0);
        //jumlahtitle = getJumlahTitlePadaPasalTertentu(temp[i].getNamaKitab,j+1);
        //print("jumlah title ${temp[i].getNamaKitab} pasal ${j+1} = $jumlahtitle");
        kosongan.add(listAyat);

        //PAKE TITLE
        //jumlahAyatPerPasaldantitle[j] = ayatPerPasal[j]+jumlahtitle;

        //GAPAKE TITLE
        jumlahAyatPerPasaldantitle[j] = ayatPerPasal[j];
        listPasalPerKitab
            .add(cPasal(indexPasal_: j + 1, jumlahAyat_: ayatPerPasal[j]));
      }

      setState(() {
        cKitab kitabC = cKitab(
            namaKitab_: temp[i].getNamaKitab.toString(),
            jumlahPasal_: jumlahpasal,
            listPasalAyat_: kosongan,
            listPasal_: jumlahAyatPerPasaldantitle);
        //print("hasil - ${temp[i].getNamaKitab.toString()} - ${listPasalPerKitab.length}");
        listNamaKitab.add(kitabC);
      });
    }
    setState(() {
      globals.listNamaKitab = listNamaKitab;
    });

    // for (int i = 0; i < listNamaKitab.length; i++) {
    //   //CEKING DOANG
    //   if (listNamaKitab.isNotEmpty) {
    //     print("ceking - jadi kitab ${listNamaKitab[i].getNamaKitab.toString()} punya jumlah pasal : ${listNamaKitab[i].jumlahPasal_}");
    //     for(int k =0;k<listNamaKitab[i].listPasal_!.length;k++){
    //       print("ceking - Pasal - ${k+1} punya jumlah ayat : ${listNamaKitab[i].getListPasal![k]}");
    //     }
    //   }
    // }
  }

  int getJumlahAyatPadaPasalTertentu(
      String parameterNamaKitab, int pasalDicari) {
    int jumlahAyat = 0;
    List pasal = getjumlahayatperpasalkitab(parameterNamaKitab);
    int jumlahPasal = getjumlahayatperpasalkitab(parameterNamaKitab).length;
    //print("Levina - jumlah pasal - $jumlahPasal");
    for (int i = 0; i < jumlahPasal; i++) {
      if (pasalDicari == i + 1) {
        jumlahAyat = pasal[i];
        break;
      }
    }
    //print("Levina - jumlah ayat - $jumlahAyat");
    return jumlahAyat;
  }

  int getJumlahTitlePadaPasalTertentu(
      String parameterNamaKitab, int pasalDicari) {
    int pasalsekarang = pasalDicari;
    int jumlahtitle = 0;
    getjumlahdataperkitab(parameterNamaKitab);
    getjumlahpasalkitab(parameterNamaKitab);

    for (int i = indexmulaikitab; i < dataperkitab + indexmulaikitab; i++) {
      if (parameterNamaKitab == "Wahyu") {
        if (alkitab[i]['type'].toString() == 't' &&
            alkitab[i]['chapter'] == pasalsekarang) {
          jumlahtitle++;
        }

        if (alkitab[i]['chapter'] == 22 && alkitab[i]['verse'] == 21) {
          break;
        } else {
          if (alkitab[i + 1]['chapter'] > pasalsekarang) {
            break;
          }
        }
      } else {
        if (alkitab[i]['type'].toString() == 't' &&
            alkitab[i]['chapter'] == pasalsekarang) {
          jumlahtitle++;
        }

        if (alkitab[i + 1]['chapter'] > pasalsekarang) {
          break;
        }
      }
    }

    return jumlahtitle;
  }

  void cariKitabTertentu(String inputNamaKitab, String inputPasal,
      String inputAyatAwal, String inputAyatAkhir) {
    kitabTertentu.clear();
    String kitabDicari = inputNamaKitab;
    int pasalDicari = int.parse(inputPasal);
    int ayatAwalDicari = int.parse(inputAyatAwal);
    int ayatAkhirDicari = int.parse(inputAyatAkhir);
    int jumlahdicari = ayatAkhirDicari - ayatAwalDicari + 1;

    int indexkitab = getIndexMulaiAlkitab(kitabDicari);
    int indexmulaiayattertentu = 0;
    int indexJumlahKitabTertentu = 0;
    int indexpenanda = 0;
    int penambahiftitle = 0;

    //List jumlahAyatKitabTertentu = getjumlahayatperpasalkitab(kitabDicari);
    // print("Levina - ayat kitab tertentu - $jumlahayattertentu");
    // print(
    //     "Levina - indexmulaialkitab - $indexkitab - kitab - ${alkitab[indexkitab]}");

    for (int i = indexkitab; i < alkitab.length; i++) {
      if (pasalDicari == alkitab[i]['chapter']) {
        indexpenanda = i;
        //print("Levina - kitab $indexpenanda");
        //print("Levina - heem ${alkitab[indexpenanda]}");
        break;
      }
    }

    for (int i = indexpenanda; i < alkitab.length; i++) {
      if (alkitab[i]['verse'] == ayatAwalDicari) {
        indexmulaiayattertentu = i;
        if (alkitab[i - 1]['type'] == "t") {
          indexmulaiayattertentu = i - 1;
        }

        break;
      }
    }

    for (int i = indexmulaiayattertentu;
        i < indexmulaiayattertentu + jumlahdicari + penambahiftitle;
        i++) {
      kitabTertentu.add([]);
      kitabTertentu[indexJumlahKitabTertentu] = alkitab[i];
      indexJumlahKitabTertentu++;
      if (alkitab[i]['type'] == 't') {
        penambahiftitle++;
      }
    }
  }

  //BUKAN KELOMPOK, SATU SATU
  void selecttext(int indexKitab, int indexPasal, int indexAyat,
      Color indexcolor, String konten, String mauapa) {
    //print("selectednih - ${getNamaKitab(indexKitab)} $indexPasal $indexAyat");

    // ignore: non_constant_identifier_names
    cSelected SelectedC = cSelected();

    bool sudahada = false;

    if (selectedAyat.isEmpty) {
      //selectedAyat = newObject();
      for (int i = 0; i < listTempHighlightData.length; i++) {
        for (int j = 0;
            j < listTempHighlightData[i]["KelompokHighlight"].length;
            j++) {
          if (listTempHighlightData[i]["KelompokHighlight"][j]["IndexKitab"] ==
                  indexKitab.toString() &&
              listTempHighlightData[i]["KelompokHighlight"][j]["IndexPasal"] ==
                  indexPasal.toString() &&
              listTempHighlightData[i]["KelompokHighlight"][j]["IndexAyat"] ==
                  indexAyat.toString()) {
            sudahada = true;
            //log("highlighttt - masuk ke hapus array empty");
            if (mauapa == "unselect") {
              deleteHighlightData(indexKitab, indexPasal, indexAyat);
            }

            break;
          }
        }
      }

      if (sudahada == false) {
        selectedAyat = [];
        selectedAyat.add([]);
        SelectedC.indxKitab = indexKitab;
        SelectedC.indxPasal = indexPasal;
        SelectedC.indxAyat = indexAyat;
        SelectedC.indxColor = indexcolor;
        SelectedC.konten = konten;
        SelectedC.namaKitab = listSemuaNamaKitab[indexKitab];

        //selectedAyat.insert(jumlahayatdiselect, SelectedC);
        selectedAyat[jumlahayatdiselect] = SelectedC;
        jumlahayatdiselect++;
      }
    } else {
      for (int i = 0; i < selectedAyat.length; i++) {
        if (selectedAyat[i].getindexkitab == indexKitab &&
            selectedAyat[i].getindexpasal == indexPasal &&
            selectedAyat[i].getindexayat == indexAyat) {
          sudahada = true;
          if (mauapa == "unselect") {
            unselecttext(indexKitab, indexPasal, indexAyat);
          }
          break;
        }
      }

      for (int i = 0; i < listTempHighlightData.length; i++) {
        for (int j = 0;
            j < listTempHighlightData[i]["KelompokHighlight"].length;
            j++) {
          if (listTempHighlightData[i]["KelompokHighlight"][j]["IndexKitab"] ==
                  indexKitab.toString() &&
              listTempHighlightData[i]["KelompokHighlight"][j]["IndexPasal"] ==
                  indexPasal.toString() &&
              listTempHighlightData[i]["KelompokHighlight"][j]["IndexAyat"] ==
                  indexAyat.toString()) {
            sudahada = true;
            if (mauapa == "unselect") {
              deleteHighlightData(indexKitab, indexPasal, indexAyat);
            }
            //return ada;

            break;
          }
        }
      }

      if (sudahada == false) {
        selectedAyat.add([]);
        SelectedC.indxKitab = indexKitab;
        SelectedC.indxPasal = indexPasal;
        SelectedC.indxAyat = indexAyat;
        SelectedC.indxColor = indexcolor;
        SelectedC.konten = konten;
        SelectedC.namaKitab = listSemuaNamaKitab[indexKitab];

        //selectedAyat.insert(jumlahayatdiselect, SelectedC);
        selectedAyat[jumlahayatdiselect] = SelectedC;
        //selectedAyat[jumlahayatdiselect] = SelectedC;
        jumlahayatdiselect++;
      }
    }
  }

  //LIST
  // void selecttext(List selectedayat){
  //   // print("steler - yg dicari $indexKitab $indexPasal $indexAyat");
  //   // if(selectedAyat.isNotEmpty){
  //   //   print("steler - yg ada ${selectedAyat[jumlahayatdiselect-1].getindexkitab} ${selectedAyat[jumlahayatdiselect-1].getindexpasal} ${selectedAyat[jumlahayatdiselect-1].getindexayat}");
  //   // }

  //   var SelectedC = cSelected();
  //   bool sudahada=false;
  //   if(selectedAyat.isEmpty){
  //     selectedAyat.add([]);
  //     SelectedC.indxkitab = indexKitab;
  //     SelectedC.indxPasal = indexPasal;
  //     SelectedC.indxAyat = indexAyat;
  //     SelectedC.indxColor = indexcolor;

  //     selectedAyat[jumlahayatdiselect]=SelectedC;
  //     jumlahayatdiselect++;
  //     print("selected - ${selectedAyat[jumlahayatdiselect-1].getindexayat}");

  //   }else{

  //     for(int i=0;i<selectedAyat.length;i++){
  //       if(selectedAyat[i].getindexkitab==indexKitab&&selectedAyat[i].getindexpasal==indexPasal&&selectedAyat[i].getindexayat==indexAyat){
  //         sudahada=true;
  //         unselecttext(indexKitab, indexPasal, indexAyat);
  //         //print("index - $sudahada");
  //         break;
  //       }

  //     }

  //     if(sudahada==false){
  //       selectedAyat.add([]);
  //       SelectedC.indxkitab = indexKitab;
  //       SelectedC.indxPasal = indexPasal;
  //       SelectedC.indxAyat = indexAyat;
  //       SelectedC.indxColor = indexcolor;
  //       selectedAyat[jumlahayatdiselect] = SelectedC;
  //       jumlahayatdiselect++;
  //       //print("index - berhasil tambah");
  //     }

  //   }

  // }

  void unselecttext(int indexKitab, int indexPasal, int indexAyat) {
    for (int i = 0; i < selectedAyat.length; i++) {
      if (selectedAyat[i].getindexkitab == indexKitab &&
          selectedAyat[i].getindexpasal == indexPasal &&
          selectedAyat[i].getindexayat == indexAyat) {
        selectedAyat.removeAt(i);
        jumlahayatdiselect--;

        break;
      }
    }
  }

  // ignore: body_might_complete_normally_nullable
  bool? adaDiListSelect(int indexKitab, int indexPasal, int indexAyat) {
    bool ada = false;
    if (selectedAyat.isNotEmpty) {
      for (int i = 0; i < selectedAyat.length; i++) {
        if (selectedAyat[i].getindexkitab == indexKitab &&
            selectedAyat[i].getindexpasal == indexPasal &&
            selectedAyat[i].getindexayat == indexAyat) {
          ada = true;
          return ada;
        }
      }
    }

    if (listTempHighlightData.isEmpty) {
      if (selectedAyat.isEmpty) {
        ada = false;
        return ada;
      } else {
        //print("index - $ada");
        for (int i = 0; i < selectedAyat.length; i++) {
          if (selectedAyat[i].getindexkitab == indexKitab &&
              selectedAyat[i].getindexpasal == indexPasal &&
              selectedAyat[i].getindexayat == indexAyat) {
            ada = true;
            return ada;
          }
        }
      }
    } else {
      for (int i = 0; i < listTempHighlightData.length; i++) {
        for (int j = 0;
            j < listTempHighlightData[i]["KelompokHighlight"].length;
            j++) {
          if (listTempHighlightData[i]["KelompokHighlight"][j]["IndexKitab"] ==
                  indexKitab.toString() &&
              listTempHighlightData[i]["KelompokHighlight"][j]["IndexPasal"] ==
                  indexPasal.toString() &&
              listTempHighlightData[i]["KelompokHighlight"][j]["IndexAyat"] ==
                  indexAyat.toString()) {
            ada = true;
            //deleteHighlightData(indexKitab, indexPasal, indexAyat);
            return ada;
          }
        }
      }
    }
  }

  Color getWarnaPilihan(int indexKitab, int indexPasal, int indexAyat) {
    Color warna = Colors.transparent;
    if (listTempHighlightData.isEmpty) {
      if (selectedAyat.isNotEmpty) {
        for (int i = 0; i < selectedAyat.length; i++) {
          if (selectedAyat[i].getindexkitab == indexKitab &&
              selectedAyat[i].getindexpasal == indexPasal &&
              selectedAyat[i].getindexayat == indexAyat) {
            warna = Colors.blue.withOpacity(0.25);
          }
        }
      }
    } else {
      for (int i = 0; i < listTempHighlightData.length; i++) {
        for (int j = 0;
            j < listTempHighlightData[i]["KelompokHighlight"].length;
            j++) {
          if (listTempHighlightData[i]["KelompokHighlight"][j]["IndexKitab"] ==
                  indexKitab.toString() &&
              listTempHighlightData[i]["KelompokHighlight"][j]["IndexPasal"] ==
                  indexPasal.toString() &&
              listTempHighlightData[i]["KelompokHighlight"][j]["IndexAyat"] ==
                  indexAyat.toString()) {
            String valueString = listTempHighlightData[i]["KelompokHighlight"]
                    [j]["IndexColor"]
                .toString()
                .split('(0x')[1]
                .split(')')[0]; // kind of hacky..
            int value = int.parse(valueString, radix: 16);
            // ignore: unnecessary_new
            Color colortemp = new Color(value);
            warna = colortemp;
            break;
          }
        }
      }
      if (selectedAyat.isNotEmpty) {
        for (int i = 0; i < selectedAyat.length; i++) {
          if (selectedAyat[i].getindexkitab == indexKitab &&
              selectedAyat[i].getindexpasal == indexPasal &&
              selectedAyat[i].getindexayat == indexAyat) {
            warna = Colors.blue.withOpacity(0.25);
          }
        }
      }
    }
    return warna;
  }

  int adaDiListUnderlined(String namakitabdicari, String pasal, String ayat) {
    int indexadadilistunderlined = -99;

    for (int i = 0; i < listUnderlinedKalimat.length; i++) {
      if (namakitabdicari == listUnderlinedKalimat[i].namakitab &&
          pasal == listUnderlinedKalimat[i].pasal &&
          ayat == listUnderlinedKalimat[i].ayat) {
        indexadadilistunderlined = i;
        break;
      }
    }

    return indexadadilistunderlined;
  }

  int? indexmulaiterunderline(List fullayat, int indexketemudilist) {
    int indexinihhh = -99;
    List ayatterselect = listUnderlinedKalimat[indexketemudilist].listIsiAyat;
    for (int i = 0; i < fullayat.length; i++) {
      //log("heeh ${fullayat[i]}  ${ayatterselect[0]}");
      if (fullayat[i] == ayatterselect[0]) {
        indexinihhh = i;
        break;
      }
    }

    return indexinihhh;
  }

  Widget tampilanUnderlined(
      String namakitabdicari,
      String pasal,
      String ayat,
      String fullayat,
      int indexketemudilist,
      int indexkitabdicari,
      int index,
      Color mycolor) {
    List ayatterselect = listUnderlinedKalimat[indexketemudilist].listIsiAyat;
    // log("erorsini 1 ${ayatterselect}");
    List ayatlengkap = fullayat.split(' ');
    // log("erorsini 2 ${ayatlengkap}");
    int panjangadagarisbawah = ayatterselect.length;
    // log("erorsini 3 $panjangadagarisbawah");
    int? indexmulaidigarisbawah =
        indexmulaiterunderline(ayatlengkap, indexketemudilist);
    //log("erorsini 4");
    if (indexmulaidigarisbawah != -99) {
      return Text.rich(
        TextSpan(
          children: <TextSpan>[
            TextSpan(
                text: "$ayat  ",
                style: GoogleFonts.nunito(
                    textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        color: Colors.black))),
            for (int i = 0; i < ayatlengkap.length; i++)
              (ayatterselect.length <= 1)
                  ? (ayatterselect.isEmpty)
                      ? TextSpan(
                          text: ayatlengkap[i] + " ",
                          style: GoogleFonts.nunito(
                              textStyle: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black)))
                      : (ayatlengkap[i] == ayatterselect[0])
                          ? TextSpan(
                              text: ayatlengkap[i] + " ",
                              style: GoogleFonts.nunito(
                                  textStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                                decoration: TextDecoration.underline,
                              )))
                          : TextSpan(
                              text: ayatlengkap[i] + " ",
                              style: GoogleFonts.nunito(
                                  textStyle: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black)))
                  : (i < indexmulaidigarisbawah! ||
                          i > panjangadagarisbawah - 1 + indexmulaidigarisbawah)
                      ?
                      // (ayatlengkap[i] == ayatterselect[0])?
                      TextSpan(
                          text: ayatlengkap[i] + " ",
                          style: GoogleFonts.nunito(
                              textStyle: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black)))
                      : TextSpan(
                          text: ayatlengkap[i] + " ",
                          style: GoogleFonts.nunito(
                              textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                          )))
          ],
        ),
      );
    } else {
      return Text(
        "$ayat  $fullayat",
        style: GoogleFonts.nunito(
            textStyle: const TextStyle(
                //decoration: TextDecoration.underline,
                fontSize: 18,
                fontWeight: FontWeight.w300,
                color: Colors.black)),
      );
    }
  }

  // double panjanglayar=-99;
  // final keylayoutbuilderaddpages = GlobalKey();

  // GlobalKey _key = GlobalKey();
  // double _panjanglayout = 0.0;

  // double screenheight=-99 ;
  // double screenwidth=-99;
 // Size wsize = Size.zero;

  //final GlobalKey<> keyheight = GlobalKey();
  List<GlobalKey> keyheight = [];
  // double _sizeOfListview = 0.0;

  // late double leyoutheight;

  Future<void> addPages(String darimana) async {
    // setState(() {
    //   leyoutheight = MediaQuery.of(context).size.height;
    //   log("hemheight - $leyoutheight");
    // });

    // //getStickerSP();

    await readFile(); //COMMAND KLO MAU NGULANG WRITE DR AWAL
    // if(mauhapussemuaunderline==false && darimana!="deleteunderline" && darimana!="underlined" && darimana!="selectayat"){
    //   await readFileUnderlined("addpages");
    // }

    page.clear();

    indexKitabDiCari = int.parse(listindexbookmarked[0]);
    pasalkitab = listindexbookmarked[1];
    ayatkitab = listindexbookmarked[2];
    namakitabdicari = listindexbookmarked[3];
    // indexKitabDiCari = 1;

    log("infoo - $indexKitabDiCari $pasalkitab $ayatkitab $namakitabdicari");

    //late var panjangLayout;
    int jumlahpasal = getjumlahayatperpasalkitab(namakitabdicari).length;
    counttitleuntukscrollviewayat = 0;
    getkitabperpasal(namakitabdicari);

    for (int i = 0; i < jumlahpasal; i++) {
      setState(() {
        keyheight.add(GlobalKey());
        page.add(
          
          SingleChildScrollView(
            scrollDirection: ScrollDirectionn,
            controller: controllerscroll,
            child: Stack(
              // fit: StackFit.loose,
              children: [
                // MeasuredSize(
                //     onChange: (Size size) {
                //       log("ceking ganti - ${size.height}");
                //       //   //BUAT WRITE ULANG LAYOUTHEIGHT
                //       setState(() {
                //         // leyoutheight = size.height;
                //         //globals.sizeStickerLay = size.height;
                //         //wsize = size;
                //         //addListLayoutHeight(namakitabdicari,i,size.height);
                //       });
                //     },
                //     child:
                        // Stack(
                        //   children: [
                        ListView.builder(
                            key: keyheight[i],
                            //key:keyheight,
                            padding: EdgeInsets.only(bottom: 70),
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: satukitabperpasal[i].length,
                            itemBuilder: (context, index) {
                              // leyoutheight = MediaQuery.of(context).size.height;

                              // setState(() {
                              //   screenheight = MediaQuery.of(context).size.height;
                              //   screenwidth = MediaQuery.of(context).size.width;
                              //   log("dapet tinggi -$screenheight");
                              // });

                              bool adagadilistunderlined = false;
                              int indexketemuunderlined = adaDiListUnderlined(
                                  namakitabdicari,
                                  (i + 1).toString(),
                                  satukitabperpasal[i][index]['verse']
                                      .toString());

                              if (indexketemuunderlined == -99) {
                                adagadilistunderlined = false;
                              } else {
                                adagadilistunderlined = true;
                              }

                              if (satukitabperpasal[i][index]['type']
                                      .toString() !=
                                  't') {
                                return AutoScrollTag(
                                  key: ValueKey(index),
                                  controller: controllerscroll!,
                                  index: index,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: (adaDiListSelect(
                                                  indexKitabDiCari, i, index) ==
                                              true)
                                          ? getWarnaPilihan(
                                              indexKitabDiCari, i, index)
                                          : Colors.transparent,
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        log("ketap sini");
                                        //log("panjang layar - ${keylayoutbuilderaddpages.currentContext!.size!.height}");
                                        if (stickermode == false) {
                                          selecttext(
                                              indexKitabDiCari,
                                              i,
                                              index,
                                              mycolor,
                                              satukitabperpasal[i][index]
                                                      ['content']
                                                  .toString(),
                                              "select");
                                          addPages("selectayat");
                                        }
                                      },
                                      onLongPress: () {
                                        if (stickermode == false) {
                                          setState(() {
                                            selecttext(
                                                indexKitabDiCari,
                                                i,
                                                index,
                                                mycolor,
                                                satukitabperpasal[i][index]
                                                        ['content']
                                                    .toString(),
                                                "unselect");
                                            addPages("selectayat");
                                          });
                                        }
                                      },
                                      onDoubleTap: () async {
                                        await _showDetailAyat(
                                            namakitabdicari,
                                            (i + 1).toString(),
                                            satukitabperpasal[i][index]['verse']
                                                .toString(),
                                            satukitabperpasal[i][index]
                                                    ['content']
                                                .toString());
                                      },
                                      child: ListTile(
                                        subtitle: (adagadilistunderlined ==
                                                true)
                                            ? tampilanUnderlined(
                                                namakitabdicari,
                                                (i + 1).toString(),
                                                satukitabperpasal[i][index]
                                                        ['verse']
                                                    .toString(),
                                                satukitabperpasal[i][index]
                                                        ['content']
                                                    .toString(),
                                                indexketemuunderlined,
                                                indexKitabDiCari,
                                                index,
                                                mycolor)
                                            : Text(
                                                "${satukitabperpasal[i][index]['verse'].toString()}  ${satukitabperpasal[i][index]['content'].toString()}",
                                                style: GoogleFonts.nunito(
                                                    textStyle: const TextStyle(
                                                        //decoration: TextDecoration.underline,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        color: Colors.black)),
                                              ),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return AutoScrollTag(
                                  key: ValueKey(index),
                                  controller: controllerscroll!,
                                  index: index,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: (adaDiListSelect(
                                                  widget.indexKitabdicari!,
                                                  i,
                                                  index) ==
                                              true)
                                          ? Colors.blue.withOpacity(0.5)
                                          : Colors.transparent,
                                    ),
                                    child: ListTile(
                                        title: Text(
                                      // ignore: unnecessary_string_interpolations
                                      "${satukitabperpasal[i][index]['content'].toString()}",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.nunito(
                                          textStyle: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black)),
                                    )),
                                  ),
                                );
                              }
                            }),
                    //,stickerlayoutwidget(i, namakitabdicari,leyoutheight)
                    //   ],
                    // ),

                   // ),
                // Container(
                //   child:
                stickerlayoutwidget(i, namakitabdicari)
                //stickerlayoutwidget(i, namakitabdicari,cariHeightLayout(namakitabdicari,i.toString()))
                // )
              ],
            ),
          ),
        );
      });

      // setState(() {
      //   panjanglayar = keylayoutbuilderaddpages.currentContext!.size!.height;
      // });
      //log("dapet lagi - ${wsize.height.toString()}");
    }

    if (darimana != "selectayat" &&
        darimana != "bookmarked" &&
        darimana != "sticker" &&
        darimana != "underlined") {
      //jump to sesuai pasal
      log("masuk sini start");
      // pageController.
      pageController.jumpToPage(int.parse(pasalkitab) - 1);
      pagesekarang = int.parse(pasalkitab) - 1;

      // //scroll ke ayat
      await _scrollToIndex(darimana);
    }
  }

  Widget listtilelayoutwidget() {
    return PageView.builder(
      pageSnapping: true,
      controller: pageController,
      itemCount: page.length,
      itemBuilder: (context, index) {
        // return page[index];
        return page[index];
      },
      onPageChanged: (page) {
        setState(() {
          pagesekarang = page;

          //height = _globalKey.currentContext!.size!.height;
        });
      },
    );
  }

  Future _scrollToIndex(String darimana) async {
    if (darimana == "listayat") {
      log("sekarang masuk if ${getNamaKitab(indexKitabDiCari)} ${pasalkitab} ${ayatkitab}");
      //log("sekarang masuk if ${getNamaKitab(widget.indexKitabdicari!)} ${(widget.pasalKitabdicari! + 1).toString()} ${(widget.ayatKitabdicari! + 1).toString()}");
      setState(() {
        indexKitabDiCari = widget.indexKitabdicari!;
        namakitabdicari = getNamaKitab(widget.indexKitabdicari!);
        pasalkitab = (widget.pasalKitabdicari! + 1).toString();
        ayatkitab = (widget.ayatKitabdicari! + 1).toString();
      });
    }

    List<List> titlepasal = getjumlahtitle(namakitabdicari);
    int tambahindex = 0;
    int ayatsekarang = int.parse(ayatkitab);

    for (int i = 0; i < titlepasal[int.parse(pasalkitab) - 1].length; i++) {
      if (ayatsekarang >= titlepasal[int.parse(pasalkitab) - 1][i]) {
        tambahindex++;
      } else {
        break;
      }
    }

    await controllerscroll?.scrollToIndex(ayatsekarang + tambahindex - 1,
        preferPosition: AutoScrollPosition.begin);
  }

  void highlightMenu(List selectedAyat) {
    //mycolor = selectedAyat[0].getindexcolor;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Pick a color!'),
              content: SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.all(6),
                child: Card(
                  elevation: 2,
                  child: ColorPicker(
                    enableOpacity: true,
                    // Use the screenPickerColor as start color.
                    color: screenPickerColor,
                    // Update the screenPickerColor using the callback.
                    onColorChanged: (Color color) {
                      //on color picked
                      setState(() {
                        mycolor = color;
                      });
                    },
                    width: 44,
                    height: 44,
                    borderRadius: 22,
                    heading: Text(
                      'Select color',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    subheading: Text(
                      'Select color shade',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ),
              )),
              actions: <Widget>[
                ElevatedButton(
                  child: const Text('DONE'),
                  onPressed: () async {
                    List temp = [];
                    for (int i = 0; i < selectedAyat.length; i++) {
                      selectedAyat[i].setColor(mycolor);
                    }
                    temp = List.from(selectedAyat);
                    highlightUser.add([]);
                    highlightUser[jumlahHighlightUser] = temp;
                    jumlahHighlightUser++;
                    selectedAyat.clear();
                    jumlahayatdiselect = 0;
                    writeData("highlight");
                    yangSudahDimasukinKeFile++;

                    Navigator.of(context).pop();
                  },
                ),
              ]);
        });
  }

  void functionMenu(String pilihanMenu, List selectedAyat) {
    if (pilihanMenu == "Highlight") {
      highlightMenu(selectedAyat);
    } else if (pilihanMenu == "Catatan") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CatatanPage(
                  status: "tambah",
                  index: 0,
                  listHighlight: selectedAyat,
                  darimana: "homepage")));
    } else if (pilihanMenu == "Renungan") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RenunganPage(
                  status: "tambah",
                  index: 0,
                  listHighlight: selectedAyat,
                  darimana: "homepage")));
    }
  }

//HIGHLIGHT FILE
  String dataHighlight = '';
  List listTempHighlightData = [];
  // get local file
  Future<File> get _localFile async {
    return File('/storage/emulated/0/Download/listHighlightUser.txt');
  }

  // write data
  Future<void> writeData(String dipanggildari) async {
    final file = await _localFile;

    dataHighlight = '';

    dataHighlight = "$dataHighlight[";
    for (int i = 0; i < listTempHighlightData.length; i++) {
      if (i != 0) {
        // ignore: prefer_interpolation_to_compose_strings
        dataHighlight = dataHighlight + ",{";
      } else {
        // ignore: prefer_interpolation_to_compose_strings
        dataHighlight = dataHighlight + "{";
      }
      dataHighlight =
          // ignore: prefer_interpolation_to_compose_strings
          dataHighlight + '"IndexHighlight":"' + (i + 1).toString() + "\",";
      // ignore: prefer_interpolation_to_compose_strings
      dataHighlight = dataHighlight + '"KelompokHighlight":';
      // ignore: prefer_interpolation_to_compose_strings
      dataHighlight = dataHighlight + "[";
      for (int j = 0;
          j < listTempHighlightData[i]["KelompokHighlight"].length;
          j++) {
        if (j != 0) {
          // ignore: prefer_interpolation_to_compose_strings
          dataHighlight = dataHighlight + ",{";
        } else {
          // ignore: prefer_interpolation_to_compose_strings
          dataHighlight = dataHighlight + "{";
        }
        // ignore: prefer_interpolation_to_compose_strings
        dataHighlight = dataHighlight +
            '"IndexKitab":"' +
            listTempHighlightData[i]["KelompokHighlight"][j]["IndexKitab"]
                .toString() +
            '","IndexPasal":"' +
            listTempHighlightData[i]["KelompokHighlight"][j]["IndexPasal"]
                .toString() +
            '","IndexAyat":"' +
            listTempHighlightData[i]["KelompokHighlight"][j]["IndexAyat"]
                .toString() +
            '","IndexColor":"' +
            listTempHighlightData[i]["KelompokHighlight"][j]["IndexColor"]
                .toString() +
            '"}';
      }
      dataHighlight = "$dataHighlight]";
      dataHighlight = "$dataHighlight}";
    }
    //for (int i = 0 + yangSudahDimasukinKeFile - 1;i < highlightUser.length;i++) {
    if (dipanggildari != "deletehighlight") {
      for (int i = 0 + yangSudahDimasukinKeFile - 1;
          i < highlightUser.length;
          i++) {
        if (listTempHighlightData.isEmpty) {
          // ignore: prefer_interpolation_to_compose_strings
          dataHighlight = dataHighlight + "{";
        } else if (i == 0 || selectedAyat.isEmpty) {
          // ignore: prefer_interpolation_to_compose_strings
          dataHighlight = dataHighlight + ",{";
        }

        // ignore: prefer_interpolation_to_compose_strings
        dataHighlight = dataHighlight +
            '"IndexHighlight":"' +
            (listTempHighlightData.length + i + 2 - yangSudahDimasukinKeFile)
                .toString() +
            "\",";
        // ignore: prefer_interpolation_to_compose_strings
        dataHighlight = dataHighlight + '"KelompokHighlight":';
        // ignore: prefer_interpolation_to_compose_strings
        dataHighlight = dataHighlight + "[";
        for (int j = 0; j < highlightUser[i].length; j++) {
          if (j != 0) {
            // ignore: prefer_interpolation_to_compose_strings
            dataHighlight = dataHighlight + ",{";
          } else {
            // ignore: prefer_interpolation_to_compose_strings
            dataHighlight = dataHighlight + "{";
          }
          // ignore: prefer_interpolation_to_compose_strings
          dataHighlight = dataHighlight +
              '"IndexKitab":"' +
              highlightUser[i][j].indxKitab.toString() +
              '","IndexPasal":"' +
              highlightUser[i][j].indxPasal.toString() +
              '","IndexAyat":"' +
              highlightUser[i][j].indxAyat.toString() +
              '","IndexColor":"' +
              highlightUser[i][j].indxColor.toString() +
              '"}';
        }
        // ignore: prefer_interpolation_to_compose_strings
        dataHighlight = dataHighlight + "]";
        // ignore: prefer_interpolation_to_compose_strings
        dataHighlight = dataHighlight + "}";
      }
    }
    // ignore: prefer_interpolation_to_compose_strings
    dataHighlight = dataHighlight + "]";

    await file.writeAsString(dataHighlight);
    await readFile();
    await addPages("selectayat");
  }

  Future<void> deleteHighlightData(
      int indexKitab, int indexPasal, int indexAyat) async {
    dataHighlight = '';
    int ygdihapus1 = 0;
    int ygdihapus2 = 0;
    dataHighlight = "$dataHighlight[";

    for (int i = 0; i < listTempHighlightData.length; i++) {
      for (int j = 0;
          j < listTempHighlightData[i]["KelompokHighlight"].length;
          j++) {
        if (listTempHighlightData[i]["KelompokHighlight"][j]["IndexKitab"]
                    .toString() ==
                indexKitab.toString() &&
            listTempHighlightData[i]["KelompokHighlight"][j]["IndexPasal"]
                    .toString() ==
                indexPasal.toString() &&
            listTempHighlightData[i]["KelompokHighlight"][j]["IndexAyat"]
                    .toString() ==
                indexAyat.toString()) {
          ygdihapus1 = i;
          ygdihapus2 = j;
          i = listTempHighlightData.length;
          break;
        }
      }
    }

    listTempHighlightData[ygdihapus1]["KelompokHighlight"].removeAt(ygdihapus2);
    for (int i = 0; i < listTempHighlightData.length; i++) {
      for (int j = 0;
          j < listTempHighlightData[i]["KelompokHighlight"].length;
          j++) {}
    }

    await writeData("deletehighlight");
    await readFile();
  }

  // read data
  Future<void> readFile() async {
    String path = '/storage/emulated/0/Download/listHighlightUser.txt';
    bool directoryExists = await Directory(path).exists();
    bool fileExists = await File(path).exists();

    if (directoryExists || fileExists) {
      final file = await _localFile;

      // Read the file-
      final contents = await file.readAsString();
      // log("Hasil log highlight - $contents");

      if (contents.isNotEmpty) {
        setState(() {
          listTempHighlightData = json.decode(contents);
        });
      }
    }
  }
//END HIGHLIGHT DATA

//UNDERLINED DATA
  List listUnderlinedKalimat = [];
  List listUnderlinedKalimatdarireadjson = [];
  String dataUnderline = '';
  bool mauhapussemuaunderline = false;
  //int yangSudahDimasukinKeFileUnderlined = 0;
  //List listTempHighlightData = [];
  Future<File> get _localFileUnderlined async {
    return File('/storage/emulated/0/Download/Underline.txt');
  }

  // write data
  Future<void> writeDataUnderlined(String dipanggildari) async {
    bool adaisiga = false;
    if (mauhapussemuaunderline == true) {
      listUnderlinedKalimatdarireadjson.clear();
      listUnderlinedKalimat.clear();
      readFileUnderlined("write");
    }
    final file = await _localFileUnderlined;
    late String katagantipetik;
    log("panjang disini masuk write sini ${listUnderlinedKalimat.length}");

    dataUnderline = '';

    dataUnderline = "$dataUnderline[";
    if (mauhapussemuaunderline == false) {
      for (int i = 0; i < listUnderlinedKalimat.length; i++) {
        adaisiga = true;

        log("panjang disini berapa -${listUnderlinedKalimat[i].namakitab}");
        log("panjang disini berapa -${listUnderlinedKalimat[i].pasal}");
        log("panjang disini berapa -${listUnderlinedKalimat[i].ayat}");

        if (i != 0) {
          // ignore: prefer_interpolation_to_compose_strings

          dataUnderline = dataUnderline + ",{";
        } else {
          // ignore: prefer_interpolation_to_compose_strings
          dataUnderline = dataUnderline + "{";
        }

        dataUnderline =
            // ignore: prefer_interpolation_to_compose_strings
            dataUnderline + '"IndexUnderlined":"' + (i + 1).toString() + "\",";
        dataUnderline =
            // ignore: prefer_interpolation_to_compose_strings
            dataUnderline +
                '"NamaKitab":"' +
                listUnderlinedKalimat[i].namakitab +
                "\",";
        dataUnderline =
            // ignore: prefer_interpolation_to_compose_strings
            dataUnderline +
                '"Pasal":"' +
                listUnderlinedKalimat[i].pasal +
                "\",";
        dataUnderline =
            // ignore: prefer_interpolation_to_compose_strings
            dataUnderline + '"Ayat":"' + listUnderlinedKalimat[i].ayat + "\",";
        // ignore: prefer_interpolation_to_compose_strings
        dataUnderline = dataUnderline + '"IndexIsiTerUnderlined":';
        // ignore: prefer_interpolation_to_compose_strings
        dataUnderline = dataUnderline + "[";
        for (int j = 0; j < listUnderlinedKalimat[i].listIsiAyat.length; j++) {
          katagantipetik = listUnderlinedKalimat[i]
              .listIsiAyat[j]
              .toString()
              .replaceAll('"', '${String.fromCharCode(92)}"');
          if (j != 0) {
            // ignore: prefer_interpolation_to_compose_strings
            dataUnderline = dataUnderline + ",{";
          } else {
            // ignore: prefer_interpolation_to_compose_strings
            dataUnderline = dataUnderline + "{";
          }
          // ignore: prefer_interpolation_to_compose_strings
          dataUnderline =
              dataUnderline + '"Kata":"' + katagantipetik + '"' + '}';
        }
        dataUnderline = "$dataUnderline]";
        dataUnderline = "$dataUnderline}";
      }
    }

    // ignore: prefer_interpolation_to_compose_strings
    dataUnderline = dataUnderline + "]";
    log("masuk write sini hasil $dataUnderline");

    if (adaisiga == false || mauhapussemuaunderline == true) {
      dataUnderline = "";
    }
    // log("jadi berapa underline -$dataUnderline");
    // log("jadi berapa length disini setelah write -${listUnderlinedKalimat[0]}");
    // listUnderlinedKalimat.clear();
    // listUnderlinedKalimatdarireadjson.clear();

    if (mauhapussemuaunderline == true || dipanggildari == "awal") {
      // log("masuk if sini");
      await file.writeAsString("");
    } else {
      await file.writeAsString(dataUnderline);
    }

    // log("hasil baca - setelah write");
    readFileUnderlined("write");
    // await addPages("bacaunderline");
  }

  // read data
  Future<void> readFileUnderlined(String darimana) async {
    final file = await _localFileUnderlined;

    listUnderlinedKalimatdarireadjson.clear();

    // Read the file-
    final contents = await file.readAsString();
    log("ada disini - ${listUnderlinedKalimat.length}");

    if (contents.isNotEmpty && mauhapussemuaunderline == false) {
      //if(darimana=="addpages"){
      listUnderlinedKalimat.clear();
      //}
      setState(() {
        listUnderlinedKalimatdarireadjson = json.decode(contents);
        log("ngambil lagi ini legnth berapa sih - ${listUnderlinedKalimatdarireadjson.length}");

        //log("hasil baca file underlined - $listUnderlinedKalimatdarireadjson");
        if (listUnderlinedKalimatdarireadjson.isNotEmpty) {
          for (int i = 0; i < listUnderlinedKalimatdarireadjson.length; i++) {
            List templistkataterunderlined = [];

            Underlined cUnderlined = Underlined();
            cUnderlined.namakitab =
                listUnderlinedKalimatdarireadjson[i]["NamaKitab"];
            cUnderlined.pasal = listUnderlinedKalimatdarireadjson[i]["Pasal"];
            cUnderlined.ayat = listUnderlinedKalimatdarireadjson[i]["Ayat"];
            for (int j = 0;
                j <
                    listUnderlinedKalimatdarireadjson[i]
                            ["IndexIsiTerUnderlined"]
                        .length;
                j++) {
              templistkataterunderlined.insert(
                  j,
                  listUnderlinedKalimatdarireadjson[i]["IndexIsiTerUnderlined"]
                          [j]["Kata"]
                      .toString());
            }
            cUnderlined.listIsiAyat = templistkataterunderlined;
            //templistkataterunderlined.clear();

            listUnderlinedKalimat.add(cUnderlined);
            // listUnderlinedKalimat.insert(
            //     listUnderlinedKalimat.length, cUnderlined);
            //log("hasil baca file underlined nambah nih - ${listUnderlinedKalimat.length}");

          }
        }
        listUnderlinedKalimatdarireadjson.clear();

        for (int i = 0; i < listUnderlinedKalimat.length; i++) {
          log("hasil baca underline ======== $i");
          log("hasil baca underline ${listUnderlinedKalimat[i].namakitab}");
          log("hasil baca underline ${listUnderlinedKalimat[i].pasal}");
          log("hasil baca underline ${listUnderlinedKalimat[i].ayat}");
          log("hasil baca underline ${listUnderlinedKalimat[i].listIsiAyat.length}");
        }

        log("jadi berapa length disini setelah baca -${listUnderlinedKalimat.length}");
      });
    }
    // else {

    //   listUnderlinedKalimatdarireadjson.clear();
    //   listUnderlinedKalimat.clear();
    // }
  }

//DELETE UNDERLINE
  // Future<void> deleteUnderlined(
  //     int indexKitab, int indexPasal, int indexAyat) async {
  //   dataHighlight = '';
  //   int ygdihapus1 = 0;
  //   int ygdihapus2 = 0;
  //   dataHighlight = "$dataHighlight[";

  //   for (int i = 0; i < listTempHighlightData.length; i++) {
  //     for (int j = 0;
  //         j < listTempHighlightData[i]["KelompokHighlight"].length;
  //         j++) {
  //       if (listTempHighlightData[i]["KelompokHighlight"][j]["IndexKitab"]
  //                   .toString() ==
  //               indexKitab.toString() &&
  //           listTempHighlightData[i]["KelompokHighlight"][j]["IndexPasal"]
  //                   .toString() ==
  //               indexPasal.toString() &&
  //           listTempHighlightData[i]["KelompokHighlight"][j]["IndexAyat"]
  //                   .toString() ==
  //               indexAyat.toString()) {
  //         ygdihapus1 = i;
  //         ygdihapus2 = j;
  //         i = listTempHighlightData.length;
  //         break;
  //       }
  //     }
  //   }

  //   listTempHighlightData[ygdihapus1]["KelompokHighlight"].removeAt(ygdihapus2);
  //   for (int i = 0; i < listTempHighlightData.length; i++) {
  //     for (int j = 0;
  //         j < listTempHighlightData[i]["KelompokHighlight"].length;
  //         j++) {}
  //   }

  //   await writeData("deletehighlight");
  //   await readFile();
  // }

//END UNDERLINED DATA

//LIST HEIGHT LAYOUT DATA
  // List listUnderlinedKalimat = [];
  // List listUnderlinedKalimatdarireadjson = [];
  String dataHeightLayout = '';
  List listHeightLayoutJson = [];
  //int yangSudahDimasukinKeFileUnderlined = 0;
  //List listTempHighlightData = [];
  Future<File> get _localFileListHeightLayout async {
    return File('/storage/emulated/0/Download/HeightLayout.txt');
  }

  // write data
  Future<void> writeDataHeightLayout() async {
    final file = await _localFileListHeightLayout;
    log("height layout panjang list ${listLayoutHeight.length}");

    dataHeightLayout = '';

    dataHeightLayout = "$dataHeightLayout[";
    for (int i = 0; i < listLayoutHeight.length; i++) {
      // log("LAYOUT NAMAKITAB -${listLayoutHeight[i]}");
      // log("LAYOUT PASAL -${listLayoutHeight[i+1]}");
      // log("LAYOUT HEIGHT -${listLayoutHeight[i+2]}");

      if (i != 0) {
        // ignore: prefer_interpolation_to_compose_strings

        dataHeightLayout = "$dataHeightLayout,{";
      } else {
        // ignore: prefer_interpolation_to_compose_strings
        dataHeightLayout = dataHeightLayout + "{";
      }

      dataHeightLayout =
          // ignore: prefer_interpolation_to_compose_strings
          dataHeightLayout + '"NamaKitab":"' + listLayoutHeight[i] + "\",";
      dataHeightLayout =
          // ignore: prefer_interpolation_to_compose_strings
          dataHeightLayout + '"Pasal":"' + listLayoutHeight[i + 1] + "\",";
      dataHeightLayout =
          // ignore: prefer_interpolation_to_compose_strings
          dataHeightLayout + '"LayoutHeight":"' + listLayoutHeight[i + 2] + '"';

      dataHeightLayout = "$dataHeightLayout}";

      i = i + 2;
    }

    // ignore: prefer_interpolation_to_compose_strings
    dataHeightLayout = dataHeightLayout + "]";
    log("masuk write sini hasil LAYOUT $dataHeightLayout");

    await file.writeAsString(dataHeightLayout);
    //listLayoutHeight.clear();

    // log("hasil baca - setelah write");
    readFileHeightLayout();
    // await addPages("bacaunderline");
  }

  // read data
  Future<void> readFileHeightLayout() async {
    // List templistheightlayout = [];

    // String textasset = "assets/textfiles/file.txt"; //path to text file asset
// String text = await rootBundle.loadString(textasset);
// print(text);

    // String path = 'assets/textfiles/file.txt';
    // final file = await _localFileListHeightLayout;
    // // Read the file-

    // bool directoryExists = await Directory(path).exists();
    // bool fileExists = await File(path).exists();

    // if (directoryExists || fileExists) {
    // final contents = await file.readAsString();
    // if (contents.isNotEmpty ) {
    //listUnderlinedKalimat.clear();

    listHeightLayoutJson =
        jsonDecode(await rootBundle.loadString('assets/HeightLayout.txt'));
    log("hasilllll - $listHeightLayoutJson");
    listLayoutHeight.clear();
    log("hasil baca lengkap ${listHeightLayoutJson}");

    for (int i = 0; i < listHeightLayoutJson.length; i++) {
      // log("hasil baca json KE- ${i+1}");
      //log("hasil baca json namakitab- ${listHeightLayoutJson[i]["NamaKitab"]}");

      listLayoutHeight.add(listHeightLayoutJson[i]["NamaKitab"]);

      listLayoutHeight.add(listHeightLayoutJson[i]["Pasal"]);
      // log("hasil baca json pasal- ${listUnderlinedKalimatdarireadjson[i].Pasal}");

      listLayoutHeight.add(listHeightLayoutJson[i]["LayoutHeight"]);
      // log("hasil baca json height- ${listUnderlinedKalimatdarireadjson[i].LayoutHeight}");

      // log("hasil baca json berhasil");

    }

    listUnderlinedKalimatdarireadjson.clear();

    // }
    // }
  }

  // Future setAudio() async{
  //   audioPlayer.setReleaseMode(ReleaseMode.loop);

  //   // final player = AudioCache(prefix:'assets/lagu');
  //   // final url = await player.load('hereimtoworship.mp3');
  //   audioPlayer.setSourceAsset('assets/lagu/hereimtoworship.mp3');

  // }

  final ValueNotifier<double> layoutbuilderheight = ValueNotifier<double>(-1);
  int counter = 0;
  @override
  void initState() {
    super.initState();

    setLagu(backsound_mode);

    readFileHeightLayout();

    globals.buatkomunitas = false;
    globals.buatcatatan = false;
    globals.buatrenungan = false;
    // print("id renungan user : ${globals.lastIdRenunganUser}");

    pagesekarang = 0;
    WidgetsBinding.instance.addObserver(this);

    screenPickerColor = Colors.yellow; // Material blue.
    mycolor = screenPickerColor;

    //dialogPickerColor = Colors.red; // Material red.
    //dialogSelectColor = const Color(0xFFA239CA); // A purple color.
    // getBoolValueSF();
    //readFile();

    controllerscroll = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: ScrollDirectionn);

    controllerscroll!.addListener(() {
      //listener
    });

    getAllDataFromJson();

    getAkunfromLokal(); // Shared Preferences

    timerModel = LogoutTimerModel();
    timerModel.updateTimestamp(DateTime.now());
    logoutTimer = Timer.periodic(Duration(seconds: 1), (time) {
      DateTime currentTime = DateTime.now();
      if (currentTime.difference(timerModel.timestamp).inSeconds > 5 &&
          stickermode != true) {
        setState(() {
          fabIsVisible = false;
        });
      }
    });

    getAyatBacaanRandomSP();
    readFileUnderlined("awal");

    getStickerSP();

    //GET ULANG FILE LAYOUT HEIGHT
    // getListLayoutHeight();

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   setState(() {
    //     _panjanglayout = _key.currentContext!.size!.height;
    //   });
    // });

    //BUAT AMBIL AMBIL PANJANG TIAP LAYOUT
    // timer = Timer.periodic(Duration(seconds: 1), (timer) {
    //   setState(() {
    //     pageController.jumpToPage(counter);
    //     counter++;
    //   });
    // });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // final ItemScrollController itemScrollController = ItemScrollController();
  // final ItemPositionsListener itemPositionsListener =
  //     ItemPositionsListener.create();
  //double textComposerWidgetHeight=0.0;

  // void getheightlayout(){
  //   Future.delayed(
  //       const Duration(milliseconds: 60),
  //       () => setState(() {
  //             textComposerWidgetHeight = context.size!.height;
  //           })).then(
  //     (_) => Future.delayed(
  //           const Duration(milliseconds: 60),
  //           () => setState(() {
  //                 textComposerWidgetHeight = context.size!.height;
  //               }),
  //         ),
  //   );
  // }

  double cariHeightLayout(String namakitab, String pasal) {
    double height = 0.0;
    for (int i = 0; i < listLayoutHeight.length; i++) {
      if (listLayoutHeight[i] == namakitab &&
          listLayoutHeight[i + 1] == pasal) {
        height = double.parse(listLayoutHeight[i + 2]);
        break;
      }
    }

    return height;
  }

  Widget stickerlayoutwidget(
      int indexpage, String namakitab) {
    //log("pas dah ambil ${MediaQuery.of(context).size.height}");
    return 
    // MeasuredSize(
    //   onChange: (Size size) {
    //     log("ceking ganti selected ayat- ${size.height}");
    //     //BUAT WRITE ULANG LAYOUTHEIGHT
    //     // setState(() {
    //     //   wsize = size;
    //     //   addListLayoutHeight(namakitabdicari,i,size.height);
    //     // });
    //   },
    //   child: 
      LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final keyContext = keyheight[indexpage].currentContext;
          final box = keyContext!.findRenderObject() as RenderBox;



          // final pos = box.localToGlobal(Offset.zero);
          // log("ceking ganti selected ayat media query- ${MediaQuery.of(context).size.height}");
          if (listposition.isNotEmpty && sticker_mode == true) {
            //log("dapet wsizes - ${textComposerWidgetHeight}");
            return Container(
              // color: Colors.transparent,
              // constraints: BoxConstraints(
              //   maxHeight: min,
              // ),
              //key: keyheight,
              width: double.infinity,
              height: box.size.height,
              //height: double.infinity,
              //height: textComposerWidgetHeight,
              //height:bounds.height * 2,
              // height:keyheight.height,
              // height: double.infinity,
              //height: globals.sizeStickerLay,
              //height:9000,
              //height: wsize.height,
              //height: (panjanglayar==-99)?100:panjanglayar,
              child: Stack(children: [
                for (final sticker in listposition)
                  if (sticker.lokasipasal == indexpage &&
                      sticker.lokasikitab == namakitab)
                    (stickerselected != "assets/delete.png" ||
                            stickermode == false)
                        ? sticker.posisistiker
                        : sticker.stackstiker
              ]),
            );
          }
          return const Text("");
        },
      );
    //);
  }

  Future<void> getInfoKitab() async {
    setState(() {
      //HARUSNYA DINYALAIN
      indexKitabDiCari = widget.indexKitabdicari!;
      namakitabdicari = getNamaKitab(widget.indexKitabdicari!);
      pasalkitab = (widget.pasalKitabdicari! + 1).toString();
      ayatkitab = (widget.ayatKitabdicari! + 1).toString();
      addBookMarkedSP(
          indexKitabDiCari.toString(), pasalkitab, ayatkitab, namakitabdicari);
      log("infoo - $indexKitabDiCari $pasalkitab $ayatkitab $namakitabdicari");
    });
  }

  Future<void> aturSync() async {
    await getInfoKitab();
    //readFile();
    addPages("listayat");
    setState(() {
      loading = false;
    });
  }

  void changestickermode(bool stickerrmode) {
    setState(() {
      stickermode = stickerrmode;
      if (stickerrmode == true) {
        fabIsVisible = true;
      }
      addPages("sticker");
    });
  }

  // SHARED PREFENCES AUTO LOGIN
  List<AkunUser> listAkunUser = [];

  void getAkunfromLokal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    globals.statusLogin = prefs.getBool('StatusUser') ?? false;
    globals.emailUser = prefs.getString('EmailUser') ?? "";
    globals.password = prefs.getString('PasswordUser') ?? "";
    print(
        "status: ${globals.statusLogin}, email: ${globals.emailUser}, password: ${globals.password}");

    AkunUser.getData(globals.emailUser, globals.password).then((value) async {
      setState(() {
        listAkunUser = value;
        globals.namaDepanUser = listAkunUser[0].namadepan;
        globals.namaBelakangUser = listAkunUser[0].namabelakang;
        globals.deskripsiUser = listAkunUser[0].deskripsi;
        globals.idUser = listAkunUser[0].iduser;
        // print("status: ${globals.statusLogin}, namadepan : ${globals.namaDepanUser}, namabelakang: ${globals.namaBelakangUser}");
        print("status: ${globals.statusLogin}, id: ${globals.idUser}");
      });
    });
  }

  //SHARED PREFERENCES BOOKMARKED
  List<String> listindexbookmarked = [];
  addBookMarkedSP(String dexkitab, String salkitab, String yatkitab,
      String namkitab) async {
    //listindexbookmarked.clear;
    listindexbookmarked = [];
    listindexbookmarked.add(indexKitabDiCari.toString());
    listindexbookmarked.add(pasalkitab);
    listindexbookmarked.add(ayatkitab);
    listindexbookmarked.add(namakitabdicari);
    // listindexbookmarked.insert(0, indexKitabDiCari.toString());
    // listindexbookmarked.insert(1, pasalkitab);
    // listindexbookmarked.insert(2, ayatkitab);
    // listindexbookmarked.insert(3, namakitabdicari);

    log("infoo masuk addbookmarked${listindexbookmarked}");
    SharedPreferences bookmarkedSP = await SharedPreferences.getInstance();
    bookmarkedSP.setStringList('ListIndexKitab', listindexbookmarked);
    getBookMarkedSP();
  }

  getBookMarkedSP() async {
    // listindexbookmarked.clear();
    SharedPreferences bookmarkedSP = await SharedPreferences.getInstance();
    listindexbookmarked = bookmarkedSP.getStringList('ListIndexKitab') ?? [];
    log("infoo masuk addbook get $listindexbookmarked");
    if (listindexbookmarked.isEmpty) {
      listindexbookmarked.add(0.toString());
      listindexbookmarked.add(0.toString());
      listindexbookmarked.add(0.toString());
      listindexbookmarked.add("Kejadian");
      addBookMarkedSP(
          indexKitabDiCari.toString(), pasalkitab, ayatkitab, namakitabdicari);
    }
  }

  //SHARED PREFERENCES LISTUKURANLAYAR
  List<String> listLayoutHeight = [];
  List<String> listkoosongan = [];
  int index = 0;
  addListLayoutHeight(
      String namakitabb, int pasal, double panjanglayout) async {
    bool adaga = heightLayoutSudahAda(namakitabb, pasal.toString());
    if (adaga == false) {
      listLayoutHeight.add(namakitabb);
      listLayoutHeight.add(pasal.toString());
      listLayoutHeight.add(panjanglayout.toString());

      log("add SP LAYOUT $listLayoutHeight");
      //log("add SP LAYOUT ${listLayoutHeight[listLayoutHeight.length-3]} ${listLayoutHeight[listLayoutHeight.length-2]} ${listLayoutHeight[listLayoutHeight.length-1]}");
      // for(int i=0;i<listLayoutHeight.length;i++){
      //   log("add LAYOUT data namakitab ========================");
      //   log("add LAYOUT data namakitab - ${listLayoutHeight[i]}");
      //   log("add LAYOUT data pasal - ${listLayoutHeight[i+1]}");
      //   log("add LAYOUT data height - ${listLayoutHeight[i+2]}");
      //   i=i+2;
      // }
      SharedPreferences heightLayoutSP = await SharedPreferences.getInstance();
      //heightLayoutSP.setStringList('ListHeightLayout', listkoosongan);
      heightLayoutSP.setStringList('ListHeightLayout', listLayoutHeight);
      listLayoutHeight.clear();
      await getListLayoutHeight();
    }
  }

  getListLayoutHeight() async {
    SharedPreferences heightLayoutSP = await SharedPreferences.getInstance();
    listLayoutHeight = heightLayoutSP.getStringList('ListHeightLayout') ?? [];

    //BUAT WRITE ULANG DI FILE
    //writeDataHeightLayout();

    // for(int i=0;i<listLayoutHeight.length;i++){
    //   log("LAYOUT data namakitab =========${i+1}===============");
    //   log("LAYOUT data namakitab - ${listLayoutHeight[i]}");
    //   log("LAYOUT data pasal - ${listLayoutHeight[i+1]}");
    //   log("LAYOUT data height - ${listLayoutHeight[i+2]}");
    //   i = i+2;
    // }

    //log("get SP LAYOUT ada berapa ukuran ${listLayoutHeight.length/3}");
  }

  bool heightLayoutSudahAda(String namakitab, String pasal) {
    bool ada = false;
    for (int i = 0; i < listLayoutHeight.length; i++) {
      if (listLayoutHeight[i] == namakitab &&
          listLayoutHeight[i + 1] == pasal) {
        ada = true;
        break;
      }
    }

    return ada;
  }

  // //SHARED PREFERENCES STICKERS

  List<String> listpositionSP = [];

  addStickerSP() async {
    //print("masuk addspstiker");
    listpositionSP.insert(
        0, listposition[listposition.length - 1].posisix.toString());
    listpositionSP.insert(
        1, listposition[listposition.length - 1].posisiy.toString());
    listpositionSP.insert(
        2, listposition[listposition.length - 1].imagepath.toString());
    listpositionSP.insert(
        3, listposition[listposition.length - 1].lokasikitab.toString());
    listpositionSP.insert(
        4, listposition[listposition.length - 1].lokasipasal.toString());
    // listpositionSP.insert(
    //     5, listposition[listposition.length - 1].statusSticker.toString());
    //listposition.clear();

    //listpositionSP.insert(5, listposition[listposition.length].posisistiker);
    //print("listindexkitab - ${listindexbookmarked.length}");
    SharedPreferences stickerSP = await SharedPreferences.getInstance();
    stickerSP.setStringList('ListOfStickers', listpositionSP);
    await getStickerSP();
  }

  updatewriteStickerSP() async {
    listpositionSP.clear();

    for (int i = 0; i < listposition.length; i++) {
      listpositionSP.insert(0 + (5 * i), listposition[i].posisix.toString());
      listpositionSP.insert(1 + (5 * i), listposition[i].posisiy.toString());
      listpositionSP.insert(2 + (5 * i), listposition[i].imagepath.toString());
      listpositionSP.insert(
          3 + (5 * i), listposition[i].lokasikitab.toString());
      listpositionSP.insert(
          4 + (5 * i), listposition[i].lokasipasal.toString());
    }

    log("updatestiker - ${listpositionSP.length}");

    SharedPreferences stickerSP = await SharedPreferences.getInstance();
    await stickerSP.clear();
    stickerSP.setStringList('ListOfStickers', listpositionSP);
    await getStickerSP();
  }

  getStickerSP() async {
    SharedPreferences stickerSP = await SharedPreferences.getInstance();
    //buat clear semua di SP
    //await stickerSP.clear();
    // Return bool
    listpositionSP = stickerSP.getStringList('ListOfStickers') ?? [];

    listposition.clear();

    if (listpositionSP.isNotEmpty) {
      for (int i = 0; i < listpositionSP.length; i++) {
        // log("stiker ke - $stikerKe");
        // log("looping child ${listpositionSP[i + 2]}");

        Positioned posisistikeretanpadelete = Positioned(
          left: double.parse(listpositionSP[i]) - 20,
          top: double.parse(listpositionSP[i + 1]) - 105,
          child: Image.asset(listpositionSP[i + 2]),
        );

        Stack stackstiker = Stack(children: [
          Image.asset(listpositionSP[i + 2]),
          InkWell(
              child: Icon(
            Icons.cancel,
            color: Colors.red,
            size: 30,
          )),
        ]);

        Positioned posisistikere = Positioned(
          left: double.parse(listpositionSP[i]) - 20,
          top: double.parse(listpositionSP[i + 1]) - 105,
          child: stackstiker,
        );

        var cPost = CSticker(
            posisix: double.parse(listpositionSP[i]),
            posisiy: double.parse(listpositionSP[i + 1]),
            imagepath: listpositionSP[i + 2],
            lokasikitab: listpositionSP[i + 3],
            lokasipasal: int.parse(listpositionSP[i + 4]),
            posisistiker: posisistikeretanpadelete,
            stackstiker: posisistikere
            //,statusSticker: statSticker
            );

        i = i + 4;

        setState(() {
          listposition.add(cPost);
        });
      }
    }

    log("stiker total ada - ${listposition.length}");

    //return listpositionSP;
  }

  // List listUnderlinedKalimat = [];
  void underlineText(String namakitab, String pasal, String ayat,
      String kalimatterselect, String fulltext) {
    //listUnderlinedKalimat.clear();
    log("hasil underline - $kalimatterselect");

    List ayatTerselectSplited = kalimatterselect.split(' ');
    log("ayatsplited belum dibenerin $ayatTerselectSplited");

    if (ayatTerselectSplited.length > 1) {
      List fulltextSplited = fulltext.split(' ');
      late int indexKetemuAwal;

      bool udahketemuawal = false;
      for (int i = 0; i < fulltextSplited.length; i++) {
        if (udahketemuawal == false) {
          if (fulltextSplited[i].contains(ayatTerselectSplited[0])) {
            ayatTerselectSplited[0] = fulltextSplited[i];
            indexKetemuAwal = i;
            break;
          }
        }
      }
      ayatTerselectSplited[ayatTerselectSplited.length - 1] =
          fulltextSplited[ayatTerselectSplited.length + indexKetemuAwal - 1];

      log("ayatsplited sudah dibenerin $ayatTerselectSplited");
    }

    Underlined cUnderlined = Underlined();
    cUnderlined.namakitab = namakitab;
    cUnderlined.pasal = pasal;
    cUnderlined.ayat = ayat;
    cUnderlined.listIsiAyat = ayatTerselectSplited;
    log("jadi berapa length sblm -${listUnderlinedKalimat.length}");
    listUnderlinedKalimat.add(cUnderlined);
    //listUnderlinedKalimat.insert(listUnderlinedKalimat.length, cUnderlined);
    log("jadi berapa length  ssudah-${listUnderlinedKalimat.length}");

    writeDataUnderlined("underlined");
    log("ayatsplited class - ${listUnderlinedKalimat[0].listIsiAyat}");
  }

  void deleteUnderline(String namakitab, String pasal, String ayat) {
    bool adaygdihapus = false;
    log("masuk func delete underline");
    for (int i = 0; i < listUnderlinedKalimat.length; i++) {
      if (listUnderlinedKalimat[i].namakitab == namakitab &&
          listUnderlinedKalimat[i].pasal == pasal &&
          listUnderlinedKalimat[i].ayat == ayat) {
        listUnderlinedKalimat.removeAt(i);
        i--;
        adaygdihapus = true;
      }
    }

    if (adaygdihapus == true) {
      writeDataUnderlined("underlined");
      addPages("deleteunderline");
    }
  }

  Future<void> _showDetailAyat(
      String namakitab, String pasal, String ayat, String isiAyat) async {
    // List ayatterselect = listUnderlinedKalimat[listUnderlinedKalimat.length-1].listIsiAyat;
    // List ayatlengkap = isiAyat.split(' ');
    // int panjangadagarisbawah = ayatterselect.length;
    // int? indexmulaidigarisbawah = indexmulaiterunderline(ayatlengkap,listUnderlinedKalimat.length-1);

    return showDialog(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
            title: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "$namakitab $pasal : $ayat",
                          style: GoogleFonts.nunito(
                              textStyle: const TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 113, 9, 49))),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            deleteUnderline(namakitab, pasal, ayat);
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.deselect,
                            color: Color.fromARGB(255, 113, 9, 49),
                          )),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.cancel_outlined,
                            color: Color.fromARGB(255, 113, 9, 49),
                          )),
                      // IconButton(
                      //     onPressed: () {
                      //       Navigator.pop(context);
                      //     },
                      //     icon: const Icon(
                      //       Icons.under,
                      //       color: Color.fromARGB(255, 113, 9, 49),
                      //     ))
                    ],
                  ),
                ],
              );
            }),
            content: Container(
                child: CustomSelectableText(
              isiAyat,
              textAlign: TextAlign.left,
              items: [
                CustomSelectableTextItem.icon(
                    controlType: SelectionControlType.copy,
                    icon: const Icon(Icons.copy)),
                CustomSelectableTextItem.icon(
                    icon: const Icon(Icons.format_underline_rounded),
                    onPressed: (text) {
                      underlineText(namakitab, pasal, ayat, text, isiAyat);
                      addPages("underlined");
                      Navigator.pop(context);
                    }),
              ],
            )));
      },
    );
  }

  Future<void> _showAyatHariIni() async {
    await getAyatHariIni();
    return showDialog(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
            title: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Ayat Bacaan",
                          style: GoogleFonts.nunito(
                              textStyle: const TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 113, 9, 49))),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.cancel_outlined,
                            color: Color.fromARGB(255, 113, 9, 49),
                          ))
                    ],
                  ),
                ],
              );
            }),
            content: Container(
              child: Text(bacaanRandomHariIni),
            ));
      },
    );
  }

  // Future<void>updateStickerSP(int indexdihapus) async {
  //   SharedPreferences stickerSP = await SharedPreferences.getInstance();
  //   // Return bool
  //   listpositionSP = stickerSP.getStringList('ListOfStickers') ?? [];
  //   log("update panjang sebelum dihapus - ${listposition.length}");
  //   listposition.clear();
  //   int stikerKe=0;

  //   for (int i = 0; i < listpositionSP.length; i++) {

  //     //if (i != indexdihapus) {
  //       Positioned posisistikeretanpadelete = Positioned(
  //         left: double.parse(listpositionSP[i]) - 20,
  //         top: double.parse(listpositionSP[i + 1]) - 105,
  //         child: Image.asset(listpositionSP[i + 2]),
  //       );

  //       Stack stackstiker = Stack(children: [
  //         Container(child: Image.asset(listpositionSP[i + 2])
  //             //your code
  //             ),
  //         InkWell(
  //             onTap: () {

  //             },
  //             child: Icon(
  //               Icons.cancel,
  //               color: Colors.red,
  //               size: 20,
  //             )),
  //       ]);

  //       Positioned posisistikere = Positioned(
  //         left: double.parse(listpositionSP[i]) - 20,
  //         top: double.parse(listpositionSP[i + 1]) - 105,
  //         child: stackstiker,
  //       );

  //       var cPost = CSticker(
  //           posisix: double.parse(listpositionSP[i]),
  //           posisiy: double.parse(listpositionSP[i + 1]),
  //           imagepath: listpositionSP[i + 2],
  //           lokasikitab: listpositionSP[i + 3],
  //           lokasipasal: int.parse(listpositionSP[i + 4]),
  //           posisistiker: posisistikeretanpadelete,
  //           stackstiker: posisistikere);

  //       setState(() {
  //         if(stikerKe!=indexdihapus){
  //           listposition.add(cPost);
  //         }

  //       });
  //       stikerKe++;
  //     //}
  //     i = i + 4;
  //   }

  //   //log("update panjang sesudah dihapus - ${listposition.length}");

  // }

  // END OF SHARED PREFERENCES

  // @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        setState(() {
          //backsound_mode = false;
          setLagu(false);
        });
        break;
      case AppLifecycleState.resumed:
        setState(() {
          // backsound_mode = true;
          setLagu(backsound_mode);
        });
        break;
      case AppLifecycleState.paused:
        setState(() {
          //backsound_mode = false;
          setLagu(false);
        });

        break;
      case AppLifecycleState.detached:
        setState(() {
          //backsound_mode = false;
          setLagu(false);
        });
        break;
    }
  }

  void setLagu(bool nyalaga) {
    if (nyalaga == true) {
      setState(() {
        FlameAudio.bgm.play('hereimtoworship.mp3');
      });
    } else {
      setState(() {
        FlameAudio.bgm.stop();
      });
    }
  }

  late LogoutTimerModel timerModel;
  late Timer logoutTimer;
  Timer? timer;
  @override
  Widget build(BuildContext context) {
    String temppathsticker = stickerselected;
    // if(widget.daripagemana == "splashscreen"){
    //   namakitabdicari = "Kejadian";
    //   pasalkitab = (widget.pasalKitabdicari!+1).toString();
    //   ayatkitab = (widget.ayatKitabdicari!+1).toString();
    // }else{
    //   aturSync();
    // }
    // pasalkitab = (widget.pasalKitabdicari!+1).toString();
    // ayatkitab = (widget.ayatKitabdicari!+1).toString();
    // addPages();
    // String namakitabdicari = "Kejadian";
    // String pasalkitab = "1";
    // String ayatkitab = "1";
    //String namakitabdicari = getNamaKitab(widget.indexKitabdicari!);
    return WillPopScope(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(int.parse(globals.defaultcolor)),
            elevation: 0,
            title: TextButton(
              onPressed: () {
                //addPages();
                //getAllNamaKitabJumlahPasaldanJumlahAyatPerPasal();
                timer?.cancel();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ListAlkitab()));
              },
              child: loading
                  ? CircularProgressIndicator()
                  : Text(
                      "${namakitabdicari} ${(int.parse(pasalkitab)).toString()}",
                      // child: Text("${namakitabdicari} ${(widget.pasalKitabdicari!+1).toString()} : ${(widget.ayatKitabdicari!+1).toString()}",
                      style: GoogleFonts.nunito(
                          textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white))),
            ),
            actions: <Widget>[
              // This button presents popup menu items.
              PopupMenuButton<MenuSelected>(
                  // Callback that sets the selected popup menu item.
                  onSelected: (MenuSelected item) {
                    functionMenu(item.name, selectedAyat);
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<MenuSelected>>[
                        const PopupMenuItem<MenuSelected>(
                          value: MenuSelected.Highlight,
                          child: Text('Highlight'),
                        ),
                        const PopupMenuItem<MenuSelected>(
                          value: MenuSelected.Catatan,
                          child: Text('Catatan'),
                        ),
                        const PopupMenuItem<MenuSelected>(
                          value: MenuSelected.Renungan,
                          child: Text('Renungan'),
                        )
                      ])
            ],
          ),
          drawer: Drawer(
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      Container(
                        height: 55,
                        color: Color(int.parse(globals.defaultcolor)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: Icon(
                                  Icons.clear,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                      ),
                      ListTile(
                        // ignore: sized_box_for_whitespace
                        leading: Container(
                          width: 40,
                          height: 40,
                          child: Image.asset('assets/images/person_icon.png'),
                        ),
                        title: Text(
                          "Profile",
                          style: GoogleFonts.nunito(
                              textStyle: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      Color(int.parse(globals.defaultcolor)))),
                        ),
                        onTap: () {
                          if (globals.statusLogin == false) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          } else if (globals.statusLogin == true) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfilePageMenu()));
                          }
                        },
                      ),
                      ListTile(
                        // ignore: sized_box_for_whitespace
                        leading: Container(
                          width: 40,
                          height: 40,
                          child: Image.asset("assets/images/add_icon.png"),
                        ),
                        title: Text(
                          "Multi Pencarian",
                          style: GoogleFonts.nunito(
                              textStyle: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      Color(int.parse(globals.defaultcolor)))),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MergeAyat(
                                        indexKitabdicari: 0,
                                        pasalKitabdicari: 0,
                                        ayatkitabdicari: 0,
                                        asalPage: "homepage",
                                      )));
                        },
                      ),
                      ListTile(
                        // ignore: sized_box_for_whitespace
                        leading: Container(
                          width: 40,
                          height: 40,
                          child: Image.asset("assets/images/catatan_icon.png"),
                        ),
                        title: Text(
                          "Catatan",
                          style: GoogleFonts.nunito(
                              textStyle: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      Color(int.parse(globals.defaultcolor)))),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ListCatatan()));
                        },
                      ),
                      ListTile(
                        // ignore: sized_box_for_whitespace
                        leading: Container(
                          width: 40,
                          height: 40,
                          child: Image.asset("assets/images/alkitab_icon.png"),
                        ),
                        title: Text(
                          "Renungan",
                          style: GoogleFonts.nunito(
                              textStyle: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      Color(int.parse(globals.defaultcolor)))),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ListRenungan()));
                        },
                      ),
                      ListTile(
                        // ignore: sized_box_for_whitespace
                        leading: Container(
                          width: 40,
                          height: 40,
                          child: Image.asset("assets/images/search_icon.png"),
                        ),
                        title: Text(
                          "Pencarian",
                          style: GoogleFonts.nunito(
                              textStyle: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      Color(int.parse(globals.defaultcolor)))),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchAlkitab()));
                        },
                      ),
                      ListTile(
                        // ignore: sized_box_for_whitespace
                        leading: Container(
                          width: 40,
                          height: 40,
                          child:
                              Image.asset("assets/images/komunitas_icon.png"),
                        ),
                        title: Text(
                          "Komunitas",
                          style: GoogleFonts.nunito(
                              textStyle: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      Color(int.parse(globals.defaultcolor)))),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ListKomunitas()));
                        },
                      ),
                      ListTile(
                        // ignore: sized_box_for_whitespace
                        leading: Container(
                          width: 40,
                          height: 40,
                          child: Icon(
                            Icons.chrome_reader_mode_outlined,
                            color: Color(int.parse(globals.defaultcolor)),
                          ),
                        ),
                        title: Text(
                          "Rencana Bacaan",
                          style: GoogleFonts.nunito(
                              textStyle: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      Color(int.parse(globals.defaultcolor)))),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ListRencanaUser()));
                        },
                      ),
                      ListTile(
                        // ignore: sized_box_for_whitespace
                        leading: Container(
                          width: 40,
                          height: 40,
                          child: Icon(
                            Icons.public,
                            color: Color(int.parse(globals.defaultcolor)),
                          ),
                          // child: Image.asset("assets/images/komunitas_icon.png"),
                        ),
                        title: Text(
                          "Explore",
                          style: GoogleFonts.nunito(
                              textStyle: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      Color(int.parse(globals.defaultcolor)))),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Explore()));
                        },
                      ),
                      ListTile(
                        // ignore: sized_box_for_whitespace
                        leading: Container(
                          width: 40,
                          height: 40,
                          child: Icon(
                            Icons.chrome_reader_mode_outlined,
                            color: Color(int.parse(globals.defaultcolor)),
                          ),
                          // child: Image.asset("assets/images/komunitas_icon.png"),
                        ),
                        title: Text(
                          "Ayat Bacaan Harian",
                          style: GoogleFonts.nunito(
                              textStyle: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      Color(int.parse(globals.defaultcolor)))),
                        ),
                        onTap: () async {
                          await _showAyatHariIni();
                        },
                      ),
                      Divider(
                          indent: 16,
                          endIndent: 16,
                          height: 1,
                          color: Colors.black),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Mode Stiker",
                              style: GoogleFonts.nunito(
                                  textStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Color(
                                          int.parse(globals.defaultcolor)))),
                            ),
                            Switch(
                              // This bool value toggles the switch.
                              value: sticker_mode,
                              activeColor: Color(0xFF373A54),
                              onChanged: (bool value) {
                                // This is called when the user toggles the switch.
                                setState(() {
                                  sticker_mode = value;
                                  addPages("sticker");
                                });
                              },
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Lagu",
                                style: GoogleFonts.nunito(
                                    textStyle: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Color(
                                            int.parse(globals.defaultcolor))))),
                            Switch(
                              // This bool value toggles the switch.
                              value: backsound_mode,
                              activeColor: Color(0xFF373A54),
                              onChanged: (bool value) {
                                setState(() {
                                  backsound_mode = value;
                                  setLagu(backsound_mode);
                                });
                                // This is called when the user toggles the switch.
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: Listener(
            onPointerDown: (PointerEvent details) {
              timerModel.updateTimestamp(DateTime.now());
              setState(() {
                fabIsVisible = true;
              });
            },
            child: GestureDetector(
              onTapDown: (TapDownDetails details) =>
                  onTapDown(context, details),
              child: loading
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        Expanded(
                          child: PageView.builder(
                            pageSnapping: true,
                            controller: pageController,
                            itemCount: page.length,
                            itemBuilder: (context, index) {
                              return page[index];
                            },
                            onPageChanged: (page) {
                              log("haduh - ${cariHeightLayout(namakitabdicari, index.toString())}");
                              setState(() {
                                int pasalsekarang = page + 1;
                                pasalkitab = pasalsekarang.toString();
                                ayatkitab = "1";
                                addBookMarkedSP(indexKitabDiCari.toString(),
                                    pasalkitab, ayatkitab, namakitabdicari);
                                log("infoo - $indexKitabDiCari $pasalkitab $ayatkitab $namakitabdicari");
                                pagesekarang = page;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(8.0),
            child: AnimatedSlide(
                duration: Duration(milliseconds: 100),
                offset: fabIsVisible ? Offset.zero : Offset(0, 2),
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 500),
                  opacity: fabIsVisible ? 1 : 0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: FloatingActionButton(
                          heroTag: null,
                          onPressed: () {
                            for (int i = 0;
                                i < listSemuaNamaKitab.length;
                                i++) {
                              if (namakitabdicari == listSemuaNamaKitab[i]) {
                                if (i == 0) {
                                  indexKitabDiCari =
                                      listSemuaNamaKitab.length - 1;
                                } else {
                                  indexKitabDiCari = i - 1;
                                }

                                break;
                              }
                            }
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage(
                                          indexKitabdicari: indexKitabDiCari,
                                          pasalKitabdicari: 0,
                                          ayatKitabdicari: 0,
                                          daripagemana: "listayat",
                                        )));
                          },
                          backgroundColor:
                              Color(int.parse(globals.defaultcolor)),
                          child: Icon(Icons.skip_previous),
                        ),
                      ),
                      (sticker_mode
                          ? Expanded(
                              flex: 3,
                              child: Container(
                                padding: const EdgeInsets.only(right: 30),
                                child: FabCircularMenu(
                                    fabElevation: 30,
                                    fabSize: 70,
                                    fabColor:
                                        Color(int.parse(globals.defaultcolor)),
                                    //fabMargin: EdgeInsets.all(10),
                                    fabCloseIcon: Image.asset(fabopenicon),
                                    fabOpenIcon: Text("+\nSticker",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white)),
                                    alignment: Alignment.bottomCenter,
                                    ringDiameter: 250,
                                    onDisplayChange: (isOpen) {
                                      setState(() {
                                        isOpen
                                            ? (changestickermode(true))
                                            : (changestickermode(false));
                                      });
                                    },
                                    ringWidth: 60,
                                    children: <Widget>[
                                      IconButton(
                                          // padding: EdgeInsets.all(10),
                                          icon: Image.asset("assets/heart.png"),
                                          onPressed: () {
                                            setState(() {
                                              temppathsticker = stickerselected;
                                              stickerselected =
                                                  "assets/heart.png";
                                              fabopenicon = "assets/heart.png";
                                              if (temppathsticker ==
                                                  "assets/delete.png") {
                                                addPages("sticker");
                                                temppathsticker =
                                                    "assets/heart.png";
                                              }
                                            });
                                          }),
                                      SizedBox(width: 100),
                                      IconButton(
                                          icon:
                                              Image.asset("assets/flower.png"),
                                          onPressed: () {
                                            setState(() {
                                              temppathsticker = stickerselected;
                                              stickerselected =
                                                  "assets/flower.png";
                                              fabopenicon = "assets/flower.png";
                                              if (temppathsticker ==
                                                  "assets/delete.png") {
                                                addPages("sticker");
                                                temppathsticker =
                                                    "assets/flower.png";
                                              }
                                            });
                                          }),
                                      SizedBox(width: 100),
                                      IconButton(
                                          icon:
                                              Image.asset("assets/rainbow.png"),
                                          onPressed: () {
                                            setState(() {
                                              temppathsticker = stickerselected;
                                              stickerselected =
                                                  "assets/rainbow.png";
                                              fabopenicon =
                                                  "assets/rainbow.png";

                                              if (temppathsticker ==
                                                  "assets/delete.png") {
                                                addPages("sticker");
                                                temppathsticker =
                                                    "assets/rainbow.png";
                                              }
                                            });
                                          }),
                                      SizedBox(width: 100),
                                      IconButton(
                                          icon:
                                              Image.asset("assets/flower1.png"),
                                          onPressed: () {
                                            setState(() {
                                              temppathsticker = stickerselected;
                                              stickerselected =
                                                  "assets/flower1.png";
                                              fabopenicon =
                                                  "assets/flower1.png";

                                              if (temppathsticker ==
                                                  "assets/delete.png") {
                                                addPages("sticker");
                                                temppathsticker =
                                                    "assets/flower1.png";
                                              }
                                            });
                                          }),
                                      SizedBox(width: 100),
                                      IconButton(
                                          icon:
                                              Image.asset("assets/delete.png"),
                                          onPressed: () {
                                            setState(() {
                                              stickerselected =
                                                  "assets/delete.png";
                                              fabopenicon = "assets/delete.png";
                                              addPages("sticker");
                                            });
                                          }),
                                    ]),
                              ),
                            )
                          : SizedBox(
                              width: 235,
                            )),
                      Expanded(
                        flex: 1,
                        child: FloatingActionButton(
                          heroTag: null,
                          onPressed: () {
                            for (int i = 0;
                                i < listSemuaNamaKitab.length;
                                i++) {
                              if (namakitabdicari == listSemuaNamaKitab[i]) {
                                if (i == listSemuaNamaKitab.length - 1) {
                                  indexKitabDiCari = 0;
                                } else {
                                  indexKitabDiCari = i + 1;
                                }

                                break;
                              }
                            }
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage(
                                          indexKitabdicari: indexKitabDiCari,
                                          pasalKitabdicari: 0,
                                          ayatKitabdicari: 0,
                                          daripagemana: "listayat",
                                        )));
                          },
                          backgroundColor:
                              Color(int.parse(globals.defaultcolor)),
                          child: Icon(Icons.skip_next),
                        ),
                      ),
                    ],
                  ),
                )),
          )),
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Center(
                child: Text(
                  'Keluar dari aplikasi?',
                  style: GoogleFonts.nunito(
                      textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 113, 9, 49))),
                ),
              ),
              actionsAlignment: MainAxisAlignment.spaceAround,
              actions: [
                // ignore: sized_box_for_whitespace
                Container(
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: Text("Batal",
                        style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white))),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 113, 9, 49),
                      elevation: 5,
                      padding: const EdgeInsets.all(5),
                    ),
                  ),
                ),
                // ignore: sized_box_for_whitespace
                Container(
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      exit(0);
                    },
                    child: Text("Keluar",
                        style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white))),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(int.parse(globals.defaultcolor)),
                      elevation: 5,
                      padding: const EdgeInsets.all(5),
                    ),
                  ),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
    );
  }
}
