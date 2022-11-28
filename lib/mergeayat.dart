import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './global.dart' as globals;
//import './homepage.dart';
import './pecahAyatClass.dart';

class AyatPembanding { // tampilkan list di ayat yang dibandingkan
  String? namaKitab;
  int? pasalKitab;
  int? ayatKitab;

  AyatPembanding({
    this.namaKitab,
    this.pasalKitab,
    this.ayatKitab
  });

  String? get getNamaKitab{
    return namaKitab;
  }
  int? get getPasalKitab{
    return pasalKitab;
  }
  int? get getAyatKitab{
    return ayatKitab;
  }
}

class DataAyatPembanding {
  String? ayat;
  String? isi;
  String? status;

  DataAyatPembanding({
    this.ayat,
    this.isi,
    this.status
  });

  String? get getAyat {
    return ayat;
  }
  String? get getIsi {
    return isi;
  }
  String? get getStatus {
    return status;
  }
}

class MergeAyat extends StatefulWidget {
  final int? indexKitabdicari;
  final int? pasalKitabdicari;
  final int? ayatkitabdicari;
  final String? asalPage;

  const MergeAyat({
    super.key,
    required this.indexKitabdicari,
    required this.pasalKitabdicari,
    required this.ayatkitabdicari,
    required this.asalPage
  });

  @override
  State<MergeAyat> createState() => _MergeAyatState();
}

class _MergeAyatState extends State<MergeAyat> {
  List ayat = List.generate(10, (i) => List.generate(3, (j) => "")); //data dummy buat isi kitab
  List searchitems = [];  // data dummy untuk simpen riwayat
  List kitabTertentu = [];
  // ignore: non_constant_identifier_names
  final ScrollDirection = Axis.vertical;
  AutoScrollController? controllerscroll;
  List alkitab_ = globals.alkitab;
  TextEditingController searchKitabController = TextEditingController();
  String hasil = "";

  double width = 20.0;
  double height = 7.0;

  @override
  void initState() {
    super.initState();
    getRiwayat();
  }

