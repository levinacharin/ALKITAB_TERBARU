import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import './global.dart' as globals;
import './detailkomunitas.dart';


class BuatKomunitas extends StatefulWidget {
  String? status;
  BuatKomunitas({
    super.key,
    this.status
  });

  @override
  State<BuatKomunitas> createState() => _BuatKomunitasState();
}

class _BuatKomunitasState extends State<BuatKomunitas> {
  DateTime date = DateTime.now();
  String tanggal = "";
  final TextEditingController _ctrnamakomunitas = TextEditingController();
  final TextEditingController _ctrdeskripsikomunitas = TextEditingController();
  final TextEditingController _ctrpasswordkomunitas = TextEditingController();
  bool status = false;
  String statuskomunitas = "";

  
  void addKomunitas() async {
    tanggal = "${date.day}/${date.month}/${date.year}";
    var url = "${globals.urllocal}komunitasakunadd";
    var response = await http.post(Uri.parse(url), body: {
      "namakomunitas" : _ctrnamakomunitas.text,
      "statuskomunitas" : statuskomunitas,
      "deskripsikomunitas" : _ctrdeskripsikomunitas.text,
      "passwordkomunitas" : _ctrpasswordkomunitas.text,
      "tanggalpembuatan" : tanggal
    });
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      var lastId = data['data']['getIdLast'];

      addDetailKomunitas(lastId);
    }
  }

  void addDetailKomunitas(int idkomunitas) async {
    var url = "${globals.urllocal}detailkomunitasadd";
    var response = await http.post(Uri.parse(url), body: {
      "idkomunitas" : idkomunitas.toString(),
      "iduser" : globals.idUser,
      "role" : "admin",
    });
    if (response.statusCode == 200) {

      // ignore: use_build_context_synchronously
      globals.idkomunitas = idkomunitas.toString();
      globals.namakomunitas = _ctrnamakomunitas.text;
      globals.statuskomunitas = statuskomunitas;
      globals.deskripsikomunitas = _ctrdeskripsikomunitas.text;
      globals.jumlahanggota = "1";

      // ignore: use_build_context_synchronously
      Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => DetailKomunitas(shouldpop: 'false', pagefrom: 'buatkomunitas',))
      );
    }
    else{
      log("buat akun gagal");
    }
  }

  void editKomunitas() async {
    setState(() {
      globals.namakomunitas = _ctrnamakomunitas.text;
      globals.deskripsikomunitas = _ctrdeskripsikomunitas.text;
      globals.passwordkomunitas = _ctrpasswordkomunitas.text;
      globals.statuskomunitas = statuskomunitas;
      print("statuskomunitas: $statuskomunitas");
    });

    var url = "${globals.urllocal}komunitasakunedit";
    var response = await http.put(Uri.parse(url), body: {
      "idkomunitas" : globals.idkomunitas,
      "namakomunitas" : _ctrnamakomunitas.text,
      "statuskomunitas" : statuskomunitas,
      "deskripsikomunitas" : _ctrdeskripsikomunitas.text,
      "passwordkomunitas" : _ctrpasswordkomunitas.text
    });
    if (response.statusCode == 200) {
      Navigator.pop(context, "refresh");
    }
  }

  bool uploadFoto = false;
  var imageFile;
  String pathPhoto = "";
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source, imageQuality: 10);

    if (image != null) {
      setState(() {
        imageFile = File(image.path);
        pathPhoto = image.path;
        uploadFoto = true;

        print("path photo: $pathPhoto");
      });

      var url = "${globals.urllocal}uploadimage";
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['id'] = globals.idkomunitas;
      request.fields['folder'] = 'komunitas';
      request.files.add(
        await http.MultipartFile.fromPath('photo', pathPhoto)
      );
      var res = await request.send();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.status == 'editkomunitas') {
      _ctrnamakomunitas.text = globals.namakomunitas;
      _ctrdeskripsikomunitas.text = globals.deskripsikomunitas;
      print("password: ${globals.passwordkomunitas}");
      if (globals.statuskomunitas == 'publik') {
        status = false;
        statuskomunitas = "publik";
        _ctrpasswordkomunitas.text = '-';
      } else {
        status = true;
        statuskomunitas = "privat";
        _ctrpasswordkomunitas.text = globals.passwordkomunitas;
      }
    }
  }

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
          icon: const Icon(Icons.arrow_back,
            color: Color.fromARGB(255, 113, 9, 49)
          )
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.status == 'editkomunitas' ? "Edit Komunitas" : "Buat Komunitas",
              style: GoogleFonts.nunito(
                textStyle: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 113, 9, 49)
                )
              ),
            ),
            const SizedBox(height: 20,),
            Row(
              children: [
                Container(
                  height: 100,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey[300]
                  ),
                  child: IconButton(
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
                    icon: const Icon(
                      Icons.camera_alt_rounded,
                      size: 30,
                    ),
                  ),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Gambar Komunitas",
                        style: GoogleFonts.nunito(
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 113, 9, 49)
                          )
                        ),
                      ),
                      Text(
                        "Unggah gambar untuk rencana bacaan dengan format .jpg, .jpeg, .png",
                        style: GoogleFonts.nunito(
                          textStyle: const TextStyle(
                            fontSize: 16
                          )
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 20,),
            Text(
              "Nama Komunitas",
              style: GoogleFonts.nunito(
                textStyle: const TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 113, 9, 49)
                )
              ),
            ),
            const SizedBox(height: 5,),
            // ignore: sized_box_for_whitespace
            Container(
              height: 40,
              child: TextField(
                controller: _ctrnamakomunitas,
                cursorColor: Color(int.parse(globals.defaultcolor)),
                decoration: InputDecoration(
                  fillColor: Colors.transparent,
                  filled: true,
                  border: InputBorder.none,
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
                  hintText: 'nama komunitas',
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
            const SizedBox(height: 30,),
            Text(
              "Deskripsi Komunitas",
              style: GoogleFonts.roboto(
                textStyle: const TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 113, 9, 49)
                )
              ),
            ),
            const SizedBox(height: 5,),
            // ignore: sized_box_for_whitespace
            Container(
              height: 40,
              child: TextField(
                controller: _ctrdeskripsikomunitas,
                cursorColor: const Color.fromARGB(255, 85, 48, 29),
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
                  hintText: 'deskripsi komunitas',
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
            const SizedBox(height: 30,),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Apakah Komunitas ingin di Privat?",
                    style: GoogleFonts.nunito(
                      textStyle: const TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 113, 9, 49)
                      )
                    ),
                  ),
                ),
                FlutterSwitch(
                  width: 65.0,
                  height: 35.0,
                  inactiveColor: Color(int.parse(globals.defaultcolor)),
                  activeColor: const Color.fromARGB(255, 0, 206, 77),
                  value: status, 
                  onToggle: (val) {
                    setState(() {
                      print("status: $status");
                      status = val;
                      print("status: $status");
                      if (status == true) {
                        statuskomunitas = "privat";
                      } else {
                        statuskomunitas = "publik";
                      }
                    });
                  }
                ),
              ],
            ),
            Visibility(
              visible: statuskomunitas == "privat" ? true : false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30,),
                  Text(
                    "Password",
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 113, 9, 49)
                      )
                    ),
                  ),
                  const SizedBox(height: 5,),
                  // ignore: sized_box_for_whitespace
                  Container(
                    height: 40,
                    child: TextField(
                      controller: _ctrpasswordkomunitas,
                      cursorColor: const Color.fromARGB(255, 85, 48, 29),
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
                        hintText: 'deskripsi komunitas',
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
            const SizedBox(height: 50,),
            // ignore: sized_box_for_whitespace
            Container(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  if (widget.status == 'editkomunitas') {
                    editKomunitas();
                  } else {
                    addKomunitas();
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
                    widget.status == 'editkomunitas' ? "Edit Komunitas" : "Buat Komunitas", 
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
    );
  }
}