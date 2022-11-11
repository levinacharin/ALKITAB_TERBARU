import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import './listayat.dart';
import './global.dart' as globals;

class ListPasal extends StatefulWidget {
  final int indexKitab;
  const ListPasal({super.key, required this.indexKitab});

  @override
  State<ListPasal> createState() => _ListPasalState();
}

class _ListPasalState extends State<ListPasal> {
  // List pasal = List.generate(30, (index) => "$index");
  List pasalKitab = [];
  int temp = 0;
  
  void isiListPasalKitab(){
    // print("cobanehhhh - ${widget.indexKitab}");
    // print("cobanehhhh - ${globals.listNamaKitab[widget.indexKitab].getNamaKitab}");
    //print("cobanehhhh1 - ${globals.listNamaKitab[widget.indexKitab].getListPasal![widget.indexKitab].getIndexPasal}");

    pasalKitab.clear();
    for(int k = 0;k<globals.listNamaKitab[widget.indexKitab].jumlahPasal_!.toInt();k++){
      pasalKitab.add([]);
      temp=k+1;
      pasalKitab[k]=temp.toString();
    }
      //     print("ceking - Pasal - ${listNamaKitab[i].getListPasal![k].getIndexPasal} punya jumlah ayat : ${listNamaKitab[i].getListPasal![k].getJumlahAyat}");
      //   }

    // for (int j = 0; j < listNamaKitab[widget.indexKitab].getListPasal![widget.indexKitab].getIndexPasal; j++) {
    //   pasalKitab.add([]);
    //   temp=j+1;
    //   //listNamaKitab[i].getListPasal![j].getIndexPasal
    //   // pasalKitab[j]=listNamaKitab[widget.indexKitab].getListPasal![j].getIndexPasal.toString();
    //   pasalKitab[j]=temp.toString();
    //   //print("cobanehhh - ${pasalKitab[j]}");
    // }
  }

  @override
  void initState() {
    super.initState();
    isiListPasalKitab();
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
          "Pasal", 
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
          itemCount: pasalKitab.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => ListAyat(indexKitab: widget.indexKitab, indexPasalKitab: index)
                  )
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
                    pasalKitab[index],
                    style: GoogleFonts.nunito(
                      textStyle: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)
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