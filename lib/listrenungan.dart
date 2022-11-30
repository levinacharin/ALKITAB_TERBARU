// ignore_for_file: prefer_const_constructors
import 'dart:convert';
import 'dart:io';
import 'package:alkitab/detailrenungank.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import './detailrenungan.dart';
//import './homepage.dart';
import './renunganpage.dart';
import './global.dart' as globals;
import 'homepage.dart';

class ListRenungan extends StatefulWidget {
  const ListRenungan({super.key});

  @override
  State<ListRenungan> createState() => _ListRenunganState();
}

class _ListRenunganState extends State<ListRenungan> {

  void sharerenungan(int i)async{
    
    temp_berkesan=listDataRenungan[i]['Ayat Berkesan'].toString().replaceAll('<br>', '\n');
    String renunganfull = "";
    renunganfull = 
    // ignore: prefer_interpolation_to_compose_strings
    "*Tanggal : "+
    listDataRenungan[i]['Tanggal'].toString() + 
    "\n\n" +
    "*Judul Renungan* : "+
    listDataRenungan[i]['Judul'].toString()+
    "\n\n" +
    "*Ayat Bacaan* :\n"+
    listDataRenungan[i]['Ayat Bacaan'].toString()+
    "\n\n" +
    "*Ayat Berkesan* :\n"+
    temp_berkesan.toString()+
    "\n\n" +
    "*Renungan* :\n"+
    listDataRenungan[i]['Isi Renungan'].toString()+
    "\n\n" +
    "*Tindakan Saya* :\n"+
    listDataRenungan[i]['Tindakan Saya'].toString()
    ;

    await FlutterShare.share(
      title: 'Share Renungan',
      text: renunganfull,
    );
  }
  DateTime date = DateTime.now();
  
  @override
  void initState() {
    super.initState();
    readFile();
    getRefleksi();
    //getExplore sama dengan get Refleksi
  }

  // SERVICES FILE JSON TEXT
  List listDataRenungan = []; // read and display
  List listDataTemp = []; // temp
  String dataRenungan = '';
  
  List<String> itemJudul = [];
  List<String> itemTanggal = [];
  List<String> itemKitab = [];
  List<String> itemRenungan = [];
  List<String> itemTagline = [];

  void readFile() async {
    String path = '/storage/emulated/0/Download/Alkitab Renungan Mobile/Renunganjson.txt';
    bool directoryExists = await Directory(path).exists();
    bool fileExists = await File(path).exists();

    if (directoryExists || fileExists) {
      final contents = await File(path).readAsString();
      listDataRenungan = []; //reset dulu
      itemJudul = [];
      itemTanggal = [];
      itemKitab = [];
      itemTagline = [];
      itemRenungan = [];
      if (contents.isNotEmpty) {
        listDataRenungan = json.decode(contents);
        setState(() {
          for (int i = 0; i < listDataRenungan.length; i++) {
            itemJudul.add(listDataRenungan[i]['Judul'].toString());
            itemTanggal.add(listDataRenungan[i]['Tanggal'].toString());
            itemKitab.add(listDataRenungan[i]['Kitab'].toString());
            itemTagline.add(listDataRenungan[i]['Tagline'].toString());
            itemRenungan.add(listDataRenungan[i]['Isi Renungan']);
          }
          listDataTemp = listDataRenungan ;
        });
      }
    }

    uploadFileLokal();
  }

  int huruf = 92;
  String temp = "";
  // ignore: non_constant_identifier_names
  String temp_berkesan = "";

