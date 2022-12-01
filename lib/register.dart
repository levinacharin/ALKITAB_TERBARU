//import 'dart:convert';
// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';

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
      final data = jsonDecode(response.body);
      var lastId = data['data']['getIdLast'];
      await uploadFileLokal(lastId.toString());

      // ignore: use_build_context_synchronously
      Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => const LoginInput())
      );
    }
  }

  Future<void> uploadFileLokal(String iduser) async {
    String path1 = '/storage/emulated/0/Download/Alkitab Renungan Mobile/Renunganjson.txt';
    bool fileExists1 = await File(path1).exists();
    if (fileExists1) {
      var url1 = '${globals.urllocal}uploaddatalokal';
      var request1  = http.MultipartRequest("POST", Uri.parse(url1));
      request1.fields['id'] = iduser;
      request1.fields['folder'] = 'Renunganjson';
      request1.files.add(
        await http.MultipartFile.fromPath('filejson', path1)
      );
      // ignore: unused_local_variable
      var res1 = await request1.send();
    }

    String path2 = '/storage/emulated/0/Download/Alkitab Renungan Mobile/Catatanjson.txt';
    bool fileExists2 = await File(path2).exists();
    if (fileExists2) {
      var url2 = '${globals.urllocal}uploaddatalokal';
      var request2  = http.MultipartRequest("POST", Uri.parse(url2));
      request2.fields['id'] = iduser;
      request2.fields['folder'] = 'Catatanjson';
      request2.files.add(
        await http.MultipartFile.fromPath('filejson', path2)
      );
      // ignore: unused_local_variable
      var res2 = await request2.send();
    }

    String path3 = '/storage/emulated/0/Download/Alkitab Renungan Mobile/listHighlightUser.txt';
    bool fileExists3 = await File(path3).exists();
    if (fileExists3) {
      var url3 = '${globals.urllocal}uploaddatalokal';
      var request3  = http.MultipartRequest("POST", Uri.parse(url3));
      request3.fields['id'] = iduser;
      request3.fields['folder'] = 'listHighlightUser';
      request3.files.add(
        await http.MultipartFile.fromPath('filejson', path3)
      );
      // ignore: unused_local_variable
      var res3 = await request3.send();
    }

    String path4 = '/storage/emulated/0/Download/Alkitab Renungan Mobile/listStiker.txt';
    bool fileExists4 = await File(path4).exists();
    if (fileExists4) {
      var url4 = '${globals.urllocal}uploaddatalokal';
      var request4 = http.MultipartRequest("POST", Uri.parse(url4));
      request4.fields['id'] = iduser;
      request4.fields['folder'] = 'listStiker';
      request4.files.add(
        await http.MultipartFile.fromPath('filejson', path4)
      );
      // ignore: unused_local_variable
      var res4 = await request4.send();
    }

    String path5 = '/storage/emulated/0/Download/Alkitab Renungan Mobile/Underline.txt';
    bool fileExists5 = await File(path5).exists();
    if (fileExists5) {
      var url5 = '${globals.urllocal}uploaddatalokal';
      var request5  = http.MultipartRequest("POST", Uri.parse(url5));
      request5.fields['id'] = iduser;
      request5.fields['folder'] = 'Underline';
      request5.files.add(
        await http.MultipartFile.fromPath('filejson', path5)
      );
      // ignore: unused_local_variable
      var res5 = await request5.send();
    }

    String path6 = '/storage/emulated/0/Download/Alkitab Renungan Mobile/Rencanajson.txt';
    bool fileExists6 = await File(path6).exists();
    if (fileExists1) {
      var url6 = '${globals.urllocal}uploaddatalokal';
      var request6  = http.MultipartRequest("POST", Uri.parse(url6));
      request6.fields['id'] = iduser;
      request6.fields['folder'] = 'Rencanajson';
      request6.files.add(
        await http.MultipartFile.fromPath('filejson', path6)
      );
      // ignore: unused_local_variable
      var res6 = await request6.send();
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
                    if (_ctrPass.text.toString() != _ctrKonfpass.text.toString()) {
                      const text = 'password tidak sama';
                      final snackBar = SnackBar(content: Text(text));
    
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else if (_ctrPass.text.toString().length > 20) {
                      const text = 'password maksimal 20 karakter';
                      final snackBar = SnackBar(content: Text(text));
    
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      addData();
                    }
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