  //PECAH AYAT
  // ignore: non_constant_identifier_names
  List<Stacks> InitStack() {
  List<Stacks> x = [];
  return x;
}

// ignore: non_constant_identifier_names
Stacks PopStack(List<Stacks> x) {
  Stacks tmp = x[0];
  x.removeAt(0);
  return tmp;
}

String pembetulanNamaKitabUnik(namakitab){
  String tempIndexPertama="";
  String tempNamaKitab="";
  namakitab = namakitab.toLowerCase();
  namakitab = namakitab.replaceAll(" ", "");
  //20 kitab unique case
  if(namakitab=="kisahpararasul"){
    namakitab = "Kisah Para Rasul";
  }
  else if(namakitab=="hakim-hakim"){
    namakitab = "Hakim-hakim";
  }
  else if(namakitab=="1samuel"){
    namakitab = "1 Samuel";
  }
  else if(namakitab=="2samuel"){
    namakitab = "2 Samuel";
  }
  else if(namakitab=="1raja-raja"){
    namakitab = "1 Raja-raja";
  }
  else if(namakitab=="2raja-raja"){
    namakitab = "2 Raja-raja";
  }
  else if(namakitab=="1tawarikh"){
    namakitab = "1 Tawarikh";
  }
  else if(namakitab=="2tawarikh"){
    namakitab = "2 Tawarikh";
  }
  else if(namakitab=="kidungagung"){
    namakitab = "Kidung Agung";
  }
  else if(namakitab=="1korintus"){
    namakitab = "1 Korintus";
  }
  else if(namakitab=="2korintus"){
    namakitab = "2 Korintus";
  }
  else if(namakitab=="1tesalonika"){
    namakitab = "1 Tesalonika";
  }
  else if(namakitab=="2tesalonika"){
    namakitab = "2 Tesalonika";
  }
  else if(namakitab=="1timotus"){
    namakitab = "1 Timotius";
  }
  else if(namakitab=="2timotius"){
    namakitab = "2 Timotius";
  }
  else if(namakitab=="1petrus"){
    namakitab = "1 Petrus";
  }
  else if(namakitab=="2petrus"){
    namakitab = "2 Petrus";
  }
  else if(namakitab=="1yohanes"){
    namakitab = "1 Yohanes";
  }
  else if(namakitab=="2yohanes"){
    namakitab = "2 Yohanes";
  }
  else if(namakitab=="3yohanes"){
    namakitab = "3 Yohanes";
  }
  else{
    tempIndexPertama=namakitab[0];
    tempIndexPertama=tempIndexPertama.toUpperCase();
    tempNamaKitab=tempIndexPertama+namakitab.substring(1);
    namakitab=tempNamaKitab;
  }


  return namakitab;
}

void pecahAyat2(String bacaan, List<Stacks> ayat) {
  String tmp = "";
  String op = "";
  String next = "*";
  // ignore: unused_local_variable
  String temp = "";
  // ignore: unused_local_variable
  String tempbacaan = "";
  // ignore: unused_local_variable
  String namakitab = "";
  // ignore: unused_local_variable
  String angkakitab = "";
  // ignore: unused_local_variable
  bool sudahmasukangka=false;


  for (int i = 0; i < bacaan.length; i++) {
    tmp = tmp + bacaan[i];
    
    if (bacaan[i] == "," || bacaan[i] == "-" || bacaan[i] == ":") {
      if (bacaan[i] == "-" &&
          bacaan.codeUnitAt(i + 1) <= 122 &&
          bacaan.codeUnitAt(i + 1) >= 97) {
      } else if (bacaan[i] == "-" &&
          bacaan.codeUnitAt(i + 1) <= 90 &&
          bacaan.codeUnitAt(i + 1) >= 65) {
      } else {
        next = "";
        op = ayat.last.next;
        next = next + bacaan[i];
        ayat.add(Stacks(op, tmp.substring(0, tmp.length - 1), next));
        tmp = "";
        op = "";
      }
    } else if (i == bacaan.length - 1) {
      op = ayat.last.next;
      ayat.add(Stacks(op, tmp, "*"));
    } else if (next.codeUnitAt(0) >= 44 &&
            next.codeUnitAt(0) <= 45 &&
            bacaan[i] == " " ||
        bacaan[i] == ";") {
      op = ayat.last.next;
      ayat.add(Stacks(op, tmp.substring(0, tmp.length - 1), "*"));
      tmp = "";
      op = "";
      next = "*";
    } else if (bacaan.codeUnitAt(i + 1) <= 57 &&
        bacaan.codeUnitAt(i + 1) >= 49 &&
        bacaan[i] == " ") {
      tmp = tmp.replaceAll(RegExp('\\s+'), " ");
      ayat.add(Stacks("*", tmp.substring(0, tmp.length - 1), "^"));
      tmp = "";
      op = "";
    }
  }

 // log("hasil heh - $ayat");
  
}

void addBacaan(List<Bacaan> bacaanKitab, List<Stacks> stk) {
  while (stk.isNotEmpty) {
    Stacks tmp = PopStack(stk);
    String kitab = "";
    String pasal = "";
    String ayat = "";
    if (tmp.op == "*" && tmp.next == "^") {
      kitab = tmp.data;
      kitab = pembetulanNamaKitabUnik(kitab);
      // ignore: avoid_print
      print("hasil edit 4 - $kitab");
      // ignore: avoid_print
      print("testing - $kitab");
      tmp = PopStack(stk);
      
      if (tmp.next == ":" && tmp.op == "^") {
        pasal = tmp.data;
        do {
          tmp = PopStack(stk);
          if (tmp.op == ":" || tmp.op == ",") {
            ayat = tmp.data;
            // ignore: unnecessary_new
            Bacaan baca = new Bacaan(kitab, pasal, ayat);
            bacaanKitab.add(baca);
          } else if (tmp.op == "-") {
            int a = int.parse(tmp.data);
            int b = int.parse(bacaanKitab.last.ayat);
            int c = a - b;
            for (int i = 0; i < c; i++) {
              b++;
              // ignore: unnecessary_new
              Bacaan baca = new Bacaan(kitab, pasal, b.toString());
              bacaanKitab.add(baca);
            }
          }
        } while (tmp.next != "*");
      }
    }
  }
}


Future<void> setAlkitab2(List<Kitab> alkitab) async {
  
  var tmp=alkitab_.asMap();
  
  for (int k = 0; k < tmp.length && tmp[k]["book"] != null; k++) {
    int skip = -1;
    String kitab = tmp[k]["book"].toString();
    List<Pasal> listPasal = [];
    for (int p = k; p < tmp.length; p++) {
      // ignore: unnecessary_null_comparison
      if (tmp[p]["book"].toString() == null ||
          tmp[p]["book"].toString() != kitab) {
        break;
      }
      String pasalTmp = tmp[p]["chapter"].toString();
      int pasal = int.parse(pasalTmp);
      // print(pasal);
      List<Ayat> listAyat = [];
      int skipP = -1;
      skip++;
      for (int a = p; a < tmp.length; a++) {
        // ignore: unnecessary_null_comparison
        if (tmp[a]["chapter"].toString() == null ||
            tmp[a]["chapter"].toString() != pasalTmp) {
          // skipP -= 2;
          break;
        }
        skipP++;
        skip++;
        String ayatS = tmp[a]["verse"].toString();
        int ayat = int.parse(ayatS);
        String isi = tmp[a]["content"].toString();
        String tipe = tmp[a]["type"].toString();
        // ignore: unnecessary_new
        Ayat tmpAyat = new Ayat(ayat, isi, tipe);
        listAyat.add(tmpAyat);
      }
      p += skipP;
      Pasal newPasal = Pasal(pasal, listAyat);
      listPasal.add(newPasal);
      // print(listAyat.length);
    }
    Kitab newKitab = Kitab(kitab, listPasal);
    alkitab.add(newKitab);

    k += skip - listPasal.length;
  }
}


void addIsiAyat2(List<AyatN> ayatBaca, List<Bacaan> bacaanKitab, List<Kitab> alkitab) {
  bool done = false;
  for (int i = 0; i < bacaanKitab.length; i++) {
    if(done==false){
      String kitab = bacaanKitab.elementAt(i).kitab;
    int k = 0;
    for (int j = 0; j < alkitab.length; j++) {
      if (kitab == alkitab.elementAt(j).kitab) {
        break;
      }
      k++;
    }
    int count = i;
    while (count < bacaanKitab.length &&
        alkitab.elementAt(k).kitab == bacaanKitab.elementAt(count).kitab) {
      String pasal = bacaanKitab.elementAt(count).pasal;
      int pasalN = int.parse(pasal);
      while (count < bacaanKitab.length &&
          alkitab
                  .elementAt(k)
                  .listPasal
                  .elementAt(pasalN - 1)
                  .pasal
                  .toString() ==
              bacaanKitab.elementAt(count).pasal) {
        String ayat = bacaanKitab.elementAt(count).ayat;
        //log("hasil heh ayat- $ayat");
        
        // if(alkitab.elementAt(k).listPasal.elementAt(pasalN - 1).listAyat.length < int.parse(ayat)){
        //   done=true;
        //   break;
        // }
        

        int ayatN = int.parse(ayat);
        int newAyat = ayatN;
        log("hasil heh ayatt-$ayatN");

        try {
          log("hasil heh sampe sini- $ayatN ${alkitab
            .elementAt(k)
            .listPasal
            .elementAt(pasalN - 1)
            .listAyat
            .elementAt(ayatN).ayat
            }");
        } catch (e) {
          log('ga sampe situ ayatnyaa');
          done=true;
          break;
        }
        

        int ayatI = alkitab
            .elementAt(k)
            .listPasal
            .elementAt(pasalN - 1)
            .listAyat
            .elementAt(ayatN)
            .ayat;
        if (ayatI == 0) {
          ayatI = alkitab
              .elementAt(k)
              .listPasal
              .elementAt(pasalN - 1)
              .listAyat
              .elementAt(ayatN + 1)
              .ayat;
          newAyat = ayatI + 1;
        } else if (ayatN > ayatI) {
          newAyat = (ayatN - ayatI) + ayatN;
        } else if (ayatN > ayatI) {
          newAyat = (ayatN - ayatI) + ayatN;
        }
        String isi = alkitab
            .elementAt(k)
            .listPasal
            .elementAt(pasalN - 1)
            .listAyat
            .elementAt(newAyat)
            .isi;
        // ignore: unnecessary_new
        AyatN ayatBacaan = new AyatN(bacaanKitab.elementAt(count), isi);
        log("hasil heh ISI- $ayat $isi");

        

        ayatBaca.add(ayatBacaan);
        count++;
      }
      if(done==true){
      break;
    }
    }

    
    
    i = count -1;
    
    
    }else{
      break;
    }
    
  }
}

Future<void> listenTextFieldSearch()async{
  setState(() async {
    hasil="";
    getPecahAyat();
  });
}

// void printDataStk(List<Stack> x) {
//   for (int i = 0; i < x.length; i++) {}
// }
  //AKHIR FUNCTION PECAH AYAT

  

