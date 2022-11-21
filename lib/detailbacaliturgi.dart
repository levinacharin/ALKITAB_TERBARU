import 'package:alkitab/listrencanauser.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'global.dart' as globals;

class DetailBLiturgi extends StatefulWidget {
  const DetailBLiturgi({super.key});

  @override
  State<DetailBLiturgi> createState() => _DetailBLiturgiState();
}

class _DetailBLiturgiState extends State<DetailBLiturgi> {
  List<bool> statusSelect = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    statusSelect = [];
    for (int i = 0; i < globals.listBacaLiturgi.length; i++) {
      statusSelect.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => ListRencanaUser())
            );
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Color.fromARGB(255, 113, 9, 49),
          ) 
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Bacaan Liturgi tanggal ${globals.titletanggal}",
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 113, 9, 49)
                  )
                ),
              ),
              const SizedBox(height: 10,),
              Text(
                globals.informasiliturgi,
                style: GoogleFonts.nunito(
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(int.parse(globals.defaultcolor))
                  )
                ),
              ),
              const SizedBox(height: 20,),
              ListView.builder(
                itemCount: globals.listBacaLiturgi.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            statusSelect[index] = !statusSelect[index];
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(width: 1, color: Color(int.parse(globals.defaultcolor))),
                              bottom: BorderSide(width: 1, color: Color(int.parse(globals.defaultcolor)))
                            )
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                globals.listBacaLiturgi[index].content,
                                style: GoogleFonts.nunito(
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 113, 9, 49)
                                  )
                                ),
                              ),
                              statusSelect[index] == false
                              ? const Icon(
                                Icons.keyboard_arrow_down,
                                color: Color.fromARGB(255, 113, 9, 49),
                              )
                              : const Icon(
                                Icons.keyboard_arrow_up,
                                color: Color.fromARGB(255, 113, 9, 49),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Visibility(
                        visible: statusSelect[index],
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Visibility(
                              visible: globals.listBacaLiturgi[index].kitab != "-" ? true : false,
                              child: Text(
                                "${globals.listBacaLiturgi[index].kitab} \n",
                                style: GoogleFonts.nunito(
                                  textStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(int.parse(globals.defaultcolor))
                                  )
                                ),
                              ),
                            ),
                            Text(
                              globals.listBacaLiturgi[index].isiContent,
                              style: GoogleFonts.nunito(
                                textStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(int.parse(globals.defaultcolor))
                                )
                              ),
                            ),
                          ],
                        )
                      ),
                      const SizedBox(height: 20,)
                      
                    ],
                  );
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}