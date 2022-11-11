// ignore_for_file: prefer_const_constructors, sort_child_properties_last
import 'package:alkitab/tambahrenungank.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

import './global.dart' as globals;
import 'detailrefleksiuser.dart';
import 'listrencanauser.dart';

class RenunganKomunitas {
  String idrenungankomunitas;
  String idkomunitas;
  String tanggalrenungan;
  String judulrenungan;
  String kitabbacaan;
  String ayatbacaan;
  String isirenungan;
  String linkrenungan;
  String tagline;

  RenunganKomunitas ({
    required this.idrenungankomunitas,
    required this.idkomunitas,
    required this.tanggalrenungan,
    required this.judulrenungan,
    required this.kitabbacaan,
    required this.ayatbacaan,
    required this.isirenungan,
    required this.linkrenungan,
    required this.tagline
  });

  factory RenunganKomunitas.createData(Map<String, dynamic> object) {
    return RenunganKomunitas(
      idrenungankomunitas: object['idrenungankomunitas'].toString(), 
      idkomunitas: object['idkomunitas'].toString(), 
      tanggalrenungan: object['tanggal'], 
      judulrenungan: object['judulrenungan'], 
      kitabbacaan: object['kitabbacaan'], 
      ayatbacaan: object['ayatbacaan'], 
      isirenungan: object['isirenungan'], 
      linkrenungan: object['linkrenungan'], 
      tagline: object['tagline']
    );
  }

  static Future<List<RenunganKomunitas>> getAllData() async {
    var url = "${globals.urllocal}renungankomunitas?idkomunitas=${int.parse(globals.idkomunitas)}";
    var apiResult = await http.get(Uri.parse(url), headers: {
      "Accept" : "application/json",
      "Access-Control-Allow-Origin" : "*"
    });
    var jsonObject = json.decode(apiResult.body);
    var data = (jsonObject as Map<String, dynamic>)['data'];
    List<RenunganKomunitas> listData = [];
    if (data.toString() == "null") {
      return listData;
    } else {
      for (int i = 0; i < data.length; i++) {
        listData.add(RenunganKomunitas.createData(data[i]));
      }
      return listData;
    }
  }
}

class RefleksiUser {
  String idrefleksi;
  String iduser;
  String idrenungankomunitas;
  String tanggalposting;
  String namadepan;
  String namabelakang;
  String ayatberkesan;
  String tindakansaya;

  RefleksiUser({
    required this.idrefleksi,
    required this.iduser,
    required this.idrenungankomunitas,
    required this.tanggalposting,
    required this.namadepan,
    required this.namabelakang,
    required this.ayatberkesan,
    required this.tindakansaya
  });

  factory RefleksiUser.createData(Map<String, dynamic> object) {
    return RefleksiUser(
      idrefleksi: object['idrefleksi'].toString(), 
      iduser: object['iduser'].toString(), 
      idrenungankomunitas: object['idrenungankomunitas'].toString(), 
      tanggalposting: object['tanggalposting'], 
      namadepan: object['namadepan'],
      namabelakang: object['namabelakang'],
      ayatberkesan: object['ayatberkesan'], 
      tindakansaya: object['tindakansaya']
    );
  }

  static Future<List<RefleksiUser>> getData(String id) async {
    var url = "${globals.urllocal}refleksiuser?idrenungankomunitas=$id";
    var apiResult = await http.get(Uri.parse(url), headers: {
      "Accept" : "application/json",
      "Access-Control-Allow-Origin" : "*"
    });
    var jsonObject = json.decode(apiResult.body);
    var data = (jsonObject as Map<String, dynamic>)['data'];
    List<RefleksiUser> listData = [];
    if (data.toString() == "null") {
      return listData;
    } else {
      for (int i = 0; i < data.length; i++) {
        listData.add(RefleksiUser.createData(data[i]));
      }
      return listData;
    }
  }

