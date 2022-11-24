// ignore_for_file: sort_child_properties_last

import 'dart:developer';

import 'package:alkitab/homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import './buatkomunitas.dart';
import './detailkomunitas.dart';
import './global.dart' as globals;

class DetailKomunitasUser {
  String idkomunitas;
  String iduser;

  DetailKomunitasUser({
    required this.idkomunitas,
    required this.iduser
  });

  factory DetailKomunitasUser.createData(Map<String, dynamic> object) {
    return DetailKomunitasUser(
      idkomunitas: object['idkomunitas'], 
      iduser: object['iduser']
    );
  }

  static Future<List<DetailKomunitasUser>> getData(int id) async {
    var url = "${globals.urllocal}detailkomunitasuser?iduser=$id";
    var apiResult = await http.get(Uri.parse(url), headers: {
      "Accept" : "application/json",
      "Access-Control-Allow-Origin" : "*"
    });
    var jsonObject = json.decode(apiResult.body);
    var data = (jsonObject as Map<String, dynamic>)['data'];
    List<DetailKomunitasUser> listData = [];
    if (data.toString() == "null") {
      return listData;
    } else {
      for (int i = 0; i < data.length; i++) {
        listData.add(DetailKomunitasUser.createData(data[i]));
      }
      return listData;
    }
  }
}

class ListKomunitas extends StatefulWidget {
  const ListKomunitas({super.key});

  @override
  State<ListKomunitas> createState() => _ListKomunitasState();
}

class _ListKomunitasState extends State<ListKomunitas> with SingleTickerProviderStateMixin{

  TextEditingController controller = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController ctr_passkomunitas = TextEditingController();

  late TabController _tabController;


  List<AkunKomunitas> listKomunitasAll = [];  // simpan semua data di list komunitas dari database
  List<AkunKomunitas> listKomunitasku = []; // simpan semua data di komunitasku
  List<AkunKomunitas> listKomunitasShow = []; // tampilin data komunitas di page
  List<DetailCountMembers> listCountMembersAll = [];  // mendapatkan jumlah anggota semua akun, connect database

  Future<void>getAllAkunKomunitas() async {
    AkunKomunitas.getAllData().then((value) async {
      setState(() {
        listKomunitasAll = [];
        listKomunitasAll = value;

        getCountMember();  // get jumlah anggota semua list
      });
    });
  }

  Future<void> getCountMember() async {
    DetailCountMembers.getCountMembers().then((value) async {
      setState(() {
        listCountMembersAll = [];
        listCountMembersAll = value;
        for (int i = 0; i < listCountMembersAll.length; i++) {
          listKomunitasAll[i].jumlahanggota = listCountMembersAll[i].jumlahanggota;
        }
        
        if (globals.idUser != "") {
          getKomunitasUserAll(); // get komunitas yang user sudah join
        }
      });
    });
  }

  Future<void> getKomunitasUserAll() async {
    DetailKomunitasUser.getData(int.parse(globals.idUser)).then((value) async {
      setState(() {
        listKomunitasku = [];
        int index = 0;
        for (int i = 0; i < value.length; i++) {
          for (int j = 0 ; j < listKomunitasAll.length; j++) {
            if (listKomunitasAll[j].idkomunitas == value[i].idkomunitas) {
              index = j;
            }
          }
          listKomunitasku.add(listKomunitasAll[index]);
        }
        checkKomunitasUser(); // untuk dapat data listkomunitasshow dimana isinya list komunitas user belum join
      });
    });
  }

