// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:alkitab/listkomunitas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import './global.dart' as globals;
import './detailkomunitas.dart';


class BuatKomunitas extends StatefulWidget {
  String? status;
  final String? pagefrom;
  BuatKomunitas({
    super.key,
    this.status,
    required this.pagefrom
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
  String statuskomunitas = "publik";

  String idkomunitas = "";
  void addKomunitas() async {
    tanggal = "${date.day}/${date.month}/${date.year}";
    var url = "${globals.urllocal}komunitasakunadd";
    var response = await http.post(Uri.parse(url), body: {
      "namakomunitas" : _ctrnamakomunitas.text,
      "statuskomunitas" : statuskomunitas,
      "deskripsikomunitas" : _ctrdeskripsikomunitas.text,
      "passwordkomunitas" : _ctrpasswordkomunitas.text,
      "tanggalpembuatan" : tanggal,
      "imagepath" : "-"
    });
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      var lastId = data['data']['getIdLast'];
      idkomunitas = lastId.toString();

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

      updateImage(idkomunitas.toString());
    }
    else{
      // ignore: avoid_print
      print("buat akun gagal");
    }
  }

  void updateImage(String idkomunitas) async {
    if (pathPhoto != "") {
      var url = "${globals.urllocal}uploadimage";
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['id'] = idkomunitas;
      request.fields['folder'] = 'komunitas';
      request.files.add(
        await http.MultipartFile.fromPath('photo', pathPhoto)
      );
      var res = await request.send();

      globals.imagepathkomunitas = "uploads/komunitas/komunitas-$idkomunitas.png";
    }

    globals.idkomunitas = idkomunitas;
    globals.namakomunitas = _ctrnamakomunitas.text;
    globals.statuskomunitas = statuskomunitas;
    globals.deskripsikomunitas = _ctrdeskripsikomunitas.text;
    if (statuskomunitas == "privat") {
      globals.passwordkomunitas = _ctrpasswordkomunitas.text;
    } else if (statuskomunitas == "publik") {
      globals.passwordkomunitas = "-";
    }

    // Navigator.pop(context, "refresh");
    // ignore: use_build_context_synchronously
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => DetailKomunitas(shouldpop: 'false', pagefrom: 'buatkomunitas',))
    );
  }

  void editKomunitas() async {
    // print("${globals.idkomunitas} - ${_ctrnamakomunitas.text} - $statuskomunitas - ${_ctrdeskripsikomunitas.text} - ${_ctrpasswordkomunitas.text}");
    var url = "${globals.urllocal}komunitasakunedit";
    // ignore: unused_local_variable
    var response = await http.put(Uri.parse(url), body: {
      "idkomunitas" : globals.idkomunitas,
      "namakomunitas" : _ctrnamakomunitas.text,
      "statuskomunitas" : statuskomunitas,
      "deskripsikomunitas" : _ctrdeskripsikomunitas.text,
      "passwordkomunitas" : _ctrpasswordkomunitas.text
    });

    setState(() {
      globals.namakomunitas = _ctrnamakomunitas.text;
      globals.deskripsikomunitas = _ctrdeskripsikomunitas.text;
      globals.passwordkomunitas = _ctrpasswordkomunitas.text;
      globals.statuskomunitas = statuskomunitas;
      print("statuskomunitas: $statuskomunitas");

      Navigator.pop(context, "refresh");
    });
    // if (response.statusCode == 200) {
    //   globals.namakomunitas = _ctrnamakomunitas.text;
    //   globals.deskripsikomunitas = _ctrdeskripsikomunitas.text;
    //   globals.passwordkomunitas = _ctrpasswordkomunitas.text;
    //   globals.statuskomunitas = statuskomunitas;
    //   print("statuskomunitas: $statuskomunitas");

    //   Navigator.pop(context, "refresh");
    //   // Navigator.push(
    //   //   context,
    //   //   MaterialPageRoute(builder: (context) => DetailKomunitas(shouldpop: "false"))
    //   // );
    // } else {
    //   print("error");
    // }
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

      if (widget.pagefrom == "detailkomunitas") {
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
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _ctrnamakomunitas.dispose();
    _ctrdeskripsikomunitas.dispose();
    _ctrpasswordkomunitas.dispose();
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

    setState(() {
      print("path photo: ${imageFile}");
      print("photo: ${globals.imagepathkomunitas}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            if (widget.pagefrom == "detailkomunitas") {
              Navigator.pop(context, "refresh");
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => DetailKomunitas(shouldpop: "false"))
              // );
            } else if (widget.pagefrom == "listkomunitas") {
              Navigator.pop(context);
              // Navigator.push(
              //   context, 
              //   MaterialPageRoute(builder: (context) => const ListKomunitas())
              // );
            }
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
                    image: pathPhoto != ""
                    ? DecorationImage(
                      image: FileImage(imageFile),
                      fit: BoxFit.fill
                    )
                    : globals.imagepathkomunitas != "-" && widget.pagefrom == "detailkomunitas"
                      ? DecorationImage(
                        image: NetworkImage(
                          '${globals.urllocal}getimage?id=${globals.idkomunitas}&folder=komunitas',
                        ),
                        fit: BoxFit.fill
                      )
                      : const DecorationImage(image: AssetImage("")), 
                    color: globals.idkomunitas == "" && pathPhoto == ""  ? Colors.grey[300] : Colors.transparent
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
                    icon: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.white
                      ),
                      child: const Icon(
                        Icons.camera_alt_rounded,
                        size: 30,
                      ),
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

                      print("statuskomunitas: $statuskomunitas");
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
                    if (_ctrpasswordkomunitas.text.length > 10) {
                      const text = 'password maksimal 10 karakter';
                      final snackBar = SnackBar(content: Text(text));
    
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      editKomunitas();
                    }
                  } else {
                    if (_ctrpasswordkomunitas.text.length > 10) {
                      const text = 'password maksimal 10 karakter';
                      final snackBar = SnackBar(content: Text(text));
    
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      addKomunitas();
                    }
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