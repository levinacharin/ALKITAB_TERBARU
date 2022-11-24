import 'dart:developer';
import 'dart:io';

import 'package:alkitab/detailkomunitas.dart';
import 'package:alkitab/listkomunitas.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

import 'global.dart' as globals;
import 'pecahAyatClass.dart';

class TambahRencana extends StatefulWidget {
  
  const TambahRencana({super.key});

  @override
  State<TambahRencana> createState() => _TambahRencanaState();
}

class _TambahRencanaState extends State<TambahRencana> {
  TextEditingController ctr_judulrencana = TextEditingController();
  TextEditingController ctr_deskripsirencana = TextEditingController();

  List<TextEditingController> ctr_judulrenungan = [];
  List<TextField> fields_judulrenungan = [];
  List<TextEditingController> ctr_isirenungan = [];
  List<TextField> fields_isirenungan = [];
  List<TextEditingController> ctr_ayatbacaan = [];
  List<TextField> fields_ayatbacaan = [];
  List<TextEditingController> ctr_linkrenungan = [];
  List<TextField>fields_linkrenungan = [];

  List alkitab_ = globals.alkitab;
  String hasil = "";
  List<Stacks> InitStack() {
    List<Stacks> x = [];
    return x;
  }
  Stacks PopStack(List<Stacks> x) {
    Stacks tmp = x[0];
    x.removeAt(0);
    return tmp;
  }
  String pembetulanNamaKitabUnik(namakitab) {
    String tempIndexPertama = "";
    String tempNamaKitab = "";
    namakitab = namakitab.toLowerCase();
    namakitab = namakitab.replaceAll(" ", "");
    //20 kitab unique case
    if (namakitab == "kisahpararasul") {
      namakitab = "Kisah Para Rasul";
    } else if (namakitab == "hakim-hakim") {
      namakitab = "Hakim-hakim";
    } else if (namakitab == "1samuel") {
      namakitab = "1 Samuel";
    } else if (namakitab == "2samuel") {
      namakitab = "2 Samuel";
    } else if (namakitab == "1raja-raja") {
      namakitab = "1 Raja-raja";
    } else if (namakitab == "2raja-raja") {
      namakitab = "2 Raja-raja";
    } else if (namakitab == "1tawarikh") {
      namakitab = "1 Tawarikh";
    } else if (namakitab == "2tawarikh") {
      namakitab = "2 Tawarikh";
    } else if (namakitab == "kidungagung") {
      namakitab = "Kidung Agung";
    } else if (namakitab == "1korintus") {
      namakitab = "1 Korintus";
    } else if (namakitab == "2korintus") {
      namakitab = "2 Korintus";
    } else if (namakitab == "1tesalonika") {
      namakitab = "1 Tesalonika";
    } else if (namakitab == "2tesalonika") {
      namakitab = "2 Tesalonika";
    } else if (namakitab == "1timotus") {
      namakitab = "1 Timotius";
    } else if (namakitab == "2timotius") {
      namakitab = "2 Timotius";
    } else if (namakitab == "1petrus") {
      namakitab = "1 Petrus";
    } else if (namakitab == "2petrus") {
      namakitab = "2 Petrus";
    } else if (namakitab == "1yohanes") {
      namakitab = "1 Yohanes";
    } else if (namakitab == "2yohanes") {
      namakitab = "2 Yohanes";
    } else if (namakitab == "3yohanes") {
      namakitab = "3 Yohanes";
    } else {
      tempIndexPertama = namakitab[0];
      tempIndexPertama = tempIndexPertama.toUpperCase();
      tempNamaKitab = tempIndexPertama + namakitab.substring(1);
      namakitab = tempNamaKitab;
    }

    return namakitab;
  }


