import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//import './homepage.dart';
import './logininput.dart';
import './register.dart';
import './global.dart' as globals;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              // Navigator.push(
              //   context, 
              //   MaterialPageRoute(builder: (context) => HomePage(indexKitabdicari: 0, pasalKitabdicari: 0, ayatKitabdicari: 0, daripagemana: "")) // nanti ganti bookmark
              // );
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back,
                color: Color.fromARGB(255, 113, 9, 49))),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ignore: sized_box_for_whitespace
            Container(
              width: 300,
              height: 300,
              child: Image.asset('assets/images/logo.png'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Text(
                "Alkitab dan Renungan Harian",
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 113, 9, 49),
                  ),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Text(
                "Selamat Datang di Aplikasi Alkitab !", 
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 18, 
                    color: Color.fromARGB(255, 95, 95, 95)
                  )
                ),
              ),
            ),
            const SizedBox(height: 50,),
            // ignore: sized_box_for_whitespace
            Container(
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => const LoginInput()));
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(int.parse(globals.defaultcolor)),
                  elevation: 10,
                  padding: const EdgeInsets.all(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 4),
                  child: Text(
                    "Masuk", 
                    style: GoogleFonts.nunito(
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      )
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10,),
            // ignore: sized_box_for_whitespace
            Container(
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => const RegisterPage()));
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  side: BorderSide(
                    width: 2, 
                    color: Color(int.parse(globals.defaultcolor))
                  ),
                  elevation: 0,
                  padding: const EdgeInsets.all(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 4),
                  child: Text(
                    "Daftar", 
                    style: GoogleFonts.nunito(
                      textStyle: TextStyle(
                        color: Color(int.parse(globals.defaultcolor)), 
                        fontWeight: FontWeight.bold, 
                        fontSize: 20
                      )
                    ),
                  ),
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}