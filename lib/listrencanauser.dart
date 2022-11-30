import 'dart:developer';
import 'dart:io';

import 'package:alkitab/detailbacaliturgi.dart';
import 'package:alkitab/detailkomunitas.dart';
import 'package:alkitab/detailrencanabaca.dart';
import 'package:alkitab/homepage.dart';
import 'package:alkitab/pecahAyatClass.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'global.dart' as globals;

class BacaanLiturgi {
  String tanggal;
  String infobacaan;
  String content;
  String kitab;
  String isiContent;

  BacaanLiturgi({
    required this.tanggal,
    required this.infobacaan,
    required this.content,
    required this.kitab,
    required this.isiContent
  });

  factory BacaanLiturgi.createData(Map<String, dynamic> object) {
    return BacaanLiturgi(
      tanggal: object['tanggal'], 
      infobacaan: object['infobacaan'], 
      content: object['content'], 
      kitab: object['kitab'], 
      isiContent: object['isiContent']
    );
  }

  static Future<List<BacaanLiturgi>> getData(String date) async {
    var url = "${globals.urllocal}liturgihariini?tanggal=$date";
    var apiResult = await http.get(Uri.parse(url), headers: {
      "Accept" : "application/json",
      "Access-Control-Allow-Origin" : "*"
    });
    var jsonObject = json.decode(apiResult.body);
    var data = (jsonObject as Map<String, dynamic>)['data'];
    List<BacaanLiturgi> listData = [];
    if (data.toString() == "null") {
      return listData;
    } else {
      for (int i = 0; i < data.length; i++) {
        listData.add(BacaanLiturgi.createData(data[i]));
      }
      return listData;
    }
  }
}

class ListRencanaUser extends StatefulWidget {
  final String pagefrom;
  const ListRencanaUser({
    super.key,
    required this.pagefrom
  });

  @override
  State<ListRencanaUser> createState() => _ListRencanaUserState();
}

class _ListRencanaUserState extends State<ListRencanaUser> {
  List listDetailRencana = [];
  List<String> itemJudulRencana = [];
  List<String> itemIdRencana = [];

  List<BacaanLiturgi> listBacaLiturgi = [];
  DateTime currentDate = DateTime.now();
  String _currentdate = "";
  List infobacatemp = [];
  String _infobacaan = "";
  String titletanggal = "";

  //  API GET BACAAN LITURGI 
  Future<void> getLiturgi(String currentdate) async  {
    BacaanLiturgi.getData(currentdate).then((value) async {
      setState(() {
        listBacaLiturgi = [];
        listBacaLiturgi = value;
        
        for (int i = 0; i < listBacaLiturgi.length; i++) {
          listBacaLiturgi[i].infobacaan = listBacaLiturgi[i].infobacaan.replaceAll("<br>", "\n");
          listBacaLiturgi[i].isiContent = listBacaLiturgi[i].isiContent.replaceAll("<br>", "\n");
          infobacatemp.add(listBacaLiturgi[i].infobacaan);
        }

        infobacatemp = infobacatemp.toSet().toList();
        _infobacaan = infobacatemp[0];

        for (int i = 0; i < listBacaLiturgi.length; i++) {
          if (listBacaLiturgi[i].kitab != "-") {
            // ignore: prefer_interpolation_to_compose_strings
            _infobacaan = _infobacaan + "\n" + listBacaLiturgi[i].content + ": " + listBacaLiturgi[i].kitab;
          }
        }
        infobacatemp = [];
      });
    });
  }

  // read file Rencanajson
  void readFile() async {
    String path = '/storage/emulated/0/Download/Alkitab Renungan Mobile/Rencanajson.txt';
    bool directoryExists = await Directory(path).exists();
    bool fileExists = await File(path).exists();

    if (directoryExists || fileExists) {
      final contents = await File(path).readAsString();
      listDetailRencana = [];
      if (contents.isNotEmpty) {
        listDetailRencana = json.decode(contents);
        
        setState(() {
          for (int i = 0; i < listDetailRencana.length; i++) {
            itemJudulRencana.add(listDetailRencana[i]['Judul Rencana']);
            itemIdRencana.add(listDetailRencana[i]['Id Rencana']);
          }
          itemJudulRencana = itemJudulRencana.toSet().toList();
          itemIdRencana = itemIdRencana.toSet().toList();
        });
      }
    }

    calculateScore();
  }