  String dropdownvalue = "1 hari";
  int dayLength = 1;
  var items = [
    '1 hari',
    '2 hari',
    '3 hari',
    '4 hari',
    '5 hari',
    '6 hari',
    '7 hari'
  ];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    for (final controller_judul in ctr_judulrenungan) {
      controller_judul.dispose();
    }
    for (final controller_isi in ctr_isirenungan) {
      controller_isi.dispose();
    }
    for (final controller_ayat in ctr_ayatbacaan) {
      controller_ayat.dispose();
    }
    
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final controller_judul = TextEditingController();
    final field_judul = TextField(
      controller: controller_judul,
      cursorColor: Color(int.parse(globals.defaultcolor)),
      decoration: InputDecoration(
        fillColor: Colors.transparent,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Color(int.parse(globals.defaultcolor))
          )
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1, 
            color: Color(int.parse(globals.defaultcolor))
          )
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Color(int.parse(globals.defaultcolor))
          )
        ),
        contentPadding: const EdgeInsets.all(10),
        hintText: "Judul Renungan ${ctr_judulrenungan.length + 1}",
        hintStyle: GoogleFonts.nunito(
          fontSize: 18,
          color: Colors.grey[400]
        )
      ),
      style: GoogleFonts.nunito(
        textStyle: const TextStyle(
          fontSize: 18,
          color: Colors.black
        )
      ),
      maxLines: 2,
    );
    
    final controller_isi = TextEditingController();
    final field_isi = TextField(
      controller: controller_isi,
      cursorColor: Color(int.parse(globals.defaultcolor)),
      decoration: InputDecoration(
        fillColor: Colors.transparent,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Color(int.parse(globals.defaultcolor))
          )
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1, 
            color: Color(int.parse(globals.defaultcolor))
          )
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Color(int.parse(globals.defaultcolor))
          )
        ),
        contentPadding: const EdgeInsets.all(10),
        hintText: "Isi Renungan ${ctr_isirenungan.length + 1}",
        hintStyle: GoogleFonts.nunito(
          fontSize: 18,
          color: Colors.grey[400]
        )
      ),
      style: GoogleFonts.nunito(
        textStyle: const TextStyle(
          fontSize: 18,
          color: Colors.black
        )
      ),
      maxLines: 5,
    );

    final controller_ayat = TextEditingController();
    final field_ayat = TextField(
      controller: controller_ayat,
      cursorColor: Color(int.parse(globals.defaultcolor)),
      decoration: InputDecoration(
        fillColor: Colors.transparent,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Color(int.parse(globals.defaultcolor))
          )
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1, 
            color: Color(int.parse(globals.defaultcolor))
          )
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Color(int.parse(globals.defaultcolor))
          )
        ),
        contentPadding: const EdgeInsets.all(10),
        hintText: "Kejadian 1:1-5; Imamat 4:2",
        hintStyle: GoogleFonts.nunito(
          fontSize: 18,
          color: Colors.grey[400]
        )
      ),
      style: GoogleFonts.nunito(
        textStyle: const TextStyle(
          fontSize: 18,
          color: Colors.black
        )
      ),
      maxLines: 2,
    );

    final controller_link = TextEditingController();
    final field_link = TextField(
      controller: controller_link,
      cursorColor: Color(int.parse(globals.defaultcolor)),
      decoration: InputDecoration(
        fillColor: Colors.transparent,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Color(int.parse(globals.defaultcolor))
          )
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1, 
            color: Color(int.parse(globals.defaultcolor))
          )
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Color(int.parse(globals.defaultcolor))
          )
        ),
        contentPadding: const EdgeInsets.all(10),
        hintText: "Link Renungan ${ctr_linkrenungan.length + 1}",
        hintStyle: GoogleFonts.nunito(
          fontSize: 18,
          color: Colors.grey[400]
        )
      ),
      style: GoogleFonts.nunito(
        textStyle: const TextStyle(
          fontSize: 18,
          color: Colors.black
        )
      ),
      maxLines: 2,
    );

    setState(() {
      ctr_judulrenungan.add(controller_judul);
      fields_judulrenungan.add(field_judul);
      ctr_isirenungan.add(controller_isi);
      fields_isirenungan.add(field_isi);
      ctr_ayatbacaan.add(controller_ayat);
      fields_ayatbacaan.add(field_ayat);
      ctr_linkrenungan.add(controller_link);
      fields_linkrenungan.add(field_link);

      print("path photo: $pathPhoto");
    });
  }

  @override
  void getPecahAyat(String ayatbacaanctr) {
    bool udahgantikitab = true;
    String bacaan = ayatbacaanctr;
    String bacaancoba = bacaan;
    bacaancoba = bacaancoba.replaceAll(" ", "");
    String tempbacaan = "";

    for (int i = 0; i < bacaancoba.length; i++) {
      if (bacaan[i] == ";") {
        udahgantikitab = true;
      }
      tempbacaan = tempbacaan + bacaancoba[i];
      if (int.tryParse(bacaancoba[i]) == null &&
          int.tryParse(bacaancoba[i+1]) != null &&
          bacaancoba[i] != ";" &&
          udahgantikitab == true) {
            tempbacaan = tempbacaan + " ";
            udahgantikitab = false;
          }
    }

    bacaan = tempbacaan;

    var stk = InitStack();

    List<Bacaan> bacaanKitab = [];
    List<AyatN> ayatBaca = [];
    List<Kitab> alkitab = [];
    setAlkitab2(alkitab);  // awalnya ada await
    pecahAyat2(bacaan, stk);

    addBacaan(bacaanKitab, stk);
    

    addIsiAyat2(ayatBaca, bacaanKitab, alkitab);
    hasil="";
    for (int i = 0; i < ayatBaca.length; i++) {
      // ignore: prefer_interpolation_to_compose_strings
        hasil = hasil +
            ayatBaca.elementAt(i).bacaan.kitab +
            " " +
            ayatBaca.elementAt(i).bacaan.pasal +
            " : " +
            ayatBaca.elementAt(i).bacaan.ayat +
            "\n" +
            ayatBaca.elementAt(i).isi +
            "\n\n";
    }
  }

  Future<void> setAlkitab2(List<Kitab> alkitab) async {
    var tmp = alkitab_.asMap();

    for (int k = 0; k < tmp.length && tmp[k]["book"] != null; k++) {
      int skip = -1;
      String kitab = tmp[k]["book"].toString();
      List<Pasal> listPasal = [];
      for (int p = k; p < tmp.length; p++) {
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

  void pecahAyat2(String bacaan, List<Stacks> ayat) {
    String tmp = "";
    String op = "";
    String next = "*";
    String temp = "";
    String tempbacaan = "";
    String namakitab = "";
    String angkakitab = ""; 
    bool sudahmasukangka = false;

    for (int i = 0; i < bacaan.length; i++) {
      tmp = tmp + bacaan[i];

      if (bacaan[i] == "," || bacaan[i] == "-" || bacaan[i] == ":") {
        if (bacaan[i] == "-" &&
          bacaan.codeUnitAt(i + 1) <= 122 &&
          bacaan.codeUnitAt(i + 1) >= 97) {
        print("masuk skip");
      } else if (bacaan[i] == "-" &&
          bacaan.codeUnitAt(i + 1) <= 90 &&
          bacaan.codeUnitAt(i + 1) >= 65) {
        print("masuk skip");
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
  }

  void addBacaan(List<Bacaan> bacaanKitab, List<Stacks> stk) {
    while (stk.length > 0) {
      Stacks tmp = PopStack(stk);
      String kitab = "";
      String pasal = "";
      String ayat = "";
      if (tmp.op == "*" && tmp.next == "^") {
        kitab = tmp.data;
        kitab = pembetulanNamaKitabUnik(kitab);
        tmp = PopStack(stk);

        if (tmp.next == ":" && tmp.op == "^") {
          pasal = tmp.data;
          do {
            tmp = PopStack(stk);
            if (tmp.op == ":" || tmp.op == ",") {
              ayat = tmp.data;
              Bacaan baca = new Bacaan(kitab, pasal, ayat);
              bacaanKitab.add(baca);
            } else if (tmp.op == "-") {
              int a = int.parse(tmp.data);
              int b = int.parse(bacaanKitab.last.ayat);
              int c = a - b;
              for (int i = 0; i < c; i++) {
                b++;
                Bacaan baca = new Bacaan(kitab, pasal, b.toString());
                bacaanKitab.add(baca);
              }
            }
          } while (tmp.next != "*");
        }
      }
    }
  }

  void addIsiAyat2( List<AyatN> ayatBaca, List<Bacaan> bacaanKitab, List<Kitab> alkitab) {
    for (int i = 0; i < bacaanKitab.length; i++) {
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
          int ayatN = int.parse(ayat);
          int newAyat = ayatN;
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
          AyatN ayatBacaan = new AyatN(bacaanKitab.elementAt(count), isi);

          ayatBaca.add(ayatBacaan);
          count++;
        }
      }
      i = count - 1;
    }
  }

  // API SERVICES
  String idrencana = "";
  void SimpanInformasiRencana() async {
    var url = "${globals.urllocal}simpanrencanabacaan";
    var response = await http.post(Uri.parse(url), body: {
      "idkomunitas" : globals.idkomunitas,
      "imagepath" : "-",
      "judulrencana" : ctr_judulrencana.text,
      "deskripsirencana" : ctr_deskripsirencana.text,
      "durasirencana" : dayLength.toString()
    });
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      var lastId = data['data']['getIdLast'];
      idrencana = lastId.toString();

      SimpanRencanaBacaan(idrencana);
    }
  }

  void SimpanRencanaBacaan(String idrencana) async {
    var url = "${globals.urllocal}simpandetailrencana";
    for (int i = 0; i < ctr_ayatbacaan.length; i++) {
      getPecahAyat(ctr_ayatbacaan[i].text);

      var response = await http.post(Uri.parse(url), body: {
      "idrencana" : idrencana,
      "hari" : (i+1).toString(),
      "kitabbacaan" : ctr_ayatbacaan[i].text,
      "ayatbacaan" : hasil,
      "judulrenungan" : ctr_judulrenungan[i].text,
      "isirenungan" : ctr_isirenungan[i].text,
      "linkrenungan" : ctr_linkrenungan[i].text
      });
    }

    updateImage(idrencana);
  }

  void updateImage(String idrencana) async {
    var url = "${globals.urllocal}uploadimage";
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields['id'] = idrencana;
    request.fields['folder'] = 'rencana';
    request.files.add(
      await http.MultipartFile.fromPath('photo', pathPhoto)
    );
    var res = await request.send();

    // ignore: use_build_context_synchronously
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => DetailKomunitas(shouldpop: "false"))
    );
  }
  // END OF API SERVICES

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
    }
  }

  Future<void> _showDialogAyatBacaan(int idx) async {
    setState(() {
      getPecahAyat(ctr_ayatbacaan[idx].text);
    });
    return showDialog(
      context: context, 
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Ayat Bacaan",
                          style: GoogleFonts.nunito(
                            textStyle: const TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 113, 9, 49)
                            )
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        }, 
                        icon: const Icon(
                          Icons.cancel_outlined,
                          color: Color.fromARGB(255, 113, 9, 49),
                        )
                      )
                    ],
                  )
                ],
              );
            },
          ),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                width: double.maxFinite,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextField(
                        controller: ctr_ayatbacaan[idx],
                        // ignore: non_constant_identifier_names
                        onChanged: (ctr_ayatbacaan) async {
                          if (ctr_ayatbacaan.isNotEmpty) {
                            setState((){
                              getPecahAyat(ctr_ayatbacaan);
                            });
                          } else {
                            setState(() {
                              hasil = "";
                            });
                          }
                        },
                        cursorColor: Color(int.parse(globals.defaultcolor)),
                        decoration: InputDecoration(
                          fillColor: Colors.transparent,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Color(int.parse(globals.defaultcolor))
                            )
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Color(int.parse(globals.defaultcolor))
                            )
                          ),
                          contentPadding: const EdgeInsets.all(10)
                        ),
                        style: TextStyle(
                          height: 1.5,
                          fontSize: 14,
                          color: Color(int.parse(globals.defaultcolor))
                        ),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.only(left: 4, right: 4),
                        child: Text(
                          hasil,
                          style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                              fontSize: 16,
                              color: Color(int.parse(globals.defaultcolor))
                            )
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }
    );
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
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: const Color.fromARGB(255, 113, 9, 49),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                    : const DecorationImage(
                      image: AssetImage("")
                    ),
                    color: pathPhoto == "" ? Colors.grey[300] : Colors.transparent
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
              "Judul Rencana Bacaan",
              style: GoogleFonts.nunito(
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 113, 9, 49)
                )
              ),
            ),
            const SizedBox(height: 5,),
            TextField(
              controller: ctr_judulrencana,
              cursorColor: Color(int.parse(globals.defaultcolor)),
              decoration: InputDecoration(
                fillColor: Colors.transparent,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Color(int.parse(globals.defaultcolor))
                  )
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1, 
                    color: Color(int.parse(globals.defaultcolor))
                  )
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Color(int.parse(globals.defaultcolor))
                  )
                ),
                contentPadding: const EdgeInsets.all(10),
                hintText: "Masukkan judul rencana bacaan ...",
                hintStyle: GoogleFonts.nunito(
                  fontSize: 18,
                  color: Colors.grey[400]
                )
              ),
              style: GoogleFonts.nunito(
                textStyle: const TextStyle(
                  fontSize: 18,
                  color: Colors.black
                )
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 25,),
            Text(
              "Deskripsi Rencana Bacaan",
              style: GoogleFonts.nunito(
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 113, 9, 49)
                )
              ),
            ),
            const SizedBox(height: 5,),
            TextField(
              controller: ctr_deskripsirencana,
              cursorColor: Color(int.parse(globals.defaultcolor)),
              decoration: InputDecoration(
                fillColor: Colors.transparent,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Color(int.parse(globals.defaultcolor))
                  )
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1, 
                    color: Color(int.parse(globals.defaultcolor))
                  )
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Color(int.parse(globals.defaultcolor))
                  )
                ),
                contentPadding: const EdgeInsets.all(10),
                hintText: "Masukkan deskripsi rencana bacaan ...",
                hintStyle: GoogleFonts.nunito(
                  fontSize: 18,
                  color: Colors.grey[400]
                )
              ),
              style: GoogleFonts.nunito(
                textStyle: const TextStyle(
                  fontSize: 18,
                  color: Colors.black
                )
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 25,),
            Row(
              children: [
                Text(
                  "Durasi",
                  style: GoogleFonts.nunito(
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 113, 9, 49)
                    )
                  ),
                ),
                const SizedBox(width: 10,),
                DropdownButton(
                  value: dropdownvalue,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(
                        items,
                        style: GoogleFonts.nunito(),
                      )
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                      for (int i = 0; i < dropdownvalue.length; i++) {
                        if (dropdownvalue[i] == " ") {
                          dayLength = int.parse(dropdownvalue[i-1]);
                          break;
                        }
                      }
                    });

                    int minus = 0;
                    int over = 0;

                    if (fields_judulrenungan.length < dayLength) {
                      minus = dayLength - fields_judulrenungan.length;

                      for (int i = 0; i <= minus-1; i++) {

                        final controller_judul = TextEditingController();
                        final field_judul = TextField(
                          controller: controller_judul,
                          cursorColor: Color(int.parse(globals.defaultcolor)),
                          decoration: InputDecoration(
                            fillColor: Colors.transparent,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: Color(int.parse(globals.defaultcolor))
                              )
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1, 
                                color: Color(int.parse(globals.defaultcolor))
                              )
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: Color(int.parse(globals.defaultcolor))
                              )
                            ),
                            contentPadding: const EdgeInsets.all(10),
                            hintText: "Judul Renungan ${ctr_judulrenungan.length + 1}",
                            hintStyle: GoogleFonts.nunito(
                              fontSize: 18,
                              color: Colors.grey[400]
                            )
                          ),
                          style: GoogleFonts.nunito(
                            textStyle: const TextStyle(
                              fontSize: 18,
                              color: Colors.black
                            )
                          ),
                          maxLines: 2,
                        );
                        
                        final controller_isi = TextEditingController();
                        final field_isi = TextField(
                          controller: controller_isi,
                          cursorColor: Color(int.parse(globals.defaultcolor)),
                          decoration: InputDecoration(
                            fillColor: Colors.transparent,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: Color(int.parse(globals.defaultcolor))
                              )
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1, 
                                color: Color(int.parse(globals.defaultcolor))
                              )
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: Color(int.parse(globals.defaultcolor))
                              )
                            ),
                            contentPadding: const EdgeInsets.all(10),
                            hintText: "Isi Renungan ${ctr_isirenungan.length + 1}",
                            hintStyle: GoogleFonts.nunito(
                              fontSize: 18,
                              color: Colors.grey[400]
                            )
                          ),
                          style: GoogleFonts.nunito(
                            textStyle: const TextStyle(
                              fontSize: 18,
                              color: Colors.black
                            )
                          ),
                          maxLines: 5,
                        );

                        final controller_ayat = TextEditingController();
                        final field_ayat = TextField(
                          controller: controller_ayat,
                          cursorColor: Color(int.parse(globals.defaultcolor)),
                          decoration: InputDecoration(
                            fillColor: Colors.transparent,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: Color(int.parse(globals.defaultcolor))
                              )
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1, 
                                color: Color(int.parse(globals.defaultcolor))
                              )
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: Color(int.parse(globals.defaultcolor))
                              )
                            ),
                            contentPadding: const EdgeInsets.all(10),
                            hintText: "Kejadian 1:1-5; Imamat 4:2",
                            hintStyle: GoogleFonts.nunito(
                              fontSize: 18,
                              color: Colors.grey[400]
                            )
                          ),
                          onChanged: (value) {
                          },
                          style: GoogleFonts.nunito(
                            textStyle: const TextStyle(
                              fontSize: 18,
                              color: Colors.black
                            )
                          ),
                          maxLines: 2,
                        );

                        final controller_link = TextEditingController();
                        final field_link = TextField(
                          controller: controller_link,
                          cursorColor: Color(int.parse(globals.defaultcolor)),
                          decoration: InputDecoration(
                            fillColor: Colors.transparent,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: Color(int.parse(globals.defaultcolor))
                              )
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1, 
                                color: Color(int.parse(globals.defaultcolor))
                              )
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: Color(int.parse(globals.defaultcolor))
                              )
                            ),
                            contentPadding: const EdgeInsets.all(10),
                            hintText: "Link Renungan ${ctr_linkrenungan.length + 1}",
                            hintStyle: GoogleFonts.nunito(
                              fontSize: 18,
                              color: Colors.grey[400]
                            )
                          ),
                          style: GoogleFonts.nunito(
                            textStyle: const TextStyle(
                              fontSize: 18,
                              color: Colors.black
                            )
                          ),
                          maxLines: 2,
                        );

                        setState(() {
                          ctr_judulrenungan.add(controller_judul);
                          fields_judulrenungan.add(field_judul);
                          ctr_isirenungan.add(controller_isi);
                          fields_isirenungan.add(field_isi);
                          ctr_ayatbacaan.add(controller_ayat);
                          fields_ayatbacaan.add(field_ayat);
                          ctr_linkrenungan.add(controller_link);
                          fields_linkrenungan.add(field_link);
                        });
                      }
                    } else if (fields_judulrenungan.length > dayLength) {
                      over = fields_judulrenungan.length - dayLength;
                      setState(() {
                        for (int i = 0; i <= over-1; i++) {
                          ctr_judulrenungan.removeLast();
                          fields_judulrenungan.removeLast();
                          ctr_isirenungan.removeLast();
                          fields_isirenungan.removeLast();
                          ctr_ayatbacaan.removeLast();
                          fields_ayatbacaan.removeLast();
                          ctr_linkrenungan.removeLast();
                          fields_linkrenungan.removeLast();
                        } 
                      });
                    }
                  },
                )
              ],
            ),
            dayLength != 0
            ? Column(
              children: [
                ListView.builder(
                  itemCount: dayLength,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(
                          height: 1,
                          color: Colors.black,
                        ),
                        const SizedBox(height: 20,),
                        Text(
                          "Hari ${index+1}",
                          style: GoogleFonts.nunito(
                            textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Color.fromARGB(255, 113, 9, 49)
                            )
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Text(
                          "Judul Renungan",
                          style: GoogleFonts.nunito(
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 113, 9, 49)
                            )
                          ),
                        ),
                        const SizedBox(height: 5,),
                        fields_judulrenungan[index],
                        const SizedBox(height: 25,),
                        Text(
                          "Isi Renungan",
                          style: GoogleFonts.nunito(
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 113, 9, 49)
                            )
                          ),
                        ),
                        const SizedBox(height: 5,),
                        fields_isirenungan[index],
                        const SizedBox(height: 25,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Kitab Bacaan",
                              style: GoogleFonts.nunito(
                                textStyle: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromARGB(255, 113, 9, 49)
                                )
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                _showDialogAyatBacaan(index);
                              }, 
                              icon: Icon(
                                Icons.zoom_out_map_rounded,
                                size: 25,
                                color: Color.fromARGB(255, 113, 9, 49),
                              )
                            )
                          ],
                        ),
                        const SizedBox(height: 5,),
                        fields_ayatbacaan[index],
                        const SizedBox(height: 25,),
                        Text(
                          "Link Renungan",
                          style: GoogleFonts.nunito(
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 113, 9, 49)
                            )
                          ),
                        ),
                        const SizedBox(height: 5,),
                        fields_linkrenungan[index],
                        const SizedBox(height: 35,),
                      ],
                    );
                  }
                ),
                const SizedBox(height: 30,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      SimpanInformasiRencana();
                    }, 
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(int.parse(globals.defaultcolor)),
                      elevation: 10,
                      padding: const EdgeInsets.all(5),
                    ),
                    child: Text(
                      "Simpan Rencana Bacaan",
                      style: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700
                        )
                      ),
                    )
                  ),
                ),
              ],
            )
            : Container()
          ],
        ),
      ),
    );
  }
}