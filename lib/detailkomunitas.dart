// ignore_for_file: sort_child_properties_last
import 'dart:io';
import 'dart:math';

import 'package:alkitab/buatkomunitas.dart';
import 'package:alkitab/classrencanabacaan.dart';
import 'package:alkitab/detailrencanabaca.dart';
import 'package:alkitab/listrencanauser.dart';
import 'package:alkitab/notifikasi.dart';
import 'package:alkitab/renunganpage.dart';
import 'package:alkitab/tambahrencana.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import './global.dart' as globals;
import './listkomunitas.dart';
import './detailrenungank.dart';
import 'tambahrenungank.dart';
import 'listdoa.dart';


class AkunKomunitas {
  String idkomunitas;
  String namakomunitas;
  String statuskomunitas;
  String deskripsikomunitas;
  String passwordkomunitas;
  String tanggalpembuatan;
  String imagepath;
  String jumlahanggota = "0";

  AkunKomunitas({
    required this.idkomunitas,
    required this.namakomunitas,
    required this.statuskomunitas,
    required this.deskripsikomunitas,
    required this.passwordkomunitas,
    required this.tanggalpembuatan,
    required this.imagepath
  });

  factory AkunKomunitas.createData(Map<String, dynamic> object) {
    return AkunKomunitas(
      idkomunitas: object['idkomunitas'].toString(), 
      namakomunitas: object['namakomunitas'], 
      statuskomunitas: object['statuskomunitas'], 
      deskripsikomunitas: object['deskripsikomunitas'],
      passwordkomunitas : object['passwordkomunitas'],
      tanggalpembuatan: object['tanggalpembuatan'],
      imagepath: object['imagepath']
    );
  }


  static Future<List<AkunKomunitas>> getAllData() async {   // mengambil semua data
    var url = "${globals.urllocal}komunitasallakun";
    var apiResult = await http.get(Uri.parse(url), headers: {
      "Accept" : "application/json",
      "Access-Control-Allow-Origin" : "*"
    });
    var jsonObject = json.decode(apiResult.body);
    var data = (jsonObject as Map<String, dynamic>)['data'];
    List<AkunKomunitas> listData = [];
    if (data.toString() == "null") {
      return listData;
    } else {
      for (int i = 0; i < data.length; i++) {
        listData.add(AkunKomunitas.createData(data[i]));
      }
      return listData;
    }
  }
}

class DetailCountMembers {   // class untuk dapat jumlah anggota
  String idkomunitas;
  String jumlahanggota;

  DetailCountMembers({
    required this.idkomunitas,
    required this.jumlahanggota
  });

  factory DetailCountMembers.createData(Map<String, dynamic> object) {
    return DetailCountMembers(
      idkomunitas: object['idkomunitas'],
      jumlahanggota: object['jumlahanggota']
    );
  }

  static Future<List<DetailCountMembers>> getCountMembers() async {
    var url = "${globals.urllocal}detailcountmembers";
    var apiResult = await http.get(Uri.parse(url), headers: {
      "Accept" : "application/json",
      "Access-Control-Allow-Origin" : "*"
    });
    var jsonObject = json.decode(apiResult.body);
    var data = (jsonObject as Map<String, dynamic>)['data'];
    List<DetailCountMembers> listData = [];
    if (data.toString() == "null") {
      return listData;
    } else {
      for (int i = 0; i < data.length; i++) {
        listData.add(DetailCountMembers.createData(data[i]));
      }
      return listData;
    }
  }
}

class DetailKomunitasMembersName {  // get anggota nama dan role
  String namadepan;
  String namabelakang;
  String role;

  DetailKomunitasMembersName({
    required this.namadepan,
    required this.namabelakang,
    required this.role
  });

  factory DetailKomunitasMembersName.createData(Map<String, dynamic> object) {
    return DetailKomunitasMembersName(
      namadepan: object['namadepan'],
      namabelakang: object['namabelakang'],
      role: object['role']
    );
  }

  static Future<List<DetailKomunitasMembersName>> getDetailKomunitas(int id) async {
    var url = "${globals.urllocal}detailkomunitasmembername?idkomunitas=$id";
    var apiResult = await http.get(Uri.parse(url), headers: {
      "Accept" : "application/json",
      "Access-Control-Allow-Origin" : "*"
    });
    var jsonObject = json.decode(apiResult.body);
    var data = (jsonObject as Map<String, dynamic>)['data'];
    List<DetailKomunitasMembersName> listData = [];
    if (data.toString() == "null") {
      return listData;
    } else {
      for (int i = 0; i < data.length; i++) {
        listData.add(DetailKomunitasMembersName.createData(data[i]));
      }
      return listData;
    }
  }
}

