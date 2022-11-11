import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import './register.dart';
import './homepage.dart';
import './global.dart' as globals;

class AkunUser {
  String iduser;
  String email;
  String namadepan;
  String namabelakang;
  String password;
  String deskripsi;

  AkunUser({
    required this.iduser,
    required this.email,
    required this.namadepan,
    required this.namabelakang,
    required this.password,
    required this.deskripsi
  });

  factory AkunUser.createData(Map<String, dynamic> object) {
    return AkunUser(
      iduser: object['iduser'],
      email: object['email'], 
      namadepan: object['namadepan'], 
      namabelakang: object['namabelakang'], 
      password: object['password'],
      deskripsi : object['deskripsi']
    );
  }

  static Future<List<AkunUser>> getData(String email, String password) async {
    var url = "${globals.urllocal}userakun?email=$email&password=$password";
    var apiResult = await http.get(Uri.parse(url), headers: {
      "Accept" : "application/json",
      "Access-Control-Allow-Origin" : "*"
    });
    var jsonObject = json.decode(apiResult.body);
    var data = (jsonObject as Map<String, dynamic>)['data'];
    //print(data);
    List<AkunUser> listData = [];
    if (data.toString() == "null") {
      return listData;
    } else {
      for (int i = 0; i < data.length; i++) {
        listData.add(AkunUser.createData(data[i]));
      }
      return listData;
    }
  }
}

class LoginInput extends StatefulWidget {
  const LoginInput({super.key});

  @override
  State<LoginInput> createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {
  // ignore: prefer_final_fields
  TextEditingController _ctrEmail = TextEditingController();
  // ignore: prefer_final_fields
  TextEditingController _ctrPass = TextEditingController();

  // ignore: non_constant_identifier_names
  bool secure_password = true;


  // JSON FROM DATABASE
  List<AkunUser> listAkunUser = [];

  Future<void> getAkunUser() async {
    AkunUser.getData(_ctrEmail.text, _ctrPass.text).then((value) async {
      setState(() {
        listAkunUser = value;
        if (listAkunUser.isNotEmpty) {
          globals.emailUser = listAkunUser[0].email;
          globals.password = listAkunUser[0].password;
          globals.namaDepanUser = listAkunUser[0].namadepan;
          globals.namaBelakangUser = listAkunUser[0].namabelakang;
          globals.deskripsiUser = listAkunUser[0].deskripsi;
          globals.statusLogin = true;
          saveAkuntoLokal();
          _showDialogSuccess();

        } else {
          // ignore: prefer_const_declarations
          final text = 'email atau password salah';
          final snackBar = SnackBar(content: Text(text));

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        
        log("list akun user: $listAkunUser");
      });
    });
  }
  // END OF JSON FROM DATABASE


  // SHARED PREFERENCES
  saveAkuntoLokal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("StatusUser", globals.statusLogin);
    prefs.setString("EmailUser", globals.emailUser);
    prefs.setString("PasswordUser", globals.password);
  }
  // END OF SHARED PREFERENCES

  Future<void> _showDialogSuccess() async {
    await Future.delayed(Duration(milliseconds: 1000), () {});
    return showDialog(
      context: context, 
      builder: (BuildContext context) => AlertDialog(
        title: Center(
          child: Text(
            "Login Berhasil",
            style: GoogleFonts.nunito(
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 113, 9, 49)
              )
            ),
            textAlign: TextAlign.center,
          ),
        ),
        actions: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePage(indexKitabdicari: 0, pasalKitabdicari: 0, ayatKitabdicari: 0, daripagemana: "logininput",))
                );
              }, 
              style: ElevatedButton.styleFrom(
                primary: Color(int.parse(globals.defaultcolor)),
                elevation: 5,
                padding: const EdgeInsets.all(5)
              ),
              child: Text(
                "OK",
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  )
                ),
              )
            ),
          )
        ],
      )
    );
  }

  @override
  void initState() {
    super.initState();
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
            color: const Color.fromARGB(255, 113, 9, 49)),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Selamat Datang !",
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 113, 9, 49)
                  )
                )
              ),
              Text("Masuk ke akun anda !",
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 95, 95, 95)
                  )
                )
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ignore: sized_box_for_whitespace
                  Container(
                    width: 200,
                    height: 200,
                    child: Image.asset('assets/images/starlogo.png'),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text("Email",
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
              const SizedBox(
                height: 30,
              ),
              Text("Kata Sandi",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Lupa kata sandi?",
                      style: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 113, 9, 49),
                          decoration: TextDecoration.underline
                        )  
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              // ignore: sized_box_for_whitespace
              Container(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    getAkunUser(); // harusnya post
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Belum memiliki akun?",
                    style: GoogleFonts.nunito(
                      textStyle: const TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 95, 95, 95),
                      )  
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => const RegisterPage())
                      );
                    }, 
                    child: Text(
                      "Daftar Sekarang",
                      style: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 113, 9, 49),
                        )  
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
