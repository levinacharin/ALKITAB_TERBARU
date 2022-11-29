//import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import './global.dart' as globals;
import './logininput.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // ignore: prefer_final_fields
  TextEditingController _ctrNamadepan = TextEditingController();
  // ignore: prefer_final_fields
  TextEditingController _ctrNamabelakang = TextEditingController();
  // ignore: prefer_final_fields
  TextEditingController _ctrEmail = TextEditingController();
  // ignore: prefer_final_fields
  TextEditingController _ctrPass = TextEditingController();
  // ignore: prefer_final_fields
  TextEditingController _ctrKonfpass = TextEditingController();

  // ignore: non_constant_identifier_names
  bool secure_password = true;
  // ignore: non_constant_identifier_names
  bool secure_konfpass = true;

  void addData() async {
    var url = "${globals.urllocal}userakunadd";
    var response = await http.post(Uri.parse(url), body: {
      "email" : _ctrEmail.text,
      "namadepan" : _ctrNamadepan.text,
      "namabelakang" : _ctrNamabelakang.text,
      "password" : _ctrKonfpass.text,
      "deskripsi" : "Available"
    });
    if (response.statusCode == 200) {

      // ignore: use_build_context_synchronously
      Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => const LoginInput())
      );
    }
  }
  
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
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Daftar Akun Anda", 
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 24, 
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 113, 9, 49)
                  )
                )
              ),
              Text(
                "Daftarkan akun anda disini !", 
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 18, 
                    color: Color.fromARGB(255, 95, 95, 95)
                  )
                )
              ),
              const SizedBox(height: 50,),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nama Depan", 
                          style: GoogleFonts.nunito(
                            textStyle: const TextStyle(
                              fontSize: 18, 
                              color: Color.fromARGB(255, 113, 9, 49)
                            )
                          )
                        ),
                        const SizedBox(height: 5,),
                        // ignore: sized_box_for_whitespace
                        Container(
                          height: 40,
                          child: TextField(
                            controller: _ctrNamadepan,
                            cursorColor: Color(int.parse(globals.defaultcolor)),
                            decoration: InputDecoration(
                              fillColor: Colors.transparent,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1, 
                                  color: Color(int.parse(globals.defaultcolor))
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1, 
                                  color: Color(int.parse(globals.defaultcolor))
                                ),
                              ),
                              hintText: 'nama depan',
                              hintStyle: TextStyle(
                                color: Colors.grey[400]
                              ),
                              contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5)
                            ),
                            style: GoogleFonts.nunito(
                              textStyle: const TextStyle(
                                fontSize: 18,
                                color: Colors.black
                              )
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nama Belakang",
                          style: GoogleFonts.nunito(
                            textStyle: const TextStyle(
                              fontSize: 18, 
                              color: Color.fromARGB(255, 113, 9, 49)
                            )
                          )
                        ),
                        const SizedBox(height: 5,),
                        // ignore: sized_box_for_whitespace
                        Container(
                          height: 40,
                          child: TextField(
                            controller: _ctrNamabelakang,
                            cursorColor: Color(int.parse(globals.defaultcolor)),
                            decoration: InputDecoration(
                              fillColor: Colors.transparent,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1, 
                                  color: Color(int.parse(globals.defaultcolor))
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1, 
                                  color: Color(int.parse(globals.defaultcolor))
                                ),
                              ),
                              hintText: 'nama belakang',
                              hintStyle: TextStyle(
                                color: Colors.grey[400]
                              ),
                              contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5)
                            ),
                            style: GoogleFonts.nunito(
                              textStyle: const TextStyle(
                                fontSize: 18,
                                color: Colors.black
                              )
                            ),
                          ),
                        ),
                      ],
                    )
                  ),
                ],
              ),
              const SizedBox(height: 30,),
              Text(
                "Email", 
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 18, 
                    color: Color.fromARGB(255, 113, 9, 49)
                  )
                )
              ),
              const SizedBox(height: 5,),
              // ignore: sized_box_for_whitespace
              Container(
                height: 40,
                child: TextField(
                  controller: _ctrEmail,
                  cursorColor: Color(int.parse(globals.defaultcolor)),
                  decoration: InputDecoration(
                    fillColor: Colors.transparent,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1, 
                        color: Color(int.parse(globals.defaultcolor))
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1, 
                        color: Color(int.parse(globals.defaultcolor))
                      ),
                    ),
                    hintText: 'example@email.com',
                    hintStyle: TextStyle(
                      color: Colors.grey[400]
                    ),
                    // ignore: prefer_const_constructors
                    contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 5)
                  ),
                  style: GoogleFonts.nunito(
                    textStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.black
                    )
                  ),
                ),
              ),
              const SizedBox(height: 30,),
              Text(
                "Kata Sandi", 
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 18, 
                    color: Color.fromARGB(255, 113, 9, 49)
                  )
                )
              ),
              const SizedBox(height: 5,),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(int.parse(globals.defaultcolor))
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _ctrPass,
                        obscureText: secure_password,
                        cursorColor: Color(int.parse(globals.defaultcolor)),
                        decoration: InputDecoration(
                          fillColor: Colors.transparent,
                          filled: true,
                          border: InputBorder.none,
                          hintText: '******',
                          hintStyle: TextStyle(
                            color: Colors.grey[400]
                          ),
                          contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 10)
                        ),
                        style: GoogleFonts.nunito(
                          textStyle: const TextStyle(
                            fontSize: 18,
                            color: Colors.black
                          )
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          secure_password = !secure_password;
                        });
                      }, 
                      icon: const Icon(Icons.remove_red_eye_outlined)
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30,),
              Text(
                "Ulangi Kata Sandi", 
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 18, 
                    color: Color.fromARGB(255, 113, 9, 49)
                  )
                )
              ),
              const SizedBox(height: 5,),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(int.parse(globals.defaultcolor))
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _ctrKonfpass,
                        obscureText: secure_konfpass,
                        cursorColor: Color(int.parse(globals.defaultcolor)),
                        decoration: InputDecoration(
                          fillColor: Colors.transparent,
                          filled: true,
                          border: InputBorder.none,
                          hintText: '******',
                          hintStyle: TextStyle(
                            color: Colors.grey[400]
                          ),
                          contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 10)
                        ),
                        style: GoogleFonts.nunito(
                          textStyle: const TextStyle(
                            fontSize: 18,
                            color: Colors.black
                          )
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          secure_konfpass = !secure_konfpass;
                        });
                      }, 
                      icon: const Icon(Icons.remove_red_eye_outlined)
                    )
                  ],
                ),
              ),
              const SizedBox(height: 60,),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    addData();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(int.parse(globals.defaultcolor)),
                    elevation: 10,
                    padding: const EdgeInsets.all(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 4),
                    child: Text(
                      "Daftar", 
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
            ],
          ),
        ),
      ),
    );
  }
}