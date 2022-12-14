// ignore_for_file: prefer_const_constructors, sort_child_properties_last
import 'dart:developer';

import 'package:alkitab/detailkomunitas.dart';
import 'package:alkitab/explore.dart';
import 'package:alkitab/tambahrenungank.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

import './global.dart' as globals;
import 'detailrefleksiuser.dart';
import 'listrencanauser.dart';

class RefleksiLike {
  String idLike;
  String darimana;
  String idUser;

  RefleksiLike(
      {required this.idLike, required this.darimana, required this.idUser});

  factory RefleksiLike.createData(Map<String, dynamic> object) {
    return RefleksiLike(
        idLike: object['idLike'].toString(),
        darimana: object['darimana'].toString(),
        idUser: object['idUser'].toString());
  }

  static Future<List<RefleksiLike>> getRefleksiLike(
      String darimana, String id) async {
    var url = "${globals.urllocal}getlike?idLike=$id&darimana=$darimana";
    var apiResult = await http.get(Uri.parse(url), headers: {
      "Accept": "application/json",
      "Access-Control-Allow-Origin": "*"
    });

    var jsonObject = json.decode(apiResult.body);
    var data = (jsonObject as Map<String, dynamic>)['data'];
    List<RefleksiLike> listData = [];
    if (data.toString() == "null") {
      return listData;
    } else {
      for (int i = 0; i < data.length; i++) {
        listData.add(RefleksiLike.createData(data[i]));
      }
      return listData;
    }
  }