class RencanaBacaan {
  String idrencana;
  String idkomunitas;
  String imagepath;
  String judulrencana;
  String deskripsirencana;
  String durasirencana;

  RencanaBacaan({
    required this.idrencana,
    required this.idkomunitas,
    required this.imagepath,
    required this.judulrencana,
    required this.deskripsirencana,
    required this.durasirencana
  });

  factory RencanaBacaan.createData(Map<String, dynamic> object) {
    return RencanaBacaan(
      idrencana: object['idrencana'].toString(), 
      idkomunitas: object['idkomunitas'].toString(), 
      imagepath: object['imagepath'], 
      judulrencana: object['judulrencana'], 
      deskripsirencana: object['deskripsirencana'], 
      durasirencana: object['durasirencana'].toString()
    );
  }

  static Future<List<RencanaBacaan>> getRencanaBacaan() async {
    var url ="${globals.urllocal}getdatarencana?idkomunitas=${globals.idkomunitas}";
    var apiResult = await http.get(Uri.parse(url), headers: {
      "Accept" : "application/json",
      "Access-Control-Allow-Origin" : "*"
    });

    var jsonObject = json.decode(apiResult.body);
    var data = (jsonObject as Map<String, dynamic>)['data'];
    print("data: $data");
    List<RencanaBacaan> listData = [];
    if (data.toString() == "null") {
      return listData;
    } else {
      for (int i = 0; i < data.length; i++) {
        listData.add(RencanaBacaan.createData(data[i]));
      }
      return listData;
    }
  }
}

class DetailRencana {
  String idrencana;
  String hari;
  String kitabbacaan;
  String ayatbacaan;
  String judulrenungan;
  String isirenungan;
  String linkrenungan;

  DetailRencana ({
    required this.idrencana,
    required this.hari,
    required this.kitabbacaan,
    required this.ayatbacaan,
    required this.judulrenungan,
    required this.isirenungan,
    required this.linkrenungan
  });

  factory DetailRencana.createData(Map<String, dynamic> object) {
    return DetailRencana(
      idrencana: object['idrencana'].toString(),
      hari: object['hari'].toString(),
      kitabbacaan: object['kitabbacaan'],
      ayatbacaan: object['ayatbacaan'],
      judulrenungan: object['judulrenungan'],
      isirenungan: object['isirenungan'],
      linkrenungan: object['linkrenungan']
    );
  }

  static Future<List<DetailRencana>> getDetailRencana(int idrencana) async {
    var url = "${globals.urllocal}getdetailrencana?idrencana=$idrencana";
    var apiResult = await http.get(Uri.parse(url), headers: {
      "Accept" : "application/json",
      "Access-Control-Allow-Origin" : "*"
    });

    var jsonObject = json.decode(apiResult.body);
    var data = (jsonObject as Map<String, dynamic>)['data'];
    List<DetailRencana> listData = [];
    if (data.toString() == "null") {
      return listData;
    } else {
      for (int i = 0; i < data.length; i++) {
        listData.add(DetailRencana.createData(data[i]));
      }
      return listData;
    }
  }
}

// untuk popup menu
enum Menu { itemPost, itemDoa, itemEdit, itemListDoa, itemKeluar, itemRencana }

class DetailKomunitas extends StatefulWidget {
  final String shouldpop;
  final String? pagefrom;
  // ignore: prefer_const_constructors_in_immutables
  DetailKomunitas({
    super.key, 
    required this.shouldpop,
    this.pagefrom
    // required this.dataKomunitas
  });

  @override
  State<DetailKomunitas> createState() => _DetailKomunitasState();
}

class _DetailKomunitasState extends State<DetailKomunitas> with SingleTickerProviderStateMixin {
  bool shouldPop = false;
  DateTime currentDate = DateTime.now();

  TextEditingController controller = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController ctr_isidoa = TextEditingController();
  
  // // TAB BAR CONTROLLER
  late TabController _tabController;


  // API KOMUNITAS
  List<RenunganKomunitas> listRenungan = [];
  List<DetailKomunitasMembersName> listMembers = [];
  List<RencanaBacaan> listRencana = [];
  // ignore: non_constant_identifier_names
  String role_user = "";
  // ignore: non_constant_identifier_names
  String nama_komunitas = "";
  // ignore: non_constant_identifier_names
  String jumlah_anggota = "";
  // ignore: non_constant_identifier_names
  String deskripsi_komunitas = "";

