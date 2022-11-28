import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import './global.dart' as globals;
//import './homepage.dart';

class AyatHasilCari { // tampilkan list di ayat yang dibandingkan
  String? namaKitab;
  int? pasalKitab;
  int? ayatKitab;
  String? isiAyat;
  int? indexKitab;

  AyatHasilCari({
    this.namaKitab,
    this.pasalKitab,
    this.ayatKitab,
    this.isiAyat,
    this.indexKitab
  });

  // String? get getNamaKitab{
  //   return this.namaKitab;
  // }
  // int? get getPasalKitab{
  //   return this.pasalKitab;
  // }
  // int? get getAyatKitab{
  //   return this.ayatKitab;
  // }
}

class SearchAlkitab extends StatefulWidget {
  const SearchAlkitab({super.key});

  @override
  State<SearchAlkitab> createState() => _SearchAlkitabState();
}

class _SearchAlkitabState extends State<SearchAlkitab> {
  List ayat = List.generate(10, (i) => List.generate(2, (j) => ""));
  List alkitab_ = globals.alkitab;
  String hasil = "";
  TextEditingController searchKataController = TextEditingController();
  List<AyatHasilCari> listAyatHasilCari=[];
  int jumlahhasilcari=0;


  @override
  void initState() {
    super.initState();
    //listAyatHasilCari.clear();
    //cariDalamKitab("dan bumi serta isinya");
    //cariDalamKitab("dan bumi serta isinya");
    //generateListAlkitab();
    //viewListAyat();
  }

  Future<void> listenTextFieldSearch()async{
  setState(() async {
    hasil="";
    cariDalamKitab(searchKataController.text);
  });
}

  bool search(String pat, String txt){
    bool nemu=false;
    int M = pat.length;
    int N = txt.length;
 
    for (int i = 0; i <= N - M; i++) {
      int j;

      for (j = 0; j < M; j++){
        if (txt[i + j] != pat[j]){
          break;
        }
        
      }

      if (j== M) {
        nemu=true;
      }
    }
    return nemu;
}
  void cariDalamKitab(String dicari) async{
    int indexkitab=1;
    jumlahhasilcari=0;
    listAyatHasilCari.clear();
    String namakitabsekarang="";
    String pasalkitabsekarang="";
    String ayatkitabsekarang="";
    String kata="";
    var ayathasilcari=AyatHasilCari();
    bool nemuga=false;
    listAyatHasilCari=[];

      for (int i = 0; i < alkitab_.length; i++) {

        if (namakitabsekarang != alkitab_[i]['book'].toString()) {
          namakitabsekarang = alkitab_[i]['book'].toString();
          indexkitab++;
        }

        if (pasalkitabsekarang != alkitab_[i]['chapter'].toString()) {
          pasalkitabsekarang = alkitab_[i]['chapter'].toString();
        }


        
        kata = alkitab_[i]['content'];

        kata=kata.toLowerCase();
        dicari=dicari.toLowerCase();
        nemuga = search(dicari, kata);

        if(nemuga==true){
          ayatkitabsekarang=alkitab_[i]['verse'].toString();
          if(alkitab_[i]['type']!="t"){

            setState(() {
              ayathasilcari = AyatHasilCari();
              ayathasilcari.namaKitab = namakitabsekarang;
              ayathasilcari.pasalKitab = int.parse(pasalkitabsekarang);
              ayathasilcari.ayatKitab = int.parse(ayatkitabsekarang);
              ayathasilcari.isiAyat = alkitab_[i]['content'];
              ayathasilcari.indexKitab=indexkitab-1;
              listAyatHasilCari.add(ayathasilcari);
              jumlahhasilcari++;
              
              //hasil=hasil+namakitabsekarang+" "+pasalkitabsekarang+":"+ayatkitabsekarang+"\n"+alkitab_[i]['content']+"\n\n";
            });
          }
          
        }

    }
    for(int i=0;i<listAyatHasilCari.length;i++){
      log("hasil class - ${listAyatHasilCari[i].isiAyat}");
    }

    
  }

  // @override
  // void viewListAyat () {
  //   for (int i = 0; i < 5; i++) {
  //     for (int j = 0; j < 2; j++) {
  //       print(ayat[i][j]);
  //       print("\n");
  //       print(ayat[i][j]);
  //     }
  //   }
  // }

  


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(int.parse(globals.defaultcolor)),
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 4, 10),
            child: TextField(
              controller: searchKataController,
              onChanged: (searchKitabController) async {
                    if(searchKitabController.isEmpty){
                      setState(() {
                        listAyatHasilCari.clear();
                      });
                    }
                  },
              
              cursorColor: Colors.white,
              style: GoogleFonts.nunito(
                textStyle: const TextStyle(
                  fontSize: 18,
                  color: Colors.white
                )
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Search ...",
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: IconButton(
                onPressed: () {
                  if(searchKataController.text.isNotEmpty){
                      setState(() async {
                        await listenTextFieldSearch();
                      });
                    }else{
                      setState(() {
                        listAyatHasilCari.clear();
                      });
                      
                    }
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        // ignore: avoid_unnecessary_containers
        body: Container(
          child: ListView.builder(
            itemCount: listAyatHasilCari.length,
            itemBuilder: (context, index) {
              
              return ListTile(
                onTap:(){
                log("ontap nih ${listAyatHasilCari[index].namaKitab.toString()} ${listAyatHasilCari[index].pasalKitab.toString()}:${listAyatHasilCari[index].ayatKitab.toString()}");
                // Navigator.push(
                //   context, 
                //   MaterialPageRoute(builder: (context) => HomePage(indexKitabdicari: listAyatHasilCari[index].indexKitab!-1, pasalKitabdicari: listAyatHasilCari[index].pasalKitab!-1, ayatKitabdicari: listAyatHasilCari[index].ayatKitab!-1, daripagemana: "listayat",))
                // );
                Navigator.pop(context);
              },
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${listAyatHasilCari[index].namaKitab.toString()} ${listAyatHasilCari[index].pasalKitab.toString()}:${listAyatHasilCari[index].ayatKitab.toString()}",
                      style: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                          fontSize: 18, 
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      "${listAyatHasilCari[index].isiAyat.toString()}\n",
                      style: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                          fontSize: 18, 
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              );
            }
          )
        ),
      ),
    );
  }
}
