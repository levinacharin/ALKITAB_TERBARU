import 'package:alkitab/detailrefleksiuser.dart';
import 'package:alkitab/listrencanauser.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_share/flutter_share.dart';


//import './homepage.dart';
import './global.dart' as globals;

class ListExplore {
  String idexplore;
  String iduser;
  String idrefleksi;
  String idrenungan;
  String tanggalposting;
  String namadepan;
  String namabelakang;
  String imagepath;
  String judul;
  String kitabbacaan;
  String ayatbacaan;
  String isirenungan;
  String linkrenungan;
  String tagline;
  String ayatberkesan;
  String tindakansaya;
  String komentar;
  String suka;

  ListExplore({
    required this.idexplore,
    required this.iduser,
    required this.idrefleksi,
    required this.idrenungan,
    required this.tanggalposting,
    required this.namadepan,
    required this.namabelakang,
    required this.imagepath,
    required this.judul,
    required this.kitabbacaan,
    required this.ayatbacaan,
    required this.isirenungan,
    required this.linkrenungan,
    required this.tagline,
    required this.ayatberkesan,
    required this.tindakansaya,
    required this.komentar,
    required this.suka
  });

  factory ListExplore.createData(Map<String, dynamic> object) {
    return ListExplore(
      idexplore: object['idexplore'].toString(), 
      iduser: object['iduser'].toString(), 
      idrefleksi: object['idrefleksi'].toString(),
      idrenungan: object['idrenungan'].toString(),
      tanggalposting: object['tanggalposting'],
      namadepan: object['namadepan'],
      namabelakang: object['namabelakang'],
      imagepath: object['imagepath'],
      judul: object['judul'],
      kitabbacaan: object['kitabbacaan'],
      ayatbacaan: object['ayatbacaan'],
      isirenungan: object['isirenungan'],
      linkrenungan: object['linkrenungan'],
      tagline: object['tagline'],
      ayatberkesan: object['ayatberkesan'],
      tindakansaya: object['tindakansaya'], 
      komentar: object['komentar'].toString(), 
      suka: object['suka'].toString()
    );
  }

