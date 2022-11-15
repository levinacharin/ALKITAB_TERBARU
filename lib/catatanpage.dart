import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import './detailcatatan.dart';
import './global.dart' as globals;

class CatatanPage extends StatefulWidget {
  final String status;
  final int index;
  final List? listHighlight;
  final String? darimana;
  const CatatanPage({super.key, required this.status, required this.index, this.listHighlight, this.darimana});

  @override
  State<CatatanPage> createState() => _CatatanPageState();
}

class _CatatanPageState extends State<CatatanPage> {
  // ignore: non_constant_identifier_names
  TextEditingController ctr_isibacaan = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController ctr_isicatatan = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController ctr_linkcatatan = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController ctr_tagline = TextEditingController();
  String ayatdipilih = ""; // yang disimpan ke json
  // ignore: non_constant_identifier_names
  String temp_ayatdipilih = ""; // untuk format waktu kitab waktu dapat data dari homepage
  // ignore: non_constant_identifier_names
  String text_highlight = "";
  String kitabPasal = "";

  bool edited = true;

  @override
  void dispose() {
    
    ctr_isibacaan.dispose();
    ctr_isicatatan.dispose();
    ctr_linkcatatan.dispose();
    ctr_tagline.dispose();
    super.dispose();
  }

  int huruf = 92;

