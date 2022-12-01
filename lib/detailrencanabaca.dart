import 'dart:convert';
import 'dart:io';
import 'dart:developer';

import 'package:alkitab/detailkomunitas.dart';
import 'package:alkitab/isirencanabaca.dart';
import 'package:alkitab/listrencanauser.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:readmore/readmore.dart';

import 'global.dart' as globals;

class DetailRencanaBaca extends StatefulWidget {
  final String pagefrom;   // user or komunitas
  const DetailRencanaBaca({
    super.key,
    required this.pagefrom
  });

  @override
  State<DetailRencanaBaca> createState() => _DetailRencanaBacaState();
}

class _DetailRencanaBacaState extends State<DetailRencanaBaca> {
  int indexSelect = 0;

  DateTime currentdate = DateTime.now();
  List<String> estDate = [];
  String datetemp = "";  

  void getDate() {
    setState(() {
      estDate = [];
      datetemp = "";
      if (widget.pagefrom == "user" || widget.pagefrom == "isirencanabaca") {
        currentdate = DateTime.parse(globals.listDetailRUser[0]['Tanggal Rencana']);
        for (int i = 0; i < globals.listDetailRUser.length; i++) {
          if (currentdate.month == 1) {
            datetemp = "${currentdate.day} Jan";
          } else if (currentdate.month == 2) {
            datetemp = "${currentdate.day} Feb";
          } else if (currentdate.month == 3) {
            datetemp = "${currentdate.day} Mar";
          } else if (currentdate.month == 4) {
            datetemp = "${currentdate.day} Apr";
          } else if (currentdate.month == 5) {
            datetemp = "${currentdate.day} Mei";
          } else if (currentdate.month == 6) {
            datetemp = "${currentdate.day} Jun";
          } else if (currentdate.month == 7) {
            datetemp = "${currentdate.day} Jul";
          } else if (currentdate.month == 8) {
            datetemp = "${currentdate.day} Aug";
          } else if (currentdate.month == 9) {
            datetemp = "${currentdate.day} Sep";
          } else if (currentdate.month == 10) {
            datetemp = "${currentdate.day} Okt";
          } else if (currentdate.month == 11) {
            datetemp = "${currentdate.day} Nov";
          } else if (currentdate.month == 12) {
            datetemp = "${currentdate.day} Des";
          }
          
          estDate.add(datetemp);

          if (i != globals.listDetailRUser.length-1) {
            currentdate = currentdate.add(Duration(days: 1));
          }
        }
      } else if (widget.pagefrom == "komunitas") {
        for (int i = 0; i < globals.listDetailRencana.length; i++) {
          if (currentdate.month == 1) {
            datetemp = "${currentdate.day} Jan";
          } else if (currentdate.month == 2) {
            datetemp = "${currentdate.day} Feb";
          } else if (currentdate.month == 3) {
            datetemp = "${currentdate.day} Mar";
          } else if (currentdate.month == 4) {
            datetemp = "${currentdate.day} Apr";
          } else if (currentdate.month == 5) {
            datetemp = "${currentdate.day} Mei";
          } else if (currentdate.month == 6) {
            datetemp = "${currentdate.day} Jun";
          } else if (currentdate.month == 7) {
            datetemp = "${currentdate.day} Jul";
          } else if (currentdate.month == 8) {
            datetemp = "${currentdate.day} Aug";
          } else if (currentdate.month == 9) {
            datetemp = "${currentdate.day} Sep";
          } else if (currentdate.month == 10) {
            datetemp = "${currentdate.day} Okt";
          } else if (currentdate.month == 11) {
            datetemp = "${currentdate.day} Nov";
          } else if (currentdate.month == 12) {
            datetemp = "${currentdate.day} Des";
          } 
          
          estDate.add(datetemp);

          if (i != globals.listDetailRencana.length-1) {
            currentdate = currentdate.add(const Duration(days: 1));
          }
        }
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDate();

    if (widget.pagefrom == "isirencanabaca") {
      for (int i = 0; i < globals.listDetailRUser.length; i++) {
        if (globals.listDetailRUser[i]['Status Ayat'] == "true" && globals.listDetailRUser[i]['Status Renungan'] == "true") {
          setState(() {
            globals.listDetailRUser[i]['Status Selesai'] = "true";
          });
        }
      }
    }
  }

  String dataRencana = '';
  List listTempData = [];
  Future<void> writeData() async {
    var temp = '';

    String path = '/storage/emulated/0/Download/Alkitab Renungan Mobile/Rencanajson.txt';
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

    int countidx = 0;

    dataRencana = '';
    dataRencana = "$dataRencana[";
    print("length temp data: ${listTempData.length} - globals list user: ${globals.listDetailRUser.length}");
    if (listTempData.isNotEmpty) {
      for (int i = 0; i < listTempData.length; i++) {
        temp = listTempData[i]['Ayat Bacaan'].toString().replaceAll('"', '${String.fromCharCode(92)}"');
        if (listTempData[i]['Id Rencana'] == globals.listDetailRUser[countidx]['Id Rencana']) {
          listTempData[i]['Status Ayat'] = globals.listDetailRUser[countidx]['Status Ayat'];
          listTempData[i]['Status Renungan'] = globals.listDetailRUser[countidx]['Status Renungan'];
          listTempData[i]['Status Selesai'] = globals.listDetailRUser[countidx]['Status Selesai'];
          
          if (countidx != globals.listDetailRUser.length-1) {
            countidx++;
          }
        }

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
        '","Image Path":"' +
        listTempData[i]['Image Path'] +
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
        '","Status Ayat":"' +
        listTempData[i]['Status Ayat'] +
        '","Status Renungan":"' +
        listTempData[i]['Status Renungan'] +
        '","Status Selesai":"' +
        listTempData[i]['Status Selesai'] +
        '"}';

        if (listTempData.length != 1 && i != listTempData.length - 1) {
          // ignore: prefer_interpolation_to_compose_strings
          dataRencana = dataRencana + ',';
        }
      }

      dataRencana = "$dataRencana]";
      dataRencana = dataRencana.replaceAll("\n", "<br>");
    }

    await File(path).writeAsString(dataRencana);

    uploadFileLokal();
  }

  Future<void> uploadFileLokal() async {
    String path4 = '/storage/emulated/0/Download/Alkitab Renungan Mobile/Rencanajson.txt';
    var url4 = '${globals.urllocal}uploaddatalokal';
    var request4  = http.MultipartRequest("POST", Uri.parse(url4));
    request4.fields['id'] = globals.idUser;
    request4.fields['folder'] = 'Rencanajson';
    request4.files.add(
      await http.MultipartFile.fromPath('filejson', path4)
    );
    // ignore: unused_local_variable
    var res4 = await request4.send();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.pagefrom == "user") {
          await writeData();
          Navigator.pop(context, "refresh");
        } else {
          Navigator.pop(context);
        }

        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () async {
              if (widget.pagefrom == "user") {
                await writeData();
                Navigator.pop(context, "refresh");
              } else {
                Navigator.pop(context);
              }
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Color.fromARGB(255, 113, 9, 49),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              // ignore: sized_box_for_whitespace
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: globals.imagepathrencana != "-"
                ? Image.network(
                  '${globals.urllocal}getimage?id=${globals.idrencana}&folder=rencana',
                  fit: BoxFit.cover,
                )
                : Image.network(
                  '${globals.urllocal}getimage?id=0&folder=rencana',
                  fit: BoxFit.cover,
                )
              ),
              const SizedBox(height: 10,),
              // ignore: sized_box_for_whitespace
              Container(
                height: 90,
                margin: const EdgeInsets.only(top: 4, bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: widget.pagefrom == "komunitas" ? globals.listDetailRencana.length : globals.listDetailRUser.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                indexSelect = index;
                              });
                            },
                            child: Row(
                              children: [
                                widget.pagefrom == "user" || widget.pagefrom == "isirencanabaca"
                                ? globals.listDetailRUser[index]['Status Selesai'] == "false"
                                  ? Container(
                                    width: 90,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: index == indexSelect ? Colors.black : Colors.grey
                                      ),
                                      borderRadius: BorderRadius.circular(15)
                                    ),
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                        children: [
                                          Text(
                                            "Hari ${index+1}",
                                            style: GoogleFonts.nunito(
                                              textStyle: const TextStyle(
                                                fontSize: 15,
                                                color: Color.fromARGB(255, 113, 9, 49)
                                              )
                                            ),
                                          ),
                                          const SizedBox(height: 10,),
                                          Text(
                                            estDate[index],
                                            style: GoogleFonts.nunito(
                                              textStyle: const TextStyle(
                                                fontSize: 15,
                                                color: Color.fromARGB(255, 113, 9, 49)
                                              )
                                            ),
                                          )
                                        ],
                                      ),
                                  )
                                  : Container(
                                      width: 90,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: index == indexSelect ? Colors.black : Colors.green
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 3,
                                            offset: const Offset(1, 3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      padding: const EdgeInsets.all(16),
                                      child: const Center(
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.green,
                                          size: 40,
                                        ),
                                      )
                                    )
                                : Container(
                                    width: 90,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: index == indexSelect ? Colors.black : Colors.grey
                                      ),
                                      borderRadius: BorderRadius.circular(15)
                                    ),
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                        children: [
                                          Text(
                                            "Hari ${index+1}",
                                            style: GoogleFonts.nunito(
                                              textStyle: const TextStyle(
                                                fontSize: 15,
                                                color: Color.fromARGB(255, 113, 9, 49)
                                              )
                                            ),
                                          ),
                                          const SizedBox(height: 10,),
                                          Text(
                                            estDate[index],
                                            style: GoogleFonts.nunito(
                                              textStyle: const TextStyle(
                                                fontSize: 15,
                                                color: Color.fromARGB(255, 113, 9, 49)
                                              )
                                            ),
                                          )
                                        ],
                                      ),
                                  ),
                                const SizedBox(width: 10,)
                              ],
                            ),
                          );
                        }
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              // ignore: sized_box_for_whitespace
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // AYAT BACAAN RENCANA BACA
                    GestureDetector(
                      // ignore: sized_box_for_whitespace
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        widget.pagefrom == "komunitas" ? globals.listDetailRencana[indexSelect].kitabbacaan : globals.listDetailRUser[indexSelect]['Kitab Bacaan'],
                                        style: GoogleFonts.nunito(
                                          textStyle: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color(int.parse(globals.defaultcolor))
                                          )
                                        ),
                                      ),
                                    ),
                                    widget.pagefrom == "user" || widget.pagefrom == "isirencanabaca"
                                    ? globals.listDetailRUser[indexSelect]['Status Ayat'] == "true"
                                      ? Container(
                                          width: 25,
                                          height: 25,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.green,
                                          ),
                                          child: const Icon(
                                            Icons.check,
                                            size: 20,
                                            color: Colors.white,
                                          ),
                                        )
                                      : Container()
                                    : Container()
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      onTap: () async {
                        if (widget.pagefrom == "user") {
                          final data = await Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context) => IsiRencanaBaca(isicontent: "ayat", idx: indexSelect,))
                          );
    
                          if (data == "refresh") {
                            setState(() {
                              getDate();
    
                              // if (widget.pagefrom == "isirencanabaca") {
                                for (int i = 0; i < globals.listDetailRUser.length; i++) {
                                  if (globals.listDetailRUser[i]['Status Ayat'] == "true" && globals.listDetailRUser[i]['Status Renungan'] == "true") {
                                    setState(() {
                                      globals.listDetailRUser[i]['Status Selesai'] = "true";
                                    });
                                  }
                                }
                              // }
                            });
                          }
                        }
                      },
                    ),
                    const SizedBox(height: 10,),
            
                    // RENUNGAN RENCANA BACA
                    Visibility(
                      visible: widget.pagefrom == "komunitas" ? globals.listDetailRencana[indexSelect].judulrenungan == "-" ? false : true : globals.listDetailRUser[indexSelect]['Judul Renungan'] == "-" ? false : true,
                      child: GestureDetector(
                        // ignore: sized_box_for_whitespace
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Renungan",
                                        style: GoogleFonts.nunito(
                                          textStyle: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color(int.parse(globals.defaultcolor))
                                          )
                                        ),
                                      ),
                                      widget.pagefrom == "user" || widget.pagefrom == "isirencanabaca"
                                      ? globals.listDetailRUser[indexSelect]['Status Renungan'] == "true"
                                        ? Container(
                                          width: 25,
                                          height: 25,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.green,
                                          ),
                                          child: const Icon(
                                            Icons.check,
                                            size: 20,
                                            color: Colors.white,
                                          ),
                                        )
                                        : Container()
                                      : Container()
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        onTap: () async {
                          if (widget.pagefrom == "user") {
                            final data = await Navigator.push(
                              context, 
                              MaterialPageRoute(builder: (context) => IsiRencanaBaca(isicontent: "renungan", idx: indexSelect,))
                            );
    
                            if (data == "refresh") {
                              setState(() {
                                getDate();
    
                                // if (widget.pagefrom == "isirencanabaca") {
                                  for (int i = 0; i < globals.listDetailRUser.length; i++) {
                                    if (globals.listDetailRUser[i]['Status Ayat'] == "true" && globals.listDetailRUser[i]['Status Renungan'] == "true") {
                                      setState(() {
                                        globals.listDetailRUser[i]['Status Selesai'] = "true";
                                      });
                                    }
                                  }
                                // }
                              });
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}