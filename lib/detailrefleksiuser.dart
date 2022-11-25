import 'dart:developer';

import 'package:alkitab/explore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import './global.dart' as globals;

class DetailRefleksiUser extends StatefulWidget {
  final String pagefrom;
  const DetailRefleksiUser({super.key, required this.pagefrom});

  @override
  State<DetailRefleksiUser> createState() => _DetailRefleksiUserState();
}

class _DetailRefleksiUserState extends State<DetailRefleksiUser> {

  
  TextEditingController ctr_komen = TextEditingController();

  List<ExploreKomen> listExploreKomen = [];

  Future<void> getExploreKomen() async {
    ExploreKomen.getExploreKomen().then((value) async {
      setState(() {
        listExploreKomen = [];
        listExploreKomen = value;
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("iduser: ${globals.idUser}");
    print("idkomunitas: ${globals.idkomunitas}");
    print("image path: ${globals.imagepathrefleksi}");
    getExploreKomen();
  }

  List kosong = [1,2,3];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
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
                  // const SizedBox(height: 20,),
                  // Container(
                  //   height: 1,
                  //   color: Color(int.parse(globals.defaultcolor)),
                  // ),
                  // const SizedBox(height: 10,),
                  // Container(
                  //   child: ListView.builder(
                  //     itemCount: kosong.length,
                  //                //itemCount: listExploreKomen.length,
                  //               itemBuilder: (context, index) {
                  //                 return ListTile(
                  //         // ignore: sized_box_for_whitespace
                  //         leading: Container(
                  //           width: 40,
                  //           height: 40,
                  //           color: Colors.yellow,
                  //           //child: Image.asset(listExploreKomen[index].imagePath),
                  //         ),
                  //         title: Text(
                  //           kosong[index].toString(),
                  //           //"helo",
                  //           //listExploreKomen[index].namadepan+" "+listExploreKomen[index].namaBelakang,
                  //           style: GoogleFonts.nunito(
                  //               textStyle: TextStyle(
                  //                   fontSize: 18,
                  //                   fontWeight: FontWeight.w500,
                  //                   color:
                  //                       Color(int.parse(globals.defaultcolor)))),
                  //         ),
                  //         onTap: () {
                            
                  //         },
                  //       );
                  //               }
                  //             ),
                  // ),
                  // Column(
                  //   children: [
                  //     Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         // ignore: avoid_unnecessary_containers
                  //         Container(
                  //           child: ClipOval(
                  //             child: Image.asset(
                  //               'assets/images/pp2.jpg',
                  //               width: 50,
                  //               height: 50,
                  //               fit: BoxFit.cover,
                  //             )
                  //           )
                  //         ),
                  //         const SizedBox(width: 5,),
                  //         Expanded(
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Text(
                  //                 "Nama User",
                  //                 style: GoogleFonts.nunito(
                  //                   textStyle: const TextStyle(
                  //                     fontSize: 18, 
                  //                     fontWeight: FontWeight.bold,
                  //                     color: Color.fromARGB(255, 113, 9, 49)
                  //                   )
                  //                 ),
                  //               ),
                  //               Text(
                  //                 "16 September 2022",
                  //                 style: GoogleFonts.nunito(
                  //                   textStyle: const TextStyle(
                  //                     fontSize: 14,
                  //                     color: Color.fromARGB(255, 125, 125, 125)
                  //                   )
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         const SizedBox(width: 55,),
                  //         Expanded(
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               const SizedBox(height: 10,),
                  //               Text(
                  //                 "Lorem Ipsum is simply dummy text of the printing and typesetting",
                  //                 style: GoogleFonts.nunito(
                  //                   textStyle: const TextStyle(
                  //                     fontSize: 16,
                  //                     fontWeight: FontWeight.w500,
                  //                     color: Colors.black
                  //                   )
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ],
                  // ),
                  //sini
                  // const SizedBox(height: 10,),
                  // Divider(
                  //   height: 1,
                  //   color: Color(int.parse(globals.defaultcolor)),
                  // ),
                  // const SizedBox(height: 10,),
                  // Column(
                  //   children: [
                  //     // Row(
                  //     //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     //   children: [
                  //     //     // ignore: avoid_unnecessary_containers
                  //     //     Container(
                  //     //       child: ClipOval(
                  //     //         child: Image.asset(
                  //     //           'assets/images/pp3.jpg',
                  //     //           width: 50,
                  //     //           height: 50,
                  //     //           fit: BoxFit.cover,
                  //     //         )
                  //     //       )
                  //     //       // Icon(
                  //     //       //   Icons.account_circle_outlined,
                  //     //       //   color: Color(int.parse(globals.defaultcolor)),
                  //     //       //   size: 50,
                  //     //       // ),
                  //     //     ),
                  //     //     const SizedBox(width: 5,),
                  //     //     // Expanded(
                  //     //     //   child: Column(
                  //     //     //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     //     //     children: [
                  //     //     //       Text(
                  //     //     //         "Nama User",
                  //     //     //         style: GoogleFonts.nunito(
                  //     //     //           textStyle: const TextStyle(
                  //     //     //             fontSize: 18, 
                  //     //     //             fontWeight: FontWeight.bold,
                  //     //     //             color: Color.fromARGB(255, 113, 9, 49)
                  //     //     //           )
                  //     //     //         ),
                  //     //     //       ),
                  //     //     //       Text(
                  //     //     //         "16 September 2022",
                  //     //     //         style: GoogleFonts.nunito(
                  //     //     //           textStyle: const TextStyle(
                  //     //     //             fontSize: 14,
                  //     //     //             color: Color.fromARGB(255, 125, 125, 125)
                  //     //     //           )
                  //     //     //         ),
                  //     //     //       ),
                  //     //     //     ],
                  //     //     //   ),
                  //     //     // ),
                  //     //   ],
                  //     // ),
                  //     Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         const SizedBox(width: 55,),
                  //         Expanded(
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               const SizedBox(height: 10,),
                  //               Text(
                  //                 "Lorem Ipsum is simply dummy text of the printing and typesetting",
                  //                 style: GoogleFonts.nunito(
                  //                   textStyle: const TextStyle(
                  //                     fontSize: 16,
                  //                     fontWeight: FontWeight.w500,
                  //                     color: Colors.black
                  //                   )
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    height: (MediaQuery.of(context).size.height)/10
                  ),
                  ],
                ),
              ),
              Positioned(
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
                          widget.pagefrom == "explore"
                          ? globals.imagepathrefleksi != "-" 
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
                          : globals.imagepathkomunitas != "-"
                            ? ClipOval(
                                child: Image.network(
                                  '${globals.urllocal}getimage?id=${globals.idkomunitas}&folder=komunitas',
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
              )
            ],
          ),
      ),
    );
  }
}