  Future<void> _showDialogPassword(int index) async {
    return showDialog<void>(
      context: context, 
      builder: (BuildContext context) => AlertDialog(
        title: Center(
          child: Text(
            "Masukkan password komunitas",
            style: GoogleFonts.nunito(
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 113, 9, 49)
              )
            ),
            textAlign: TextAlign.center,
          ),
        ),
        content: TextField(
          controller: ctr_passkomunitas,
          cursorColor: Color(int.parse(globals.defaultcolor)),
          decoration: InputDecoration(
            fillColor: Colors.transparent,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 1, color: Color(int.parse(globals.defaultcolor))),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 1, color: Color(int.parse(globals.defaultcolor))),
            ),
            hintText: "Masukkan password komunitas",
            hintStyle: TextStyle(
              color: Colors.grey[400]
            ),
            contentPadding: const EdgeInsets.all(10),
          ),
          style: GoogleFonts.nunito(
            textStyle: const TextStyle(
              fontSize: 18,
              color: Colors.black
            )
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            // ignore: sized_box_for_whitespace
            child: Container(
              height: 40,
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  checkPassword(index);
                }, 
                child: Text(
                  "Gabung Komunitas",
                  style: GoogleFonts.nunito(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    )
                  )
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(int.parse(globals.defaultcolor)),
                  elevation: 5,
                  padding: const EdgeInsets.all(5),
                ),
              ),
            ),
          ),
        ],
        actionsAlignment: MainAxisAlignment.center,
      )
    );
  }

  Future<void> _showDialogAlert() async {
    return showDialog(
      context: context, 
      builder: (BuildContext context) => AlertDialog(
        title: Center(
          child: Text(
            "Silahkan login terlebih dahulu agar bisa menggunakan fitur ini",
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
                Navigator.pop(context);
              }, 
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(int.parse(globals.defaultcolor)),
                elevation: 5,
                padding: const EdgeInsets.all(5)
              ),
              child: Text(
                "Kembali",
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
  
  void checkPassword(int index) {
    if (ctr_passkomunitas.text == listKomunitasShow[index].passwordkomunitas) {
      addDetailKomunitas(int.parse(listKomunitasShow[index].idkomunitas));
    } else {
      // ignore: prefer_const_declarations
      final text = 'password salah';
      final snackBar = SnackBar(content: Text(text));

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void addDetailKomunitas(int idkomunitas) async {
    var url = "${globals.urllocal}detailkomunitasadd";
    var response = await http.post(Uri.parse(url), body: {
      "idkomunitas" : idkomunitas.toString(),
      "iduser" : globals.idUser,
      "role" : "anggota",
    });
    if (response.statusCode == 200) {

      for (int i = 0; i < listKomunitasShow.length; i++) {
        if (listKomunitasShow[i].idkomunitas == idkomunitas.toString()) {
          globals.idkomunitas = idkomunitas.toString();
          globals.namakomunitas = listKomunitasShow[i].namakomunitas;
          globals.statuskomunitas = listKomunitasShow[i].statuskomunitas;
          globals.deskripsikomunitas = listKomunitasShow[i].deskripsikomunitas;
          
          int anggota = int.parse(listKomunitasShow[i].jumlahanggota) + 1;
          listKomunitasShow[i].jumlahanggota = anggota.toString();
          globals.jumlahanggota = listKomunitasShow[i].jumlahanggota ;
          break;
        }
      }

      // ignore: use_build_context_synchronously
      Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => DetailKomunitas(shouldpop: 'false', pagefrom: 'joinkomunitas',))
      );
    }
    else{
      log("buat akun gagal");
    }
  }

  void checkKomunitasUser() {
    listKomunitasShow = [];
    bool hasJoin = false;
    for (int i = 0; i < listKomunitasAll.length; i++) {
      hasJoin = false;
      for (int j = 0; j < listKomunitasku.length; j++) {
        if (listKomunitasku[j].idkomunitas == listKomunitasAll[i].idkomunitas) {
          hasJoin = true;
          break;
        }
      }

      if (hasJoin == false) {
        listKomunitasShow.add(listKomunitasAll[i]);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getAllAkunKomunitas();  // untuk list komunitasku

    globals.idkomunitas = "";
    globals.namakomunitas = "";
    globals.statuskomunitas = "";
    globals.deskripsikomunitas = "";
    globals.passwordkomunitas = "";
    globals.tanggalpembuatan = "";
    globals.jumlahanggota = "";
    globals.imagepathkomunitas = "";
    globals.roleuser = "";



    _tabController = TabController(length: 2, vsync: this);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => const HomePage(indexKitabdicari: 0, pasalKitabdicari: 0, ayatKitabdicari: 0, daripagemana: "listkomunitas"))
            );
          },
          icon: const Icon(Icons.arrow_back,
            color: Color.fromARGB(255, 113, 9, 49)
          )
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 16, right: 16),
            child: Text(
              "Komunitas",
              style: GoogleFonts.nunito(
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 113, 9, 49)
                )
              ),
            ),
          )
        ],
      ),
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: Container(
                height: 35,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: Color(int.parse(globals.defaultcolor)),
                  ),
                  labelColor: Colors.white,
                  labelStyle: GoogleFonts.nunito(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    )
                  ),
                  labelPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                  unselectedLabelColor: Colors.black,
                  tabs: const [
                    Tab(text: 'List Komunitas',),
                    Tab(text: 'Komunitasku', key: ValueKey(2),)
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // List Komunitas
                  Column(
                    children: [
                      const SizedBox(height: 20,),
                      Container(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        height: 40,
                        child: TextField(
                          controller: controller,
                          cursorColor: const Color.fromARGB(255, 95, 95, 95),
                          decoration:  InputDecoration(
                              fillColor: const Color.fromARGB(255, 253, 255, 252),
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Color(int.parse(globals.defaultcolor))),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Color(int.parse(globals.defaultcolor))),
                              ),
                              hintText: 'Cari Komunitas',
                              hintStyle: TextStyle(
                                color: Colors.grey[400]
                              ),
                              contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5)),
                          style: GoogleFonts.nunito(
                            textStyle: const TextStyle(
                              fontSize: 16,
                              color: Colors.black
                            )
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: globals.idUser != "" ? listKomunitasShow.length : listKomunitasAll.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12, right: 12),
                                    child: Card(
                                      elevation: 3,
                                      child: Container(
                                        padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(
                                                  children: [
                                                    globals.idUser != ""
                                                    ? listKomunitasShow[index].imagepath != "-"
                                                      ? ClipOval(
                                                        child: Image.network(
                                                          '${globals.urllocal}getimage?id=${listKomunitasShow[index].idkomunitas}&folder=komunitas',
                                                          width: 60,
                                                          height: 60,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      )
                                                      : Icon(
                                                        Icons.account_circle_outlined,
                                                        color: Color(int.parse(globals.defaultcolor)),
                                                        size: 60,
                                                      )
                                                  : listKomunitasAll[index].imagepath != "-"
                                                    ? ClipOval(
                                                      child: Image.network(
                                                        '${globals.urllocal}getimage?id=${listKomunitasAll[index].idkomunitas}&folder=komunitas',
                                                        width: 60,
                                                        height: 60,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    )
                                                    : Icon(
                                                      Icons.account_circle_outlined,
                                                      color: Color(int.parse(globals.defaultcolor)),
                                                      size: 60,
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(width: 5,),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              globals.idUser != "" 
                                                              ?listKomunitasShow[index].namakomunitas.toString()
                                                              :listKomunitasAll[index].namakomunitas.toString(),
                                                              style: GoogleFonts.nunito(
                                                                textStyle: const TextStyle(
                                                                  fontSize: 18, 
                                                                  fontWeight: FontWeight.bold,
                                                                  color: Color.fromARGB(255, 113, 9, 49)
                                                                )
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Icon(
                                                            Icons.person,
                                                            size: 16,
                                                          ),
                                                          const SizedBox(width: 5,),
                                                          Text(
                                                            globals.idUser != ""
                                                            ?"${listKomunitasShow[index].jumlahanggota} Anggota"
                                                            :"${listKomunitasAll[index].jumlahanggota} Anggota",
                                                            style: GoogleFonts.nunito(
                                                              textStyle: const TextStyle(
                                                                fontSize: 14,
                                                                color: Colors.black
                                                              )
                                                            ),
                                                          ),
                                                          Text(
                                                            "|",
                                                            style: GoogleFonts.nunito(
                                                              textStyle: const TextStyle(
                                                                fontSize: 14,
                                                                color: Colors.black
                                                              )
                                                            ),
                                                          ),
                                                          globals.idUser != ""
                                                          ? listKomunitasShow[index].statuskomunitas == 'publik' 
                                                          ? Row(
                                                            children: [
                                                              Icon(
                                                                Icons.lock_open_outlined, 
                                                                color: Color(int.parse(globals.defaultcolor)), 
                                                                size: 16,
                                                              ),
                                                              Text(
                                                                "Publik",
                                                                style: GoogleFonts.nunito(
                                                                  textStyle: const TextStyle(
                                                                    fontSize: 14,
                                                                    color: Colors.black
                                                                  )
                                                                ),
                                                              )
                                                            ],
                                                          )
                                                          : Row(
                                                            children: [
                                                              Icon(
                                                                Icons.lock_outline, 
                                                                color: Color(int.parse(globals.defaultcolor)), 
                                                                size: 16,
                                                              ),
                                                              Text(
                                                                "Privat",
                                                                style: GoogleFonts.nunito(
                                                                  textStyle: const TextStyle(
                                                                    fontSize: 14,
                                                                    color: Colors.black
                                                                  )
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                          : listKomunitasAll[index].statuskomunitas == 'publik'
                                                          ? Row(
                                                            children: [
                                                              Icon(
                                                                Icons.lock_open_outlined, 
                                                                color: Color(int.parse(globals.defaultcolor)), 
                                                                size: 16,
                                                              ),
                                                              Text(
                                                                "Publik",
                                                                style: GoogleFonts.nunito(
                                                                  textStyle: const TextStyle(
                                                                    fontSize: 14,
                                                                    color: Colors.black
                                                                  )
                                                                ),
                                                              )
                                                            ],
                                                          )
                                                          : Row(
                                                            children: [
                                                              Icon(
                                                                Icons.lock_outline, 
                                                                color: Color(int.parse(globals.defaultcolor)), 
                                                                size: 16,
                                                              ),
                                                              Text(
                                                                "Privat",
                                                                style: GoogleFonts.nunito(
                                                                  textStyle: const TextStyle(
                                                                    fontSize: 14,
                                                                    color: Colors.black
                                                                  )
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Column(
                                                  children: [
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        if (globals.idUser != "") {
                                                          if (listKomunitasShow[index].statuskomunitas == 'privat') {
                                                            _showDialogPassword(index);
                                                          } else {
                                                            addDetailKomunitas(int.parse(listKomunitasShow[index].idkomunitas));
                                                          }
                                                        } else {
                                                          _showDialogAlert();
                                                        }
                                                      }, 
                                                      child: Text(
                                                        "Gabung",
                                                        style: GoogleFonts.nunito(
                                                          textStyle: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w600,
                                                            color: Color(int.parse(globals.defaultcolor))
                                                          )
                                                        ),
                                                      ),
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor: Colors.white,
                                                        side: BorderSide(
                                                          color: Color(int.parse(globals.defaultcolor))
                                                        ),
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(10)
                                                        ),
                                                        elevation: 0,
                                                        padding: const EdgeInsets.all(5),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                            const SizedBox(height: 15,),
                                            Text(
                                              globals.idUser != ""
                                              ?listKomunitasShow[index].deskripsikomunitas.toString()
                                              :listKomunitasAll[index].deskripsikomunitas.toString(),
                                              style: GoogleFonts.nunito(
                                                textStyle: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black
                                                )
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
                                ],
                              ),
                              onTap: () {
                                if (globals.idUser != "") {
                                  globals.idkomunitas = listKomunitasShow[index].idkomunitas;
                                  globals.namakomunitas = listKomunitasShow[index].namakomunitas;
                                  globals.statuskomunitas = listKomunitasShow[index].statuskomunitas;
                                  globals.deskripsikomunitas = listKomunitasShow[index].deskripsikomunitas;
                                  globals.jumlahanggota = listKomunitasShow[index].jumlahanggota;
                                  globals.passwordkomunitas = listKomunitasShow[index].passwordkomunitas;
                                  globals.tanggalpembuatan = listKomunitasShow[index].tanggalpembuatan;
                                  globals.imagepathkomunitas = listKomunitasShow[index].imagepath;
                                } else {
                                  globals.idkomunitas = listKomunitasAll[index].idkomunitas;
                                  globals.namakomunitas = listKomunitasAll[index].namakomunitas;
                                  globals.statuskomunitas = listKomunitasAll[index].statuskomunitas;
                                  globals.deskripsikomunitas = listKomunitasAll[index].deskripsikomunitas;
                                  globals.jumlahanggota = listKomunitasAll[index].jumlahanggota;
                                  globals.passwordkomunitas = listKomunitasAll[index].passwordkomunitas;
                                  globals.tanggalpembuatan = listKomunitasAll[index].tanggalpembuatan;
                                  globals.imagepathkomunitas = listKomunitasAll[index].imagepath;
                                }
                                Navigator.push(
                                  context, 
                                  MaterialPageRoute(builder: (context) => DetailKomunitas(shouldpop: 'true',))
                                );
                              },
                            );
                          }
                        ),
                      ),
                    ],
                  ),
                  // end of list komunitas
        
                  // komunitasku
                  Column(
                    children: [
                      const SizedBox(height: 20,),
                      Container(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        height: 40,
                        child: TextField(
                          controller: controller,
                          cursorColor: const Color.fromARGB(255, 95, 95, 95),
                          decoration: InputDecoration(
                              fillColor: const Color.fromARGB(255, 253, 255, 252),
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Color(int.parse(globals.defaultcolor))),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Color(int.parse(globals.defaultcolor))),
                              ),
                              hintText: 'Cari Komunitas',
                              hintStyle: TextStyle(
                                color: Colors.grey[400]
                              ),
                              contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5)),
                              style: GoogleFonts.nunito(
                            textStyle: const TextStyle(
                              fontSize: 18,
                              color: Colors.black
                            )
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        // ignore: prefer_is_empty
                        child: listKomunitasku.length > 0 
                        ? ListView.builder(
                          itemCount: listKomunitasku.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12, right: 12),
                                    child: Card(
                                      elevation: 3,
                                      child: Container(
                                        padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(
                                                  children: [
                                                    listKomunitasku[index].imagepath != "-"
                                                    ? ClipOval(
                                                      child: Image.network(
                                                        '${globals.urllocal}getimage?id=${listKomunitasku[index].idkomunitas}&folder=komunitas',
                                                        width: 60,
                                                        height: 60,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    )
                                                    : Icon(
                                                      Icons.account_circle_outlined,
                                                      color: Color(int.parse(globals.defaultcolor)),
                                                      size: 60,
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(width: 5,),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        listKomunitasku[index].namakomunitas,
                                                        style: GoogleFonts.nunito(
                                                          textStyle: const TextStyle(
                                                            fontSize: 18, 
                                                            fontWeight: FontWeight.bold,
                                                            color: Color.fromARGB(255, 113, 9, 49)
                                                          )
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Icon(
                                                            Icons.person,
                                                            size: 16,
                                                          ),
                                                          const SizedBox(width: 5,),
                                                          Text(
                                                            "${listKomunitasku[index].jumlahanggota} Anggota",
                                                            style: GoogleFonts.nunito(
                                                              textStyle: const TextStyle(
                                                                fontSize: 14,
                                                                color: Colors.black
                                                              )
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Column(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.all(8),
                                                      decoration: BoxDecoration(
                                                        color: Colors.transparent,
                                                        border: Border.all(
                                                          color: listKomunitasku[index].statuskomunitas == 'publik'
                                                          ? Color(int.parse(globals.defaultcolor))
                                                          : const Color.fromARGB(255, 113, 9, 49),
                                                          width: 1,
                                                        ),
                                                        borderRadius: BorderRadius.circular(10)
                                                      ),
                                                      child: listKomunitasku[index].statuskomunitas == 'publik'
                                                      ? Text(
                                                        "Publik",
                                                        style: GoogleFonts.nunito(
                                                          textStyle: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w600,
                                                            color: Color(int.parse(globals.defaultcolor))
                                                          )
                                                        ),
                                                      )
                                                      : Text(
                                                        "Privat",
                                                        style: GoogleFonts.nunito(
                                                          textStyle: const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w600,
                                                            color: Color.fromARGB(255, 113, 9, 49)
                                                          )
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                            const SizedBox(height: 15,),
                                            Text(
                                              listKomunitasku[index].deskripsikomunitas,
                                              style: GoogleFonts.nunito(
                                                textStyle: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black
                                                )
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
                                ],
                              ),
                              onTap: () {
                                globals.idkomunitas = listKomunitasku[index].idkomunitas;
                                globals.namakomunitas = listKomunitasku[index].namakomunitas;
                                globals.statuskomunitas = listKomunitasku[index].statuskomunitas;
                                globals.deskripsikomunitas = listKomunitasku[index].deskripsikomunitas;
                                globals.jumlahanggota = listKomunitasku[index].jumlahanggota;
                                globals.passwordkomunitas = listKomunitasku[index].passwordkomunitas;
                                globals.tanggalpembuatan = listKomunitasku[index].passwordkomunitas;
                                globals.imagepathkomunitas = listKomunitasku[index].imagepath;
                                Navigator.push(
                                  context, 
                                  MaterialPageRoute(builder: (context) => DetailKomunitas(shouldpop: 'true', pagefrom: 'komunitasku',))
                                );
                              },
                            );
                          }
                        )
                        : Center(
                            child: Text(
                              "Anda belum join komunitas",
                              style: GoogleFonts.nunito(
                                textStyle: TextStyle(
                                  fontSize: 20,
                                  color: Color(int.parse(globals.defaultcolor)),
                                  fontWeight: FontWeight.bold
                                )
                              ),
                            )
                          )
                      ),
                    ],
                  ),
                  // end of komunitasku
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Visibility(
        visible: globals.idUser != "" ? true : false,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context, MaterialPageRoute(builder: (context) => BuatKomunitas(pagefrom: "listkomunitas",))
            );
          },
          child: const Icon(
            Icons.add,
            size: 40,
          ),
          backgroundColor: Color(int.parse(globals.defaultcolor)),
        ),
      ),
    );
  }
}
