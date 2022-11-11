import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import './homepage.dart';
import './global.dart' as globals;

class ListAyat extends StatefulWidget {
    final int indexKitab;
    final int indexPasalKitab;

  const ListAyat({super.key, required this.indexKitab, required this.indexPasalKitab});

  @override
  State<ListAyat> createState() => _ListAyatState();
}

class _ListAyatState extends State<ListAyat> {
  //List ayat = List.generate(30, (index) => "$index");

  int jumlahAyat=0;
  List ayatKitab = [];
  int temp = 0;

  void getJumlahAyatKitab(){
    // print("cobanehhhh - ${widget.indexKitab}");
    // print("cobanehhhh - ${listNamaKitab[widget.indexKitab].getNamaKitab}");
    // print("cobanehhhh - ${listNamaKitab[widget.indexKitab].getListPasal![widget.indexKitab].getIndexPasal}");
    jumlahAyat=0;
    ayatKitab.clear();

    // for (int i = 0; i < listNamaKitab.length; i++) {
    //   //CEKING DOANG
    //   if (listNamaKitab.isNotEmpty) {
    //     print("ceking - jadi kitab ${listNamaKitab[i].getNamaKitab.toString()} punya jumlah pasal : ${listNamaKitab[i].jumlahPasal_}");
    //     for(int k =0;k<listNamaKitab[i].listPasal_!.length;k++){
    //       print("ceking - Pasal - ${k+1} punya jumlah ayat : ${listNamaKitab[i].getListPasal![k]}");
    //     }
    //   }

    // }

    
    for (int j = 0; j < globals.listNamaKitab[widget.indexKitab].listPasal_!.length; j++) {
      if(j==widget.indexPasalKitab){
        jumlahAyat = globals.listNamaKitab[widget.indexKitab].getListPasal![j];
        break;
      }
      //jumlahAyat = globals.listNamaKitab[widget.indexKitab].getListPasal![j];
      //pasalKitab[j]=listNamaKitab[widget.indexKitab].getListPasal![j].getIndexPasal.toString();
      //print("cobanehhh - ${pasalKitab[j]}");
    }

    for(int i = 0; i<jumlahAyat;i++){
      ayatKitab.add([]);
      temp = i+1;
      ayatKitab[i]=temp.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    getJumlahAyatKitab();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Text(
          "Ayat", 
          style: GoogleFonts.nunito(textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white))
        ),
      ),
      body: Container (
        padding: const EdgeInsets.all(8),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, 
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
          ), 
          itemCount: ayatKitab.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => HomePage(indexKitabdicari: widget.indexKitab, pasalKitabdicari: widget.indexPasalKitab, ayatKitabdicari: index, daripagemana: "listayat",))
                );
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 2), // changes position of shadow
                    ),
                  ],
                  color: Colors.white
                ),
                child: Center(
                  child: Text(
                    ayatKitab[index],
                    style: GoogleFonts.nunito(
                      textStyle: const TextStyle(fontSize: 16 , color: Colors.black, fontWeight: FontWeight.bold)
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}