  // Shared Preferences Id Rencana
  List<String> listIdRencana = []; 
  getIdRencanaSP() async { // ambil id yang tersimpan
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    listIdRencana = sharedPreferences.getStringList('listIdRencana') ?? [];

    setState(() {
      print("list id rencana: $listIdRencana");
      listIdRencana = listIdRencana.toSet().toList();
    });
  }

  List listDetailTemp = [];
  sendData(String idrencana) async {
    setState(() {
      listDetailTemp = [];
      for (int i = 0; i < listDetailRencana.length; i++) {
        if (listDetailRencana[i]['Id Rencana'] == idrencana) {
          listDetailTemp.add(listDetailRencana[i]);
        }
      }
      globals.listDetailRUser.clear();
      globals.listDetailRUser = listDetailTemp;
    });
  }

  
  List<int> listScore = [];
  int count = 0;
  int hasdone = 0;
  double total = 0;
  void calculateScore() {
    setState(() {
      int idx = 0;
      if (globals.listDetailRUser.isNotEmpty) {
        for (int i = 0; i < listDetailRencana.length; i++) {
          if (listDetailRencana[i]['Id Rencana'] == globals.idrencana) {
            listDetailRencana[i]['Status Selesai'] = globals.listDetailRUser[idx]['Status Selesai'];
            idx++;
          }
        }
      }

      listScore = [];
      int num = 0;
      count = 0;
      hasdone = 0;
      total= 0.0;

      for (int i = 0; i < listDetailRencana.length; i++) {
        if (i != listDetailRencana.length-1) {
          if (listDetailRencana[i+1]['Id Rencana'] == listDetailRencana[i]['Id Rencana']) {
            if (listDetailRencana[i]['Status Selesai'] == "true") {
              ++hasdone;
            }
            ++count;
          } else {
            if (listDetailRencana[i]['Status Selesai'] == "true") {
              ++hasdone;
            }
            ++count;
            total = (hasdone / count) * 100;
            num = total.round();
            listScore.add(num);

            hasdone = 0;
            count = 0;
            total = 0;
          }
        } else {
          if (listDetailRencana[i]['Status Selesai'] == "true") {
            ++hasdone;
          }
          ++count;

          total = (hasdone / count) * 100;
          num = total.round();
          listScore.add(num);

          hasdone = 0;
          count = 0;
          total = 0;

        }
      }

      globals.listDetailRUser.clear();
      globals.idrencana = "";
      // globals.statusBaca.clear();
      
      print("list score: $listScore");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getIdRencanaSP();
    readFile();
    _currentdate = "${currentDate.year}-${currentDate.month}-${currentDate.day}";
    getLiturgi(_currentdate );
    formatDatetoString();

    // saveStatusBaca(globals.idrencana);
  }

  void formatDatetoString() {
    setState(() {
      if (currentDate.month == 1) {
        titletanggal = "${currentDate.day} Januari ${currentDate.year}";
      } else if (currentDate.month == 2) {
        titletanggal = "${currentDate.day} Februari ${currentDate.year}";
      } else if (currentDate.month == 3) {
        titletanggal = "${currentDate.day} Maret ${currentDate.year}";
      } else if (currentDate.month == 4) {
        titletanggal = "${currentDate.day} April ${currentDate.year}";
      } else if (currentDate.month == 5) {
        titletanggal = "${currentDate.day} Mei ${currentDate.year}";
      } else if (currentDate.month == 6) {
        titletanggal = "${currentDate.day} Juni ${currentDate.year}";
      } else if (currentDate.month == 7) {
        titletanggal = "${currentDate.day} Juli ${currentDate.year}";
      } else if (currentDate.month == 8) {
        titletanggal = "${currentDate.day} Agustus ${currentDate.year}";
      } else if (currentDate.month == 9) {
        titletanggal = "${currentDate.day} September ${currentDate.year}";
      } else if (currentDate.month == 10) {
        titletanggal = "${currentDate.day} Oktober ${currentDate.year}";
      } else if (currentDate.month == 11) {
        titletanggal = "${currentDate.day} November ${currentDate.year}";
      } else if (currentDate.month == 12) {
        titletanggal = "${currentDate.day} Desember ${currentDate.year}";
      }
    });
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
              if (widget.pagefrom == "komunitas") {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => DetailKomunitas(shouldpop: "false"))
                );
              } else {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => const HomePage(indexKitabdicari: 0, pasalKitabdicari: 0, ayatKitabdicari: 0, daripagemana: "listrencanauser"))
                );
              }
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Color.fromARGB(255, 113, 9, 49),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Text(
                  "Rencana Bacaanku",
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
              // Container(
              //   padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              //   height: 40,
              //   child: TextField(
              //     cursorColor: Color(int.parse(globals.defaultcolor)),
              //     decoration: InputDecoration(
              //       fillColor: const Color.fromARGB(255, 253, 255, 252),
              //       filled: true,
              //       enabledBorder: OutlineInputBorder(
              //         borderSide: BorderSide(
              //           width: 1, 
              //           color: Color(int.parse(globals.defaultcolor))
              //         ),
              //       ),
              //       focusedBorder: OutlineInputBorder(
              //         borderSide: BorderSide(
              //           width: 1, 
              //           color: Color(int.parse(globals.defaultcolor))
              //         ),
              //       ),
              //       hintText: 'Cari',
              //       hintStyle: TextStyle(
              //         color: Colors.grey[400]
              //       ),
              //       contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5)
              //     ),
              //     style: GoogleFonts.nunito(
              //       textStyle: const TextStyle(
              //         fontSize: 16,
              //         color: Colors.black
              //       )
              //     ),
              //   ),
              // ),
              const SizedBox(height: 20,),
              GestureDetector(
                onTap: () {
                  globals.listBacaLiturgi = listBacaLiturgi;
                  globals.informasiliturgi = _infobacaan;
                  globals.titletanggal = titletanggal;
        
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => const DetailBLiturgi())
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Card(
                    elevation: 4,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Bacaan Liturgi Hari Ini",
                            style: GoogleFonts.nunito(
                              textStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 113, 9, 49)
                              )
                            ),
                          ),
                          const SizedBox(height: 20,),
                          Text(
                            _infobacaan,
                            style: GoogleFonts.nunito(
                              textStyle: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Color(int.parse(globals.defaultcolor)),
                              )
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Container(
                child: ListView.builder(
                  itemCount: itemJudulRencana.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                      child: Column(
                        children: [
                          GestureDetector(
                            child: Card(
                              elevation: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    // ignore: sized_box_for_whitespace
                                    Container(
                                      width: 100,
                                      height: 80,
                                      child: Image.network(
                                        '${globals.urllocal}getimage?id=${itemIdRencana[index]}&folder=rencana',
                                        fit: BoxFit.cover ,
                                      ),
                                    ),
                                    const SizedBox(width: 5,),
                                    Expanded(
                                      child: Text(
                                        itemJudulRencana[index],
                                        style: GoogleFonts.nunito(
                                          textStyle: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Color.fromARGB(255, 113, 9, 49)
                                          )
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 5,),
                                    Container(
                                      width: 45,
                                      height: 45,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: listScore[index] != 100 
                                                  ? Color(int.parse(globals.defaultcolor))
                                                  : Colors.green,
                                          width: 2
                                        )
                                      ),
                                      child: Center(
                                        child: Text(
                                          "${listScore[index]}%",
                                          style: GoogleFonts.nunito(
                                            textStyle: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Color(int.parse(globals.defaultcolor))
                                            )
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            onTap: () async {
                              await sendData(listIdRencana[index]);
        
                              globals.idrencana = "";
                              globals.idrencana = listIdRencana[index];
          
                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                context, 
                                MaterialPageRoute(builder: (context) => const DetailRencanaBaca(pagefrom: "user",))
                              );
                            },
                          ),
                          const SizedBox(height: 10,)
                        ],
                      ),
                    );
                  },
                )
              )
            ],
          ),
        )
      ),
    );
  }
}