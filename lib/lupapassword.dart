// ignore_for_file: prefer_final_fields, non_constant_identifier_names, unused_local_variable, use_build_context_synchronously

import 'package:alkitab/logininput.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'global.dart' as globals;

class LupaPassword extends StatefulWidget {
  final String email;
  const LupaPassword({
    super.key,
    required this.email
  });

  @override
  State<LupaPassword> createState() => _LupaPasswordState();
}

class _LupaPasswordState extends State<LupaPassword> {
  TextEditingController _ctrPass = TextEditingController();
  TextEditingController _ctrKonfpass = TextEditingController();

  bool secure_password = true;
  bool secure_konfpass = true;

  void updateData() async {
    var url = "${globals.urllocal}updatepassuser";
    var response = await http.put(Uri.parse(url), body: {
      "password" : _ctrPass.text,
      "email" : widget.email
    });

    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => const LoginInput())
    );
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
          color: const Color.fromARGB(255, 113, 9, 49),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40,),
                Text(
                  "Lupa Kata Sandi", 
                  style: GoogleFonts.nunito(
                    textStyle: const TextStyle(
                      fontSize: 24, 
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 113, 9, 49)
                    )
                  )
                ),
                const SizedBox(height: 30,),
                Text(
                    "Kata Sandi Baru *", 
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
                    "Ulangi Kata Sandi *", 
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
                        updateData();
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
                        "Ganti Kata Sandi", 
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
      ),
    );
  }
}