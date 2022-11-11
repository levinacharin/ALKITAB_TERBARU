import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'global.dart' as globals;

class NotifikasiPage extends StatefulWidget {
  const NotifikasiPage({super.key});

  @override
  State<NotifikasiPage> createState() => _NotifikasiPageState();
}

class _NotifikasiPageState extends State<NotifikasiPage> {
  String judulnotifikasi = "Bacaan harian baru!";
  String isinotifikasi = "Felicia telah mengirim topik bacaan baru, yuk baca topik yang telah dikirimkan!";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          }, 
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Color.fromARGB(255, 113, 9, 49),
          )
        ),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.black
                    ),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        judulnotifikasi,
                        style: GoogleFonts.nunito(
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Colors.black
                          )
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Text(
                        isinotifikasi,
                        style: GoogleFonts.nunito(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            color: Colors.black
                          )
                        ),
                      )
                    ],
                  ),
                ),
                // const SizedBox(height: 10,)
              ],
            ),
          );
        }
      ),
    );
  }
}