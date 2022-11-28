// ignore_for_file: prefer_const_constructors
import 'dart:io';
import 'dart:convert';
import 'package:alkitab/homepage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import './detailcatatan.dart';
//import './homepage.dart';
import './catatanpage.dart';
import './global.dart' as globals;

class ListCatatan extends StatefulWidget {
  const ListCatatan({super.key});

  @override
  State<ListCatatan> createState() => _ListCatatanState();
}

class _ListCatatanState extends State<ListCatatan> {
  @override
  void initState() {
    super.initState();
    readFile();
  }

  Future reloadPage() async {
    await Future.delayed(Duration(seconds: 2));
    readFile();
    setState(() { });
  }

  // SERVICES FILE TEXT 
  List listDataCat = []; // read and display
  List listDataTemp = []; // temp
  String dataCatatan = '';
  
  List<String> itemAyatBacaan = [];
  List<String> itemCatatan = [];
  List<String> itemTagline = [];

  void readFile() async {
    String path = '/storage/emulated/0/Download/Alkitab Renungan Mobile/Catatanjson.txt';
    bool directoryExists = await Directory(path).exists();
    bool fileExists = await File(path).exists();

    if (directoryExists || fileExists) {
      final contents = await File(path).readAsString();
      listDataCat = [];
      itemAyatBacaan = [];
      itemCatatan = [];
      itemTagline = [];
      listDataTemp = [];
      if (contents.isNotEmpty) {
        listDataCat = json.decode(contents);
        setState(() {
          for (int i = 0; i < listDataCat.length; i++) {
            itemAyatBacaan.add(listDataCat[i]['Ayat Bacaan'].toString());
            itemCatatan.add(listDataCat[i]['Isi Catatan'].toString());
            itemTagline.add(listDataCat[i]['Tagline'].toString());
          }
          listDataTemp = listDataCat;
        });
      }
    }
  }

  int huruf = 92;
  String temp = "";

  void deleteData(int indexdata) async {
    // final file = await _localFile;
    setState(() {
      listDataCat.removeAt(indexdata);
      itemAyatBacaan = [];
      itemCatatan = [];
      itemTagline = [];
      for (int i = 0; i < listDataCat.length; i++) {
        itemAyatBacaan.add(listDataCat[i]['Ayat Bacaan'].toString());
        itemCatatan.add(listDataCat[i]['Isi Catatan'].toString());
        itemTagline.add(listDataCat[i]['Tagline'].toString());
      }
    });

    dataCatatan = "";
    dataCatatan = "$dataCatatan[";
    for (int i = 0; i < listDataCat.length; i++) {
      temp = listDataCat[i]['Isi Bacaan'].toString().replaceAll('"', '${String.fromCharCode(huruf)}"');
      // ignore: prefer_interpolation_to_compose_strings
      dataCatatan = dataCatatan + "{";
      // ignore: prefer_interpolation_to_compose_strings
      dataCatatan = dataCatatan + '"Id Catatan":"' + listDataCat[i]['Id Catatan'].toString()
                  + '","Ayat Bacaan":"' + listDataCat[i]['Ayat Bacaan'].toString()
                  + '","Isi Bacaan":"' + temp
                  + '","Isi Catatan":"' + listDataCat[i]['Isi Catatan'].toString()
                  + '","Link Catatan":"' + listDataCat[i]['Link Catatan'].toString()
                  + '","Tagline":"' +listDataCat[i]['Tagline'].toString()
                  + '"}';
      if (listDataCat.length != 1 && i != listDataCat.length - 1) {
          // ignore: prefer_interpolation_to_compose_strings
          dataCatatan = dataCatatan + ',';
        }
    }
    // ignore: prefer_interpolation_to_compose_strings
    dataCatatan = dataCatatan + "]";
    dataCatatan = dataCatatan.replaceAll("\n", "<br>");
    // log("data catatan: $dataCatatan");
    // write string to text file
    String path = '/storage/emulated/0/Download/Alkitab Renungan Mobile/Catatanjson.txt';
    File(path).writeAsString(dataCatatan);
  }
  // END OF SERVICES


  // ignore: unused_field
  static var httpClient = HttpClient();
  Future<File> getFileServer() async {
    var url = '${globals.urllocal}getfileserver?id=${globals.idUser}&folder=Catatanjson';
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    File file = File('/storage/emulated/0/Download/Alkitab Renungan Mobile/Catatanjson.txt');
    await file.writeAsBytes(bytes);
    return file;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => HomePage(indexKitabdicari: 0, pasalKitabdicari: 0, ayatKitabdicari: 0, daripagemana: "listcatatan"))
            );
          },
          icon: const Icon(Icons.arrow_back_rounded),
          color: const Color.fromARGB(255, 113, 9, 49)
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       // uploadFileLokal();
        //       getFileServer();
        //     }, 
        //     icon: Icon(
        //       Icons.ios_share,
        //       color: const Color.fromARGB(255, 113, 9, 49),
        //     )
        //   )
        // ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Text(
              "Catatan", 
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
                    temptag = temptag.toLowerCase();
                    if (temptag.contains(searchText)) {
                      listfordisplay.add(listDataTemp[i]);
                    }
                  }
                  // print("result: $listfordisplay");
                  listDataCat = [];
                  listDataCat = listfordisplay;
  
                  itemAyatBacaan = [];
                  itemCatatan = [];
                  itemTagline = [];
                  for (int i = 0; i < listDataCat.length; i++) {
                    itemAyatBacaan.add(listDataCat[i]['Ayat Bacaan'].toString());
                    itemCatatan.add(listDataCat[i]['Isi Catatan'].toString());
                    itemTagline.add(listDataCat[i]['Tagline'].toString());
                  }
                  listDataCat = listfordisplay;
                });
              },
              cursorColor: Color(int.parse(globals.defaultcolor)),
              decoration: InputDecoration(
                fillColor: Color.fromARGB(255, 253, 255, 252),
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1, 
                    color: Color(int.parse(globals.defaultcolor))
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1, 
                    color: Color(int.parse(globals.defaultcolor))
                  ),
                ),
                hintText: 'Cari',
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
                            padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        itemAyatBacaan[index], 
                                        style: GoogleFonts.nunito(
                                          textStyle: TextStyle(
                                            fontSize: 18, 
                                            fontWeight: FontWeight.w700, 
                                            color: Color(int.parse(globals.defaultcolor))
                                          )
                                        ),
                                      )
                                    ),
                                    PopupMenuButton(
                                      icon: const Icon(
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
                                              SizedBox(width: 5),
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
                                              SizedBox(width: 5),
                                              Text("Delete"),
                                            ],
                                          ),
                                          value: 2,
                                        ),
                                      ],
                                      onSelected: (value) {
                                        if (value == 1) {
                                          Navigator.push(
                                            context, 
                                            MaterialPageRoute(builder: (context) => CatatanPage(status: 'edit', index: index, darimana: "listcatatan",))
                                          );

                                        } else if (value == 2) {
                                          deleteData(index);
                                        }
                                      },
                                    )
                                  ],
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
                                  itemCatatan[index], 
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
                      const SizedBox(height: 10,),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => DetailCatatan(index: index, shouldpop: 'true',))
                    );
                  },
                );
              },
              itemCount: itemAyatBacaan.length,
            )
          ),
        ],
      ),
    );
  }
}