  @override
  void initState() {
    text_highlight = "";
    super.initState();
    if (widget.status == 'edit') {
      updateData();
      edited = false;
    } else if (widget.status == 'tambah') {
      edited = true;
    }
    
    List? selectedAyat = widget.listHighlight;
    if(widget.listHighlight!.isNotEmpty){
      if (widget.darimana == "homepage") {
      //SORTING
    selectedAyat!.sort((a, b) {
      return a.getindexpasal.compareTo(b.getindexpasal);
    });

    List? listhighlightsementara = [];
    List? listperpasal = [];

    int pasal = selectedAyat[0].getindexpasal;

    for (int i = 0; i < selectedAyat.length; i++) {
      if (pasal == selectedAyat[i].getindexpasal &&
          i != selectedAyat.length - 1) {
        listperpasal.add(selectedAyat[i]);
      } else {
        if (i == selectedAyat.length - 1) {
          listperpasal.add(selectedAyat[i]);
          listperpasal.sort((a, b) {
            return a.getindexayat.compareTo(b.getindexayat);
          });
          listhighlightsementara.addAll(listperpasal);
        } else {
          listperpasal.sort((a, b) {
            return a.getindexayat.compareTo(b.getindexayat);
          });
          listhighlightsementara.addAll(listperpasal);
          pasal = selectedAyat[i].getindexpasal;
          listperpasal.clear();
          listperpasal.add(selectedAyat[i]);
        }
      }
    }

    setState(() {
      selectedAyat = listhighlightsementara;
    });

    //END OF SORTING
    //}

    bool ganti = true;
    bool gantikitab = false;
    kitabPasal = "";
      for (int i = 0; i < selectedAyat!.length; i++) {
        log("hasil passing kitab - ${selectedAyat![i].getindexkitab}");
        log("hasil passing pasal - ${selectedAyat![i].getindexpasal}");
        log("hasil passing ayat - ${selectedAyat![i].getindexayat}");
        log("hasil passing konten - ${selectedAyat![i].getkonten}");
        log("hasil passing nama - ${selectedAyat![i].getnamakitab}");
        // text_highlight = text_highlight + selectedAyat![i].getnamakitab+ ' '+((selectedAyat![i].getindexpasal)+1).toString()+ ' : ' + ((selectedAyat![i].getindexayat)).toString() + '\n' + selectedAyat![i].getkonten + '\n' + '\n';
        // temp_ayatdipilih = selectedAyat![i].getnamakitab+ ' '+((selectedAyat![i].getindexpasal)+1).toString()+ ' : '+((selectedAyat![i].getindexayat)).toString();

        // if (ayatdipilih.isNotEmpty) {
        //   ayatdipilih = ayatdipilih + ", " + temp_ayatdipilih;
        // } else {
        //   ayatdipilih = temp_ayatdipilih;
        // }
        //print("data catatan - $text_highlight");
        //text_highlight = text_highlight + '"' + selectedAyat[i].getnamakitab+ ' '+((selectedAyat[i].getindexpasal)+1).toString()+ ' : '+((selectedAyat[i].getindexayat)).toString()+'"'+"\n"+selectedAyat[i].getkonten+"\n"+"\n";
        if (ganti == true) {
          gantikitab = true;
          if (i != 0) {
            kitabPasal = "$kitabPasal ; ";
            text_highlight = "$text_highlight\n\n";
          }

          // ignore: prefer_interpolation_to_compose_strings
          kitabPasal = kitabPasal +
              selectedAyat![i].getnamakitab +
              ' ' +
              ((selectedAyat![i].getindexpasal) + 1).toString() +
              ":" +
              ((selectedAyat![i].getayatasli)).toString();
        } else {
          gantikitab = false;
          kitabPasal =
              // ignore: prefer_interpolation_to_compose_strings
              kitabPasal + ',' + ((selectedAyat![i].getayatasli)).toString();
        }

        if (i != selectedAyat!.length - 1) {
          if (selectedAyat![i].getnamakitab !=
                  selectedAyat![i + 1].getnamakitab ||
              selectedAyat![i].getindexpasal !=
                  selectedAyat![i + 1].getindexpasal) {
            ganti = true;
          } else {
            ganti = false;
          }
        }

        if (gantikitab == true) {
          // seluruhbacaan = kitabPasal+"\n"+text_highlight;
          // kitabPasal="";
          // ignore: prefer_interpolation_to_compose_strings
          text_highlight = text_highlight +
              selectedAyat![i].getnamakitab +
              ' ' +
              ((selectedAyat![i].getindexpasal) + 1).toString() +
              "\n" +
              ((selectedAyat![i].getayatasli)).toString() +
              '. ' +
              selectedAyat![i].getkonten +
              ' ';
          //kitabPasal="";
        } else {
          // ignore: prefer_interpolation_to_compose_strings
          text_highlight = text_highlight +
              ((selectedAyat![i].getayatasli)).toString() +
              '. ' +
              selectedAyat![i].getkonten +
              ' ';
        }
      }
    }

    

    

      if (selectedAyat!.isNotEmpty) {
        log("data catatan b : $text_highlight");
        // var temp = text_highlight.replaceAll('"', '${String.fromCharCode(huruf)}"');
        // print("data catatan : $temp");
        setState(() {
          // ctr_highlight.text=temp;
          //ctr_isibacaan.text=seluruhbacaan;
          ctr_isibacaan.text = "$kitabPasal\n\n$text_highlight";
          //ctr_isibacaan.text=text_highlight;
        });
      }
    }
    
    //log("hasil passing - ${widget.listHighlight}");
  }


  // SERVICE FILE TEXT
  String dataCatatan = '';
  List listTempData = [];
  String mauapa="gapapa";

