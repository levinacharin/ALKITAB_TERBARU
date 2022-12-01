import 'dart:convert';
import 'dart:io';

import 'package:alkitab/detailkomunitas.dart';
import 'package:alkitab/detailrefleksiuser.dart';
import 'package:alkitab/detailrenungan.dart';
import 'package:alkitab/detailrenungank.dart';
import 'package:alkitab/homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'global.dart' as globals;
import 'pecahAyatClass.dart';

class TambahRenunganK extends StatefulWidget {
  const TambahRenunganK({
    super.key
  });

  @override
  State<TambahRenunganK> createState() => _TambahRenunganKState();
}

class _TambahRenunganKState extends State<TambahRenunganK> {
  TextEditingController ctr_judul = TextEditingController();
  TextEditingController ctr_ayatbacaan = TextEditingController();
  TextEditingController ctr_ayatberkesan = TextEditingController();
  TextEditingController ctr_isirenungan = TextEditingController();
  TextEditingController ctr_tindakan = TextEditingController();
  TextEditingController ctr_linkrenungan = TextEditingController();
  TextEditingController ctr_tagline = TextEditingController();

  DateTime date = DateTime.now();
  bool isVisible = true;
  bool isEdited = false;

  List alkitab_ = globals.alkitab;
  String hasil = "";
  List ayatbacaterpilih = [];
  List<Stacks> InitStack() {
    List<Stacks> x = [];
    return x;
  }
  Stacks PopStack(List<Stacks> x) {
    Stacks tmp = x[0];
    x.removeAt(0);
    return tmp;
  }
  String pembetulanNamaKitabUnik(namakitab) {
    String tempIndexPertama = "";
    String tempNamaKitab = "";
    namakitab = namakitab.toLowerCase();
    namakitab = namakitab.replaceAll(" ", "");
    //20 kitab unique case
    if (namakitab == "kisahpararasul") {
      namakitab = "Kisah Para Rasul";
    } else if (namakitab == "hakim-hakim") {
      namakitab = "Hakim-hakim";
    } else if (namakitab == "1samuel") {
      namakitab = "1 Samuel";
    } else if (namakitab == "2samuel") {
      namakitab = "2 Samuel";
    } else if (namakitab == "1raja-raja") {
      namakitab = "1 Raja-raja";
    } else if (namakitab == "2raja-raja") {
      namakitab = "2 Raja-raja";
    } else if (namakitab == "1tawarikh") {
      namakitab = "1 Tawarikh";
    } else if (namakitab == "2tawarikh") {
      namakitab = "2 Tawarikh";
    } else if (namakitab == "kidungagung") {
      namakitab = "Kidung Agung";
    } else if (namakitab == "1korintus") {
      namakitab = "1 Korintus";
    } else if (namakitab == "2korintus") {
      namakitab = "2 Korintus";
    } else if (namakitab == "1tesalonika") {
      namakitab = "1 Tesalonika";
    } else if (namakitab == "2tesalonika") {
      namakitab = "2 Tesalonika";
    } else if (namakitab == "1timotus") {
      namakitab = "1 Timotius";
    } else if (namakitab == "2timotius") {
      namakitab = "2 Timotius";
    } else if (namakitab == "1petrus") {
      namakitab = "1 Petrus";
    } else if (namakitab == "2petrus") {
      namakitab = "2 Petrus";
    } else if (namakitab == "1yohanes") {
      namakitab = "1 Yohanes";
    } else if (namakitab == "2yohanes") {
      namakitab = "2 Yohanes";
    } else if (namakitab == "3yohanes") {
      namakitab = "3 Yohanes";
    } else {
      tempIndexPertama = namakitab[0];
      tempIndexPertama = tempIndexPertama.toUpperCase();
      tempNamaKitab = tempIndexPertama + namakitab.substring(1);
      namakitab = tempNamaKitab;
    }

    return namakitab;
  }
  List<cSelected> ayatberkesan = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (globals.roleuser == 'admin') {
      isVisible = false;
      isEdited = true;
    } else {
      isVisible = true;
      isEdited = false;
      
      ctr_judul.text = globals.judulrenungan;
      ctr_ayatbacaan.text = globals.kitabbacaan;
      ctr_isirenungan.text = globals.isirenungan;
      ctr_linkrenungan.text = globals.linkrenungan;
      ctr_tagline.text = globals.tagline;
    }
  }

  @override
  void getPecahAyat(String darimana) async {
    bool udahgantikitab = true;
    String bacaan = ctr_ayatbacaan.text.toString();
    String bacaancoba = bacaan;
    bacaancoba = bacaancoba.replaceAll(" ", "");
    String tempbacaan = "";

    for (int i = 0; i < bacaancoba.length; i++) {
      if (bacaan[i] == ";") {
        udahgantikitab = true;
      }
      tempbacaan = tempbacaan + bacaancoba[i];
      if (int.tryParse(bacaancoba[i]) == null &&
          int.tryParse(bacaancoba[i+1]) != null &&
          bacaancoba[i] != ";" &&
          udahgantikitab == true) {
            tempbacaan = tempbacaan + " ";
            udahgantikitab = false;
          }
    }

    bacaan = tempbacaan;

    var stk = InitStack();

    List<Bacaan> bacaanKitab = [];
    List<AyatN> ayatBaca = [];
    List<Kitab> alkitab = [];
    await setAlkitab2(alkitab);
    pecahAyat2(bacaan, stk);

    addBacaan(bacaanKitab, stk);
    print("ada berapa yangdicari - $bacaanKitab");
    

    addIsiAyat2(ayatBaca, bacaanKitab, alkitab);
    hasil="";
    ayatbacaterpilih.clear();
    for (int i = 0; i < ayatBaca.length; i++) {
      setState(() {
        hasil = hasil +
            ayatBaca.elementAt(i).bacaan.kitab +
            " " +
            ayatBaca.elementAt(i).bacaan.pasal +
            " : " +
            ayatBaca.elementAt(i).bacaan.ayat +
            "\n" +
            ayatBaca.elementAt(i).isi +
            "\n\n";
      });
    }

    setState(() {
      ayatbacaterpilih = ayatBaca;
    });
  }

  void pecahAyat2(String bacaan, List<Stacks> ayat) {
    String tmp = "";
    String op = "";
    String next = "*";
    String temp = "";
    String tempbacaan = "";
    String namakitab = "";
    String angkakitab = ""; 
    bool sudahmasukangka = false;

    for (int i = 0; i < bacaan.length; i++) {
      tmp = tmp + bacaan[i];

      if (bacaan[i] == "," || bacaan[i] == "-" || bacaan[i] == ":") {
        if (bacaan[i] == "-" &&
          bacaan.codeUnitAt(i + 1) <= 122 &&
          bacaan.codeUnitAt(i + 1) >= 97) {
        print("masuk skip");
      } else if (bacaan[i] == "-" &&
          bacaan.codeUnitAt(i + 1) <= 90 &&
          bacaan.codeUnitAt(i + 1) >= 65) {
        print("masuk skip");
      } else {
        next = "";
        op = ayat.last.next;
        next = next + bacaan[i];
        ayat.add(Stacks(op, tmp.substring(0, tmp.length - 1), next));
        tmp = "";
        op = "";
      }
      } else if (i == bacaan.length - 1) {
        op = ayat.last.next;
        ayat.add(Stacks(op, tmp, "*"));
      } else if (next.codeUnitAt(0) >= 44 &&
              next.codeUnitAt(0) <= 45 &&
              bacaan[i] == " " ||
          bacaan[i] == ";") {
        op = ayat.last.next;
        ayat.add(Stacks(op, tmp.substring(0, tmp.length - 1), "*"));
        tmp = "";
        op = "";
        next = "*";
      } else if (bacaan.codeUnitAt(i + 1) <= 57 &&
          bacaan.codeUnitAt(i + 1) >= 49 &&
          bacaan[i] == " ") {
        tmp = tmp.replaceAll(RegExp('\\s+'), " ");
        ayat.add(Stacks("*", tmp.substring(0, tmp.length - 1), "^"));
        tmp = "";
        op = "";
      }
    }
  }

  void addBacaan(List<Bacaan> bacaanKitab, List<Stacks> stk) {
    while (stk.length > 0) {
      Stacks tmp = PopStack(stk);
      String kitab = "";
      String pasal = "";
      String ayat = "";
      if (tmp.op == "*" && tmp.next == "^") {
        kitab = tmp.data;
        kitab = pembetulanNamaKitabUnik(kitab);
        print("testing - $kitab");
        tmp = PopStack(stk);

        if (tmp.next == ":" && tmp.op == "^") {
          pasal = tmp.data;
          do {
            tmp = PopStack(stk);
            if (tmp.op == ":" || tmp.op == ",") {
              ayat = tmp.data;
              Bacaan baca = new Bacaan(kitab, pasal, ayat);
              bacaanKitab.add(baca);
            } else if (tmp.op == "-") {
              int a = int.parse(tmp.data);
              int b = int.parse(bacaanKitab.last.ayat);
              int c = a - b;
              for (int i = 0; i < c; i++) {
                b++;
                Bacaan baca = new Bacaan(kitab, pasal, b.toString());
                bacaanKitab.add(baca);
              }
            }
          } while (tmp.next != "*");
        }
      }
    }
  }

  void addIsiAyat2( List<AyatN> ayatBaca, List<Bacaan> bacaanKitab, List<Kitab> alkitab) {
    for (int i = 0; i < bacaanKitab.length; i++) {
      String kitab = bacaanKitab.elementAt(i).kitab;
      int k = 0;
      for (int j = 0; j < alkitab.length; j++) {
        if (kitab == alkitab.elementAt(j).kitab) {
          break;
        }
        k++;
      }
      int count = i;
      while (count < bacaanKitab.length &&
          alkitab.elementAt(k).kitab == bacaanKitab.elementAt(count).kitab) {
        String pasal = bacaanKitab.elementAt(count).pasal;
        int pasalN = int.parse(pasal);
        while (count < bacaanKitab.length &&
            alkitab
                    .elementAt(k)
                    .listPasal
                    .elementAt(pasalN - 1)
                    .pasal
                    .toString() ==
                bacaanKitab.elementAt(count).pasal) {
          String ayat = bacaanKitab.elementAt(count).ayat;
          int ayatN = int.parse(ayat);
          int newAyat = ayatN;
          int ayatI = alkitab
              .elementAt(k)
              .listPasal
              .elementAt(pasalN - 1)
              .listAyat
              .elementAt(ayatN)
              .ayat;
          if (ayatI == 0) {
            ayatI = alkitab
                .elementAt(k)
                .listPasal
                .elementAt(pasalN - 1)
                .listAyat
                .elementAt(ayatN + 1)
                .ayat;
            newAyat = ayatI + 1;
          } else if (ayatN > ayatI) {
            newAyat = (ayatN - ayatI) + ayatN;
          } else if (ayatN > ayatI) {
            newAyat = (ayatN - ayatI) + ayatN;
          }
          String isi = alkitab
              .elementAt(k)
              .listPasal
              .elementAt(pasalN - 1)
              .listAyat
              .elementAt(newAyat)
              .isi;
          AyatN ayatBacaan = new AyatN(bacaanKitab.elementAt(count), isi);

          ayatBaca.add(ayatBacaan);
          count++;
        }
      }
      i = count - 1;
    }
  }

  bool adadilistayatberkesan(String namakitab, String pasal, String ayat){
    bool adapaga=false;
    for(int i=0;i<ayatberkesan.length;i++){
        if(ayatberkesan[i].getnamakitab==namakitab && ayatberkesan[i].getindexpasal==int.parse(pasal) && ayatberkesan[i].getindexayat==int.parse(ayat)){
          adapaga=true;
          break;
        }
      }

    return adapaga;
  }

  Future<void> setAlkitab2(List<Kitab> alkitab) async {
    var tmp = alkitab_.asMap();

    for (int k = 0; k < tmp.length && tmp[k]["book"] != null; k++) {
      int skip = -1;
      String kitab = tmp[k]["book"].toString();
      List<Pasal> listPasal = [];
      for (int p = k; p < tmp.length; p++) {
        if (tmp[p]["book"].toString() == null ||
            tmp[p]["book"].toString() != kitab) {
          break;
        }
        String pasalTmp = tmp[p]["chapter"].toString();
        int pasal = int.parse(pasalTmp);
        // print(pasal);
        List<Ayat> listAyat = [];
        int skipP = -1;
        skip++;
        for (int a = p; a < tmp.length; a++) {
          if (tmp[a]["chapter"].toString() == null ||
              tmp[a]["chapter"].toString() != pasalTmp) {
            // skipP -= 2;
            break;
          }
          skipP++;
          skip++;
          String ayatS = tmp[a]["verse"].toString();
          int ayat = int.parse(ayatS);
          String isi = tmp[a]["content"].toString();
          String tipe = tmp[a]["type"].toString();
          Ayat tmpAyat = new Ayat(ayat, isi, tipe);
          listAyat.add(tmpAyat);
        }
        p += skipP;
        Pasal newPasal = Pasal(pasal, listAyat);
        listPasal.add(newPasal);
        // print(listAyat.length);
      }
      Kitab newKitab = Kitab(kitab, listPasal);
      alkitab.add(newKitab);

      k += skip - listPasal.length;
    }
  }

  Future<void> selectAyatBerkesan(String namakitab, String pasal, String ayat, String isi) async {
    cSelected SelectedC = cSelected();
    bool sudahada=false;
    if(ayatberkesan.isEmpty){
      SelectedC.namaKitab = namakitab;
      SelectedC.indxPasal = int.parse(pasal);
      SelectedC.indxAyat = int.parse(ayat);
      SelectedC.konten = isi;
      ayatberkesan.add(SelectedC);
    }else{
      for(int i=0;i<ayatberkesan.length;i++){
        if(ayatberkesan[i].getnamakitab==namakitab && ayatberkesan[i].getindexpasal==int.parse(pasal) && ayatberkesan[i].getindexayat==int.parse(ayat)){
          sudahada=true;
          break;
        }
      }

      if(sudahada==false){
          SelectedC.namaKitab = namakitab;
          SelectedC.indxPasal = int.parse(pasal);
          SelectedC.indxAyat = int.parse(ayat);
          SelectedC.konten = isi;
          ayatberkesan.add(SelectedC);
      }
    }
    await setTextAyatBerkesan();
  }

  Future<void> setTextAyatBerkesan()async{
    //log("onchanged - $ayatberkesan");
    if (ayatberkesan.isNotEmpty) {
      //SORTING
      ayatberkesan.sort((a, b) {
        return a.getindexpasal!.compareTo(b.getindexpasal!.toInt());
      });

      List<cSelected> listhighlightsementara = [];
      List<cSelected> listperpasal = [];

      int pasal = ayatberkesan[0].getindexpasal!.toInt();

      for (int i = 0; i < ayatberkesan.length; i++) {
        if (pasal == ayatberkesan[i].getindexpasal &&
            i != ayatberkesan.length - 1) {
          listperpasal.add(ayatberkesan[i]);
        } else {
          if (i == ayatberkesan.length - 1) {
            listperpasal.add(ayatberkesan[i]);
            listperpasal.sort((a, b) {
              return a.getindexayat!.compareTo(b.getindexayat!.toInt());
            });
            listhighlightsementara.addAll(listperpasal);
          } else {
            listperpasal.sort((a, b) {
              return a.getindexayat!.compareTo(b.getindexayat!.toInt());
            });
            listhighlightsementara.addAll(listperpasal);
            pasal = ayatberkesan[i].getindexpasal!.toInt();
            listperpasal.clear();
            listperpasal.add(ayatberkesan[i]);
          }
        }
      }

      setState(() {
        ayatberkesan = listhighlightsementara;
      });

      //END OF SORTING
    }

    String hemtexthighlight="";
    bool ganti=true;
    bool gantikitab = false;

    for (int i = 0; i < ayatberkesan.length; i++) {
      if(ganti==true){
            gantikitab=true;
            if (i != 0) {
              hemtexthighlight = hemtexthighlight + "\n\n";
            }

        
          }else{
            gantikitab=false;
            
          }

          if (i != ayatberkesan.length - 1) {
          if (ayatberkesan[i].getnamakitab !=
                  ayatberkesan[i + 1].getnamakitab ||
              ayatberkesan[i].getindexpasal !=
                  ayatberkesan[i + 1].getindexpasal) {
            ganti = true;
          } else {
            ganti = false;
          }
        }
        
          if(gantikitab==true){
              hemtexthighlight = hemtexthighlight +ayatberkesan[i].getnamakitab.toString()+ ' '+(ayatberkesan[i].getindexpasal).toString()+"\n"+((ayatberkesan[i].getindexayat)).toString() + '. ' + ayatberkesan[i].getkonten.toString() + ' ';
            }else{
              hemtexthighlight = hemtexthighlight + ((ayatberkesan[i].getindexayat)).toString() + '. ' + ayatberkesan[i].getkonten.toString() + ' ';

            }
          
    }

    setState(() {
      ctr_ayatberkesan.text=hemtexthighlight;
    });
  }

  Future<void>unselectAyatBerkesan(String namakitab, String pasal, String ayat) async {
    //bool sudahada=false;
    late int indexdihapus;
    if(ayatberkesan.isNotEmpty){
      for(int i=0;i<ayatberkesan.length;i++){
        if(ayatberkesan[i].getnamakitab==namakitab && ayatberkesan[i].getindexpasal==int.parse(pasal) && ayatberkesan[i].getindexayat==int.parse(ayat)){
          //sudahada=true;
          indexdihapus=i;
          break;
        }
      }

      ayatberkesan.removeAt(indexdihapus);

      

      await setTextAyatBerkesan();
    }
  }

  // API tambah renungan
  void addRenunganKomunitas() async {
    String tanggal = "${date.day}/${date.month}/${date.year}";
    hasil = hasil.replaceAll("\n", "<br>");
    var url = "${globals.urllocal}renungankomunitasadd";
    var response = await http.post(Uri.parse(url), body: {
      "idkomunitas" : globals.idkomunitas,
      "tanggalrenungan" : tanggal,
      "judulrenungan" : ctr_judul.text,
      "kitabbacaan" : ctr_ayatbacaan.text,
      "ayatbacaan" : hasil,
      "isirenungan" : ctr_isirenungan.text,
      "linkrenungan" : ctr_linkrenungan.text,
      "tagline" : ctr_tagline.text
    });
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      var lastId = data['data']['getIdLast'];

      globals.lastIdRDatabase = lastId.toString();
      
      
      // ignore: use_build_context_synchronously
      globals.idrenungankomunitas = globals.lastIdRDatabase;
      globals.tanggalrenungan = tanggal;
      globals.judulrenungan = ctr_judul.text;
      globals.kitabbacaan = ctr_ayatbacaan.text;
      globals.isirenungan = ctr_isirenungan.text;
      globals.linkrenungan = ctr_linkrenungan.text;
      globals.tagline = ctr_tagline.text;
      // ignore: use_build_context_synchronously
      Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => const DetailRenunganKomunitas(darimana: "tambahrenungank",))
      );
    } else {
      final data = jsonDecode(response.body);
      var lastId = data['data']['getIdLast'];
    }
  }

  void addRefleksiUser() async {
    String tanggal = "${date.day}/${date.month}/${date.year}";
    var url = "${globals.urllocal}refleksiuseradd";
    var response = await http.post(Uri.parse(url), body: {
      "iduser" : globals.idUser,
      "idrenungankomunitas" : globals.idrenungankomunitas,
      "tanggalposting" : tanggal,
      "ayatberkesan" : ctr_ayatberkesan.text,
      "tindakansaya" : ctr_tindakan.text
    });
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      var message = data['Message'];
    }
  }
  // END OF API

  String dataRenungan = "";
  List listTempData = [];

  void writeData() async {
    var temp = "";
    var temp_berkesan = "";
    String tanggal = "${date.day}/${date.month}/${date.year}";

    // read data proses
    String path = '/storage/emulated/0/Download/Alkitab Renungan Mobile/Renunganjson.txt';
    bool directoryExists = await Directory(path).exists();
    bool fileExists = await File(path).exists();

    if (directoryExists || fileExists) {
      final contents = await File(path).readAsString();
      listTempData = []; //reset dulu
      setState(() {
        if (contents.isNotEmpty) {
          listTempData = json.decode(contents);

          for (int i = 0; i < listTempData.length; i++) {
            listTempData[i]['Ayat Bacaan'] = listTempData[i]['Ayat Bacaan']
                .toString()
                .replaceAll("<br>", "\n");
            listTempData[i]['Ayat Berkesan'] = listTempData[i]['Ayat Berkesan']
                .toString()
                .replaceAll("<br>", "\n");
          }
        }
      });
    } else if (directoryExists == false) {
        String newdir = '/storage/emulated/0/Download/Alkitab Renungan Mobile';
        // ignore: unnecessary_new
        await new Directory(newdir).create();
      }
    // end of read data proses

    // make json and add to string
    dataRenungan = ''; // reset string

    dataRenungan = dataRenungan + "[";
    if (listTempData.isNotEmpty) {
      for (int i = 0; i < listTempData.length; i++) {
        globals.lastIdRenunganUser = int.parse(listTempData[i]['Id Renungan User']);
        listTempData[i]['Ayat Bacaan'] = listTempData[i]['Ayat Bacaan']
          .toString()
          .replaceAll('"', '${String.fromCharCode(92)}"');
        listTempData[i]['Ayat Berkesan'] = listTempData[i]['Ayat Berkesan']
          .toString()
          .replaceAll('"', '${String.fromCharCode(92)}"');

        // ignore: prefer_interpolation_to_compose_strings
        dataRenungan = dataRenungan + "{";
        // ignore: prefer_interpolation_to_compose_strings
        dataRenungan = dataRenungan + 
          '"Id Renungan User":"' +
          listTempData[i]['Id Renungan User'].toString() +
          '","Id Renungan Komunitas":"' +
          listTempData[i]['Id Renungan Komunitas'].toString() +
          '","Nama Komunitas":"' +
          listTempData[i]['Nama Komunitas'].toString() +
          '","Tanggal":"' +
          listTempData[i]['Tanggal'].toString() + 
          '","Judul":"' +
          listTempData[i]['Judul'].toString() +
          '","Kitab":"' +
          listTempData[i]['Kitab'].toString() +
          '","Ayat Bacaan":"' +
          listTempData[i]['Ayat Bacaan'].toString() +
          '","Ayat Berkesan":"' +
          listTempData[i]['Ayat Berkesan'].toString() +
          '","Isi Renungan":"' +
          listTempData[i]["Isi Renungan"].toString() +
          '","Tindakan Saya":"' +
          listTempData[i]['Tindakan Saya'].toString() +
          '","Link Renungan":"' +
          listTempData[i]['Link Renungan'].toString() +
          '","Tagline":"' +
          listTempData[i]['Tagline'].toString() +
          '"},';
      }
      globals.lastIdRenunganUser = globals.lastIdRenunganUser + 1;
    }
    temp = hasil.replaceAll('"', '${String.fromCharCode(92)}"');
    temp_berkesan = ctr_ayatberkesan.text.replaceAll('"', '${String.fromCharCode(92)}"');

    // ignore: prefer_interpolation_to_compose_strings
    dataRenungan = dataRenungan + "{" +
      '"Id Renungan User":"' +
      globals.lastIdRenunganUser.toString() +
      '","Id Renungan Komunitas":"' +
      globals.idrenungankomunitas +
      '","Nama Komunitas":"'+
      globals.namakomunitas +
      '","Tanggal":"' +
      tanggal +
      '","Judul":"'+
      ctr_judul.text +
      '","Kitab":"' +
      ctr_ayatbacaan.text +
      '","Ayat Bacaan":"' +
      temp +
      '","Ayat Berkesan":"' +
      temp_berkesan +
      '","Isi Renungan":"' +
      ctr_isirenungan.text +
      '","Tindakan Saya":"' +
      ctr_tindakan.text +
      '","Link Renungan":"' +
      ctr_linkrenungan.text +
      '","Tagline":"' +
      ctr_tagline.text +
      '"}]';

      dataRenungan = dataRenungan.replaceAll("\n", "<br>");
      // write string of json to local file
      File(path).writeAsString(dataRenungan);

      // ignore: use_build_context_synchronously
      Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => DetailRenungan(id: globals.lastIdRenunganUser, shoulpop: "true", darimana: "tambahrenungank",))
      );
  }

  Future<void> _showDialogAyatBacaan() async {
    getPecahAyat("showdialogayatbacaan");
    return showDialog(
      context: context, 
      barrierDismissible: true,
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
                          globals.roleuser == 'admin' ? "Ayat Bacaan *" : "Ayat Bacaan",
                          style: GoogleFonts.nunito(
                            textStyle: const TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 113, 9, 49)
                            )
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        }, 
                        icon: const Icon(
                          Icons.cancel_outlined,
                          color: Color.fromARGB(255, 113, 9, 49),
                        )
                      )
                    ],
                  )
                ],
              );
            }
          ),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                width: double.maxFinite,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        child: TextField(
                          controller: ctr_ayatbacaan,
                          onChanged: (ctr_ayatbacaan) async {
                            if (ctr_ayatbacaan.isNotEmpty) {
                              setState(() {
                                getPecahAyat("showdialogayatbacaan");
                              });
                            } else {
                              setState(() {
                                ayatbacaterpilih.clear();
                                hasil = "";
                              });
                            }
                          },
                          cursorColor: Color(int.parse(globals.defaultcolor)),
                          decoration: InputDecoration(
                            fillColor: Colors.transparent,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Color(int.parse(globals.defaultcolor))),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Color(int.parse(globals.defaultcolor))),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Color(int.parse(globals.defaultcolor))),
                            ),
                            hintText: "Kejadian 1:1; Keluaran 1:1",
                            hintStyle: TextStyle(color: Colors.grey[400]),
                            contentPadding: EdgeInsets.all(10),
                          ),
                          style: const TextStyle(
                              height: 1.5,
                              fontSize: 14,
                              color: Color.fromARGB(255, 61, 61, 61)),
                          maxLines: 2,
                          enabled: isEdited,
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      ListView.builder(
                        itemCount: ayatbacaterpilih.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              color: (adadilistayatberkesan(ayatbacaterpilih.elementAt(index).bacaan.kitab,ayatbacaterpilih.elementAt(index).bacaan.pasal,ayatbacaterpilih.elementAt(index).bacaan.ayat) ==
                                      true)
                                  ? Colors.blue.withOpacity(0.25)
                                  : Colors.transparent,
                            ),
                            child: ListTile(
                              onTap: () {
                                selectAyatBerkesan(ayatbacaterpilih.elementAt(index).bacaan.kitab,ayatbacaterpilih.elementAt(index).bacaan.pasal,ayatbacaterpilih.elementAt(index).bacaan.ayat,ayatbacaterpilih.elementAt(index).isi);
                                Navigator.pop(context);
                                _showDialogAyatBacaan();
                              },
                              onLongPress: () {
                                unselectAyatBerkesan(ayatbacaterpilih.elementAt(index).bacaan.kitab,ayatbacaterpilih.elementAt(index).bacaan.pasal,ayatbacaterpilih.elementAt(index).bacaan.ayat);
                                Navigator.pop(context);
                                _showDialogAyatBacaan();
                              },
                              subtitle: Text(
                                "${ayatbacaterpilih.elementAt(index).bacaan.kitab + " " + ayatbacaterpilih.elementAt(index).bacaan.pasal + " : " + ayatbacaterpilih.elementAt(index).bacaan.ayat + "\n" + ayatbacaterpilih.elementAt(index).isi}"
                              )
                            ),
                          );
                        }
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }
    );
  }

  Future<void> _showDialogShare() async {
    return showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(
              "Share refleksi ke komunitas?",
              style: GoogleFonts.nunito(
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 113, 9, 49)
                )
              ),
              textAlign: TextAlign.center,
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceAround,
          actions: [
            Container(
              width: 100,
              child: ElevatedButton(
                onPressed: () {
                  writeData();
                },
                // ignore: sort_child_properties_last
                child: Text(
                  "Tidak",
                  style: GoogleFonts.nunito(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    )
                  )
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(int.parse(globals.defaultcolor)),
                  elevation: 5,
                  padding: const EdgeInsets.all(5),
                ),
              ),
            ),
            Container(
              width: 100,
              child: ElevatedButton(
                onPressed: () {
                  addRefleksiUser();
                  writeData();
                },
                // ignore: sort_child_properties_last
                child: Text(
                  "Ya",
                  style: GoogleFonts.nunito(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    )
                  )
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 113, 9, 49),
                  elevation: 5,
                  padding: const EdgeInsets.all(5),
                ),
              ),
            )
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, "refresh");
          },
          icon: const Icon(Icons.arrow_back_rounded),
          color: const Color.fromARGB(255, 113, 9, 49)
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                globals.roleuser == 'admin'? "Tambah Renungan" : "Buat Refleksi",
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 24,
                    color: Color.fromARGB(255, 113, 9, 49),
                    fontWeight: FontWeight.bold
                  )
                )
              ),
              const SizedBox(height: 30,),
              Text(
                globals.roleuser == 'admin' ? "Judul Bacaan *" : "Judul Bacaan",
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 113, 9, 49)
                  )
                )
              ),
              const SizedBox(height: 5,),
              TextField(
                controller: ctr_judul,
                cursorColor: Color(int.parse(globals.defaultcolor)),
                decoration: InputDecoration(
                  fillColor: Colors.transparent,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Color(int.parse(globals.defaultcolor))
                    )
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1, 
                      color: Color(int.parse(globals.defaultcolor))
                    )
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Color(int.parse(globals.defaultcolor))
                    )
                  ),
                  contentPadding: const EdgeInsets.all(10),
                  hintText: "Masukkan judul renungan bacaan ...",
                  hintStyle: GoogleFonts.nunito(
                    fontSize: 18,
                    color: Colors.grey[400]
                  )
                ),
                enabled: isEdited,
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    color: Colors.black
                  )
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 25,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    globals.roleuser == 'admin' ? "Ayat Bacaan *" : "Ayat Bacaan",
                    style: GoogleFonts.nunito(
                      textStyle: const TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 113, 9, 49),
                      )
                    )
                  ),
                  IconButton(
                    onPressed: () {
                      _showDialogAyatBacaan();
                    }, 
                    icon: const Icon(
                      Icons.zoom_out_map_rounded,
                      size: 25,
                      color: Color.fromARGB(255, 113, 9, 49),
                    )
                  )
                ],
              ),
              const SizedBox(height: 5,),
              TextField(
                controller: ctr_ayatbacaan,
                cursorColor: Color(int.parse(globals.defaultcolor)),
                decoration: InputDecoration(
                  fillColor: Colors.transparent,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Color(int.parse(globals.defaultcolor))
                    )
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1, 
                      color: Color(int.parse(globals.defaultcolor))
                    )
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Color(int.parse(globals.defaultcolor))
                    )
                  ),
                  contentPadding: const EdgeInsets.all(10),
                  hintText: "Kejadian 1:1-4, Imamat 3:1",
                  hintStyle: GoogleFonts.nunito(
                    fontSize: 18,
                    color: Colors.grey[400]
                  )
                ),
                enabled: isEdited,
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    color: Colors.black
                  )
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 35,),
              Text(
                globals.roleuser == 'admin' ? "Renungan *" : "Renungan",
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 113, 9, 49)
                  )
                )
              ),
              const SizedBox(height: 5,),
              TextField(
                controller: ctr_isirenungan,
                cursorColor: Color(int.parse(globals.defaultcolor)),
                decoration: InputDecoration(
                  fillColor: Colors.transparent,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Color(int.parse(globals.defaultcolor))
                    )
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1, 
                      color: Color(int.parse(globals.defaultcolor))
                    )
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Color(int.parse(globals.defaultcolor))
                    )
                  ),
                  contentPadding: const EdgeInsets.all(10),
                  hintText: "Masukkan isi renungan ...",
                  hintStyle: GoogleFonts.nunito(
                    fontSize: 18,
                    color: Colors.grey[400]
                  )
                ),
                enabled: isEdited,
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    color: Colors.black
                  )
                ),
                maxLines: 10,
              ),
              const SizedBox(height: 35,),
              Text(
                "Link Renungan",
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 113, 9, 49)
                  )
                )
              ),
              const SizedBox(height: 5,),
              TextField(
                controller: ctr_linkrenungan,
                cursorColor: Color(int.parse(globals.defaultcolor)),
                decoration: InputDecoration(
                  fillColor: Colors.transparent,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Color(int.parse(globals.defaultcolor))
                    )
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1, 
                      color: Color(int.parse(globals.defaultcolor))
                    )
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Color(int.parse(globals.defaultcolor))
                    )
                  ),
                  contentPadding: const EdgeInsets.all(10),
                  hintText: "Masukkan link yang berkaitan ...",
                  hintStyle: GoogleFonts.nunito(
                    fontSize: 18,
                    color: Colors.grey[400]
                  )
                ),
                enabled: isEdited,
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    color: Colors.black
                  )
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 35,),
              Text(
                globals.roleuser == 'admin' ? "Tagline *" : "Tagline",
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 113, 9, 49)
                  )
                )
              ),
              const SizedBox(height: 5,),
              TextField(
                controller: ctr_tagline,
                cursorColor: Color(int.parse(globals.defaultcolor)),
                decoration: InputDecoration(
                  fillColor: Colors.transparent,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Color(int.parse(globals.defaultcolor))
                    )
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1, 
                      color: Color(int.parse(globals.defaultcolor))
                    )
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Color(int.parse(globals.defaultcolor))
                    )
                  ),
                  contentPadding: const EdgeInsets.all(10),
                  hintText: "#tagline",
                  hintStyle: GoogleFonts.nunito(
                    fontSize: 18,
                    color: Colors.grey[400]
                  )
                ),
                enabled: isEdited,
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    color: Colors.black
                  )
                ),
                maxLines: 1,
              ),
              Visibility(
                visible: isVisible,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 35,),
                    Text(
                      "Ayat Berkesan *",
                      style: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 113, 9, 49)
                        )
                      ),
                    ),
                    const SizedBox(height: 5,),
                    TextField(
                      controller: ctr_ayatberkesan,
                      cursorColor: Color(int.parse(globals.defaultcolor)),
                      decoration: InputDecoration(
                        fillColor: Colors.transparent,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: Color(int.parse(globals.defaultcolor))),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: Color(int.parse(globals.defaultcolor))),
                        ),
                        contentPadding: EdgeInsets.all(10),
                        hintText: "Kejadian 1:1; Keluaran 1:1",
                        hintStyle: TextStyle(
                          color: Colors.grey[400]
                        )
                      ),
                      style: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                          fontSize: 18,
                          color: Colors.black
                        )
                      ),
                      maxLines: 8,
                    ),
                    const SizedBox(height: 35,),
                    Text(
                      "Tindakan Saya *",
                      style: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 113, 9, 49)
                        )
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      controller: ctr_tindakan,
                      cursorColor: Color(int.parse(globals.defaultcolor)),
                      decoration: InputDecoration(
                        fillColor: Colors.transparent,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: Color(int.parse(globals.defaultcolor))),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: Color(int.parse(globals.defaultcolor))),
                        ),
                        contentPadding: EdgeInsets.all(10),
                        hintText: "Apa yang akan kamu lakukan setelah membaca renungan ini ?",
                        hintStyle: TextStyle(
                          color: Colors.grey[400]
                        )
                      ),
                      style: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                          fontSize: 18,
                          color: Colors.black
                        )
                      ),
                      maxLines: 7,
                    ),
                  ],
                )
              ),
              const SizedBox(height: 60,),
              Container(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    if (globals.roleuser == 'admin') {
                      addRenunganKomunitas();
                    } else {
                      _showDialogShare();
                    }
                    
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(int.parse(globals.defaultcolor)),
                    elevation: 10,
                    padding: const EdgeInsets.all(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 4),
                    child: Text(
                      globals.roleuser == 'admin' ? "Tambah Renungan" : "Buat Refleksi",
                      style: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        )
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}