  void deleteData(int indexdata) async {
    setState(() {
      listDataRenungan.removeAt(indexdata);
      itemJudul = [];
      itemTanggal = [];
      itemKitab = [];
      itemTagline = [];
      itemRenungan = [];
      for (int i = 0; i < listDataRenungan.length; i++) {
        itemJudul.add(listDataRenungan[i]['Judul'].toString());
        itemTanggal.add(listDataRenungan[i]['Tanggal'].toString());
        itemKitab.add(listDataRenungan[i]['Kitab'].toString());
        itemTagline.add(listDataRenungan[i]['Tagline'].toString());
        itemRenungan.add(listDataRenungan[i]['Isi Renungan']);
      }
    });

    dataRenungan = '';
    dataRenungan = "$dataRenungan[";
    for (int i = 0; i < listDataRenungan.length; i++) {
      temp = listDataRenungan[i]['Ayat Bacaan'].toString().replaceAll('"', '${String.fromCharCode(huruf)}"');
      temp_berkesan = listDataRenungan[i]['Ayat Berkesan'].toString().replaceAll('"', '${String.fromCharCode(huruf)}"');
      dataRenungan = "$dataRenungan{";
      // ignore: prefer_interpolation_to_compose_strings
      dataRenungan = dataRenungan + 
                  '"Id Renungan User":"' +
                  listDataRenungan[i]['Id Renungan User'].toString() +
                  '","Id Renungan Komunitas":"' +
                  listDataRenungan[i]['Id Renungan Komunitas'].toString() +
                  '","Nama Komunitas":"' +
                  listDataRenungan[i]['Nama Komunitas'] +
                  '","Tanggal":"' + 
                  listDataRenungan[i]['Tanggal'].toString() + 
                  '","Judul":"' + 
                  listDataRenungan[i]['Judul'].toString() +
                  '","Kitab":"' +
                  listDataRenungan[i]['Kitab'].toString() +
                  '","Ayat Bacaan":"' +
                  temp +
                  '","Ayat Berkesan":"' +
                  temp_berkesan +
                  '","Isi Renungan":"'+
                  listDataRenungan[i]['Isi Renungan'].toString() + 
                  '","Tindakan Saya":"' + 
                  listDataRenungan[i]['Tindakan Saya'].toString() + 
                  '","Link Renungan":"' +
                  listDataRenungan[i]['Link Renungan'].toString() +
                  '","Tagline":"' +
                  listDataRenungan[i]['Tagline'].toString()
                  + '"}';
      if (listDataRenungan.length != 1 && i != listDataRenungan.length - 1) {
          // ignore: prefer_interpolation_to_compose_strings
          dataRenungan = dataRenungan + ',';
        }
    }
    // ignore: prefer_interpolation_to_compose_strings
    dataRenungan = dataRenungan + "]";
    dataRenungan = dataRenungan.replaceAll("\n", "<br>");
    // write string to text file
    String path = '/storage/emulated/0/Download/Alkitab Renungan Mobile/Renunganjson.txt';
    File(path).writeAsString(dataRenungan);

    uploadFileLokal();
  }
  // END OF SERVICE

  void addAsRefleksiUser(int idx) async {
    String tanggal = "${date.day}/${date.month}/${date.year}";
    var url = "${globals.urllocal}refleksiuseradd";
    var response = await http.post(Uri.parse(url), body: {
      "iduser" : globals.idUser,
      "idrenungankomunitas" : listDataRenungan[idx]['Id Renungan Komunitas'],
      "tanggalposting" : tanggal,
      "ayatberkesan" : listDataRenungan[idx]['Ayat Berkesan'],
      "tindakansaya" : listDataRenungan[idx]['Tindakan Saya']
    });
  }

  List<bool> sharetokomunitas = [];
  bool isExist = false;
  String idrefleksi = "";
  Future<void> getRefleksi() async {
    RefleksiUser.getAllData().then((value) async {
      setState(() {
        for (int i = 0; i < listDataRenungan.length; i++) {
          isExist = false;
          for (int j = 0; j < value.length; j++) {
            if (listDataRenungan[i]['Id Renungan Komunitas'] == value[j].idrenungankomunitas && 
                value[j].iduser == globals.idUser) {
                  isExist = true;
                }
          }

          if (isExist == true || listDataRenungan[i]['Id Renungan Komunitas'] == "0") {
            sharetokomunitas.add(false);
          } else {
            sharetokomunitas.add(true);
          }
        }
      });
    });  
  }

  void addToExplore() async {
    var tanggal = "${date.day}/${date.month}/${date.year}";
    var url = "${globals.urllocal}simpanrenunganexplore";
    var response = await http.post(Uri.parse(url), body: {
      "iduser" : globals.idUser,
      "idrefleksi" : idrefleksi,
      "tanggalposting" : tanggal,
      "komentar" : "0",
      "suka" : "0"
    });
  }

