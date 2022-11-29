import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_switch/flutter_switch.dart';

import './global.dart' as globals;

class PanduanAplikasi extends StatefulWidget {
  const PanduanAplikasi({super.key});

  @override
  State<PanduanAplikasi> createState() => _PanduanAplikasiState();
}

class _PanduanAplikasiState extends State<PanduanAplikasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_rounded),
          color: const Color.fromARGB(255, 113, 9, 49)
        ),
        title: Text(
          "Panduan Aplikasi",
          style: GoogleFonts.nunito(
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 113, 9, 49)
            )
          ),
        ),
        elevation: 0,
      ),
    );
  }
}