  @override
  

  // ignore: override_on_non_overriding_member
  void getPecahAyat()async{
    //hasil="";
    
    bool udahgantikitab=true;
    String bacaan = searchKitabController.text.toString();
    //print("hasil edit 1- $bacaan");
    String bacaancoba = bacaan;
    bacaancoba = bacaancoba.replaceAll(" ", "");
    
    String tempbacaan="";

    for(int i=0;i<bacaancoba.length;i++){
      if(bacaan[i]==";"){
        udahgantikitab = true;
      }
      tempbacaan=tempbacaan+bacaancoba[i];
      if(int.tryParse(bacaancoba[i]) == null && int.tryParse(bacaancoba[i+1]) != null && bacaancoba[i]!=";" && udahgantikitab==true){
          tempbacaan="$tempbacaan ";
          udahgantikitab=false;
      }
      
    }

    

    bacaan=tempbacaan;
    //log("hasil edit 2- $bacaan");
    var stk = InitStack();
    
    List<Bacaan> bacaanKitab = [];
    List<AyatN> ayatBaca = [];
    List<Kitab> alkitab = [];
    await setAlkitab2(alkitab);
    log("sampe sini");
    pecahAyat2(bacaan, stk);
    log("sampe sini 2");
   
    addBacaan(bacaanKitab, stk);
    log("sampe sini 3");
    
    addIsiAyat2(ayatBaca, bacaanKitab, alkitab);
    log("sampe sini 4 ${ayatBaca.length}");
    //print("\n");
    for (int i = 0; i < ayatBaca.length; i++) {
      setState(() {
        // ignore: prefer_interpolation_to_compose_strings
        hasil = hasil + ayatBaca.elementAt(i).bacaan.kitab +
          " " +
          ayatBaca.elementAt(i).bacaan.pasal +
          " : " +
          ayatBaca.elementAt(i).bacaan.ayat +
          "\n" +
          ayatBaca.elementAt(i).isi+
          "\n\n" ;
      });
      
    }

    
  }


