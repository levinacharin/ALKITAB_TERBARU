import 'dart:io';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import './catatanpage.dart';
import './listcatatan.dart';


class DetailCatatan extends StatefulWidget {
  final int index;
  final String? status;
  final String shouldpop;
  final String? darimana;

  const DetailCatatan({super.key,
  required this.index,
  this.status,
  required this.shouldpop,
  this.darimana
  });

  @override
  State<DetailCatatan> createState() => _DetailCatatanState();
}

class _DetailCatatanState extends State<DetailCatatan> {
  List listData = [];
  String itemBacaan = "";
  String itemCatatan = "";
  String itemLinkCatatan = "";
  String itemTagline = "";

  bool shouldPop = false;
  
  void readFile() async {
    String path = '/storage/emulated/0/Download/Alkitab Renungan Mobile/Catatanjson.txt';
    bool directoryExists = await Directory(path).exists();
    bool fileExists = await File(path).exists();

    if (directoryExists || fileExists) {
      final contents = await File(path).readAsString();
      listData = [];
      if (contents.isNotEmpty) {
        listData = json.decode(contents);
        int index = 0;
        if (widget.status == 'tambah') {
          index = listData.length-1;
        } else {
          index = widget.index;
        }
        setState(() {
          itemBacaan = listData[index]['Isi Bacaan'].toString().replaceAll("<br>", "\n");
          itemCatatan = listData[index]['Isi Catatan'].toString();
          itemLinkCatatan = listData[index]['Link Catatan'].toString();
          itemTagline = listData[index]['Tagline'].toString();
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    readFile();

    if (widget.shouldpop == 'true') {
      shouldPop = true;
    } else {
      shouldPop = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              if (widget.darimana == "listcatatan" || widget.darimana == "homepage") {
                Navigator.pop(context);
                Navigator.pop(context, "refresh");
              } else {
                Navigator.pop(context, "refresh");
              }
            },
            icon: const Icon(Icons.arrow_back_rounded),
            color: const Color.fromARGB(255, 113, 9, 49)
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Detail Catatan",
                    style: GoogleFonts.nunito(
                      textStyle: const TextStyle(
                        fontSize: 24,
                        color: Color.fromARGB(255, 113, 9, 49),
                        fontWeight: FontWeight.bold
                      )
                    ),
                  ),
                  IconButton(
                    onPressed: () async {

                      final data = await Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context) => CatatanPage(status: 'edit', index: widget.index, darimana: "detailcatatan",))
                      );

                      print("data : $data");
                      if (data == "refresh") {
                        setState(() {
                          readFile();
                        });
                      }
                    }, 
                    icon: const Icon(
                      Icons.edit,
                      color:Color.fromARGB(255, 113, 9, 49)
                    )
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Bacaan",
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 113, 9, 49)
                  )
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(10),
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
                child: Text(
                  itemBacaan,
                  style: GoogleFonts.nunito(
                    textStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.black
                    )
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Catatan Saya",
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 113, 9, 49)
                  )
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(10),
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
                child: Text(
                  itemCatatan,
                  style: GoogleFonts.nunito(
                    textStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.black
                    )
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Link Catatan",
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 113, 9, 49)
                  )
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () async {
                  // ignore: deprecated_member_use
                  await launch(itemLinkCatatan);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(10),
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
                  child: 
                  Text(
                    itemLinkCatatan,
                    
                    style: GoogleFonts.nunito(
                      textStyle: const TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      )
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Tagline",
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 113, 9, 49)
                  )
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(10),
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
                child: Text(
                  itemTagline,
                  style: GoogleFonts.nunito(
                    textStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.black
                    )
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
      onWillPop: () async {
        return shouldPop;
      },
    );
  }
}