  static Future<List<RefleksiLike>> getUserRefleksiLike(String darimana, String id) async {
    var url = "${globals.urllocal}getstatuslikeuser?idUser=${id}&darimana=$darimana";
    var apiResult = await http.get(Uri.parse(url), headers: {
      "Accept": "application/json",
      "Access-Control-Allow-Origin": "*"
    });

    var jsonObject = json.decode(apiResult.body);
    var data = (jsonObject as Map<String, dynamic>)['data'];
    List<RefleksiLike> listData = [];
    if (data.toString() == "null") {
      return listData;
    } else {
      for (int i = 0; i < data.length; i++) {
        log("darifunction ${data[i]}");
        listData.add(RefleksiLike.createData(data[i]));
      }
      return listData;
    }
  }
}

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
  String imagepath;
  String ayatberkesan;
  String tindakansaya;
  String? suka;
  String? komen;

  RefleksiUser({
    required this.idrefleksi,
    required this.iduser,
    required this.idrenungankomunitas,
    required this.tanggalposting,
    required this.namadepan,
    required this.namabelakang,
    required this.imagepath,
    required this.ayatberkesan,
    required this.tindakansaya,
    this.suka,
    this.komen
  });

  factory RefleksiUser.createData(Map<String, dynamic> object) {
    return RefleksiUser(
      idrefleksi: object['idrefleksi'].toString(), 
      iduser: object['iduser'].toString(), 
      idrenungankomunitas: object['idrenungankomunitas'].toString(), 
      tanggalposting: object['tanggalposting'], 
      namadepan: object['namadepan'],
      namabelakang: object['namabelakang'],
      imagepath: object['imagepath'],
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
  final String? darimana;
  const DetailRenunganKomunitas({
    super.key,
    this.darimana
  });

  @override
  State<DetailRenunganKomunitas> createState() => _DetailRenunganKomunitasState();
}

class _DetailRenunganKomunitasState extends State<DetailRenunganKomunitas> {

  void addLikeDatabase(String idlike) async {
    var url = "${globals.urllocal}simpanlike";
    var response = await http.post(Uri.parse(url), body: {
      "idLike": idlike,
      "darimana": "refleksi",
      "idUser": globals.idUser,
    });
  
  }

  Future<http.Response> deleteLikeDatabase(String idLikeTemp, String darimana, String idUserTemp) async {
    // print("idkomunitas: ${globals.idkomunitas} - iduser: ${globals.idUser}");
    var url = "${globals.urllocal}deletelike?idLike=$idLikeTemp&darimana=$darimana&idUser=$idUserTemp";
    var response = await http.delete(Uri.parse(url), 
    headers: <String, String> {
      'Content-Type' : 'application/json; charset=UTF-8',
    });
    
    return response;
  }

  

  // bool like=false;
  void sharerenungan(int index)async{
    // globals.idrenungankomunitas = listRenungan[index].idrenungankomunitas;
    //                             globals.tanggalrenungan = listRenungan[index].tanggalrenungan;
    //                             globals.judulrenungan = listRenungan[index].judulrenungan;
    //                             globals.kitabbacaan = listRenungan[index].kitabbacaan;
    //                             globals.ayatbacaan = listRenungan[index].ayatbacaan;
    //                             globals.isirenungan = listRenungan[index].isirenungan;
    //                             globals.linkrenungan = listRenungan[index].linkrenungan;
    //                             globals.tagline = listRenungan[index].tagline;
    String renunganfull = "";
    renunganfull = 
    // ignore: prefer_interpolation_to_compose_strings
    "*Tanggal* : "+
    globals.tanggalrenungan .toString() + 
    "\n\n" +
    "*Judul Renungan* : "+
    globals.judulrenungan.toString()+
    "\n\n" +
    "*Ayat Bacaan* :\n"+
    globals.ayatbacaan.toString()+
    "\n\n" +
    "*Ayat Berkesan* :\n"+
    listRefleksi[index].ayatberkesan.toString()+
    "\n\n" +
    "*Renungan* :\n"+
    globals.isirenungan.toString()+
    "\n\n" +
    "*Tindakan Saya* :\n"+
    listRefleksi[index].tindakansaya.toString()
    ;

    await FlutterShare.share(
      title: 'Share Renungan',
      text: renunganfull,
    );
  }
  List<RefleksiUser> listRefleksi = [];
  bool hasRefleksi = false;
  List<bool> listShowUserLikeRefleksi=[];
  List<RefleksiLike> listRefleksiUserLike = [];
  bool statusLike = false;

  Future<void> getListRefleksi() async {
    RefleksiUser.getData(globals.idrenungankomunitas).then((value) async {
      setState(() {
        listRefleksi = [];
        listRefleksi = value;

        listShowUserLikeRefleksi = [];
        for (int i = 0; i < listRefleksi.length; i++) {
          listShowUserLikeRefleksi.add(false);

          RefleksiLike.getRefleksiLike("refleksi", listRefleksi[i].idrefleksi).then((value) async {
            setState(() {
              listRefleksi[i].suka = value.length.toString();
              print("suka: ${listRefleksi[i].suka}");
            });
          });

          ExploreKomen.getExploreKomen("refleksi", listRefleksi[i].idrefleksi).then((value) async {
            setState(() {
              listRefleksi[i].komen = value.length.toString();
            });
          });
        }

        getListUserLikeRefleksi();

        // String tanggaltemp = "";
        // String tanggal = "";
        // String bulan = "";
        // String tahun = "";
        // int count = 0;

        // int indexbuatlistygdilikeuser=0;
        // hasRefleksi = false;

        // for (int i = 0; i < listRefleksi.length; i++) {
        //   listShowUserLikeRefleksi.add(false);

        //   List<RefleksiLike> listRefleksiLike = [];
        //   await RefleksiLike.getRefleksiLike("refleksi", listRefleksi[i].idrefleksi).then((value) async {
        //     setState(() {
        //       listRefleksiLike = [];
        //       listRefleksiLike = value; //isinya list per detail like dari explore yg dah difilter, apakah udah dari explore dan idexplore
        //     });
        //   });

        //   for(int j=0;j<listRefleksiLike.length;j++){
        //     log("benergasihhh cekall $j - ${listRefleksiLike[j].idUser} ${globals.idUser}");
        //     if(listRefleksiLike[j].idUser==globals.idUser){
        //       listShowUserLikeRefleksi[indexbuatlistygdilikeuser]=true;
        //       //break;
        //     }else{
        //       listShowUserLikeRefleksi[indexbuatlistygdilikeuser]=false;
        //     }
        //     log("benergasihhh - ${listShowUserLikeRefleksi[indexbuatlistygdilikeuser]}");
            
        //   }
          
        //   indexbuatlistygdilikeuser++;



        //   //log("atas likenih - ${listExplore[i].iduser}");

          
        //   listRefleksi[i].suka = listRefleksiLike.length.toString();
        //   if(listRefleksi[i].iduser == globals.idUser) {
        //     hasRefleksi = true;
        //   }

        //   tanggaltemp = listRefleksi[i].tanggalposting;
        //   for (int j = 0; j < tanggaltemp.length; j++) {
        //     if (tanggaltemp[j] == '/' && bulan == "") {
        //       if (tanggaltemp[j+2] != '/') {
        //         bulan = bulan + tanggaltemp[j+1] + tanggaltemp[j+2];
        //         count = 2;
        //       } else {
        //         bulan = bulan + tanggaltemp[j+1];
        //         count = 1;
        //       }
        //     } else  if (tanggaltemp[j] == '/' && count == 0) {
        //       tahun = tahun + tanggaltemp[j+1] + tanggaltemp[j+2] + tanggaltemp[j+3] + tanggaltemp[j+4];
        //       break;
        //     } else if (tanggal == "") {
        //       if (tanggaltemp[j+1] != '/') {
        //         tanggal = tanggal + tanggaltemp[j] + tanggaltemp[j+1];
        //       } else {
        //         tanggal = tanggal + tanggaltemp[j];
        //       }
        //     } else {
        //       count--;
        //     }
        //   }
        

        //   if (bulan == "1") {
        //     bulan = "Januari";
        //   } else if (bulan == "2") {
        //     bulan = "Februari";
        //   } else if (bulan == "3") {
        //     bulan = "Maret";
        //   } else if (bulan == "4") {
        //     bulan = "April";
        //   } else if (bulan == "5") {
        //     bulan = "Mei";
        //   } else if (bulan == "6") {
        //     bulan = "Juni";
        //   } else if (bulan == "7") {
        //     bulan = "Juli";
        //   } else if (bulan == "8") {
        //     bulan = "Agustus";
        //   } else if (bulan == "9") {
        //     bulan = "September";
        //   } else if (bulan == "10") {
        //     bulan = "Oktober";
        //   } else if (bulan == "11") {
        //     bulan = "November";
        //   } else if (bulan == "12") {
        //     bulan = "Desember";
        //   } 

        //   listRefleksi[i].tanggalposting = "$tanggal $bulan $tahun";

        //   tanggaltemp = "";
        //   tanggal = "";
        //   bulan = "";
        //   tahun = "";
        //   count = 0;
        // }
      });
    });
  }

  Future<void>getListUserLikeRefleksi() async {
    String tanggaltemp = "";
    String tanggal = "";
    String bulan = "";
    String tahun = "";
    int count = 0;

    RefleksiLike.getUserRefleksiLike("refleksi", globals.idUser).then((value) async {
      setState(() {
        listRefleksiUserLike = value;

        for (int i = 0; i < listRefleksi.length; i++) {
          statusLike = false;
          for (int j = 0 ; j < value.length; j++) {
            if (listRefleksi[i].idrefleksi == value[j].idLike && globals.idUser != "") {
              statusLike = true;
            }
          }

          listShowUserLikeRefleksi[i] = statusLike;

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

  List<ExploreKomen> listExploreKomen = [];
  Future<void> getExploreKomen(String darimana, String idx) async {
    ExploreKomen.getExploreKomen(darimana,idx).then((value) async {
      setState(() {
        listExploreKomen = [];
        listExploreKomen = value;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListRefleksi();
  }

  Future<void> _showDialogAlert() async {
    return showDialog(
      context: context, 
      builder: (BuildContext context) => AlertDialog(
        title: Center(
          child: Text(
            "Silahkan login terlebih dahulu agar bisa like postingan ini",
            style: GoogleFonts.nunito(
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 113, 9, 49)
              )
            ),
            textAlign: TextAlign.center,
          ),
        ),
        actions: [
          // ignore: sized_box_for_whitespace
          Container(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              }, 
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(int.parse(globals.defaultcolor)),
                elevation: 5,
                padding: const EdgeInsets.all(5)
              ),
              child: Text(
                "Kembali",
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  )
                ),
              )
            ),
          )
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            if (widget.darimana == "tambahrenungank") {
              Navigator.pop(context);
              Navigator.pop(context, "refresh");
            } else {
              Navigator.pop(context, "refresh");
            }
            // Navigator.push(
            //   context, 
            //   MaterialPageRoute(builder: (context) => DetailKomunitas(shouldpop: "false"))
            // );
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
                    globals.imagepathkomunitas != "-"
                    ? ClipOval(
                      child: Image.network(
                        '${globals.urllocal}getimage?id=${globals.idkomunitas}&folder=komunitas',
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    )
                    : Icon(
                      Icons.account_circle_outlined,
                      color: Color(int.parse(globals.defaultcolor)),
                      size: 80,
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
                        onPressed: () async {
                          final data = await Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context) => TambahRenunganK())
                          );

                          if (data == "refresh") {
                            getListRefleksi();
                          }
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
                          backgroundColor: Color(int.parse(globals.defaultcolor)),
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
                return Column(
                  children: [
                    Card(
                      elevation: 3,
                      child: 
                      Container(
                        padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () async {
                              globals.idrefleksi = listRefleksi[index].idrefleksi;
                              globals.iduserrefleksi = listRefleksi[index].iduser;
                              globals.namaduserrefleksi = listRefleksi[index].namadepan;
                              globals.namabuserrefleksi = listRefleksi[index].namabelakang;
                              globals.imagepathrefleksi = listRefleksi[index].imagepath;
                              listRefleksi[index].ayatberkesan = listRefleksi[index].ayatberkesan.replaceAll("<br>", "\n"); 
                              globals.ayatberkesan = listRefleksi[index].ayatberkesan;
                              globals.tindakansaya = listRefleksi[index].tindakansaya;
                              globals.suka = listRefleksi[index].suka.toString();
                              globals.komentar = listRefleksi[index].komen.toString();
                              globals.listShowUserLikeExplore = listShowUserLikeRefleksi[index];
                              final data = await Navigator.push(
                                context, 
                                MaterialPageRoute(builder: (context) => DetailRefleksiUser(pagefrom: 'refleksi',))
                              );

                              if (data == "refresh") {
                                getListRefleksi();
                                setState(() {
                                  listRefleksi[index].suka = globals.suka;
                                  listRefleksi[index].komen = globals.komentar;
                                  listShowUserLikeRefleksi[index] = globals.listShowUserLikeExplore;
                                });
                              }
                  
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    listRefleksi[index].imagepath != "-"
                                    ?ClipOval(
                                      child: Image.network(
                                        '${globals.urllocal}getimage?id=${listRefleksi[index].iduser}&folder=user',
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                    : Icon(
                                      Icons.account_circle_outlined,
                                      color: Color(int.parse(globals.defaultcolor)),
                                      size: 60,
                                    ),
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

                ],),
                            ),
                            
                            
                            //sini
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
                                    if (globals.idUser != "") {
                                      setState(() {
                                        listShowUserLikeRefleksi[index] = !listShowUserLikeRefleksi[index];

                                        int count = int.parse(listRefleksi[index].suka.toString());
                                        if (listShowUserLikeRefleksi[index] == false) {
                                          count--;
                                          deleteLikeDatabase(listRefleksi[index].idrefleksi, "refleksi", globals.idUser);
                                        } else if (listShowUserLikeRefleksi[index] == true) {
                                          count++;
                                          addLikeDatabase(listRefleksi[index].idrefleksi);
                                        }

                                        listRefleksi[index].suka = count.toString();
                                      });
                                    } else {
                                      _showDialogAlert();
                                    }
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
                                        Container(
                                            width: 20,
                                            height: 20,
                                            child: (listShowUserLikeRefleksi[index] == true?Image.asset(
                                                  "assets/images/icon_like_red.png"):Image.asset(
                                                  "assets/images/icon_like_black.png"))
                                          ),
                                        const SizedBox(width: 10,),
                                        Text(
                                          listRefleksi[index].suka.toString(),
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
                                      listRefleksi[index].komen.toString(),
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
                                GestureDetector(
                                  onTap: () {
                                    sharerenungan(index);
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.ios_share_outlined,
                                        color: Color.fromARGB(255, 125, 125, 125),
                                        size: 20,
                                      ),
                                      const SizedBox(width: 10,),
                                      Text(
                                        "  ",
                                        style: GoogleFonts.nunito(
                                          textStyle: const TextStyle (
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(255, 125, 125, 125)
                                          )
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                  ],
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}