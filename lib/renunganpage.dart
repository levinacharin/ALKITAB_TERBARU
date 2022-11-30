import 'dart:developer';
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import './global.dart' as globals;
import './detailrenungan.dart';
import './pecahAyatClass.dart';
import 'homepage.dart';

class RenunganPage extends StatefulWidget {
  final String status;
  final int index;
  final List? listHighlight;
  final String? darimana;
  const RenunganPage(
      {super.key,
      required this.status,
      required this.index,
      this.listHighlight,
      required this.darimana});

  @override
  State<RenunganPage> createState() => _RenunganPageState();
}


class _RenunganPageState extends State<RenunganPage> {
  DateTime date = DateTime.now();
  String tanggaldipilih = "";
  // ignore: non_constant_identifier_names
  TextEditingController ctr_judul = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController ctr_abacaan = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController ctr_aberkesan = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController ctr_renungan = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController ctr_tindakan = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController ctr_linkrenungan = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController ctr_tagline = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController ctr_popupabacaan = TextEditingController();
  String ayatdipilih = ""; // keluarin judul di form atas textfield highlight
  // ignore: non_constant_identifier_names
  String temp_ayatdipilih = "";
  // ignore: non_constant_identifier_names
  String text_highlight = "";
  // ignore: non_constant_identifier_names
  String isi_ayatdipilih = "";

  List alkitab_ = globals.alkitab;
  TextEditingController searchKitabController = TextEditingController();
  String hasil = "";
  String kitabPasal = "";
  // int jumlahdicari = 0;
  // int jumlahdicaribanding = 0;

  bool edited = true;

  List ayatbacaterpilih=[];

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
    bool sudahmasukangka = false;