  Future<void> getListRenungan() async {
    RenunganKomunitas.getAllData().then((value) async {
      setState(() {
        listRenungan = [];
        listRenungan = value;

        String tanggaltemp = "";
        String tanggal = "";
        String bulan = "";
        String tahun = "";
        int count = 0;
        for (int i = 0; i < listRenungan.length; i++) {
          listRenungan[i].ayatbacaan = listRenungan[i].ayatbacaan.replaceAll("<br>", "\n");
          tanggaltemp = listRenungan[i].tanggalrenungan;
          for (int j = 0; j < tanggaltemp.length; j++) {
            if (tanggaltemp[j] == '/' && bulan == "") {
              if (tanggaltemp[j+2] != '/') {
                bulan = bulan + tanggaltemp[j+1] + tanggaltemp[j+2];
                count = 2;
              } else {
                bulan = bulan + tanggaltemp[j+1];
                count = 1;
              }
            } else  if (tanggaltemp[j] == '/' && count == 0) {
              tahun = tahun + tanggaltemp[j+1] + tanggaltemp[j+2] + tanggaltemp[j+3] + tanggaltemp[j+4];
              break;
            } else if (tanggal == "") {
              if (tanggaltemp[j+1] != '/') {
                tanggal = tanggal + tanggaltemp[j] + tanggaltemp[j+1];
              } else {
                tanggal = tanggal + tanggaltemp[j];
              }
            } else {
              count--;
            }
          }

          if (bulan == "1") {
            bulan = "Januari";
          } else if (bulan == "2") {
            bulan = "Februari";
          } else if (bulan == "3") {
            bulan = "Maret";
          } else if (bulan == "4") {
            bulan = "April";
          } else if (bulan == "5") {
            bulan = "Mei";
          } else if (bulan == "6") {
            bulan = "Juni";
          } else if (bulan == "7") {
            bulan = "Juli";
          } else if (bulan == "8") {
            bulan = "Agustus";
          } else if (bulan == "9") {
            bulan = "September";
          } else if (bulan == "10") {
            bulan = "Oktober";
          } else if (bulan == "11") {
            bulan = "November";
          } else if (bulan == "12") {
            bulan = "Desember";
          } 

          listRenungan[i].tanggalrenungan = "$tanggal $bulan $tahun";

          tanggaltemp = "";
          tanggal = "";
          bulan = "";
          tahun = "";
          count = 0;
        }
      });
    });
  }


  Future<void> getMembersName() async {
    DetailKomunitasMembersName.getDetailKomunitas(int.parse(globals.idkomunitas)).then((value) async {
      setState(() {
        listMembers = value;
        for (int i = 0; i < listMembers.length; i++) {
          if (listMembers[i].namadepan == globals.namaDepanUser) {
            role_user = listMembers[i].role;
          }
        }
        globals.roleuser = role_user;
        print("role user:  ${globals.roleuser}");
      });
    });
  }

  Future<void> getDataRencana() async {
    RencanaBacaan.getRencanaBacaan().then((value) async {
      setState(() {
        listRencana = value;

        getIdRencanaSP();
      });
    });
  }

  Future reloadPage() async {
    setState(() {
      getListRenungan();
      getMembersName();
      getDataRencana();
      _tabController = TabController(length: 3, vsync: this);

      if (widget.shouldpop == 'true'){
        shouldPop = true;
      } else {
        shouldPop = false;
      }
    });
  }

  void sendBantuanDoa() async {
    var url ="${globals.urllocal}listdoaadd";
    var response = await http.post(Uri.parse(url), body: {
      "iduser" : globals.idUser,
      "idkomunitas" : globals.idkomunitas,
      "isidoa" : ctr_isidoa.text
    });
    if (response.statusCode == 200) {}
    Navigator.pop(context);
  }