  void addToRenunganKomunitas(int idx) async {
    var lastId = 0;

    var url = "${globals.urllocal}renungankomunitasadd";
    var response = await http.post(Uri.parse(url), body: {
      "idkomunitas" : "0",
      "tanggalrenungan" : listDataRenungan[idx]['Tanggal'],
      "judulrenungan" : listDataRenungan[idx]['Judul'],
      "kitabbacaan" : listDataRenungan[idx]['Kitab'],
      "ayatbacaan" : listDataRenungan[idx]['Ayat Bacaan'],
      "isirenungan" : listDataRenungan[idx]['Isi Renungan'],
      "link renungan" : listDataRenungan[idx]['Link Renungan'],
      "tagline" : listDataRenungan[idx]['Tagline']
    });
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      lastId = data['data']['getIdLast'];
    }

    addToRefleksiUser(lastId.toString(), idx);
  }

  void addToRefleksiUser(String lastId, int idx) async {
    var url = "${globals.urllocal}refleksiuseradd";
    var response = await http.post(Uri.parse(url), body: {
      "iduser" : globals.idUser,
      "idrenungankomunitas" : lastId,
      "tanggalposting" : listDataRenungan[idx]['Tanggal'],
      "ayatberkesan" : listDataRenungan[idx]['Ayat Berkesan'],
      "tindakansaya" : listDataRenungan[idx]['Tindakan Saya']
    });
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      var lastId = data['data']['getIdLast'];

      idrefleksi = lastId.toString();

    }
    addToExplore();
  }

  Future<void> uploadFileLokal() async {
    String path5 = '/storage/emulated/0/Download/Alkitab Renungan Mobile/Renunganjson.txt';
    var url5 = '${globals.urllocal}uploaddatalokal';
    var request5  = http.MultipartRequest("POST", Uri.parse(url5));
    request5.fields['id'] = globals.idUser;
    request5.fields['folder'] = 'Renunganjson';
    request5.files.add(
      await http.MultipartFile.fromPath('filejson', path5)
    );
    // ignore: unused_local_variable
    var res5 = await request5.send();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigator.push(
              //   context, 
              //   MaterialPageRoute(builder: (context) => HomePage(indexKitabdicari: 0, pasalKitabdicari: 0, ayatKitabdicari: 0, daripagemana: "listrenungan"))
              // );
            },
            icon: const Icon(Icons.arrow_back_rounded),
            color: const Color.fromARGB(255, 113, 9, 49)
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: Text(
                "Renungan", 
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 24, 
                    fontWeight: FontWeight.bold, 
                    color: Color.fromARGB(255, 113, 9, 49)
                  )
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              height: 40,
              child: TextField(
                onChanged: (searchText) {
                  searchText = searchText.toLowerCase();
                  setState(() {
                    List listfordisplay = [];
                    for (int i = 0; i < listDataTemp.length; i++) {
                      String temptag = listDataTemp[i]["Tagline"];
                      String tempjudul = listDataTemp[i]["Judul"];
                      temptag = temptag.toLowerCase();
                      tempjudul = tempjudul.toLowerCase();
                      if (temptag.contains(searchText) || tempjudul.contains(searchText)) {
                        listfordisplay.add(listDataTemp[i]);
                      }
                    }
                    
                    listDataRenungan = [];
                    listDataRenungan = listfordisplay;
      
                    itemJudul = [];
                    itemTanggal = [];
                    itemKitab = [];
                    itemTagline = [];
                    itemRenungan = [];
                    for (int i = 0; i < listDataRenungan.length; i++) {
                      itemJudul.add(listDataRenungan[i]['Judul'].toString());
                      itemTanggal.add(listDataRenungan[i]['Tanggal'].toString());
                      itemKitab.add(listDataRenungan[i]['Kitab'].toString());
                      itemTagline.add(listDataRenungan[i]['Tagline'].toString());
                      itemRenungan.add(listDataRenungan[i]['Renungan'].toString());
                    }
                  });
                },
                cursorColor: Color.fromARGB(255, 95, 95, 95),
                decoration: InputDecoration(
                  fillColor: Color.fromARGB(255, 253, 255, 252),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Color(int.parse(globals.defaultcolor))),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Color(int.parse(globals.defaultcolor))),
                  ),
                  hintText: 'Cari Taglines',
                  hintStyle: TextStyle(
                    color: Colors.grey[400]
                  ),
                  contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 5)
                ),
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    color: Colors.black
                  )
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12, right: 12),
                          child: Card(
                            elevation: 3,
                            child: Container(
                              padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      listDataRenungan[index]['Id Renungan Komunitas'] != "0"
                                      ? 
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color: Color(0xFF373A54),
                                                      
                                                    ),
                                                    child: Text("Komunitas",
                                                    textAlign: TextAlign.center,
                                                        style: GoogleFonts.nunito(
                                                            textStyle: const TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                color: Colors
                                                                    .white))),
                                                                    
                                                  ),
                                          ),
                                          Expanded(
                                            child: Container(
                                            
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              
                                            ),
                                          ),
                                        ],
                                      )
                                      : Container(
                                      ),
                                    ],
                                  ),
                                  listDataRenungan[index]['Id Renungan Komunitas'] != "0"
                                      ? SizedBox(height: 9):SizedBox(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          itemJudul[index], 
                                          style: GoogleFonts.nunito(
                                            textStyle: TextStyle(
                                              fontSize: 18, 
                                              fontWeight: FontWeight.bold, 
                                              color: Color(int.parse(globals.defaultcolor))
                                            )
                                          ),
                                        )
                                      ),
                                      
                                      PopupMenuButton(
                                        icon: Icon(
                                          Icons.more_horiz,
                                          color: Color.fromARGB(255, 113, 9, 49),
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(8))
                                        ),
                                        itemBuilder: (context) => [
                                          PopupMenuItem(
                                            // ignore: sort_child_properties_last
                                            child: Row(
                                              children: const [
                                                Icon(Icons.create),
                                                SizedBox(width: 5,),
                                                Text("Edit"),
                                              ],
                                            ),
                                            value: 1,
                                          ),
                                          PopupMenuItem(
                                            // ignore: sort_child_properties_last
                                            child: Row(
                                              children: const [
                                                Icon(Icons.auto_delete),
                                                SizedBox(width: 5,),
                                                Text("Delete"),
                                              ],
                                            ),
                                            value: 2,
                                          ),
                                          PopupMenuItem(
                                            // ignore: sort_child_properties_last
                                            child: Row(
                                              children: const [
                                                Icon(Icons.share),
                                                SizedBox(width: 5,),
                                                Text("Share"),
                                              ],
                                            ),
                                            value: 3,
                                          )
                                        ],
                                        onSelected: (value) async {
                                          if (value == 1) {
                                            final data = await Navigator.push(
                                              context, 
                                              MaterialPageRoute(builder: (context) => RenunganPage(status: 'edit', index: index, darimana: 'listrenungan',))
                                            );
                                            if (data == "refresh") {
                                              readFile();
                                              getRefleksi();
                                            }
                                          } else if (value == 2) {
                                            deleteData(index);
                                          } else if (value == 3) {
                                            setState(() {
                                              if (sharetokomunitas[index] == true) {
                                                showModalBottomSheet(
                                                  context: context, 
                                                  builder: (BuildContext context) {
                                                    return Container(
                                                      height: 200,
                                                      padding: const EdgeInsets.only(top: 30),
                                                      color: Colors.white,
                                                      child: Center(
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () async {
                                                                if (globals.idUser != "") {
                                                                  addAsRefleksiUser(index);
                                                                  await showDialog(
                                                                    context: context, 
                                                                    builder: (context) {
                                                                      return AlertDialog(
                                                                        title: Center(
                                                                          child: Text(
                                                                            "Kirim ke komunitas berhasil",
                                                                            style: GoogleFonts.nunito(
                                                                              textStyle: const TextStyle(
                                                                                fontSize: 18,
                                                                                fontWeight: FontWeight.w500,
                                                                                color: Color.fromARGB(255, 113, 9, 49)
                                                                              )
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        actions: [
                                                                          Container(
                                                                            width: MediaQuery.of(context).size.width,
                                                                            child: ElevatedButton(
                                                                              onPressed: () {
                                                                                setState(() {
                                                                                  readFile();
                                                                                  getRefleksi();
                                                                                });
                                                                                Navigator.pop(context);
                                                                                
                                                                              },
                                                                              style: ElevatedButton.styleFrom(
                                                                                backgroundColor: Color(int.parse(globals.defaultcolor)),
                                                                                elevation: 5,
                                                                                padding: const EdgeInsets.all(5),
                                                                              ),
                                                                              child: Text(
                                                                                "Oke",
                                                                                style: GoogleFonts.nunito(
                                                                                  textStyle: const TextStyle(
                                                                                    fontSize: 16,
                                                                                    color: Colors.white
                                                                                  )
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      );
                                                                    }
                                                                  );
                                                                } else {
                                                                  await showDialog(
                                                                    context: context, 
                                                                    builder: (context) {
                                                                      return AlertDialog(
                                                                        title: Center(
                                                                          child: Text(
                                                                            "Silahkan Login Terlebih Dahulu",
                                                                            style: GoogleFonts.nunito(
                                                                              textStyle: const TextStyle(
                                                                                fontSize: 18,
                                                                                fontWeight: FontWeight.w500,
                                                                                color: Color.fromARGB(255, 113, 9, 49)
                                                                              )
                                                                            ),
                                                                            textAlign: TextAlign.center,
                                                                          ),
                                                                        ),
                                                                        actions: [
                                                                          Container(
                                                                            width: MediaQuery.of(context).size.width,
                                                                            child: ElevatedButton(
                                                                              onPressed: () {
                                                                                Navigator.pop(context);
                                                                              },
                                                                              style: ElevatedButton.styleFrom(
                                                                                backgroundColor: Color(int.parse(globals.defaultcolor)),
                                                                                elevation: 5,
                                                                                padding: const EdgeInsets.all(5),
                                                                              ),
                                                                              child: Text(
                                                                                "Oke",
                                                                                style: GoogleFonts.nunito(
                                                                                  textStyle: const TextStyle(
                                                                                    fontSize: 16,
                                                                                    color: Colors.white
                                                                                  )
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      );
                                                                    }
                                                                  );
                                                                }
                                                              },
                                                              child: Column(
                                                                children: [
                                                                  Container(
                                                                    width: 50,
                                                                    height: 50,
                                                                    child: Image.asset("assets/images/icon_komunitas.png"),
                                                                  ),
                                                                  const SizedBox(height: 5,),
                                                                  Container(
                                                                    width: 100,
                                                                    child: Column(
                                                                      children: [
                                                                        Text(
                                                                          "Kirim ke Komunitas",
                                                                          style: GoogleFonts.nunito(
                                                                            textStyle: const TextStyle(
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.w600,
                                                                              color: Colors.black
                                                                            )
                                                                          ),
                                                                          textAlign: TextAlign.center,
                                                                        ),
                                                                        const SizedBox(height: 5,),
                                                                        Text(
                                                                          "( ${listDataRenungan[index]['Nama Komunitas']} )",
                                                                          style: GoogleFonts.nunito(
                                                                            textStyle: const TextStyle(
                                                                              fontSize: 14,
                                                                              color: Color.fromARGB(255, 113, 9, 49)
                                                                            )
                                                                          ),
                                                                          textAlign: TextAlign.center,
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () async {
                                                                if (globals.idUser != "") {
                                                                  addToExplore();
                                                                  await showDialog(
                                                                    context: context, 
                                                                    builder: (context) {
                                                                      return AlertDialog(
                                                                        title: Center(
                                                                          child: Text(
                                                                            "Kirim ke explore berhasil",
                                                                            style: GoogleFonts.nunito(
                                                                              textStyle: const TextStyle(
                                                                                fontSize: 18,
                                                                                fontWeight: FontWeight.w500,
                                                                                color: Color.fromARGB(255, 113, 9, 49)
                                                                              )
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        actions: [
                                                                          Container(
                                                                            width: MediaQuery.of(context).size.width,
                                                                            child: ElevatedButton(
                                                                              onPressed: () {
                                                                                Navigator.pop(context);
                                                                              },
                                                                              style: ElevatedButton.styleFrom(
                                                                                backgroundColor: Color(int.parse(globals.defaultcolor)),
                                                                                elevation: 5,
                                                                                padding: const EdgeInsets.all(5),
                                                                              ),
                                                                              child: Text(
                                                                                "Oke",
                                                                                style: GoogleFonts.nunito(
                                                                                  textStyle: const TextStyle(
                                                                                    fontSize: 16,
                                                                                    color: Colors.white
                                                                                  )
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      );
                                                                    }
                                                                  );
                                                                }
                                                                else {
                                                                  await showDialog(
                                                                    context: context, 
                                                                    builder: (context) {
                                                                      return AlertDialog(
                                                                        title: Center(
                                                                          child: Text(
                                                                            "Silahkan Login Terlebih Dahulu",
                                                                            style: GoogleFonts.nunito(
                                                                              textStyle: const TextStyle(
                                                                                fontSize: 18,
                                                                                fontWeight: FontWeight.w500,
                                                                                color: Color.fromARGB(255, 113, 9, 49)
                                                                              )
                                                                            ),
                                                                            textAlign: TextAlign.center,
                                                                          ),
                                                                        ),
                                                                        actions: [
                                                                          Container(
                                                                            width: MediaQuery.of(context).size.width,
                                                                            child: ElevatedButton(
                                                                              onPressed: () {
                                                                                Navigator.pop(context);
                                                                              },
                                                                              style: ElevatedButton.styleFrom(
                                                                                backgroundColor: Color(int.parse(globals.defaultcolor)),
                                                                                elevation: 5,
                                                                                padding: const EdgeInsets.all(5),
                                                                              ),
                                                                              child: Text(
                                                                                "Oke",
                                                                                style: GoogleFonts.nunito(
                                                                                  textStyle: const TextStyle(
                                                                                    fontSize: 16,
                                                                                    color: Colors.white
                                                                                  )
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      );
                                                                    }
                                                                  );
                                                                }
                                                              },
                                                              child: Column(
                                                                children: [
                                                                  Container(
                                                                    width: 50,
                                                                    height: 50,
                                                                    child: Image.asset("assets/images/icon_explore.png"),
                                                                  ),
                                                                  const SizedBox(height: 5,),
                                                                  Container (
                                                                    width: 100,
                                                                    child: Text(
                                                                      "Kirim ke Explore",
                                                                      style: GoogleFonts.nunito(
                                                                        textStyle: const TextStyle(
                                                                          fontSize: 16,
                                                                          fontWeight: FontWeight.w600,
                                                                          color: Colors.black
                                                                        )
                                                                      ),
                                                                      textAlign: TextAlign.center,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                sharerenungan(index);
                                                              },
                                                              child: Column(
                                                                children: [
                                                                  Container(
                                                                    width: 50,
                                                                    height: 50,
                                                                    child: Image.asset("assets/images/icon_share.png"),
                                                                  ),
                                                                  Container (
                                                                    width: 100,
                                                                    child: Text(
                                                                      "Kirim ke App Lain",
                                                                      style: GoogleFonts.nunito(
                                                                        textStyle: const TextStyle(
                                                                          fontSize: 16,
                                                                          fontWeight: FontWeight.w600,
                                                                          color: Colors.black
                                                                        )
                                                                      ),
                                                                      textAlign: TextAlign.center,
                                                                    ),
                                                                  ),
                        
                                                                  // Icon(
                                                                  //   Icons.contact_phone,
                                                                  //   size: 40,
                                                                  // ),
                                                                  const SizedBox(height: 5,),
                                                                  
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                );
                                              } else {
                                                showModalBottomSheet(
                                                  context: context, 
                                                  builder: (BuildContext context) {
                                                    return Container(
                                                      height: 150,
                                                      padding: const EdgeInsets.only(top: 30),
                                                      color: Colors.white,
                                                      child: Center(
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () async {
                                                                addToRenunganKomunitas(index);
                                                                await showDialog(
                                                                  context: context, 
                                                                  builder: (context) {
                                                                    return AlertDialog(
                                                                      title: Center(
                                                                        child: Text(
                                                                          "Kirim ke explore berhasil",
                                                                          style: GoogleFonts.nunito(
                                                                            textStyle: const TextStyle(
                                                                              fontSize: 18,
                                                                              fontWeight: FontWeight.w500,
                                                                              color: Color.fromARGB(255, 113, 9, 49)
                                                                            )
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      actions: [
                                                                        Container(
                                                                          width: MediaQuery.of(context).size.width,
                                                                          child: ElevatedButton(
                                                                            onPressed: () {
                                                                              Navigator.pop(context);
                                                                            },
                                                                            style: ElevatedButton.styleFrom(
                                                                              primary: Color(int.parse(globals.defaultcolor)),
                                                                              elevation: 5,
                                                                              padding: const EdgeInsets.all(5),
                                                                            ),
                                                                            child: Text(
                                                                              "Oke",
                                                                              style: GoogleFonts.nunito(
                                                                                textStyle: const TextStyle(
                                                                                  fontSize: 16,
                                                                                  color: Colors.white
                                                                                )
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    );
                                                                  }
                                                                );
                                                              },
                                                              child: Column(
                                                                children: [
                                                                  Container(
                                                                    width: 50,
                                                                    height: 50,
                                                                    child: Image.asset("assets/images/icon_explore.png"),
                                                                  ),
                                                                  const SizedBox(height: 5,),
                                                                  Container (
                                                                    width: 100,
                                                                    child: Text(
                                                                      "Kirim ke Explore",
                                                                      style: GoogleFonts.nunito(
                                                                        textStyle: const TextStyle(
                                                                          fontSize: 16,
                                                                          fontWeight: FontWeight.w600,
                                                                          color: Colors.black
                                                                        )
                                                                      ),
                                                                      textAlign: TextAlign.center,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                sharerenungan(index);
                                                              },
                                                              child: Column(
                                                                children: [
                                                                  Container(
                                                                    width: 50,
                                                                    height: 50,
                                                                    child: Image.asset("assets/images/icon_share.png"),
                                                                  ),
                                                                  Container (
                                                                    width: 100,
                                                                    child: Text(
                                                                      "Kirim ke App Lain",
                                                                      style: GoogleFonts.nunito(
                                                                        textStyle: const TextStyle(
                                                                          fontSize: 16,
                                                                          fontWeight: FontWeight.w600,
                                                                          color: Colors.black
                                                                        )
                                                                      ),
                                                                      textAlign: TextAlign.center,
                                                                    ),
                                                                  ),
                                                                  const SizedBox(height: 5,),
                                                                  
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                );
                                              }
                                            });
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                  
                                  Text(
                                    itemTanggal[index], 
                                    style: GoogleFonts.nunito(
                                      textStyle: TextStyle(
                                        fontSize: 14, 
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black
                                      )
                                    ),
                                  ),
                                  Text(
                                    itemKitab[index], 
                                    style: GoogleFonts.nunito(
                                      textStyle: TextStyle(
                                        fontSize: 14, 
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black
                                      )
                                    ),
                                  ),
                                  Text(
                                    itemTagline[index], 
                                    style: GoogleFonts.nunito(
                                      textStyle: TextStyle(
                                        fontSize: 14, 
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black
                                      )
                                    ),
                                  ),
                                  const SizedBox(height: 20,),
                                  Text(
                                    itemRenungan[index], 
                                    style: GoogleFonts.nunito(
                                      textStyle: TextStyle(
                                        fontSize: 16, 
                                        color: Colors.black
                                      )
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10,)
                      ],
                    ),
                    onTap: () async {
                      final data = await Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => DetailRenungan(id: int.parse(listDataRenungan[index]['Id Renungan User']), shoulpop: 'true',))
                      );

                      if (data == "refresh") {
                        readFile();
                        getRefleksi();
                      }
                    },
                  );    
                },
                itemCount: itemJudul.length,
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async  {
            
            final data = await Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => RenunganPage(status: 'tambah', index: 0, darimana: 'addfromlistrenungan',))
            );

            if (data == "refresh") {
              readFile();
              getRefleksi();
              
            }
          },
          backgroundColor: Color(int.parse(globals.defaultcolor)),
          child: Icon(Icons.add, color: Colors.white,),
        ),
      ),
    );
  }
}