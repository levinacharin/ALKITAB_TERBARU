import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

import './homepage.dart';
import './global.dart' as globals;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    permission();
    _navigatehome();
  }

  Future<void> permission() async {
    if (await Permission.manageExternalStorage.request().isGranted) {
    } else {
      await Permission.manageExternalStorage.request();
    }
  }

  _navigatehome() async {
    await Future.delayed(const Duration(milliseconds: 5000), () {});
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomePage(indexKitabdicari: 0,ayatKitabdicari: 0, pasalKitabdicari: 0,daripagemana: "splashscreen",)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ignore: sized_box_for_whitespace
              Container(
                width: 200,
                height: 200,
                child: Image.asset('assets/images/Alkitab-biru.gif'),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Text(
                  "Alkitab dan Renungan Harian",
                  style: GoogleFonts.nunito(
                    textStyle: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(int.parse(globals.defaultcolor)),
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30,),
              CircularProgressIndicator(
                color: Color(int.parse(globals.defaultcolor)),
                strokeWidth: 6,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
