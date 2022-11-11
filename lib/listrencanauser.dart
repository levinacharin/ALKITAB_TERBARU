import 'dart:developer';
import 'dart:io';

import 'package:alkitab/detailrencanabaca.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'global.dart' as globals;

class ListRencanaUser extends StatefulWidget {
  const ListRencanaUser({super.key});

  @override
  State<ListRencanaUser> createState() => _ListRencanaUserState();
}

class _ListRencanaUserState extends State<ListRencanaUser> {
  bool status_maintenance = false;
  List listDetailRencana = [];
  List<String> itemJudulRencana = [];


  // read file Rencanajson
  void readFile() async {
    String path = '/storage/emulated/0/Download/Rencanajson.txt';
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
          }
          itemJudulRencana = itemJudulRencana.toSet().toList();
        });
      }
    }

    calculateScore();
  }

  // Shared Preferences Id Rencana
  List<String> listIdRencana = []; 
  getIdRencanaSP() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    listIdRencana = sharedPreferences.getStringList('listIdRencana') ?? [];

    setState(() {
      listIdRencana = listIdRencana.toSet().toList();
    });
  }

  List listDetailTemp = [];
  sendData(String idrencana) async {
    print("idrencana: $idrencana");
    listDetailTemp = [];
    setState(() {
      for (int i = 0; i < listDetailRencana.length; i++) {
        if (listDetailRencana[i]['Id Rencana'] == idrencana) {
          listDetailTemp.add(listDetailRencana[i]);
        }
      }
      globals.listDetailRUser = listDetailTemp;
    });
  }

  
  List<double> listScore = [];
  int count = 0;
  int hasdone = 0;
  double total = 0;
  void calculateScore() {
    setState(() {
      for (int i = 0; i < listDetailRencana.length; i++) {
        if (i != listDetailRencana.length-1) {
          if (listDetailRencana[i+1]['Id Rencana'] == listDetailRencana[i]['Id Rencana']) {
            if (listDetailRencana[i]['Status Selesai'] == "true"){
              hasdone++;
            }
            count++;
          } else {
            if (listDetailRencana[i]['Status Selesai'] == "true") {
              ++hasdone;
            }
            ++count;
            total = hasdone / count;
            listScore.add(total);
            count = 0;
          }
        } else {
          if (listDetailRencana[i]['Status Selesai'] == "true") {
            ++hasdone;
          }
          ++count;
          total = hasdone / count;
          listScore.add(total);
          count = 0;
        }
      }

      print("list score: $listScore");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getIdRencanaSP();
    readFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            globals.listDetailRUser = [];
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: const Color.fromARGB(255, 113, 9, 49),
          ),
        ),
      ),
      body: status_maintenance != true
      ? Column(
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
          Container(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            height: 40,
            child: TextField(
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
              itemCount: itemJudulRencana.length,
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
                                Container(
                                  width: 100,
                                  height: 80,
                                  child: Image.asset(
                                    "assets/images/pp3.jpg"
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
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Color(int.parse(globals.defaultcolor)),
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

                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context) => DetailRencanaBaca(pagefrom: "user",))
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
      )
      : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.settings,
              size: 100,
              color: Color(int.parse(globals.defaultcolor)),
            ),
            const SizedBox(height: 20,),
            Text(
              "Mohon maaf fitur ini masih dalam perbaikan oleh developer",
              style: GoogleFonts.nunito(
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(int.parse(globals.defaultcolor))
                )
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}