  void writeData() async {
    var temp = '';
    // READ FILE / PATH
    String path = '/storage/emulated/0/Download/Catatanjson.txt';
    bool directoryExists = await Directory(path).exists();
    bool fileExists = await File(path).exists();
    
    if(mauapa!="resetcatatan"){
      if (directoryExists || fileExists) {
      final contents = await File(path).readAsString(encoding: utf8);
      listTempData = [];
      setState(() {
        if (contents.isNotEmpty) {
        listTempData = json.decode(contents);
        // replace 'br' to '\n'
        for (int i = 0; i < listTempData.length; i++) {
          listTempData[i]['Bacaan'] = listTempData[i]['Bacaan'].toString().replaceAll("<br>", "\n");
        }
      }
      });
    }
    }
    
    // END OF READ FILE / PATH

    // FORMAT JSON IN STRING
    dataCatatan = ''; // reset string
    dataCatatan = "$dataCatatan[";
    if (widget.status == 'tambah') {
      if (listTempData.isNotEmpty) {
        for (int i = 0; i < listTempData.length; i++) {
          globals.lastIdCatatan = int.parse(listTempData[i]['Id Catatan']);
          temp = listTempData[i]['Isi Bacaan'].toString().replaceAll('"', '${String.fromCharCode(huruf)}"');
          dataCatatan = "$dataCatatan{";
          // ignore: prefer_interpolation_to_compose_strings
          dataCatatan = dataCatatan +
              '"Id Catatan":"' +
              listTempData[i]['Id Catatan'].toString() +
              '","Ayat Bacaan":"' +
              listTempData[i]['Ayat Bacaan'].toString() +
              '","Isi Bacaan":"' +
              temp +
              '","Isi Catatan":"' +
              listTempData[i]['Isi Catatan'].toString() +
              '","Link Catatan":"' +
              listTempData[i]['Link Catatan'].toString() +
              '","Tagline":"' +
              listTempData[i]['Tagline'].toString() +
              '"}' +
              ",";
        }
        globals.lastIdCatatan = globals.lastIdCatatan + 1;
      }
      temp = ctr_isibacaan.text.replaceAll('"', '${String.fromCharCode(huruf)}"');
      // ignore: prefer_interpolation_to_compose_strings
      dataCatatan = dataCatatan +
          "{" +
          '"Id Catatan":"' +
          globals.lastIdCatatan.toString() +
          '","Ayat Bacaan":"' +
          kitabPasal +
          '","Isi Bacaan":"' +
          temp +
          '","Isi Catatan":"' +
          ctr_isicatatan.text +
          '","Link Catatan":"' +
          ctr_linkcatatan.text +
          '","Tagline":"' +
          ctr_tagline.text +
          '"}';
    } else if (widget.status == 'edit') {
      listTempData[widget.index]['Isi Bacaan'] = ctr_isibacaan.text.toString();
      listTempData[widget.index]['Isi Catatan'] = ctr_isicatatan.text.toString();
      listTempData[widget.index]['Link Catatan'] = ctr_linkcatatan.text.toString();
      listTempData[widget.index]['Tagline'] = ctr_tagline.text.toString();
      for (int i = 0; i < listTempData.length; i++) {
        temp = listTempData[i]['Isi Bacaan'].toString().replaceAll('"', '${String.fromCharCode(huruf)}"');
        dataCatatan = "$dataCatatan{";
        // ignore: prefer_interpolation_to_compose_strings
        dataCatatan = dataCatatan +
            '"Id Catatan":"' +
            listTempData[i]['Id Catatan'].toString() +
            '","Ayat Bacaan":"' +
            listTempData[i]['Ayat Bacaan'].toString() +
            '","Isi Bacaan":"' +
            temp + 
            '","Isi Catatan":"' +
            listTempData[i]['Isi Catatan'].toString() +
            '","Link Catatan":"' +
            listTempData[i]['Link Catatan'].toString() +
            '","Tagline":"' +
            listTempData[i]['Tagline'].toString() +
            '"}';
        if (listTempData.length != 1 && i != listTempData.length - 1) {
          dataCatatan = '$dataCatatan,';
        }
      }
    }
    dataCatatan = "$dataCatatan]";
    dataCatatan = dataCatatan.replaceAll("\n", "<br>");
    // log("data catatan : dataCatatan");
    // END OF FORMAT JSON
    
    
    // WIRTE STRING OF JSON TO FILE
    // log("status: ${widget.status}");

    if(mauapa!="resetcatatan"){
      await File(path).writeAsString(dataCatatan);
    } else {
      await File(path).writeAsString("");
    }
    

    globals.buatcatatan = true;
    // ignore: use_build_context_synchronously
    // Navigator.pop(context, "refresh");
  }