    for (int i = 0; i < bacaan.length; i++) {
      tmp = tmp + bacaan[i];

      if (bacaan[i] == "," || bacaan[i] == "-" || bacaan[i] == ":") {
        if (bacaan[i] == "-" &&
          bacaan.codeUnitAt(i + 1) <= 122 &&
          bacaan.codeUnitAt(i + 1) >= 97) {
        //print("masuk skip");
      } else if (bacaan[i] == "-" &&
          bacaan.codeUnitAt(i + 1) <= 90 &&
          bacaan.codeUnitAt(i + 1) >= 65) {
        //print("masuk skip");
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
    while (stk.isNotEmpty) {
      Stacks tmp = PopStack(stk);
      String kitab = "";
      String pasal = "";
      String ayat = "";
      if (tmp.op == "*" && tmp.next == "^") {
        kitab = tmp.data;
        kitab = pembetulanNamaKitabUnik(kitab);
        //print("testing - $kitab");
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
    var tmp = alkitab_.asMap();

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

  // void addIsiAyat2( List<AyatN> ayatBaca, List<Bacaan> bacaanKitab, List<Kitab> alkitab) {
  //   for (int i = 0; i < bacaanKitab.length; i++) {
  //     String kitab = bacaanKitab.elementAt(i).kitab;
  //     int k = 0;
  //     for (int j = 0; j < alkitab.length; j++) {
  //       if (kitab == alkitab.elementAt(j).kitab) {
  //         break;
  //       }
  //       k++;
  //     }
  //     int count = i;
  //     while (count < bacaanKitab.length &&
  //         alkitab.elementAt(k).kitab == bacaanKitab.elementAt(count).kitab) {
  //       String pasal = bacaanKitab.elementAt(count).pasal;
  //       int pasalN = int.parse(pasal);
  //       while (count < bacaanKitab.length &&
  //           alkitab
  //                   .elementAt(k)
  //                   .listPasal
  //                   .elementAt(pasalN - 1)
  //                   .pasal
  //                   .toString() ==
  //               bacaanKitab.elementAt(count).pasal) {
  //         String ayat = bacaanKitab.elementAt(count).ayat;
  //         int ayatN = int.parse(ayat);
  //         int newAyat = ayatN;
  //         int ayatI = alkitab
  //             .elementAt(k)
  //             .listPasal
  //             .elementAt(pasalN - 1)
  //             .listAyat
  //             .elementAt(ayatN)
  //             .ayat;
  //         if (ayatI == 0) {
  //           ayatI = alkitab
  //               .elementAt(k)
  //               .listPasal
  //               .elementAt(pasalN - 1)
  //               .listAyat
  //               .elementAt(ayatN + 1)
  //               .ayat;
  //           newAyat = ayatI + 1;
  //         } else if (ayatN > ayatI) {
  //           newAyat = (ayatN - ayatI) + ayatN;
  //         } else if (ayatN > ayatI) {
  //           newAyat = (ayatN - ayatI) + ayatN;
  //         }
  //         String isi = alkitab
  //             .elementAt(k)
  //             .listPasal
  //             .elementAt(pasalN - 1)
  //             .listAyat
  //             .elementAt(newAyat)
  //             .isi;
  //         // ignore: unnecessary_new
  //         AyatN ayatBacaan = new AyatN(bacaanKitab.elementAt(count), isi);

  //         ayatBaca.add(ayatBacaan);
  //         count++;
  //       }
  //     }
  //     i = count - 1;
  //   }
  // }

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

  Future<void> listenTextFieldSearch(String darimana) async {
    setState(() async{
      hasil = "";
      getPecahAyat(darimana);
    });
    
  }

  void getPecahAyat(String darimana) async {
    
    
    bool udahgantikitab = true;
    String bacaan = ctr_abacaan.text.toString();
    String bacaancoba = bacaan;
    bacaancoba = bacaancoba.replaceAll(" ", "");
    String tempbacaan = "";

    for (int i = 0; i < bacaancoba.length; i++) {
      if (bacaan[i] == ";") {
        udahgantikitab = true;
      }
      tempbacaan = tempbacaan + bacaancoba[i];
      if (int.tryParse(bacaancoba[i]) == null &&
          int.tryParse(bacaancoba[i + 1]) != null &&
          bacaancoba[i] != ";" &&
          udahgantikitab == true) {
        // ignore: prefer_interpolation_to_compose_strings
        tempbacaan = tempbacaan + " ";
        udahgantikitab = false;
      }
    }

    bacaan = tempbacaan;

    var stk = InitStack();

    List<Bacaan> bacaanKitab = [];
    List<AyatN> ayatBaca = [];
    List<Kitab> alkitab = [];
    await setAlkitab2(alkitab);
    pecahAyat2(bacaan, stk);

    addBacaan(bacaanKitab, stk);
    // print("ada berapa yangdicari - $bacaanKitab");
    

    addIsiAyat2(ayatBaca, bacaanKitab, alkitab);
    hasil="";
    ayatbacaterpilih.clear();
    //print("\n");
    for (int i = 0; i < ayatBaca.length; i++) {
      // log("ayatbaca - ${ayatBaca.elementAt(i).bacaan.kitab +
      //       " " +
      //       ayatBaca.elementAt(i).bacaan.pasal +
      //       " : " +
      //       ayatBaca.elementAt(i).bacaan.ayat +
      //       "\n" +
      //       ayatBaca.elementAt(i).isi}");
      setState(() {
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
      });
    }

    setState(() {
      ctr_popupabacaan.text = hasil;
      ayatbacaterpilih = ayatBaca;
      //setTextAyatBerkesan();
      //updateAyatBerkesan(ayatbacaterpilih);

      // if(darimana=="showmydialog"){
      //   getPecahAyat("hem");
      log("hasile lak ws bener ini seh - $ayatbacaterpilih");
      //   //listenTextFieldSearch("hem");
      // }
      
    });

    
    //jumlahdicari=bacaanKitab.length;

    
  }

  @override
  void dispose() {
    ctr_judul.dispose();
    ctr_abacaan.dispose();
    ctr_aberkesan.dispose();
    ctr_renungan.dispose();
    ctr_tindakan.dispose();
    ctr_linkrenungan.dispose();
    ctr_tagline.dispose();
    ctr_popupabacaan.dispose();
    super.dispose();
  }

  

  List<cSelected> ayatberkesan=[];
  Future<void>unselectAyatBerkesan(String namakitab, String pasal, String ayat) async {
    //bool sudahada=false;
    late int indexdihapus;
    if(ayatberkesan.isNotEmpty){
      for(int i=0;i<ayatberkesan.length;i++){
        if(ayatberkesan[i].getnamakitab==namakitab && ayatberkesan[i].getindexpasal==int.parse(pasal) && ayatberkesan[i].getindexayat==int.parse(ayat)){
          //sudahada=true;
          indexdihapus=i;
          break;
        }
      }

      ayatberkesan.removeAt(indexdihapus);

      

      await setTextAyatBerkesan();
    }

    // for(int i=0;i<ayatberkesan.length;i++){
    //   log("berhasil $i - ${ayatberkesan[i].getnamakitab} ${ayatberkesan[i].getindexpasal} ${ayatberkesan[i].getindexayat}");
    // }

    
  }
  Future<void> selectAyatBerkesan(String namakitab, String pasal, String ayat, String isi, int ayatasli) async {
    log("bukan ayataslii - $ayat");
    log("ayataslii - $ayatasli");
  //   List? tempaja = widget.listHighlight;
  //   int ayatasli = 0;

  // //    int? indxKitab;
  // // int? indxPasal;
  // // int? indxAyat;
  // // Color? indxColor;
  // // String? konten;
  // // String? namaKitab;
  // // int? ayatAsli;

  //   for(int i=0;i<tempaja!.length;i++){
  //     if(tempaja[i].namaKitab == namakitab && tempaja[i].indxPasal == int.parse(pasal) && tempaja[i].indxAyat == int.parse(ayat) && tempaja[i].konten == isi){
  //       ayatasli = tempaja[i].ayatAsli;
  //     }
  //   }
    // if(reset==true){
    //   ayatberkesan.clear();
    // }
    // ignore: non_constant_identifier_names
    cSelected SelectedC = cSelected();
    bool sudahada=false;
    if(ayatberkesan.isEmpty){
      SelectedC.namaKitab = namakitab;
      SelectedC.indxPasal = int.parse(pasal);
      SelectedC.indxAyat = int.parse(ayat);
      SelectedC.konten = isi;
      SelectedC.ayatAsli = ayatasli;
      ayatberkesan.add(SelectedC);
    }else{
      for(int i=0;i<ayatberkesan.length;i++){
        if(ayatberkesan[i].getnamakitab==namakitab && ayatberkesan[i].getindexpasal==int.parse(pasal) && ayatberkesan[i].getindexayat==int.parse(ayat)){
          sudahada=true;
          break;
        }
      }

      if(sudahada==false){
          SelectedC.namaKitab = namakitab;
          SelectedC.indxPasal = int.parse(pasal);
          SelectedC.indxAyat = int.parse(ayat);
          SelectedC.konten = isi;
          SelectedC.ayatAsli = ayatasli;
          ayatberkesan.add(SelectedC);
      }
    }

    // for(int i=0;i<ayatberkesan.length;i++){
    //   log("berhasil $i - ${ayatberkesan[i].getnamakitab} ${ayatberkesan[i].getindexpasal} ${ayatberkesan[i].getindexayat}");
    // }

    await setTextAyatBerkesan();
  }

  bool adadilistayatberkesan(String namakitab, String pasal, String ayat){
    bool adapaga=false;
    for(int i=0;i<ayatberkesan.length;i++){
        if(ayatberkesan[i].getnamakitab==namakitab && ayatberkesan[i].getindexpasal==int.parse(pasal) && ayatberkesan[i].getayatasli==int.parse(ayat)){
          adapaga=true;
          break;
        }
      }

    return adapaga;
  }

  Future<void> setTextAyatBerkesan()async{
    //log("onchanged - $ayatberkesan");
    if (ayatberkesan.isNotEmpty) {
      //SORTING
      ayatberkesan.sort((a, b) {
        return a.getindexpasal!.compareTo(b.getindexpasal!.toInt());
      });

      List<cSelected> listhighlightsementara = [];
      List<cSelected> listperpasal = [];

      int pasal = ayatberkesan[0].getindexpasal!.toInt();

      for (int i = 0; i < ayatberkesan.length; i++) {
        if (pasal == ayatberkesan[i].getindexpasal &&
            i != ayatberkesan.length - 1) {
          listperpasal.add(ayatberkesan[i]);
        } else {
          if (i == ayatberkesan.length - 1) {
            listperpasal.add(ayatberkesan[i]);
            listperpasal.sort((a, b) {
              return a.getindexayat!.compareTo(b.getindexayat!.toInt());
            });
            listhighlightsementara.addAll(listperpasal);
          } else {
            listperpasal.sort((a, b) {
              return a.getindexayat!.compareTo(b.getindexayat!.toInt());
            });
            listhighlightsementara.addAll(listperpasal);
            pasal = ayatberkesan[i].getindexpasal!.toInt();
            listperpasal.clear();
            listperpasal.add(ayatberkesan[i]);
          }
        }
      }

      setState(() {
        ayatberkesan = listhighlightsementara;
      });

      //END OF SORTING
    }

    String hemtexthighlight="";
    bool ganti=true;
    bool gantikitab = false;

    for (int i = 0; i < ayatberkesan.length; i++) {
      if(ganti==true){
            gantikitab=true;
            if (i != 0) {
              // ignore: prefer_interpolation_to_compose_strings
              hemtexthighlight = hemtexthighlight + "\n\n";
            }

        
          }else{
            gantikitab=false;
            
          }

          if (i != ayatberkesan.length - 1) {
          if (ayatberkesan[i].getnamakitab !=
                  ayatberkesan[i + 1].getnamakitab ||
              ayatberkesan[i].getindexpasal !=
                  ayatberkesan[i + 1].getindexpasal) {
            ganti = true;
          } else {
            ganti = false;
          }
        }
        
          if(gantikitab==true){
              // ignore: prefer_interpolation_to_compose_strings
              hemtexthighlight = hemtexthighlight +ayatberkesan[i].getnamakitab.toString()+ ' '+(ayatberkesan[i].getindexpasal).toString()+"\n"+((ayatberkesan[i].getayatasli)).toString() + '. ' + ayatberkesan[i].getkonten.toString() + ' ';
            }else{
              // ignore: prefer_interpolation_to_compose_strings
              hemtexthighlight = hemtexthighlight + ((ayatberkesan[i].getayatasli)).toString() + '. ' + ayatberkesan[i].getkonten.toString() + ' ';

            }
          
    }

    setState(() {
      ctr_aberkesan.text=hemtexthighlight;
    });
  }

  Future<void> updateAyatBerkesan(List listbacaan) async {
    List? selectedAyat = listbacaan;

    if (listbacaan.isNotEmpty) {
      //SORTING
      selectedAyat.sort((a, b) {
        return a.getindexpasal.compareTo(b.getindexpasal);
      });

      List? listhighlightsementara = [];
      List? listperpasal = [];

      int pasal = selectedAyat[0].getindexpasal;

      for (int i = 0; i < selectedAyat.length; i++) {
        if (pasal == selectedAyat[i].getindexpasal &&
            i != selectedAyat.length - 1) {
          listperpasal.add(selectedAyat[i]);
        } else {
          if (i == selectedAyat.length - 1) {
            listperpasal.add(selectedAyat[i]);
            listperpasal.sort((a, b) {
              return a.getindexayat.compareTo(b.getindexayat);
            });
            listhighlightsementara.addAll(listperpasal);
          } else {
            listperpasal.sort((a, b) {
              return a.getindexayat.compareTo(b.getindexayat);
            });
            listhighlightsementara.addAll(listperpasal);
            pasal = selectedAyat[i].getindexpasal;
            listperpasal.clear();
            listperpasal.add(selectedAyat[i]);
          }
        }
      }

      setState(() {
        selectedAyat = listhighlightsementara;
      });

      //END OF SORTING
    }
    ayatberkesan.clear();
    for (int i = 0; i < selectedAyat!.length; i++) {
      if (selectedAyat!.isNotEmpty) {
        // selectAyatBerkesan(
        //     selectedAyat![i].getnamakitab,
        //     (selectedAyat![i].getindexpasal + 1).toString(),
        //     (selectedAyat![i].getindexayat).toString(),
        //     selectedAyat![i].getkonten);

        selectAyatBerkesan(
            selectedAyat![i].getnamakitab,
            (selectedAyat![i].getindexpasal + 1).toString(),
            (selectedAyat![i].getindexayat).toString(),
            selectedAyat![i].getkonten,
            selectedAyat![i].getayatasli);
      }
    }

    //await setTextAyatBerkesan();
  }

  
  @override
  void initState() {
    super.initState();

    tanggaldipilih = "${date.day}/${date.month}/${date.year}";
    if (widget.status == 'edit') {
      updateData();
      edited = false;
    } else if (widget.status == 'tambah') {
      edited = true;
    }

    
  List? selectedAyat = widget.listHighlight;
  List ayatpilihantemp = [];
  String tempneh="";
  
    
    //String kitabPasal="";

    if (widget.darimana == "homepage") {
      if(widget.listHighlight!.isNotEmpty){
      

      //SORTING
      selectedAyat!.sort((a, b) {
        return a.getindexpasal.compareTo(b.getindexpasal);
      });

      List? listhighlightsementara=[];
      List? listperpasal=[];

      int pasal= selectedAyat[0].getindexpasal;
      
      for(int i=0;i<selectedAyat.length;i++){
        if(pasal==selectedAyat[i].getindexpasal && i!=selectedAyat.length-1){
          listperpasal.add(selectedAyat[i]);
        }else{
          if (i == selectedAyat.length - 1) {
              listperpasal.add(selectedAyat[i]);
              listperpasal.sort((a, b) {
                return a.getindexayat.compareTo(b.getindexayat);
              });
              listhighlightsementara.addAll(listperpasal);
            } else {
              listperpasal.sort((a, b) {
                return a.getindexayat.compareTo(b.getindexayat);
              });
              listhighlightsementara.addAll(listperpasal);
              pasal = selectedAyat[i].getindexpasal;
              listperpasal.clear();
              listperpasal.add(selectedAyat[i]);
            }
          


          
        }


      }

      setState(() {
        selectedAyat = listhighlightsementara;
      });
    
    //END OF SORTING
    }


    bool ganti=true;
    bool gantikitab = false;
      // print("data catatan - masuk sini");
      updateAyatBerkesan(selectedAyat!);
      for (int i = 0; i < selectedAyat!.length; i++) {

        if(i==selectedAyat!.length-1 && selectedAyat!.length!=1){
          ayatpilihantemp.add(selectedAyat![i].getayatasli);
          
         log("keluar hasil split if awal - $ayatpilihantemp");
            bool udahdash = false;
            for (int h = 0; h < ayatpilihantemp.length; h++) {
              if (h == 0) {
                tempneh = tempneh + ayatpilihantemp[h].toString();
              } else if (ayatpilihantemp[h] - ayatpilihantemp[h - 1] != 1) {
                if (udahdash == true) {
                  tempneh = tempneh +
                      ayatpilihantemp[h - 1].toString() +
                      "," +
                      ayatpilihantemp[h].toString();
                  udahdash = false;
                } else {
                  tempneh = tempneh + "," + ayatpilihantemp[h].toString();
                }
              } else if (ayatpilihantemp[h] - ayatpilihantemp[h - 1] == 1) {
               
                if (udahdash == false) {
                  if (h == (ayatpilihantemp.length - 1)) {
                    tempneh = tempneh + "-" + ayatpilihantemp[h].toString();
                    //udahdash = true;
                  } else {
                    tempneh = tempneh + "-";
                    udahdash = true;
                    continue;
                  }
                }else{
                  if (h == (ayatpilihantemp.length - 1)) {
                    tempneh = tempneh +ayatpilihantemp[h].toString();
                    //udahdash = true;
                  }else {
                    
                    continue;
                  }

                }
                
              }
            }

            log("keluar hasil split akhir $tempneh");
            ayatpilihantemp.clear();
            ayatdipilih = ayatdipilih + tempneh;
            // kitabPasal = "$kitabPasal$tempneh";
            tempneh="";
        }
        // if(selectedAyat!.isNotEmpty){
        //   selectAyatBerkesan(selectedAyat![i].getnamakitab,(selectedAyat![i].getindexpasal+1).toString(),(selectedAyat![i].getindexayat).toString(),selectedAyat![i].getkonten);

        // }
        
        // ignore: prefer_interpolation_to_compose_strings
        isi_ayatdipilih = isi_ayatdipilih +
            '[' +
            selectedAyat![i].getayatasli.toString() +
            "] " +
            selectedAyat![i].getkonten.toString() +
            "\n";
        // text_highlight = text_highlight + selectedAyat[i].getnamakitab + ' ' + ((selectedAyat[i].getindexpasal) + 1).toString() + ' : ' + ((selectedAyat[i].getindexayat)).toString() +'\n'+selectedAyat[i].getkonten +"\n";

          if(ganti==true){
            gantikitab=true;
            temp_ayatdipilih = selectedAyat![i].getnamakitab +
              ' ' +
              ((selectedAyat![i].getindexpasal) + 1).toString() +
              ':' 
              // +
              // ((selectedAyat![i].getayatasli)).toString()
              ;
              if(i==selectedAyat!.length-1 && selectedAyat!.length==1){
                temp_ayatdipilih = "$temp_ayatdipilih${selectedAyat![i].getayatasli}";
              }
              

          }else{
            gantikitab=false;
            // kitabPasal =
            //   kitabPasal + ',' + ((selectedAyat![i].getindexayat)).toString();
            // ignore: prefer_interpolation_to_compose_strings
            // temp_ayatdipilih = ', '+((selectedAyat![i].getayatasli)).toString();
          }

          if (i != selectedAyat!.length - 1) {
          if (selectedAyat![i].getnamakitab !=
                  selectedAyat![i + 1].getnamakitab ||
              selectedAyat![i].getindexpasal !=
                  selectedAyat![i + 1].getindexpasal) {
            ganti = true;
          } else {
            ganti = false;
          }
        }
        
          // if(gantikitab==true){
          //     hemtexthighlight = hemtexthighlight +selectedAyat![i].getnamakitab+ ' '+((selectedAyat![i].getindexpasal)+1).toString()+"\n"+((selectedAyat![i].getindexayat)).toString() + '. ' + selectedAyat![i].getkonten + ' ';
          //   }else{
          //     hemtexthighlight = hemtexthighlight + ((selectedAyat![i].getindexayat)).toString() + '. ' + selectedAyat![i].getkonten + ' ';

          //   }
          
          


        if (ayatdipilih.isNotEmpty) {
            if(gantikitab==true){
              log("keluar hasil split if awal - $ayatpilihantemp");
            bool udahdash = false;
            for (int h = 0; h < ayatpilihantemp.length; h++) {
              if (h == 0) {
                tempneh = tempneh + ayatpilihantemp[h].toString();
              } else if (ayatpilihantemp[h] - ayatpilihantemp[h - 1] != 1) {
                if (udahdash == true) {
                  tempneh = tempneh +
                      ayatpilihantemp[h - 1].toString() +
                      "," +
                      ayatpilihantemp[h].toString();
                  udahdash = false;
                } else {
                  tempneh = tempneh + "," + ayatpilihantemp[h].toString();
                }
              } else if (ayatpilihantemp[h] - ayatpilihantemp[h - 1] == 1) {
               
                if (udahdash == false) {
                  if (h == (ayatpilihantemp.length - 1)) {
                    tempneh = tempneh + "-" + ayatpilihantemp[h].toString();
                    //udahdash = true;
                  } else {
                    tempneh = tempneh + "-";
                    udahdash = true;
                    continue;
                  }
                }else{
                  if (h == (ayatpilihantemp.length - 1)) {
                    tempneh = tempneh +ayatpilihantemp[h].toString();
                    //udahdash = true;
                  }else {
                    
                    continue;
                  }

                }
                
              }
            }

            log("keluar hasil split akhir $tempneh");
            ayatpilihantemp.clear();
            ayatdipilih = ayatdipilih + tempneh+"; " + temp_ayatdipilih;
            // kitabPasal = "$kitabPasal$tempneh";
            tempneh="";
              // ignore: prefer_interpolation_to_compose_strings
              
            }
            // else{
            //   ayatdipilih = ayatdipilih + temp_ayatdipilih;

            // }
            

          } else {
            ayatdipilih = temp_ayatdipilih;
          }

          ayatpilihantemp.add(selectedAyat![i].getayatasli);

          
      }


      setState(() {
        text_highlight =
            // ignore: prefer_interpolation_to_compose_strings
            text_highlight + ayatdipilih + "\n" + '\n' 
            // + isi_ayatdipilih
            ;
            //log("data renungan b : $text_highlight");
        //prosesListhighlightJadiRange(ayatdipilih);
        ctr_abacaan.text = ayatdipilih;
        //log("ayatdipilih - $text_highlight");
        log("keluar hasil akhir - $text_highlight");


        
      });

      listenTextFieldSearch("initstate");
    setState(() {
      ctr_popupabacaan.text = hasil;
    });

    }
    
  }

  // SERVICES FILE JSON TEXT
  String dataRenungan = '';
  List listTempData = [];

  void  writeData() async {
    var temp = ""; // temp bacaan
    // ignore: non_constant_identifier_names
    var temp_berkesan = "";
    // read data proses
    String path = '/storage/emulated/0/Download/Alkitab Renungan Mobile/Renunganjson.txt';
    bool directoryExists = await Directory(path).exists();
    bool fileExists = await File(path).exists();

    if (directoryExists || fileExists) {
      final contents = await File(path).readAsString();
      listTempData = []; //reset dulu
      setState(() {
        if (contents.isNotEmpty) {
          listTempData = json.decode(contents);

          for (int i = 0; i < listTempData.length; i++) {
            listTempData[i]['Ayat Bacaan'] = listTempData[i]['Ayat Bacaan']
                .toString()
                .replaceAll("<br>", "\n");
            listTempData[i]['Ayat Berkesan'] = listTempData[i]['Ayat Berkesan']
                .toString()
                .replaceAll("<br>", "\n");
          }
        }
      });
    }
    // end of read data proses

    // make json and add to string
    dataRenungan = ''; // reset string

    // ignore: prefer_interpolation_to_compose_strings
    dataRenungan = dataRenungan + "[";
    if (widget.status == 'tambah') {
      if (widget.darimana == 'addfromlistrenungan' || widget.darimana == 'homepage') {
        text_highlight = '';
        ayatdipilih = '';
        isi_ayatdipilih = '';
        bool getkitab = false;

        for (int i = 0; i < ctr_abacaan.text.length; i++) {
          if (ctr_abacaan.text[i] == "\n") {
            getkitab = true;
          }

          if (getkitab == false) {
            ayatdipilih= ayatdipilih + ctr_abacaan.text[i];
          } else if (getkitab == true) {
            isi_ayatdipilih = isi_ayatdipilih + ctr_abacaan.text[i];
          }
        }
        // ignore: prefer_interpolation_to_compose_strings
        text_highlight = text_highlight + ayatdipilih + "\n" + isi_ayatdipilih;
      }

      if (listTempData.isNotEmpty) {
        for (int i = 0; i < listTempData.length; i++) {
          globals.lastIdRenunganUser = int.parse(listTempData[i]['Id Renungan User']);
          listTempData[i]['Ayat Bacaan'] = listTempData[i]['Ayat Bacaan']
              .toString()
              .replaceAll('"', '${String.fromCharCode(92)}"');
          listTempData[i]['Ayat Berkesan'] = listTempData[i]['Ayat Berkesan']
              .toString()
              .replaceAll('"', '${String.fromCharCode(92)}"');
          // ignore: prefer_interpolation_to_compose_strings
          dataRenungan = dataRenungan + "{";
          // ignore: prefer_interpolation_to_compose_strings
          dataRenungan = dataRenungan +
              '"Id Renungan User":"'+
              listTempData[i]['Id Renungan User'].toString() +
              '","Id Renungan Komunitas":"' +
              listTempData[i]['Id Renungan Komunitas'].toString() +
              '","Nama Komunitas":"' +
              listTempData[i]['Nama Komunitas'] +
              '","Tanggal":"' +
              listTempData[i]['Tanggal'].toString() +
              '","Judul":"' +
              listTempData[i]['Judul'].toString() +
              '","Kitab":"' +
              listTempData[i]['Kitab'].toString() +
              '","Ayat Bacaan":"' +
              listTempData[i]['Ayat Bacaan'].toString() +
              '","Ayat Berkesan":"' +
              listTempData[i]['Ayat Berkesan'].toString() +
              '","Isi Renungan":"' +
              listTempData[i]['Isi Renungan'].toString() +
              '","Tindakan Saya":"' +
              listTempData[i]['Tindakan Saya'].toString() +
              '","Link Renungan":"' +
              listTempData[i]['Link Renungan'].toString() + 
              '","Tagline":"' +
              listTempData[i]['Tagline'].toString() +
              '"}' +
              ",";
        }
        globals.lastIdRenunganUser = globals.lastIdRenunganUser + 1;
      }
      temp = text_highlight.replaceAll('"', '${String.fromCharCode(92)}"');
      temp_berkesan = ctr_aberkesan.text.replaceAll('"', '${String.fromCharCode(92)}"');
      // ignore: prefer_interpolation_to_compose_strings
      dataRenungan = dataRenungan +
          "{" +
          '"Id Renungan User":"' +
          globals.lastIdRenunganUser.toString() +
          '","Id Renungan Komunitas":"'+
          "0"+
          '","Nama Komunitas":"' +
          "Pribadi" +
          '","Tanggal":"' +
          tanggaldipilih +
          '","Judul":"' +
          ctr_judul.text +
          '","Kitab":"' +
          ctr_abacaan.text +
          '","Ayat Bacaan":"' +
          temp +
          '","Ayat Berkesan":"' +
          temp_berkesan +
          '","Isi Renungan":"' +
          ctr_renungan.text +
          '","Tindakan Saya":"' +
          ctr_tindakan.text +
          '","Link Renungan":"'+
          ctr_linkrenungan.text +
          '","Tagline":"' +
          ctr_tagline.text +
          '"}';
    } else if (widget.status == 'edit') {
      if (widget.darimana == 'listrenungan') {
        text_highlight = '';
        ayatdipilih = '';
        isi_ayatdipilih = '';
        bool getkitab = false;

        for (int i = 0; i < ctr_abacaan.text.length; i++) {
          if (ctr_abacaan.text[i] == "\n") {
            getkitab = true;
          }

          if (getkitab == false) {
            ayatdipilih= ayatdipilih + ctr_abacaan.text[i];
          } else if (getkitab == true) {
            isi_ayatdipilih = isi_ayatdipilih + ctr_abacaan.text[i];
          }
        }
        // ignore: prefer_interpolation_to_compose_strings
        text_highlight = text_highlight + ayatdipilih + "\n" + isi_ayatdipilih;
        print("data th: $ayatdipilih");

        listTempData[widget.index]['Tanggal'] = tanggaldipilih;
        listTempData[widget.index]['Judul'] = ctr_judul.text.toString();
        listTempData[widget.index]['Kitab'] = ctr_abacaan.text.toString();
        listTempData[widget.index]['Ayat Bacaan'] = text_highlight;
        listTempData[widget.index]['Ayat Berkesan'] = ctr_aberkesan.text.toString();
        listTempData[widget.index]['Isi Renungan'] = ctr_renungan.text.toString();
        listTempData[widget.index]['Tindakan Saya'] = ctr_tindakan.text.toString();
        listTempData[widget.index]['Link Renungan'] = ctr_linkrenungan.text.toString();
        listTempData[widget.index]['Tagline'] = ctr_tagline.text.toString();
      } else if (widget.darimana == 'detailrenungan') {
        text_highlight = '';
        ayatdipilih = '';
        isi_ayatdipilih = '';
        bool getkitab = false;

        for (int i = 0; i < ctr_abacaan.text.length; i++) {
          if (ctr_abacaan.text[i] == "\n") {
            getkitab = true;
          }

          if (getkitab == false) {
            ayatdipilih= ayatdipilih + ctr_abacaan.text[i];
          } else if (getkitab == true) {
            isi_ayatdipilih = isi_ayatdipilih + ctr_abacaan.text[i];
          }
        }
        // ignore: prefer_interpolation_to_compose_strings
        text_highlight = text_highlight + ayatdipilih + "\n" + isi_ayatdipilih;
        print("data th: $ayatdipilih");

        listTempData[index]['Tanggal'] = tanggaldipilih;
        listTempData[index]['Judul'] = ctr_judul.text.toString();
        listTempData[index]['Kitab'] = ctr_abacaan.text.toString();
        listTempData[index]['Ayat Bacaan'] = text_highlight;
        listTempData[index]['Ayat Berkesan'] = ctr_aberkesan.text.toString();
        listTempData[index]['Isi Renungan'] = ctr_renungan.text.toString();
        listTempData[index]['Tindakan Saya'] = ctr_tindakan.text.toString();
        listTempData[index]['Link Renungan'] = ctr_linkrenungan.text.toString();
        listTempData[index]['Tagline'] = ctr_tagline.text.toString();
      }

      for (int i = 0; i < listTempData.length; i++) {
        listTempData[i]['Ayat Bacaan'] = listTempData[i]['Ayat Bacaan']
            .toString()
            .replaceAll('"', '${String.fromCharCode(92)}"');
        listTempData[i]['Ayat Berkesan'] = listTempData[i]['Ayat Berkesan']
            .toString()
            .replaceAll('"', '${String.fromCharCode(92)}"');
        // ignore: prefer_interpolation_to_compose_strings
        dataRenungan = dataRenungan + "{";
        // ignore: prefer_interpolation_to_compose_strings
        dataRenungan = dataRenungan +
            '"Id Renungan User":"' +
            listTempData[i]['Id Renungan User'].toString() +
            '","Id Renungan Komunitas":"' +
            listTempData[i]['Id Renungan Komunitas'].toString() +
            '","Nama Komunitas":"' +
            listTempData[i]['Nama Komunitas'] +
            '","Tanggal":"' +
            listTempData[i]['Tanggal'].toString() +
            '","Judul":"' +
            listTempData[i]['Judul'].toString() +
            '","Kitab":"' +
            listTempData[i]['Kitab'].toString() +
            '","Ayat Bacaan":"' +
            listTempData[i]['Ayat Bacaan'].toString() +
            '","Ayat Berkesan":"' +
            listTempData[i]['Ayat Berkesan'].toString() +
            '","Isi Renungan":"' +
            listTempData[i]['Isi Renungan'].toString() +
            '","Tindakan Saya":"' +
            listTempData[i]['Tindakan Saya'].toString() +
            '","Link Renungan":"' +
            listTempData[i]['Link Renungan'].toString() +
            '","Tagline":"' +
            listTempData[i]['Tagline'].toString() +
            '"}';
        if (listTempData.length != 1 && i != listTempData.length - 1) {
          // ignore: prefer_interpolation_to_compose_strings
          dataRenungan = dataRenungan + ',';
        }
      }
    }
    // ignore: prefer_interpolation_to_compose_strings
    dataRenungan = dataRenungan + "]";
    dataRenungan = dataRenungan.replaceAll("\n", "<br>");
    // end of add json to string

    // write string of json to local file
    File(path).writeAsString(dataRenungan);

    if (widget.darimana == "detailrenungan") {
      // ignore: use_build_context_synchronously
      Navigator.pop(context, "refresh");
    } else if (widget.darimana == "listrenungan") {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => DetailRenungan(id: int.parse(listTempData[widget.index]['Id Renungan User']), shoulpop: "false", darimana: widget.darimana,))
      );
    } else if (widget.darimana == "homepage" || widget.darimana == "addfromlistrenungan") {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => DetailRenungan(id: globals.lastIdRenunganUser, shoulpop: "false", darimana: widget.darimana,))
      );
    }

    // ignore: use_build_context_synchronously
    // Navigator.push(
    //   context, 
    //   MaterialPageRoute(builder: (context) =>  DetailRenungan(id: globals.lastIdRenunganUser, shoulpop: "false"))
    // );
  }

  int index = 0; // buat bisa write data kalo dari detail renungan
  void updateData() async {
    // read data proses
    String path = '/storage/emulated/0/Download/Alkitab Renungan Mobile/Renunganjson.txt';
    bool directoryExists = await Directory(path).exists();
    bool fileExists = await File(path).exists();
    if (directoryExists || fileExists) {
      final contents = await File(path).readAsString();
      listTempData = []; //reset dulu
      setState(() {
        if (contents.isNotEmpty) {
          listTempData = json.decode(contents);
        }
      });
    }
    // end of read data proses
    
    if (widget.darimana == "listrenungan") {
      setState(() {
        tanggaldipilih = listTempData[widget.index]['Tanggal'].toString();
        ctr_judul.text = listTempData[widget.index]['Judul'].toString();
        ctr_abacaan.text = listTempData[widget.index]['Kitab'].toString();
        ctr_popupabacaan.text = listTempData[widget.index]['Ayat Bacaan']
            .toString()
            .replaceAll("<br>", "\n");
        ctr_aberkesan.text = listTempData[widget.index]['Ayat Berkesan']
            .toString()
            .toString()
            .replaceAll("<br>", "\n");
        ctr_renungan.text = listTempData[widget.index]['Isi Renungan'].toString();
        ctr_tindakan.text = listTempData[widget.index]['Tindakan Saya'].toString();
        ctr_linkrenungan.text = listTempData[widget.index]['Link Renungan'].toString();
        ctr_tagline.text = listTempData[widget.index]['Tagline'].toString();
      });
    } else if (widget.darimana == "detailrenungan") {
      for (int i = 0; i < listTempData.length; i++) {
        if (listTempData[i]['Id Renungan User'] == widget.index.toString()) {
          index = i;
          tanggaldipilih = listTempData[i]['Tanggal'].toString();
          ctr_judul.text = listTempData[i]['Judul'].toString();
          ctr_abacaan.text = listTempData[i]['Kitab'].toString();
          ctr_popupabacaan.text = listTempData[i]['Ayat Bacaan']
              .toString()
              .replaceAll("<br>", "\n");
          ctr_aberkesan.text = listTempData[i]['Ayat Berkesan']
              .toString()
              .toString()
              .replaceAll("<br>", "\n");
          ctr_renungan.text = listTempData[i]['Isi Renungan'].toString();
          ctr_tindakan.text = listTempData[i]['Tindakan Saya'].toString();
          ctr_linkrenungan.text = listTempData[i]['Link Renungan'].toString();
          ctr_tagline.text = listTempData[i]['Tagline'].toString();
        }
      }
    }
  }
  // END OF SERVICES
  
  
  Future<void> _showMyDialog() async {
    //hasil="";
    getPecahAyat("showmydialog");
    log("apasih - ${ayatbacaterpilih.length}");
    return showDialog(
      context: context,
      barrierDismissible: true, // user must tap button!
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
                          edited == true ? "Ayat Bacaan*" : "Ayat Bacaan",
                          style: GoogleFonts.nunito(
                              textStyle: const TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 113, 9, 49))),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.cancel_outlined,
                            color: Color.fromARGB(255, 113, 9, 49),
                          ))
                    ],
                  ),
                ],
              );
              }
              
            ),
            content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              // ignore: sized_box_for_whitespace
              return Container(
                      
                width: double.maxFinite,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // ignore: avoid_unnecessary_containers
                      Container(
                      child: TextField(
                        controller: ctr_abacaan,
                        // ignore: non_constant_identifier_names
                        onChanged: (ctr_abacaan) async {
                          if (ctr_abacaan.isNotEmpty) {
                            setState(() {
                              //await listenTextFieldSearch("showmydialog");
                              getPecahAyat("showmydialog");
                              //_showMyDialog();
                            });
                          } else {
                            setState(() {
                              ayatbacaterpilih.clear();
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
                                color: Color(int.parse(globals.defaultcolor))),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1,
                                color: Color(int.parse(globals.defaultcolor))),
                          ),
                          disabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1, color: Colors.grey 
                            )
                          ),
                          enabled: edited,
                          hintText: "Kejadian 1:1; Keluaran 1:1",
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          contentPadding: const EdgeInsets.all(10),
                        ),
                        style: const TextStyle(
                            height: 1.5,
                            fontSize: 14,
                            color: Color.fromARGB(255, 61, 61, 61)),
                        maxLines: 2,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(10)),
                      ListView.builder(
                          itemCount: ayatbacaterpilih.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                              color: (adadilistayatberkesan(ayatbacaterpilih.elementAt(index).bacaan.kitab,ayatbacaterpilih.elementAt(index).bacaan.pasal,ayatbacaterpilih.elementAt(index).bacaan.ayat) ==
                                      true)
                                  ? Colors.blue.withOpacity(0.25)
                                  : Colors.transparent,
                            ),
                              child: ListTile(
                                onTap: () {
                                  selectAyatBerkesan(ayatbacaterpilih.elementAt(index).bacaan.kitab,ayatbacaterpilih.elementAt(index).bacaan.pasal,ayatbacaterpilih.elementAt(index).bacaan.ayat,ayatbacaterpilih.elementAt(index).isi,int.parse(ayatbacaterpilih.elementAt(index).bacaan.ayat));
                                  Navigator.pop(context);
                                  _showMyDialog();
                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //     SnackBar(
                                  //       content: Text(
                                  //           '${ayatbacaterpilih.elementAt(index).bacaan.kitab} ${ayatbacaterpilih.elementAt(index).bacaan.pasal} ${ayatbacaterpilih.elementAt(index).bacaan.ayat}'),
                                  //     ),
                                  //   );
                                  
                              
                                },
                                onLongPress: (){
                                  unselectAyatBerkesan(ayatbacaterpilih.elementAt(index).bacaan.kitab,ayatbacaterpilih.elementAt(index).bacaan.pasal,ayatbacaterpilih.elementAt(index).bacaan.ayat);
                                  Navigator.pop(context);
                                  _showMyDialog();
                                },
                                  subtitle: Text(
                                      "${ayatbacaterpilih.elementAt(index).bacaan.kitab + " " + ayatbacaterpilih.elementAt(index).bacaan.pasal + " : " + ayatbacaterpilih.elementAt(index).bacaan.ayat + "\n" + ayatbacaterpilih.elementAt(index).isi}")),
                            );
                          }),
                    ],
                  ),
                ),
              );
            }));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.status == 'tambah' ? "Tambah Renungan" : "Edit Renungan",
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 24,
                    color: Color.fromARGB(255, 113, 9, 49),
                    fontWeight: FontWeight.bold
                  )
                )
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                edited == true ? "Tanggal*" : "Tanggal",
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 113, 9, 49)
                  )
                )
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: edited == true 
                        ? Color(int.parse(globals.defaultcolor))
                        : Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.transparent,
                    ),
                    child: edited == true
                    ? IconButton(
                      onPressed: () async {
                        DateTime? newDate = await showDatePicker(
                            context: context,
                            initialDate: date,
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100));
  
                        if (newDate == null) return;
                        setState(() {
                          date = newDate;
                          tanggaldipilih =
                              "${date.day}/${date.month}/${date.year}";
                        });
                      },
                      icon: Icon(
                        Icons.calendar_today_rounded,
                        size: 30,
                        color: Color(int.parse(globals.defaultcolor)),
                      )
                    )
                    : Icon(
                        Icons.calendar_today_rounded,
                        size: 30,
                        color: Color(int.parse(globals.defaultcolor)),
                      ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: edited == true
                          ? Color(int.parse(globals.defaultcolor))
                          : Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.transparent
                      ),
                      child: Text(
                        tanggaldipilih,
                        style: GoogleFonts.nunito(
                          textStyle: const TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 61, 61, 61)
                          )
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Judul Renungan*",
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 113, 9, 49)
                  )
                )
              ),
              const SizedBox(height: 5),
              TextField(
                controller: ctr_judul,
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
                      width: 1, color: Color(int.parse(globals.defaultcolor))
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(10),
                ),
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    color: Colors.black
                  )
                ),
                maxLines: 3,
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    edited == true ? "Ayat Bacaan*" : "Ayat Bacaan",
                    style: GoogleFonts.nunito(
                      textStyle: const TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 113, 9, 49)
                      )
                    )
                  ),
                  IconButton(
                    onPressed: () {
                      //listenTextFieldSearch("renunganpage");
                      _showMyDialog();
                    },
                    icon: const Icon(Icons.zoom_out_map_rounded,
                      size: 25,
                      color: Color.fromARGB(255, 113, 9, 49)
                    )
                  ),
                ],
              ),
              const SizedBox(height: 5),
              TextField(
                controller: ctr_abacaan,
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
                  disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1, color: Colors.grey 
                    )
                  ),
                  contentPadding: const EdgeInsets.all(10),
                  hintText: "Kejadian 1:1; Keluaran 1:1",
                  hintStyle: TextStyle(
                    color: Colors.grey[400]
                  )
                ),
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    color: Colors.black
                  )
                ),
                enabled: edited,
                maxLines: 2,
              ),
              const SizedBox(
                height: 35,
              ),
              Text("Ayat Berkesan*",
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 113, 9, 49)
                  )
                )
              ),
              const SizedBox(height: 5),
              TextField(
                controller: ctr_aberkesan,
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
                  contentPadding: const EdgeInsets.all(10),
                ),
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    color: Colors.black
                  )
                ),
                maxLines: 8,
              ),
              const SizedBox(
                height: 35,
              ),
              Text("Renungan*",
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 113, 9, 49)
                  )
                )
              ),
              const SizedBox(height: 5),
              TextField(
                controller: ctr_renungan,
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
                  contentPadding: const EdgeInsets.all(10),
                ),
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    color: Colors.black
                  )
                ),
                maxLines: 7,
              ),
              const SizedBox(
                height: 35,
              ),
              Text("Tindakan Saya*",
                style: GoogleFonts.nunito(
                textStyle: const TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 113, 9, 49)
                  )
                )
              ),
              const SizedBox(height: 5),
              TextField(
                controller: ctr_tindakan,
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
                  contentPadding: const EdgeInsets.all(10),
                ),
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    color: Colors.black
                  )
                ),
                maxLines: 7,
              ),
              const SizedBox(
                height: 35,
              ),
              Text("Link Renungan",
                style: GoogleFonts.nunito(
                textStyle: const TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 113, 9, 49)
                  )
                )
              ),
              const SizedBox(height: 5),
              TextField(
                controller: ctr_linkrenungan,
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
                  hintText: 'Masukkan link atau "-"',
                  hintStyle: GoogleFonts.nunito(
                    textStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.grey
                    )
                  ),
                  contentPadding: const EdgeInsets.all(10),
                ),
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    color: Colors.black
                  )
                ),
                maxLines: 2,
              ),
              const SizedBox(
                height: 35,
              ),
              Text("Tagline*",
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 113, 9, 49)
                  )
                )
              ),
              const SizedBox(height: 5),
              TextField(
                controller: ctr_tagline,
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
                  contentPadding: const EdgeInsets.all(10),
                ),
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    color: Colors.black
                  )
                ),
                maxLines: 1,
              ),
              const SizedBox(
                height: 60,
              ),
              // ignore: sized_box_for_whitespace
              Container(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    writeData();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(int.parse(globals.defaultcolor)),
                    elevation: 10,
                    padding: const EdgeInsets.all(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 4),
                    child: Text(
                      "Simpan Renungan",
                      style: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
