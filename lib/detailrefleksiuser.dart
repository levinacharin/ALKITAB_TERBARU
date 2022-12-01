import 'dart:developer';

import 'package:alkitab/detailrenungank.dart';
import 'package:alkitab/explore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import './global.dart' as globals;

class DetailRefleksiUser extends StatefulWidget {
  final String pagefrom;
  const DetailRefleksiUser({super.key, required this.pagefrom});

  @override
  State<DetailRefleksiUser> createState() => _DetailRefleksiUserState();
}

class _DetailRefleksiUserState extends State<DetailRefleksiUser> {
  DateTime tanggalhariini = DateTime.now();
  
  TextEditingController ctr_komen = TextEditingController();

  List<ExploreKomen> listExploreKomen = [];
  String idx="";

  void addLikeDatabase(String idlike) async {
    var url = "${globals.urllocal}simpanlike";
    var response = await http.post(Uri.parse(url), body: {
      "idLike": idlike,
      "darimana": widget.pagefrom,
      "idUser": globals.idUser,
    });
  }

  Future<http.Response> deleteLikeDatabase(String idLikeTemp, String darimana, String idUserTemp) async {
    var url = "${globals.urllocal}deletelike?idLike=$idLikeTemp&darimana=$darimana&idUser=$idUserTemp";
    var response = await http.delete(Uri.parse(url), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    return response;
  }

  Future<void> getExploreKomen(String darimana, String idx) async {
    ExploreKomen.getExploreKomen(darimana, idx).then((value) async {
      setState(() {
        listExploreKomen = [];
        listExploreKomen = value;

        globals.komentar = listExploreKomen.length.toString();
        log("isi list explore komen ${listExploreKomen[listExploreKomen.length-1].namadepan}");

        String tanggaltemp = "";
        String tanggal = "";
        String bulan = "";
        String tahun = "";
        int count = 0;
        for (int i = 0; i < listExploreKomen.length; i++) {
          //listExploreKomen[i].ayatbacaan = listExploreKomen[i].ayatbacaan.replaceAll("<br>", "\n");
          tanggaltemp = listExploreKomen[i].tanggalKomen;
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

          listExploreKomen[i].tanggalKomen = "$tanggal $bulan $tahun";

          tanggaltemp = "";
          tanggal = "";
          bulan = "";
          tahun = "";
          count = 0;
        }
      });
    });
  }

  void addKomenDatabase() async {
    if(widget.pagefrom=="explore"){
      idx=globals.idexplore;
    }else{
      idx=globals.idrefleksi;
    }
    String tanggalhariinistring = "${tanggalhariini.day}/${tanggalhariini.month}/${tanggalhariini.year}";
    var url = "${globals.urllocal}simpankomen";
    var response = await http.post(Uri.parse(url), body: {
      "idKomen" : idx,
      "darimana" : widget.pagefrom,
      "idUser" : globals.idUser,
      "isiKomen" : ctr_komen.text,
      "tanggalKomen" : tanggalhariinistring
    });
    if (response.statusCode == 200) {

      // ignore: use_build_context_synchronously
      setState(() {
        getExploreKomen(widget.pagefrom, idx);
        ctr_komen.text = "";
      });
      // Navigator.push(
      //   context, 
      //   MaterialPageRoute(builder: (context) => DetailRefleksiUser(pagefrom:widget.pagefrom))
      // );
    }
  }

  void updateLikeKomen(String idexplore, String suka, String komen) async {
    var url = "${globals.urllocal}updatelikekomen";
    var response = await http.put(Uri.parse(url), body: {
      "idexplore" : idexplore,
      "suka" : suka,
      "komen" : komen
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("iduser: ${globals.idUser}");
    print("idkomunitas: ${globals.idkomunitas}");
    print("image path: ${globals.imagepath}");
    print("jumlah komen: ${globals.komentar}");
    if(widget.pagefrom=="explore"){
      idx=globals.idexplore;
    }else if (widget.pagefrom == "refleksi"){
      idx=globals.idrefleksi;
    }
    getExploreKomen(widget.pagefrom, idx);
  }

  List kosong = [1,2,3];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.pagefrom == "explore") {
          updateLikeKomen(globals.idexplore, globals.suka, globals.komentar);

          Navigator.pop(context, "refresh");
          // Navigator.push(
          //   context, 
          //   MaterialPageRoute(builder: (context) => const Explore())
          // );
        } else if (widget.pagefrom == "refleksi") {
          Navigator.pop(context, "refresh");
        }

        return true;
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
    
                if (widget.pagefrom == "explore") {
                  updateLikeKomen(globals.idexplore, globals.suka, globals.komentar);
    
                  Navigator.pop(context, "refresh");
                  // Navigator.push(
                  //   context, 
                  //   MaterialPageRoute(builder: (context) => const Explore())
                  // );
                } else if (widget.pagefrom == "refleksi") {
                  Navigator.pop(context, "refresh");
                }
              }, 
              icon: const Icon(
                Icons.arrow_back,
                color: Color.fromARGB(255, 113, 9, 49)
              )
            ),
          ),
          body: Stack(
              children: <Widget>[
                SingleChildScrollView(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            globals.imagepathrefleksi != "-" 
                            ? ClipOval(
                              child: Image.network(
                                '${globals.urllocal}getimage?id=${globals.iduserrefleksi}&folder=user',
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
                                "${globals.namaduserrefleksi} ${globals.namabuserrefleksi}",
                                style: GoogleFonts.nunito(
                                  textStyle: const TextStyle(
                                    fontSize: 18, 
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 113, 9, 49)
                                  )
                                ),
                              ),
                              Text(
                                globals.tagline,
                                style: GoogleFonts.nunito(
                                  textStyle: const TextStyle(
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 125, 125, 125)
                                  )
                                ),
                              ),
                              Text(
                                globals.tanggalrefleksi,
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
                        textStyle: const TextStyle(
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
                        textStyle: const TextStyle(
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
                        textStyle: const TextStyle(
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
                        textStyle: const TextStyle(
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
                          textStyle: const TextStyle(
                            fontSize: 18,
                            color: Colors.blue,
                            decoration: TextDecoration.underline
                          )
                        ),
                      ),
                    ),
                    const SizedBox(height: 25,),
                    Text(
                      "Ayat Berkesan",
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
                      globals.ayatberkesan,
                      style: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: Colors.black
                        )
                      ),
                    ),
                    const SizedBox(height: 25,),
                    Text(
                      "Tindakan Saya",
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
                      globals.tindakansaya,
                      style: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: Colors.black
                        )
                      ),
                    ),
                    const SizedBox(height: 20,),
                    GestureDetector(
                      onTap: () {
                        if (globals.idUser != "") {
                          if (widget.pagefrom == "explore") {
                            setState(() {
                              globals.listShowUserLikeExplore = !globals.listShowUserLikeExplore;
                              int count = int.parse(globals.suka);
                              if (globals.listShowUserLikeExplore == false) {
                                count--;
                                deleteLikeDatabase(globals.idexplore, widget.pagefrom, globals.idUser);
                              } else if (globals.listShowUserLikeExplore == true) {
                                count++;
                                addLikeDatabase(globals.idexplore);
                              }
    
                              globals.suka = count.toString();
                            });
                          } else {
                            setState(() {
                              globals.listShowUserLikeExplore = !globals.listShowUserLikeExplore;
                              int count = int.parse(globals.suka);
                              if (globals.listShowUserLikeExplore == false) {
                                count--;
                                deleteLikeDatabase(globals.idrefleksi, widget.pagefrom, globals.idUser);
                              } else if (globals.listShowUserLikeExplore == true) {
                                count++;
                                addLikeDatabase(globals.idrefleksi);
                              }
    
                              globals.suka = count.toString();
                            });
                          }
                        } else {
                          showDialog(
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
                      },
                      child: Container(
                        width: 70,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 10,
                                offset: const Offset(0, 1),
                              )
                            ]),
                        child: Row(
                          children: [
                            Container(
                                width: 20,
                                height: 20,
                                child: globals.listShowUserLikeExplore == true
                                  ? Image.asset("assets/images/icon_like_red.png")
                                  : Image.asset("assets/images/icon_like_black.png")
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              globals.suka,
                              style: GoogleFonts.nunito(
                                  textStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight:
                                          FontWeight.bold,
                                      color: Color.fromARGB(
                                          255,
                                          125,
                                          125,
                                          125))),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Container(
                      height: 1,
                      color: Color(int.parse(globals.defaultcolor)),
                    ),
                    const SizedBox(height: 10,),
                    Column(children: [
                      // Container(child: 
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                      //itemCount: kosong.length,
                                itemCount: listExploreKomen.length,
                                itemBuilder: (context, index) {
                                  // log("lbuilder - ${listExploreKomen[index].idKomen.toString()}");
                                  // log("lbuilder - ${listExploreKomen[index].darimana.toString()}");
                                  // log("lbuilder - ${listExploreKomen[index].isiKomen.toString()}");
                                  // log("lbuilder - ${listExploreKomen[index].tanggalKomen.toString()}");
                                  // log("lbuilder - ${listExploreKomen[index].imagePath.toString()}");
                                  return 
                                  Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // ignore: avoid_unnecessary_containers
                            Column(
                              children: [
                                Container(
                                  
                                  child:listExploreKomen[index].imagePath != "-" 
                                ? ClipOval(
                                  child: 
                                  Image.network(
                                    '${globals.urllocal}getimage?id=${listExploreKomen[index].idUser}&folder=user',
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover,
                                  ),
                                )
                                : 
                                const Icon(
                                  Icons.person, size: 40,
                                ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 10,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    listExploreKomen[index].namadepan+" "+listExploreKomen[index].namaBelakang,
                                    style: GoogleFonts.nunito(
                                      textStyle: const TextStyle(
                                        fontSize: 18, 
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 113, 9, 49)
                                      )
                                    ),
                                  ),
                                  Text(
                                    listExploreKomen[index].tanggalKomen,
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
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(width: 55,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10,),
                                  Text(
                                    listExploreKomen[index].isiKomen,
                                    style: GoogleFonts.nunito(
                                      textStyle: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black
                                      )
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20,)
                      ],
                    );
                        }
                              ),
                      
                      // )
                    ],),
                    
                    
                    SizedBox(
                      height: (MediaQuery.of(context).size.height)/20
                    ),
                    ],
                  ),
                  
                ),
                Visibility(
                  visible: globals.idUser != "" ? true : false,
                  child: Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              globals.imagepath != "-"
                              ? ClipOval(
                                child: Image.network(
                                  '${globals.urllocal}getimage?id=${globals.idUser}&folder=user',
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                              )
                              : Icon(
                                  Icons.account_circle_outlined,
                                  color: Color(int.parse(globals.defaultcolor)),
                                      size: 40,
                                )
                            ],
                          ),
                          const SizedBox(width: 5,),
                          Expanded(
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(int.parse(globals.defaultcolor))
                                ),
                                borderRadius: const BorderRadius.all(Radius.circular(50)),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: ctr_komen,
                                      cursorColor: Color(int.parse(globals.defaultcolor)),
                                      decoration: InputDecoration(
                                        fillColor: Colors.transparent,
                                        filled: true,
                                        border: InputBorder.none,
                                        hintText: 'berikan pendapat anda ..',
                                        hintStyle: TextStyle(
                                          color: Colors.grey[400]
                                        ),
                                        contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 10)
                                      ),
                                      style: GoogleFonts.nunito(
                                        textStyle: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black
                                        )
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      addKomenDatabase();
                                    }, 
                                    icon: const Icon(Icons.send)
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
        ),
      ),
    );
  }
}