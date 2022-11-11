import 'package:alkitab/classrencanabacaan.dart';
import 'package:alkitab/detailkomunitas.dart';
import 'package:alkitab/isirencanabaca.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

  bool Status1 = false;
  bool Status2 = false;
  bool StatusAll = false;

  void getDate() {
    setState(() {
      estDate = [];
      datetemp = "";
      if (widget.pagefrom == "user") {
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
            currentdate = currentdate.add(Duration(days: 1));
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
    
    print("rencanadone: ${globals.rencanaDone}");
    for (int i = 0; i < globals.rencanaDone.length; i++) {
      if (globals.rencanaDone[i] == "1,1") {
        Status2 = true;
      } else if (globals.rencanaDone[i] == "0,1") {
        Status1 = true;
      }
    }

    if (Status1 == true && Status2 == true) {
      StatusAll = true;
    }

    print("status 1: $Status1, status 2: $Status2, status all: $StatusAll");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            globals.rencanaDone = [];
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Color.fromARGB(255, 113, 9, 49),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: Image.asset(
                "assets/images/pp3.jpg",
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              height: 90,
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
                              StatusAll == false
                              // globals.listDetailRUser[index]['Status Selesai'] == "false" || StatusAll == false
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
                                    // color: Colors.green,
                                    border: Border.all(
                                      color: Colors.green
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 3,
                                        offset: Offset(1, 3), // changes position of shadow
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
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                                  Text(
                                    widget.pagefrom == "komunitas" ? globals.listDetailRencana[indexSelect].kitabbacaan : globals.listDetailRUser[indexSelect]['Kitab Bacaan'],
                                    style: GoogleFonts.nunito(
                                      textStyle: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color(int.parse(globals.defaultcolor))
                                      )
                                    ),
                                  ),
                                  Status1 == true
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
                                  : Container(
                                      width: 25,
                                      height: 25,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Color(int.parse(globals.defaultcolor)),
                                          width: 2
                                        )
                                      ),
                                    )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      if (widget.pagefrom == "user") {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => IsiRencanaBaca(isicontent: "ayat", idx: indexSelect,))
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 10,),
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
                                    Status2 == true
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
                                    : Container(
                                      width: 25,
                                      height: 25,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Color(int.parse(globals.defaultcolor)),
                                          width: 2
                                        )
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        if (widget.pagefrom == "user") {
                          Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context) => IsiRencanaBaca(isicontent: "renungan", idx: indexSelect,))
                          );
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
    );
  }
}