  static Future<List<RefleksiUser>> getAllData() async {
    var url = "${globals.urllocal}refleksiuserall";
    var apiResult = await http.get(Uri.parse(url), headers: {
      "Accept" : "application/json",
      "Access-Control-Allow-Origin" : "*"
    });
    var jsonObject = json.decode(apiResult.body);
    var data = (jsonObject as Map<String, dynamic>)['data'];
    List<RefleksiUser> listData = [];
    if (data.toString() == "null") {
      return listData;
    } else {
      for (int i = 0; i < data.length; i++) {
        listData.add(RefleksiUser.createData(data[i]));
      }
      return listData;
    }
  }
}

class DetailRenunganKomunitas extends StatefulWidget {
  const DetailRenunganKomunitas({
    super.key,
  });

  @override
  State<DetailRenunganKomunitas> createState() => _DetailRenunganKomunitasState();
}

class _DetailRenunganKomunitasState extends State<DetailRenunganKomunitas> {
  List<RefleksiUser> listRefleksi = [];
  bool hasRefleksi = false;

  Future<void> getListRefleksi() async {
    RefleksiUser.getData(globals.idrenungankomunitas).then((value) async {
      setState(() {
        listRefleksi = value;

        String tanggaltemp = "";
        String tanggal = "";
        String bulan = "";
        String tahun = "";
        int count = 0;
        hasRefleksi = false;
        for (int i = 0; i < listRefleksi.length; i++) {
          if(listRefleksi[i].iduser == globals.idUser) {
            hasRefleksi = true;
          }

          tanggaltemp = listRefleksi[i].tanggalposting;
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

          listRefleksi[i].tanggalposting = "$tanggal $bulan $tahun";

          tanggaltemp = "";
          tanggal = "";
          bulan = "";
          tahun = "";
          count = 0;
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListRefleksi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          }, 
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 113, 9, 49)
          )
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 8, right: 8 ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ClipOval(
                      child: Image.asset(
                        'assets/images/dummy-image.jpg',
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
                        globals.tanggalrenungan,
                        style: GoogleFonts.nunito(
                          textStyle: const TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 125, 125, 125)
                          )
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: globals.roleuser == 'admin' || globals.roleuser == '' || hasRefleksi == true ? false : true,
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context) => TambahRenunganK())
                          );
                        }, 
                        child: Text(
                          "Buat Refleksi",
                          style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            )
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Color(int.parse(globals.defaultcolor)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                          ),
                          elevation: 5,
                          padding: const EdgeInsets.all(5),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 30,),
            Text(
              "Judul",
              style: GoogleFonts.nunito(
                textStyle: const TextStyle(
                  fontSize: 18, 
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 113, 9, 49)
                )
              ),
            ),
            const SizedBox(height: 5,),
            Text(
              globals.judulrenungan,
              style: GoogleFonts.nunito(
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  color: Colors.black
                )
              ),
            ),
            const SizedBox(height: 25,),
            Text(
              "Topik Bacaan",
              style: GoogleFonts.nunito(
                textStyle: const TextStyle(
                  fontSize: 18, 
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 113, 9, 49)
                )
              ),
            ),
            const SizedBox(height: 5,),
            Text(
              globals.kitabbacaan,
              style: GoogleFonts.nunito(
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  color: Colors.black
                )
              ),
            ),
            const SizedBox(height: 25,),
            Text(
              "Ayat Bacaan",
              style: GoogleFonts.nunito(
                textStyle: const TextStyle(
                  fontSize: 18, 
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 113, 9, 49)
                )
              ),
            ),
            const SizedBox(height: 5,),
            Text(
              globals.ayatbacaan,
              style: GoogleFonts.nunito(
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  color: Colors.black
                )
              ),
            ),
            const SizedBox(height: 25,),
            Text(
              "Renungan",
              style: GoogleFonts.nunito(
                textStyle: const TextStyle(
                  fontSize: 18, 
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 113, 9, 49)
                )
              ),
            ),
            const SizedBox(height: 5,),
            Text(
              globals.isirenungan,
              style: GoogleFonts.nunito(
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  color: Colors.black
                )
              ),
            ),
            const SizedBox(height: 25,),
            Text(
              "Link",
              style: GoogleFonts.nunito(
                textStyle: const TextStyle(
                  fontSize: 18, 
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 113, 9, 49)
                )
              ),
            ),
            const SizedBox(height: 5,),
            InkWell(
              onTap: () async {
                // ignore: deprecated_member_use
                await launch(globals.linkrenungan);
              },
              child: Text(
                globals.linkrenungan,
                style: GoogleFonts.nunito(
                  textStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                    decoration: TextDecoration.underline
                  )
                ),
              ),
            ),
            const SizedBox(height: 25,),
            Text(
              "Tagline",
              style: GoogleFonts.nunito(
                textStyle: const TextStyle(
                  fontSize: 18, 
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 113, 9, 49)
                )
              ),
            ),
            const SizedBox(height: 5,),
            Text(
              globals.tagline,
              style: GoogleFonts.nunito(
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  color: Colors.black
                )
              ),
            ),
            const SizedBox(height: 10,),
            Divider(
              height: 1,
              color: Colors.black,
            ),
            const SizedBox(height: 10,),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: listRefleksi.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: Column(
                    children: [
                      Card(
                        elevation: 3,
                        child: 
                        Container(
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
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${listRefleksi[index].namadepan} ${listRefleksi[index].namabelakang}",
                                        style: GoogleFonts.nunito(
                                          textStyle: const TextStyle(
                                            fontSize: 18, 
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(255, 113, 9, 49)
                                          )
                                        ),
                                      ),
                                      Text(
                                        listRefleksi[index].tanggalposting,
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
                                globals.judulrenungan,
                                style: GoogleFonts.nunito(
                                  textStyle: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(int.parse(globals.defaultcolor))
                                  )
                                ),
                              ),
                              const SizedBox(height: 15,),
                              Text(
                                listRefleksi[index].tindakansaya,
                                style: GoogleFonts.nunito(
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black
                                  )
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Container(
                                padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
                                height: 1,
                                color: const Color.fromARGB(255, 125, 125, 125),
                              ),
                              const SizedBox(height: 10,),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 10,
                                            offset: Offset(0, 1), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.thumb_up_rounded,
                                            color: Color.fromARGB(255, 125, 125, 125),
                                            size: 20,
                                          ),
                                          const SizedBox(width: 10,),
                                          Text(
                                            "01",
                                            style: GoogleFonts.nunito(
                                              textStyle: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(255, 125, 125, 125)
                                              )
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10,),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.chat_bubble_outline_outlined,
                                        color: Color.fromARGB(255, 125, 125, 125),
                                        size: 20,
                                      ),
                                      const SizedBox(width: 5,),
                                      Text(
                                        "01",
                                        style: GoogleFonts.nunito(
                                          textStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(255, 125, 125, 125)
                                          )
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 10,),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.ios_share_outlined,
                                        color: Color.fromARGB(255, 125, 125, 125),
                                        size: 20,
                                      ),
                                      const SizedBox(width: 5,),
                                      Text(
                                        "01",
                                        style: GoogleFonts.nunito(
                                          textStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(255, 125, 125, 125)
                                          )
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                    ],
                  ),
                  onTap: () {
                    globals.idrefleksi = listRefleksi[index].idrefleksi;
                    globals.iduserrefleksi = listRefleksi[index].iduser;
                    globals.namaduserrefleksi = listRefleksi[index].namadepan;
                    globals.namabuserrefleksi = listRefleksi[index].namabelakang;
                    listRefleksi[index].ayatberkesan = listRefleksi[index].ayatberkesan.replaceAll("<br>", "\n"); 
                    globals.ayatberkesan = listRefleksi[index].ayatberkesan;
                    globals.tindakansaya = listRefleksi[index].tindakansaya;
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => DetailRefleksiUser())
                    );
                  },
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}