  static Future<List<ListExplore>> getAllData() async {
    var url = "${globals.urllocal}lihatallrenunganexplore";
    var apiResult = await http.get(Uri.parse(url), headers: {
      "Accept" : "application/json",
      "Access-Control-Allow-Origin" : "*"
    });
    var jsonObject = json.decode(apiResult.body);
    var data = (jsonObject as Map<String, dynamic>)['data'];
    List<ListExplore> listData = [];
    if (data.toString() == "null") {
      return listData;
    } else {
      for (int i = 0; i < data.length; i++) {
        listData.add(ListExplore.createData(data[i]));
      }
      return listData;
    }
  }
}

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  bool like=false;
  List<ListExplore> listExplore = [];
  Future<void> getListExplore() async {
    ListExplore.getAllData().then((value) async {
      setState(() {
        listExplore = value;
        for (int i = 0; i < listExplore.length; i++) {
          listExplore[i].ayatbacaan = listExplore[i].ayatbacaan.replaceAll("<br>", "\n");
          listExplore[i].ayatberkesan = listExplore[i].ayatberkesan.replaceAll("<br>", "\n");
        }
        

        String tanggaltemp = "";
        String tanggal = "";
        String bulan = "";
        String tahun = "";
        int count = 0;
        for (int i = 0; i < listExplore.length; i++) {
          tanggaltemp = listExplore[i].tanggalposting;
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

          listExplore[i].tanggalposting = "$tanggal $bulan $tahun";

          tanggaltemp = "";
          tanggal = "";
          bulan = "";
          tahun = "";
          count = 0;
        }
      });
    });
  }

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListExplore();
  }

  void sharerenungan(int index)async{
    String renunganfull = "";
    renunganfull = 
    // ignore: prefer_interpolation_to_compose_strings
    "*Tanggal* : "+
    listExplore[index].tanggalposting.toString() + 
    "\n\n" +
    "*Judul Renungan* : "+
    listExplore[index].judul.toString()+
    "\n\n" +
    "*Ayat Bacaan* :\n"+
    listExplore[index].ayatbacaan.toString()+
    "\n\n" +
    "*Ayat Berkesan* :\n"+
    listExplore[index].ayatberkesan.toString()+
    "\n\n" +
    "*Renungan* :\n"+
    listExplore[index].isirenungan.toString()+
    "\n\n" +
    "*Tindakan Saya* :\n"+
    listExplore[index].tindakansaya.toString()
    ;

    await FlutterShare.share(
      title: 'Share Renungan',
      text: renunganfull,
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
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back,
            color: Color.fromARGB(255, 113, 9, 49)
          )
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 16, right: 16),
            child: Text(
              "Explore",
              style: GoogleFonts.nunito(
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 113, 9, 49)
                )
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20,),
          Container(
            padding: const EdgeInsets.only(left: 16, right: 16),
            height: 40,
            child: TextField(
              controller: controller,
              cursorColor: const Color.fromARGB(255, 95, 95, 95),
              decoration: InputDecoration(
                  fillColor: const Color.fromARGB(255, 253, 255, 252),
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 3, color: Color(int.parse(globals.defaultcolor))),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1, color: Color(int.parse(globals.defaultcolor))),
                  ),
                  hintText: 'Cari Renungan',
                  hintStyle: TextStyle(
                    color: Colors.grey[400]
                  ),
                  contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5)),
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    color: Colors.black
                  )
                ),
            ),
          ),
          const SizedBox(height: 10,),
          Expanded(
            child: ListView.builder(
              itemCount: listExplore.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                      child: Card(
                        elevation: 3,
                        child: 
                        Container(
                          padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    globals.idexplore = listExplore[index].idexplore;
                                    globals.iduserrefleksi = listExplore[index].iduser;
                                    globals.idrefleksi = listExplore[index].idrefleksi;
                                    globals.idrenungankomunitas = listExplore[index].idrenungan;
                                    globals.tanggalposting = listExplore[index].tanggalposting;
                                    globals.namaduserrefleksi = listExplore[index].namadepan;
                                    globals.namabuserrefleksi = listExplore[index].namabelakang;
                                    globals.imagepathrefleksi = listExplore[index].imagepath;
                                    globals.judulrenungan = listExplore[index].judul;
                                    globals.kitabbacaan = listExplore[index].kitabbacaan;
                                    globals.ayatbacaan = listExplore[index].ayatbacaan;
                                    globals.isirenungan = listExplore[index].isirenungan;
                                    globals.linkrenungan = listExplore[index].linkrenungan;
                                    globals.tagline = listExplore[index].tagline;
                                    globals.ayatberkesan = listExplore[index].ayatberkesan;
                                    globals.tindakansaya = listExplore[index].tindakansaya;
                                    globals.komentar = listExplore[index].komentar;
                                    globals.suka = listExplore[index].suka;
                                  });

                                  Navigator.push(
                                    context, 
                                    MaterialPageRoute(builder: (context) => const DetailRefleksiUser())
                                  );
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            listExplore[index].imagepath != "-"
                                            ? ClipOval(
                                              child: Image.network(
                                                '${globals.urllocal}getimage?id=${listExplore[index].iduser}&folder=user',
                                                width: 60,
                                                height: 60,
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                            : Icon(
                                              Icons.account_circle_outlined,
                                              color: Color(int.parse(globals.defaultcolor)),
                                              size: 60,
                                            )
                                          ],
                                        ),
                                        const SizedBox(width: 5,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${listExplore[index].namadepan} ${listExplore[index].namabelakang}",
                                              style: GoogleFonts.nunito(
                                                textStyle: const TextStyle(
                                                  fontSize: 18, 
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(255, 113, 9, 49)
                                                )
                                              ),
                                            ),
                                            Text(
                                              listExplore[index].tanggalposting,
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
                                      listExplore[index].judul,
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
                                      listExplore[index].isirenungan,
                                      style: GoogleFonts.nunito(
                                        textStyle: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black
                                        )
                                      ),
                                    ),
                                    const SizedBox(height: 10,),
                                  ],
                                ),
                              ),
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
                                      if(like==false){
                                        setState(() {
                                          like=true;
                                        });
                                        
                                      }else{
                                        setState(() {
                                          like=false;
                                        });
                                        
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 10,
                                            offset: const Offset(0, 1),
                                          )
                                        ]
                                      ),
                                      child: Row(
                                        children: [
                                            
                                            Container(
                                              width: 20,
                                              height: 20,
                                              child: (like?Image.asset(
                                                  "assets/images/icon_like_red.png"):Image.asset(
                                                  "assets/images/icon_like_black.png"))
                                              ,
                                              // child: Image.asset("assets/images/komunitas_icon.png"),
                                            ),
                                            const SizedBox(
                                              width: 10,),
                                          Text(
                                            listExplore[index].suka,
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
                                    ),
                                  ),
                                  const SizedBox(width: 20,),
                                  GestureDetector(
                                    onTap: () {
                                      print("komen klik");
                                    },
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.chat_bubble_outline_outlined,
                                          color: Color.fromARGB(255, 125, 125, 125),
                                          size: 20,
                                        ),
                                        const SizedBox(width: 10,),
                                        Text(
                                          listExplore[index].komentar,
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
                                  ),
                                  const SizedBox(width: 20,),
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
                                          "0",
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
                    ),
                    const SizedBox(height: 10,),
                  ],
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}