  void updateData() async {
    // read data proses
    String path = '/storage/emulated/0/Download/Catatanjson.txt';
    bool directoryExists = await Directory(path).exists();
    bool fileExists = await File(path).exists();
    if (directoryExists || fileExists) {
      final contents = await File(path).readAsString();
      listTempData = []; //reset dulu
      setState(() {
        if (contents.isNotEmpty) {
          listTempData = json.decode(contents);
        }
      });
    }
    // end of read data

    setState(() {
      ayatdipilih = "";
      ctr_isibacaan.text = listTempData[widget.index]['Isi Bacaan'].toString().replaceAll("<br>", "\n");
      ctr_isicatatan.text = listTempData[widget.index]['Isi Catatan'].toString();
      ctr_linkcatatan.text = listTempData[widget.index]['Link Catatan'].toString();
      ctr_tagline.text = listTempData[widget.index]['Tagline'].toString();
    });
  }
  // END OF SERVICE


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_rounded),
            color: const Color.fromARGB(255, 113, 9, 49)),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.status == 'tambah' ? "Tambah Catatan" : "Edit Catatan",
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 24,
                    color: Color.fromARGB(255, 113, 9, 49),
                    fontWeight: FontWeight.bold
                  )
                )
              ),
              const SizedBox(
                height: 30,
              ),
              Text("Bacaan",
                  style: GoogleFonts.nunito(
                      textStyle: const TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 113, 9, 49)))),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: ctr_isibacaan,
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
                  contentPadding: const EdgeInsets.all(10),
                ),
                enabled: edited,
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    color: Colors.black
                  )
                ),
                maxLines: 8,
              ),
              const SizedBox(
                height: 30,
              ),
              Text("Catatan Saya",
                  style: GoogleFonts.nunito(
                      textStyle: const TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 113, 9, 49)))),
              const SizedBox(height: 5,),
              TextField(
                controller: ctr_isicatatan,
                cursorColor: Color(int.parse(globals.defaultcolor)),
                decoration: InputDecoration(
                  fillColor: Colors.transparent,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 3, color: Color(int.parse(globals.defaultcolor))),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1, color: Color(int.parse(globals.defaultcolor))),
                  ),
                  contentPadding: const EdgeInsets.all(10),
                ),
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    color: Colors.black
                  )
                ),
                maxLines: 4,
              ),
              const SizedBox(
                height: 30,
              ),
              Text("Link Catatan",
                  style: GoogleFonts.nunito(
                      textStyle: const TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 113, 9, 49)))),
              const SizedBox(height: 5,),
              
              TextField(
                controller: ctr_linkcatatan,
                cursorColor: Color(int.parse(globals.defaultcolor)),
                decoration: InputDecoration(
                  fillColor: Colors.transparent,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 3, color: Color(int.parse(globals.defaultcolor))),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1, color: Color(int.parse(globals.defaultcolor))),
                  ),
                  contentPadding: const EdgeInsets.all(10),
                ),
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    color: Colors.black
                  )
                ),
                maxLines: 2,
              ),
              const SizedBox(
                height: 30,
              ),
              Text("Tagline",
                  style: GoogleFonts.nunito(
                      textStyle: const TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 113, 9, 49)))),
              const SizedBox(height: 5,),
              TextField(
                controller: ctr_tagline,
                cursorColor: Color(int.parse(globals.defaultcolor)),
                decoration: InputDecoration(
                  fillColor: Colors.transparent,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 3, color: Color(int.parse(globals.defaultcolor))),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1, color: Color(int.parse(globals.defaultcolor))),
                  ),
                  contentPadding: const EdgeInsets.all(10),
                ),
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    color: Colors.black
                  )
                ),
                maxLines: 1,
              ),
              const SizedBox(
                height: 60,
              ),
              // ignore: sized_box_for_whitespace
              Container(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () async {
                    writeData();
                  },
                  style: ElevatedButton.styleFrom(
                    // ignore: deprecated_member_use
                    primary: Color(int.parse(globals.defaultcolor)),
                    elevation: 10,
                    padding: const EdgeInsets.all(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 4),
                    child: Text(
                      "Simpan Catatan",
                      style: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}