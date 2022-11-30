import 'package:alkitab/detailrencanabaca.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import 'global.dart' as globals;

class IsiRencanaBaca extends StatefulWidget {
  final String isicontent; // ayat or renungan
  final int idx;
  final String? pagefrom;
  const IsiRencanaBaca({
    super.key,
    required this.isicontent,
    required this.idx,
    this.pagefrom
  });

  @override
  State<IsiRencanaBaca> createState() => _IsiRencanaBacaState();
}

class _IsiRencanaBacaState extends State<IsiRencanaBaca> {
  String replaceTemp = ""; // tmpt penyimpanan sementara untuk format json diubah dari br ke \n

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    replaceTemp = globals.listDetailRUser[widget.idx]['Ayat Bacaan'];
    replaceTemp = replaceTemp.replaceAll("<br>", "\n");

    globals.listDetailRUser[widget.idx]['Ayat Bacaan'] = replaceTemp;

    print("index kiriman: ${widget.idx}");
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            replaceTemp = globals.listDetailRUser[widget.idx]['Ayat Bacaan'];
            replaceTemp = replaceTemp.replaceAll("\n", "<br>");

            globals.listDetailRUser[widget.idx]['Ayat Bacaan'] = replaceTemp;
            
            if (widget.isicontent == "ayat") {
              globals.listDetailRUser[widget.idx]['Status Ayat'] = "true";
            } else if (widget.isicontent == "renungan") {
              globals.listDetailRUser[widget.idx]['Status Renungan'] = "true";
            }

            Navigator.pop(context, "refresh");
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Color.fromARGB(255, 113, 9, 49),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: widget.isicontent == 'renungan'
        ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Judul Renungan",
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
              globals.listDetailRUser[widget.idx]['Judul Renungan'],
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
              globals.listDetailRUser[widget.idx]['Isi Renungan'],
              style: GoogleFonts.nunito(
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  color: Colors.black
                )
              ),
            ),
            const SizedBox(height: 25,),
            InkWell(
              onTap: () async {
                if (globals.listDetailRUser[widget.idx]['Link Renungan'] != "-") {
                  // ignore: deprecated_member_use
                  await launch(globals.listDetailRUser[widget.idx]['Link Renungan']);
                }
              },
              child: Text(
                "Link Renungan",
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 18, 
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 113, 9, 49)
                  )
                ),
              ),
            ),
            const SizedBox(height: 5,),
            Text(
              globals.listDetailRUser[widget.idx]['Link Renungan'],
              style: GoogleFonts.nunito(
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  color: Colors.black
                )
              ),
            ),
          ],
        )
        : Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              const SizedBox(height: 20,),
              Text(
                globals.listDetailRUser[widget.idx]['Ayat Bacaan'],
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black
                  )
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: widget.isicontent == "renungan" 
      ? Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 32),
            child: FloatingActionButton(
              onPressed: () {
                globals.listDetailRUser[widget.idx]['Status Renungan'] = "true";
                
                if (widget.pagefrom == "ayat") {
                  Navigator.pop(context);
                } else {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => IsiRencanaBaca(isicontent: "ayat", idx: widget.idx, pagefrom: "renungan",))
                  );
                }
              },
              backgroundColor: Color(int.parse(globals.defaultcolor)),
              child: const Icon(
                Icons.navigate_before,
                size: 30,
              ),
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              globals.listDetailRUser[widget.idx]['Status Renungan'] = "true";
              
              if (widget.pagefrom == "ayat") {
                Navigator.pop(context);
                Navigator.pop(context,"refresh");
              } else {
                Navigator.pop(context, "refresh");
              }
              
              // Navigator.push(
              //   context, 
              //   MaterialPageRoute(builder: (context) => const DetailRencanaBaca(pagefrom: 'isirencanabaca'))
              // );
            },  
            backgroundColor: Color(int.parse(globals.defaultcolor)),
            child: const Icon(
              Icons.check,
              size: 30,
            ),
          )
        ],
      )
      : globals.listDetailRUser[widget.idx]['Judul Renungan'] == "-"
        ? FloatingActionButton(
            onPressed: () {
              globals.listDetailRUser[widget.idx]['Status Ayat'] = 'true';
              
              Navigator.pop(context, "refresh");
              // Navigator.push(
              //   context, 
              //   MaterialPageRoute(builder: (context) => const DetailRencanaBaca(pagefrom: 'isirencanabaca'))
              // );
            },
            backgroundColor: Color(int.parse(globals.defaultcolor)),
            child: const Icon(
              Icons.check,
              size: 30,
            ),
          )
        : FloatingActionButton(
            onPressed: () {
              globals.listDetailRUser[widget.idx]['Status Ayat'] = 'true';

              if (widget.pagefrom == "renungan") {
                Navigator.pop(context);
              } else {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => IsiRencanaBaca(isicontent: "renungan", idx: widget.idx, pagefrom: "ayat",))
                );
              }
            },
            backgroundColor: Color(int.parse(globals.defaultcolor)),
            child: const Icon(
              Icons.navigate_next,
              size: 30,
            ),
          )
    );
  }
}