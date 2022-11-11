import 'dart:developer';
import 'dart:io';
//import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import './global.dart' as globals;
import './profile.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  // ignore: non_constant_identifier_names
  TextEditingController ctr_namadepan = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController ctr_namabelakang = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController ctr_email = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController ctr_deskripsi = TextEditingController();

  File? image;

  Future pickImage(ImageSource source) async {
    try { 
      // getting an image
      final image = await ImagePicker().pickImage(source: source);

      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
        // print("image: $imageTemporary");
      });
    } on PlatformException catch (e) {
      log('Failed to pick image: $e');
    }
  }

  Future<String?> uploadImage(file, id) async {
    // ignore: prefer_interpolation_to_compose_strings
    String url = "${globals.urllocal}upload?id=" + id;
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('photo', file));
    var res = await request.send();
    return res.reasonPhrase;
  }

  void updateData() async {
    setState(() {
      globals.namaDepanUser = ctr_namadepan.text;
      globals.namaBelakangUser = ctr_namabelakang.text;
      globals.deskripsiUser = ctr_deskripsi.text;
    });

    var url = "${globals.urllocal}userakunedit";
    var response = await http.put(Uri.parse(url), body: {
      "email" : ctr_email.text,
      "namadepan" : ctr_namadepan.text,
      "namabelakang" : ctr_namabelakang.text,
      "deskripsi" : ctr_deskripsi.text
    });
    if (response.statusCode == 200) {
    }

    if (image != null) {
    }

    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => const ProfilePage())
    );
  }
  
  @override
  void dispose() {
    super.dispose();
    ctr_namadepan.dispose();
    ctr_namabelakang.dispose();
    ctr_email.dispose();
    ctr_deskripsi.dispose();
  }

  @override
  void initState() {
    super.initState();
    ctr_namadepan.text = globals.namaDepanUser;
    ctr_namabelakang.text = globals.namaBelakangUser;
    ctr_email.text = globals.emailUser;
    ctr_deskripsi.text = globals.deskripsiUser;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            // Navigator.push(
            //   context, 
            //   MaterialPageRoute(builder: (context) => const ProfilePage())
            // );
          },
          icon: const Icon(Icons.arrow_back_rounded),
          color: const Color.fromARGB(255, 113, 9, 49)
        ),
        title: Text(
          "Edit Profile User",
          style: GoogleFonts.nunito(
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 113, 9, 49),
            )
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  image != null 
                  ? ClipOval(
                    child: Image.file(
                      image!,
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  )
                  : Icon(
                    Icons.account_circle_outlined,
                    color: Color(int.parse(globals.defaultcolor)),
                    size: 120,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context, 
                        builder: (BuildContext context) {
                          return Container(
                            height: 150,
                            padding: const EdgeInsets.only(top: 30),
                            color: Colors.white,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          pickImage(ImageSource.gallery);
                                          Navigator.pop(context);
                                        }, 
                                        child: Image.asset(
                                          'assets/images/fromgallery.png',
                                          width: 40,
                                          height: 40,
                                        ),
                                      ),
                                      Text(
                                        "Pilih Dari Album",
                                        style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                            fontSize: 16,
                                            color: Color(int.parse(globals.defaultcolor))
                                          )
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(width: 40,),
                                  Column(
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          pickImage(ImageSource.camera);
                                          Navigator.pop(context);
                                        },
                                        child: Image.asset(
                                          'assets/images/fromcamera.png',
                                          width: 40,
                                          height: 40,
                                        ),
                                      ),
                                      Text(
                                        "Mengambil Foto",
                                        style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                            fontSize: 16,
                                            color: Color(int.parse(globals.defaultcolor))
                                          )
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      );
                    }, 
                    child: Text(
                      "Ganti Foto", 
                      style: GoogleFonts.nunito(
                        textStyle: TextStyle(
                          fontSize: 16, 
                          color: Color(int.parse(globals.defaultcolor)), 
                          decoration: TextDecoration.underline
                        )
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
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
                        TextField (
                          controller: ctr_namadepan,
                          cursorColor: Color(int.parse(globals.defaultcolor)),
                          decoration: InputDecoration(
                            fillColor: Colors.transparent,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1, color: Color(int.parse(globals.defaultcolor))),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1, color: Color(int.parse(globals.defaultcolor))),
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
                        TextField (
                          controller: ctr_namabelakang,
                          cursorColor: Color(int.parse(globals.defaultcolor)),
                          decoration: InputDecoration(
                            fillColor: Colors.transparent,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1, color: Color(int.parse(globals.defaultcolor))),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1, color: Color(int.parse(globals.defaultcolor))),
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
                      ],
                    )
                  ),
                ],
              ),
              const SizedBox(height: 25,),
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
              TextField (
                controller: ctr_email,
                cursorColor: Color(int.parse(globals.defaultcolor)),
                decoration: InputDecoration(
                  fillColor: Colors.transparent,
                  filled: true,
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Color(int.parse(globals.defaultcolor))),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Color(int.parse(globals.defaultcolor))),
                  ),
                  contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5)
                ),
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    color: Colors.black
                  )
                ),
                enabled: false,
              ),
              const SizedBox(height: 25,),
              Text(
                "Deskripsi", 
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 18, 
                    color: Color.fromARGB(255, 113, 9, 49)
                  )
                )
              ),
              const SizedBox(height: 5,),
              TextField(
                controller: ctr_deskripsi,
                cursorColor: Color(int.parse(globals.defaultcolor)),
                decoration: InputDecoration(
                  fillColor: Colors.transparent,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Color(int.parse(globals.defaultcolor))),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Color(int.parse(globals.defaultcolor))),
                  ),
                  contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5)
                ),
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    color: Colors.black
                  )
                ),
                maxLines: 4,
              ),
              const SizedBox(height: 70),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,   
                child: ElevatedButton(
                  onPressed: () {
                    // updateData();
                    Navigator.pop(context, "refresh");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(int.parse(globals.defaultcolor)),
                    elevation: 10,
                    padding: const EdgeInsets.all(5),
                  ),
                  child: Text(
                    "Simpan", 
                    style: GoogleFonts.nunito(
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      )
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