  // SHARED PREFERENCES
  List<String> listRiwayat = [];
  List<String> listIsiRiwayat = [];
  void saveRiwayat() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('list riwayat', listRiwayat);
    prefs.setStringList('list isi riwayat', listIsiRiwayat);
  }

  void getRiwayat() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> listsp = prefs.getStringList('list riwayat') ?? [];
    List<String> listisp = prefs.getStringList('list isi riwayat') ?? [];

    setState(() {
      listRiwayat = [];
      listIsiRiwayat = [];
      listRiwayat = listsp;
      listIsiRiwayat = listisp;
    });

    // print("hasil: $listRiwayat");
    // print("hasil: $listIsiRiwayat");
  }
  // END OF SHARED PREFERENCES

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(int.parse(globals.defaultcolor)),
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              // ignore: non_constant_identifier_names
              bool status_similar = false;
              for (int i = 0; i < listRiwayat.length; i++) {
                if(listRiwayat[i] == searchKitabController.text) {
                  status_similar = true;
                }
              }
              if (searchKitabController.text.isNotEmpty && status_similar == false) {
                listRiwayat.add(searchKitabController.text);
                listIsiRiwayat.add(hasil);
              }
              saveRiwayat();
              Navigator.pop(context);
              // Navigator.push(
              //   context, 
              //   MaterialPageRoute(builder: (context) => HomePage(indexKitabdicari: 0, pasalKitabdicari: 0, ayatKitabdicari: 0, daripagemana: "mergeayat"))
              // );
            }, 
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(right:16, left: 16, top: 10),
              child: TextField(
                controller: searchKitabController,
                  onChanged: (searchKitabController) async {
                    if(searchKitabController.isNotEmpty){
                      setState(() async {
                        await listenTextFieldSearch();
                      });
                    }else{
                      setState(() {
                        hasil="";
                      });
                      
                    }
                  },
                cursorColor: const Color.fromARGB(255, 95, 95, 95),
                decoration: InputDecoration(
                  fillColor: Colors.transparent,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Color(int.parse(globals.defaultcolor))),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Color(int.parse(globals.defaultcolor))),
                  ),
                  hintText: 'Kejadian 1:1-10,17,21 ; 1 Samuel 2:3 ...',
                  contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5)
                ),
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    color: Colors.black
                  )
                ),
                maxLines: 2,
              ),
            ),
            const SizedBox(height: 5,),
            Container(
              padding: const EdgeInsets.only(left: 16, top: 8),
              child: Text(
                "Riwayat",
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600, 
                    color: Color.fromARGB(255, 113, 9, 49)
                  )
                ),
              ),
            ),
      
            Container(
              height: 100,
              padding: const EdgeInsets.only(left: 16, right: 4),
              child: ListView.builder(
                itemCount: listRiwayat.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            listRiwayat[index],
                            style: GoogleFonts.nunito(
                              textStyle: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w500
                              )
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              listRiwayat.removeAt(index);
                              listIsiRiwayat.removeAt(index);
                            });
                            saveRiwayat();
                          }, 
                          icon: const Icon(
                            Icons.cancel_outlined,
                            size: 20,
                          )
                        ),
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        searchKitabController.text = listRiwayat[index];
                        hasil = listIsiRiwayat[index];
                      });
                      
                    },
                  );
                },
              ),
            ),
      
            Container(
              height: 1,
              margin: const EdgeInsets.only(left: 8, right: 8),
              color: Color(int.parse(globals.defaultcolor)),
            ),
      
            Expanded(
              child: SingleChildScrollView(
                child: 
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    hasil,
                    style: GoogleFonts.nunito(
                      textStyle: const TextStyle(
                        fontSize: 18, 
                        fontWeight: FontWeight.w600,
                        color: Colors.black
                      )
                    ),
                    textAlign: TextAlign.justify,
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
