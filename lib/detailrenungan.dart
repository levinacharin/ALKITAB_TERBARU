import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'dart:convert';

import './listrenungan.dart';
import './renunganpage.dart';


class DetailRenungan extends StatefulWidget {
  final int id;
  final String? status;
  final String shoulpop;
  final String? darimana;

  const DetailRenungan({super.key,
  required this.id,
  this.status,
  required this.shoulpop,
  this.darimana
  });

  @override
  State<DetailRenungan> createState() => _DetailRenunganState();
}

class _DetailRenunganState extends State<DetailRenungan> {
  List listData = [];
  String itemTanggal = "";
  String itemJudul = "";
  String itemaBacaan = "";
  String itemaBerkesan = "";
  String itemRenungan = "";
  String itemTindakan = "";
  String itemLinkRenungan = "";
  String itemTagline = "";

  bool shouldPop = false;

  void readFile() async {
    String path = '/storage/emulated/0/Download/Renunganjson.txt';
    bool directoryExists = await Directory(path).exists();
    bool fileExists = await File(path).exists();

    if (directoryExists || fileExists) {
      final contents = await File(path).readAsString();
      listData = [];
      if (contents.isNotEmpty) {
        setState(() {
          print("id: ${widget.id}");
        });
        listData = json.decode(contents);
        for (int i = 0; i < listData.length; i++) {
          if (int.parse(listData[i]['Id Renungan User']) == widget.id) {
            setState(() {
              itemTanggal = listData[i]['Tanggal'].toString();
              itemJudul = listData[i]['Judul'].toString();
              itemaBacaan = listData[i]['Kitab'].toString().replaceAll("<br>", "\n"); // yang Ayat Bacaan harusnya
              itemaBerkesan = listData[i]['Ayat Berkesan'].toString().replaceAll("<br>", "\n");
              itemRenungan = listData[i]['Isi Renungan'].toString();
              itemTindakan = listData[i]['Tindakan Saya'].toString();
              itemLinkRenungan = listData[i]['Link Renungan'].toString();
              itemTagline = listData[i]['Tagline'].toString();
            });
          }
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    readFile();

    if (widget.shoulpop == 'true') {
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
              if (widget.darimana == "listrenungan" || widget.darimana == "homepage" || widget.darimana == "addfromlistrenungan") {
                Navigator.pop(context);
                Navigator.pop(context);
              } else if (widget.darimana == "tambahrenungank") {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
              } else {
                Navigator.pop(context);
              }
            },
            icon: const Icon(Icons.arrow_back_rounded),
            color: const Color.fromARGB(255, 113, 9, 49),
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
                    "Renungan",
                    style: GoogleFonts.nunito(
                      textStyle: const TextStyle(
                        fontSize: 24,
                        color: Color.fromARGB(255, 113, 9, 49),
                        fontWeight: FontWeight.bold
                      )
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => RenunganPage(status: 'edit', index: widget.id, darimana: 'detailrenungan'))
                      );
                    }, 
                    icon: const Icon(
                      Icons.edit,
                      color: Color.fromARGB(255, 113, 9, 49),
                    )
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Tanggal",
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
                  itemTanggal,
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
                "Judul Renungan",
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
                  itemJudul,
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
                "Ayat Bacaan",
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
                  itemaBacaan,
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
                "Ayat Berkesan",
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
                  itemaBerkesan,
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
                "Renungan",
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
                  itemRenungan,
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
                "Tindakan Saya",
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
                  itemTindakan,
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
                "Link Renungan",
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
                  await launch(itemLinkRenungan);
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
                  child: Text(
                    itemLinkRenungan,
                    style: GoogleFonts.nunito(
                      textStyle: const TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                        decoration: TextDecoration.underline
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
      }
    );
  }
}