  Future<http.Response> exitKomunitas() async {
    // print("idkomunitas: ${globals.idkomunitas} - iduser: ${globals.idUser}");
    var url = "${globals.urllocal}detailkomunitasdelete?idkomunitas=${globals.idkomunitas}&iduser=${globals.idUser}";
    var response = await http.delete(Uri.parse(url), 
    headers: <String, String> {
      'Content-Type' : 'application/json; charset=UTF-8',
    });
    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => const ListKomunitas())
      );
    }

    return response;
  }
  // // END API KOMUNITAS

  void selectedMenu(String menu) async {
    if (menu == "itemPost") {
      final data = await Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => const TambahRenunganK())
      );

      if (data == "refresh") {
        reloadPage();
      }
    } else if (menu == "itemDoa") {
      _showDialogDoa();
    } else if (menu == "itemEdit") {
      final data = await Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => BuatKomunitas(status: 'editkomunitas',))
      );

      if (data == "refresh") {
        reloadPage();
      }

    } else if (menu == "itemListDoa") {
      Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => ListDoaPage())
      );
    } else if (menu == "itemKeluar") {
      deleteDialog();
    } else if (menu == "itemRencana") {
      final data = await Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => TambahRencana())
      );

      if (data == "refresh") {
        reloadPage();
      }
    }
  }

  Future<void> _showDialogDoa() async {
    return showDialog(
      context: context, 
      builder: (BuildContext context) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                "Tulis apa yang ingin didoakan",
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 113, 9, 49)
                  )
                ),
                textAlign: TextAlign.center
              ),
            ),
          ],
        ),
        content: TextField(
          controller: ctr_isidoa,
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
            hintText: "Masukkan doa ....",
            hintStyle: TextStyle(
              color: Colors.grey[400]
            ),
            contentPadding: const EdgeInsets.all(10),
          ),
          style: GoogleFonts.nunito(
            textStyle: const TextStyle(
              fontSize: 18,
              color: Colors.black
            )
          ),
          maxLines: 12,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            // ignore: sized_box_for_whitespace
            child: Container(
              height: 40,
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  sendBantuanDoa();
                }, 
                child: Text(
                  "Kirim Pokok Doa",
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
          ),
        ],
        actionsAlignment: MainAxisAlignment.center,
      )
    );
  }

  Future<void> deleteDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Text(
          "Apakah anda yakin ingin keluar dari komunitas?",
          style: GoogleFonts.nunito(
            textStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color( int.parse(globals.defaultcolor))
            ),
          ),
          textAlign: TextAlign.center,
        ),
        actions: [
          Container(
            width: 100,
              child: ElevatedButton(
              onPressed: () {
                exitKomunitas();
              }, 
              child: Text(
                "Keluar",
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
                Navigator.pop(context);
              }, 
              child: Text(
                "Batal",
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
            )
          ) 
        ],  
        actionsAlignment: MainAxisAlignment.spaceAround,
      )
    );
  }


  @override
  void initState() {
    super.initState();
    getListRenungan();
    getMembersName();
    getDataRencana();
    _tabController = TabController(length: 3, vsync: this);

    if (widget.shouldpop == 'true'){
      shouldPop = true;
    } else {
      shouldPop = false;
    }

    print("id komunitas: ${globals.idkomunitas}");
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  // SHARED PREFERENCES ID RENCANA
  List<String> listIdRencana = [];
  addIdRencanaSP(String idrencana) async {
    await getIdRencanaSP();
    listIdRencana.add(idrencana);
    print("listIdRencana: $listIdRencana");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setStringList('listIdRencana', listIdRencana);

    // ignore: use_build_context_synchronously
    final data = await Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => ListRencanaUser())
    );

    if (data == "refresh") {
      setState(() {
        getListRenungan();
          getMembersName();
          getDataRencana();
          _tabController = TabController(length: 3, vsync: this);

          if (widget.shouldpop == 'true'){
            shouldPop = true;
          } else {
            shouldPop = false;
          }
      });
    }
  }

  List<bool> punyaRencana = [];
  getIdRencanaSP() async {
    listIdRencana = [];
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    listIdRencana = sharedPreferences.getStringList('listIdRencana') ?? [];
    
    bool hasRencana = false;
    setState(() {
      print("list Id Rencana: $listIdRencana - ${listIdRencana.length}");
      for (int i = 0; i < listRencana.length; i++) {
        print("list Rencana $i - ${listRencana[i].idrencana}");
        hasRencana = false;
        for (int j = 0; j < listIdRencana.length; j++) {
          print("list Id Rencana for $j - ${listIdRencana[j]}");
          if (listRencana[i].idrencana == listIdRencana[j]) {
            hasRencana = true;
            break;
          }
        }

      if (hasRencana == true) {
        punyaRencana.add(true);
      } else {
        punyaRencana.add(false);
      }
    }
    });

    print("punya rencana : $punyaRencana");
  }

  // GET LIST DETAIL RENCANA
  List<DetailRencana> listDetailRencana = [];

  Future<void> getListDetailRencana(int idrencana, int index) async {
    DetailRencana.getDetailRencana(idrencana).then((value) {
      setState(() {
        listDetailRencana = value;
        writeData(idrencana, index);
      });
    });
  }

  // SAVE RENCANA TO JSON
  String dataRencana = '';
  List listTempData = [];

  void writeData(int idrencana, int index) async {
    var temp = '';

    String path = '/storage/emulated/0/Download/Rencanajson.txt';
    bool directoryExists = await Directory(path).exists();
    bool fileExists = await File(path).exists();

    if (directoryExists || fileExists) {
      final contents = await File(path).readAsString(encoding: utf8);
      listTempData = [];
      setState(() {
        if (contents.isNotEmpty) {
          listTempData = json.decode(contents);

          for (int i = 0; i < listTempData.length; i++) {
            listTempData[i]['Ayat Bacaan'] = listTempData[i]['Ayat Bacaan'].toString().replaceAll("<br>", "\n");
          }
        }
      });
    }


    dataRencana = '';
    dataRencana = "$dataRencana[";
    if (listTempData.isNotEmpty) {
      for (int i = 0; i < listTempData.length; i++) {
        temp = listTempData[i]['Ayat Bacaan'].toString().replaceAll('"', '${String.fromCharCode(92)}"');
        dataRencana = "$dataRencana{";
        // ignore: prefer_interpolation_to_compose_strings
        dataRencana = dataRencana +
        '"Id Rencana":"' +
        listTempData[i]['Id Rencana'] + 
        '","Tanggal Rencana":"' +
        listTempData[i]['Tanggal Rencana'] +
        '","Judul Rencana":"' +
        listTempData[i]['Judul Rencana'] +
        '","Deskripsi Rencana":"' +
        listTempData[i]['Deskripsi Rencana'] +
        '","Kitab Bacaan":"' +
        listTempData[i]['Kitab Bacaan'] +
        '","Ayat Bacaan":"' +
        temp +
        '","Judul Renungan":"' +
        listTempData[i]['Judul Renungan'] +
        '","Isi Renungan":"' +
        listTempData[i]['Isi Renungan'] +
        '","Link Renungan":"' +
        listTempData[i]['Link Renungan'] +
        '","Status Selesai":"' +
        listTempData[i]['Status Selesai'] +
        '"},';
      }
    }
    for (int i = 0; i < listDetailRencana.length; i++) {
      temp = listDetailRencana[i].ayatbacaan.replaceAll('"', '${String.fromCharCode(92)}"');
      // ignore: prefer_interpolation_to_compose_strings
      dataRencana = dataRencana + "{"
      '"Id Rencana":"' +
      idrencana.toString() +
      '","Tanggal Rencana":"' +
      currentDate.toString() +
      '","Judul Rencana":"' +
      listRencana[index].judulrencana + 
      '","Deskripsi Rencana":"' +
      listRencana[index].deskripsirencana +
      '","Kitab Bacaan":"' +
      listDetailRencana[i].kitabbacaan +
      '","Ayat Bacaan":"' +
      temp +
      '","Judul Renungan":"' +
      listDetailRencana[i].judulrenungan +
      '","Isi Renungan":"' +
      listDetailRencana[i].isirenungan +
      '","Link Renungan":"' +
      listDetailRencana[i].linkrenungan +
      '","Status Selesai":"' +
      'false"}';
      if (i != listDetailRencana.length-1) {
        dataRencana = dataRencana + ",";
      }
    }
    dataRencana = "$dataRencana]";
    dataRencana = dataRencana.replaceAll("\n", "<br>");

    await File(path).writeAsString(dataRencana);

    addIdRencanaSP(idrencana.toString());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              globals.listDetailRencana = [];
              Navigator.pop(context, "refresh");
            }, 
            icon: const Icon(
              Icons.arrow_back,
              color: Color.fromARGB(255, 113, 9, 49)
            )
          ),
          actions: [
            globals.roleuser != ""
            ? Row(
              children: [
                IconButton(
                  onPressed: () {
                    reloadPage();
                  }, 
                  icon: const Icon(
                    Icons.refresh,
                    color: Color.fromARGB(255, 113, 9, 49),
                  )
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => NotifikasiPage())
                      
                    );
                  }, 
                  icon: const Icon(
                    Icons.notifications,
                    color: Color.fromARGB(255, 113, 9, 49),
                  )
                ),
                globals.roleuser == 'admin'
                ? PopupMenuButton<Menu>(
                  icon: const Icon(
                    Icons.more_horiz,
                    color: Color.fromARGB(255, 113, 9, 49),
                  ),
                  padding: const EdgeInsets.all(10),
                  color: Colors.grey[100],
                  elevation: 10,
                  onSelected: (Menu item) {
                    selectedMenu(item.name);
                  },
                  itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<Menu>>[
                    PopupMenuItem<Menu>(
                      value: Menu.itemEdit,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Edit Komunitas',
                            style: GoogleFonts.nunito(
                              textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(int.parse(globals.defaultcolor))
                              )
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem<Menu>(
                      value: Menu.itemPost,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tambah Renungan',
                            style: GoogleFonts.nunito(
                              textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(int.parse(globals.defaultcolor))
                              )
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem<Menu>(
                      value: Menu.itemRencana,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tambah Rencana Bacaan',
                            style: GoogleFonts.nunito(
                              textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(int.parse(globals.defaultcolor))
                              )
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem<Menu>(
                      value: Menu.itemListDoa,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'List Doa',
                            style: GoogleFonts.nunito(
                              textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(int.parse(globals.defaultcolor))
                              )
                            ),
                          ),
                        ],
                      ),
                    )
                  ]
                )
                : PopupMenuButton<Menu>(
                  icon: const Icon(
                    Icons.more_horiz,
                    color: Color.fromARGB(255, 113, 9, 49),
                  ),
                  padding: const EdgeInsets.all(10),
                  color: Colors.grey[100],
                  elevation: 10,
                  onSelected: (Menu item) {
                    selectedMenu(item.name);
                  },
                  itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<Menu>>[
                    PopupMenuItem<Menu>(
                      value: Menu.itemDoa,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Minta Bantuan Doa',
                            style: GoogleFonts.nunito(
                              textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(int.parse(globals.defaultcolor))
                              )
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem<Menu>(
                      value: Menu.itemKeluar,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Keluar dari Komunitas',
                            style: GoogleFonts.nunito(
                              textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(int.parse(globals.defaultcolor))
                              )
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]
                ),
              ],
            )
            : Container(),
          ],
        ),
        body: Column(
          children: [
          globals.imagepathkomunitas != "-"
          ? ClipOval(
            child: Image.network(
              '${globals.urllocal}getimage?id=${globals.idkomunitas}&folder=komunitas',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          )
          : Icon(
            Icons.account_circle_outlined,
            color: Color(int.parse(globals.defaultcolor)),
            size: 100,
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                globals.namakomunitas,
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 113, 9, 49)
                  )
                ),
              ),
              const SizedBox(width: 5,),
              globals.statuskomunitas == 'publik' 
              ? Icon(Icons.lock_open_outlined, color: Color(int.parse(globals.defaultcolor)),)
              : Icon(Icons.lock_outline, color: Color(int.parse(globals.defaultcolor)),)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.person,
                size: 16,
                color: Color(int.parse(globals.defaultcolor)),
              ),
              const SizedBox(width: 5,),
              Text(
                "${globals.jumlahanggota} anggota",
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    color: Colors.black
                  )
                ),
              )
            ],
          ),
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: ReadMoreText(
              globals.deskripsikomunitas,
              trimLines: 2,
              style: GoogleFonts.nunito(
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black
                )
              ),
              textAlign: TextAlign.center,
              colorClickableText: Colors.grey[400],
              trimMode: TrimMode.Line,
              trimCollapsedText: 'See More',
              trimExpandedText: ' ..Less',
            ),
          ),
          const SizedBox(height: 15,),
          Container(
            height: 45,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey
                )
              )
            ),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              labelPadding: const EdgeInsets.only(left: 20, right: 20),
              labelColor: Colors.black,
              labelStyle: GoogleFonts.nunito(
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                )
              ),
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.black,
              tabs: const [
                Tab(text: 'Renungan',),
                Tab(text: 'Rencana Bacaan',),
                Tab(text: 'Anggota',)
              ],
            ),
          ),
          Expanded(
            child: globals.statuskomunitas == 'publik' || widget.pagefrom == 'komunitasku' || widget.pagefrom == 'buatkomunitas' || widget.pagefrom == 'joinkomunitas'
            ? TabBarView(
              controller: _tabController,
              children: [
                // Renungan
                Column(
                  children: [
                    const SizedBox(height: 20,),
                    Container(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      height: 40,
                      child: TextField(
                        controller: controller,
                        cursorColor: const Color.fromARGB(255, 95, 95, 95),
                        decoration:  InputDecoration(
                          fillColor: const Color.fromARGB(255, 253, 255, 252),
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: Color(int.parse(globals.defaultcolor))),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: Color(int.parse(globals.defaultcolor))),
                          ),
                          hintText: 'Cari Komunitas',
                          hintStyle: TextStyle(
                            color: Colors.grey[400]
                          ),
                          contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5)
                        ),
                        style: GoogleFonts.nunito(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            color: Colors.black
                          )
                        ),
                      ),
                    ),
                    const SizedBox(height: 12,),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        // ignore: prefer_is_empty
                        child: listRenungan.length > 0 
                        ? ListView.builder(
                          itemCount: listRenungan.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              child: Column(
                                children: [
                                  Card(
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  globals.imagepathkomunitas != "-"
                                                    ? ClipOval(
                                                      child: Image.network(
                                                        '${globals.urllocal}getimage?id=${globals.idkomunitas}&folder=komunitas',
                                                        width: 60,
                                                        height: 60,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    )
                                                    : Icon(
                                                      Icons.account_circle_outlined,
                                                      color: Color(int.parse(globals.defaultcolor)),
                                                      size: 60,
                                                    )
                                                ],
                                              ),
                                              const SizedBox(width: 5,),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    globals.namakomunitas,
                                                    style: GoogleFonts.nunito(
                                                      textStyle: const TextStyle(
                                                        fontSize: 18, 
                                                        fontWeight: FontWeight.bold,
                                                        color: Color.fromARGB(255, 113, 9, 49)
                                                      )
                                                    ),
                                                  ),
                                                  Text(
                                                    listRenungan[index].tanggalrenungan,
                                                    style: GoogleFonts.nunito(
                                                      textStyle: const TextStyle(
                                                        fontSize: 14,
                                                        color: Color.fromARGB(255, 125, 125, 125)
                                                      )
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 5,),
                                          Text(
                                            listRenungan[index].judulrenungan,
                                            style: GoogleFonts.nunito(
                                              textStyle: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Color(int.parse(globals.defaultcolor))
                                              )
                                            ),
                                          ),
                                          Text(
                                            listRenungan[index].kitabbacaan,
                                            style: GoogleFonts.nunito(
                                              textStyle: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.black
                                              )
                                            ),
                                          ),
                                          const SizedBox(height: 15,),
                                          ReadMoreText(
                                            listRenungan[index].isirenungan,
                                            trimLines: 3,
                                            style: GoogleFonts.nunito(
                                              textStyle: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.black
                                              )
                                            ),
                                            colorClickableText: Colors.grey[400],
                                            trimMode: TrimMode.Line,
                                            trimCollapsedText: 'See More',
                                            trimExpandedText: ' Less',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
                                ],
                              ),
                              onTap: () {
                                globals.idrenungankomunitas = listRenungan[index].idrenungankomunitas;
                                globals.tanggalrenungan = listRenungan[index].tanggalrenungan;
                                globals.judulrenungan = listRenungan[index].judulrenungan;
                                globals.kitabbacaan = listRenungan[index].kitabbacaan;
                                globals.ayatbacaan = listRenungan[index].ayatbacaan;
                                globals.isirenungan = listRenungan[index].isirenungan;
                                globals.linkrenungan = listRenungan[index].linkrenungan;
                                globals.tagline = listRenungan[index].tagline;
                                Navigator.push(
                                  context, 
                                  MaterialPageRoute(builder: (context) => const DetailRenunganKomunitas())
                                );
                              },
                            );
                          }
                        ) 
                        : Center(
                          child: Text(
                            "Belum ada Renungan",
                            style: GoogleFonts.nunito(
                              textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(int.parse(globals.defaultcolor))
                              )
                            ),
                          ),
                        )
                      ),
                    ),
                  ],
                ),
                // end of Renungan
    
                // Rencana Bacaan
                Column(
                  children: [
                    const SizedBox(height: 20,),
                    Container(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      height: 40,
                      child: TextField(
                        controller: controller,
                        cursorColor: const Color.fromARGB(255, 95, 95, 95),
                        decoration:  InputDecoration(
                          fillColor: const Color.fromARGB(255, 253, 255, 252),
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: Color(int.parse(globals.defaultcolor))),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: Color(int.parse(globals.defaultcolor))),
                          ),
                          hintText: 'Cari Komunitas',
                          hintStyle: TextStyle(
                            color: Colors.grey[400]
                          ),
                          contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5)
                        ),
                        style: GoogleFonts.nunito(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            color: Colors.black
                          )
                        ),
                      ),
                    ),
                    const SizedBox(height: 12,),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        // ignore: prefer_is_empty
                        child: listRencana.length > 0 
                        ? ListView.builder(
                          itemCount: listRencana.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              child: Column(
                                children: [
                                  Card(
                                    child: Container(
                                    padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 2,
                                          offset: const Offset(0, 2), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  ClipOval(
                                                    child: Image.asset(
                                                      "assets/images/rencana1.jpg",
                                                      width: 60,
                                                      height: 60,
                                                      fit: BoxFit.cover,
                                                    )
                                                  )
                                                ],
                                              ),
                                              const SizedBox(width: 5,),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${listRencana[index].durasirencana} hari",
                                                      style: GoogleFonts.nunito(
                                                        textStyle: const TextStyle(
                                                          fontSize: 14,
                                                          color: Color.fromARGB(255, 125, 125, 125)
                                                        )
                                                      ),
                                                    ),
                                                    Text(
                                                      listRencana[index].judulrencana,
                                                      style: GoogleFonts.nunito(
                                                        textStyle: const TextStyle(
                                                          fontSize: 18, 
                                                          fontWeight: FontWeight.bold,
                                                          color: Color.fromARGB(255, 113, 9, 49)
                                                        )
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Column(
                                                children: [
                                                  Visibility(
                                                    visible: punyaRencana[index] == true ? false : true,
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        getListDetailRencana(int.parse(listRencana[index].idrencana), index);
                                                      }, 
                                                      child: Text(
                                                        "Mulai",
                                                        style: GoogleFonts.nunito(
                                                          textStyle: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.w600,
                                                            color: Color(int.parse(globals.defaultcolor))
                                                          )
                                                        ),
                                                      ),
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor: Colors.white,
                                                        side: BorderSide(
                                                          color: Color(int.parse(globals.defaultcolor))
                                                        ),
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(10)
                                                        ),
                                                        elevation: 3,
                                                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                          const SizedBox(height: 15,),
                                          ReadMoreText(
                                            listRencana[index].deskripsirencana,
                                            trimLines: 3,
                                            style: GoogleFonts.nunito(
                                              textStyle: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.black
                                              )
                                            ),
                                            colorClickableText: Colors.grey[400],
                                            trimMode: TrimMode.Line,
                                            trimCollapsedText: 'See More',
                                            trimExpandedText: ' Less',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
                                ],
                              ),
                              onTap: () async {
                                await DetailRencana.getDetailRencana(int.parse(listRencana[index].idrencana)).then((value) {
                                  setState(() {
                                    globals.listDetailRencana = value;
                                  });
                                });
                                // ignore: use_build_context_synchronously
                                Navigator.push(
                                  context, 
                                  MaterialPageRoute(builder: (context) => DetailRencanaBaca(pagefrom: "komunitas",))
                                );
                              },
                            );
                          }
                        )
                        : Center(
                          child: Text(
                            "Belum ada Rencana",
                            style: GoogleFonts.nunito(
                              textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(int.parse(globals.defaultcolor))
                              )
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // end of Rencana Bacaan
    
                
                // Anggota
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: listMembers.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              child: Column(
                                children: [
                                  Card(
                                    elevation: 3,
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  ClipOval(
                                                    child: Image.asset(
                                                      'assets/images/pp1.jpg',
                                                      width: 60,
                                                      height: 60,
                                                      fit: BoxFit.cover,
                                                    )
                                                  )
                                                ],
                                              ),
                                              const SizedBox(width: 5,),
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "${listMembers[index].namadepan} ",
                                                      style: GoogleFonts.nunito(
                                                        textStyle: const TextStyle(
                                                          fontSize: 18, 
                                                          fontWeight: FontWeight.w600,
                                                          color: Color.fromARGB(255, 113, 9, 49)
                                                        )
                                                      ),
                                                    ),
                                                    Text(
                                                      listMembers[index].namabelakang,
                                                      style: GoogleFonts.nunito(
                                                        textStyle: const TextStyle(
                                                          fontSize: 18, 
                                                          fontWeight: FontWeight.w600,
                                                          color: Color.fromARGB(255, 113, 9, 49)
                                                        )
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                  color: Colors.transparent,
                                                  border: Border.all(
                                                    color: Color(int.parse(globals.defaultcolor)),
                                                    width: 1
                                                  ),
                                                  borderRadius: BorderRadius.circular(10)
                                                ),
                                                child: Text(
                                                  listMembers[index].role,
                                                  style: GoogleFonts.nunito(
                                                    textStyle: TextStyle(
                                                      fontSize: 16, 
                                                      fontWeight: FontWeight.w400,
                                                      color: Color(int.parse(globals.defaultcolor))
                                                    )
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
                                ],
                              ),
                            );
                          }
                        ),
                      ),
                    ],
                  ),
                ),
                // End of Anggota
              ],
            )
            : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock_outline, 
                  size: 80,
                  color: Color(int.parse(globals.defaultcolor)),
                ),
                const SizedBox(height: 10,),
                Text(
                  "Komunitas ini di privat",
                  style: GoogleFonts.nunito(
                  textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(int.parse(globals.defaultcolor))
                  )
                ),
                ),
                
              ],
            ),
          )
        ],)
      ),
      onWillPop: () async {
        return shouldPop;
      }
    );
  }
}
