import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './listpasal.dart';

import 'global.dart' as globals;

class ListAlkitab extends StatefulWidget {

  const ListAlkitab({super.key});

  @override
  State<ListAlkitab> createState() => _ListAlkitabState();
}

class _ListAlkitabState extends State<ListAlkitab> {
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
          "Alkitab", 
          style: GoogleFonts.nunito(textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white))
        ),
      ),
      body: 
      Padding (
        padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, 
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
          ), 
          itemCount: globals.listNamaKitab.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTapDown: (details) {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => ListPasal(indexKitab: index))
                );
              },
              // onTap: () {
                
              // },
              child: Container(
                padding: const EdgeInsets.all(8),
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
                    globals.listNamaKitab[index].getNamaKitab.toString(),
                    style: GoogleFonts.nunito(
                      textStyle: const TextStyle(
                        fontSize: 16, 
                        color: Colors.black, 
                        fontWeight: FontWeight.bold
                      )
                    ),
                    textAlign: TextAlign.center,
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