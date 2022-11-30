import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_switch/flutter_switch.dart';

import './global.dart' as globals;

class PanduanAplikasi extends StatefulWidget {
  // Widget(){

  // }
  const PanduanAplikasi({super.key});

  @override
  State<PanduanAplikasi> createState() => _PanduanAplikasiState();
}



class _PanduanAplikasiState extends State<PanduanAplikasi> {
  List usermanual = [
    [
    "Memilih kitab, pasal dan ayat",
    "1. Membuka halaman utama\n"+
    "2. Klik nama kitab di atas kiri\n"+
    "3. Pilih kitab yang ingin dibuka\n"+
    "4. Pilih pasal\n"+
    "5. Pilih ayat"
    ],
    [
    "Memberi highlight pada ayat",
    "1. Membuka halaman utama\n"+
    "2. Tap sekali pada semua ayat yang ingin diberi highlight\n"+
    "3. Klik titik 3 di atas kanan\n"+
    "4. Pilih highlight\n"+
    "5. Pilih warna dan atur opacity\n"+
    "6. Klik simpan"
    ],
    [
    "Menghapus highlight",
    "1. Membuka halaman utama\n"+
    "2. Tekan lama pada ayat yang highlightnya ingin dihapus"
    ],
    [
    "Memberi underline pada pilihan kata",
    "1. Membuka halaman utama\n"+
    "2. Tap dua kali pada ayat yang ingin diberi underline\n"+
    "3. Tahan lama pada kata yang ingin diberi underline, select semua kata yang ingin diberi highlight\n"+
    "4. Klik tanda u pada pilihan yang muncul"
    ],
    [
    "Menghapus underline",
    "1. Membuka halaman utama\n"+
    "2. Tap dua kali pada ayat yang memiliki underline yang ingin dihapus\n"+
    "3. Klik icon diatas kanan sebelah icon close"
  
    ],
    [
    "Membaca lebih dari satu kitab",
    "1. Klik menu di sebelah kiri atas\n"+
    "2. Pilih multi pencarian\n"+
    "3. Tuliskan nama kitab, pasal dan ayat yang ingin dibaca, dengan format {nama kitab pasal:ayat; nama kitab pasal:ayat dst}\n"+
    "Contoh: Kejadian 1:1,2-10,5 ; Keluaran 1:2,6-9"
    
    ],
    [
    "Mencari kata atau kalimat tertentu",
    "1. Klik menu di sebelah kiri atas\n"+
    "2. Pilih pencarian\n"+
    "3. Masukan kata yang ingin dicari"
    ],
    [
    "Membuat catatan pribadi",
    "1. Membuka halaman utama\n"+
    "2. Tap sekali pada semua ayat yang ingin diberi catatan\n"+
    "3. Klik titik 3 di atas kanan\n"+
    "4. Pilih catatan\n"+
    "5. Isi form catatan\n"+
    "6. Bagian tagline, adalah bagian yang bisa dijadikan kata kunci jika suatu saat pengguna ingin mencari kata tersebut\n"+
    "7. Simpan"
    ],
    [
    "Membuat renungan pribadi",
    "Melalui Select Ayat : \n"+
    "1. Membuka halaman utama\n"+
    "2. Tap sekali pada semua ayat yang dijadikan renungan\n"+
    "3. Klik titik 3 di atas kanan\n"+
    "4. Pilih renungan\n"+
    "5. Isi form renungan\n"+
    "6. Untuk memilih ayat berkesan, tekan icon expand di sebelah kanan tulisan ayat bacaan, ayat yang tadi dipilih akan otomatis menjadi ayat berkesan\n"+
    "7. Untuk menambah ayat berkesan, tap sekali pada ayat tersebut\n"+
    "8. Untuk menghapus ayat berkesan tap lama pada ayat yang ingin dibatalkan menjadi ayat berkesan\n"+
    "9. Bagian tagline, adalah bagian yang bisa dijadikan kata kunci jika suatu saat pengguna ingin mencari kata tersebut\n"+
    "10. Simpan \n\n"+
    "Tambah manual lewat halaman list renungan : \n"+
    "1. Klik menu di sebelah kiri atas\n"+
    "2. Pilih renungan\n"+
    "3. Klik tombol + di bawah kanan\n"+
    "4. Isi form renungan\n"+
    "5. Pengisian ayat bacaan\n"+
    "   Tuliskan nama kitab, pasal dan ayat yang ingin dibaca, dengan format {nama kitab pasal:ayat; nama kitab pasal:ayat dst}\n"+
    "   Contoh: Kejadian 1:1,2-10,5 ; Keluaran 1:2,6-9 \n"+
    "6. Untuk memilih ayat berkesan, tekan icon expand di sebelah kanan tulisan ayat bacaan, ayat yang tadi dipilih akan otomatis menjadi ayat berkesan\n"+
    "7. Untuk menambah ayat berkesan, tap sekali pada ayat tersebut\n"+
    "8. Untuk menghapus ayat berkesan tap lama pada ayat yang ingin dibatalkan menjadi ayat berkesan\n"+
    "9. Bagian tagline, adalah bagian yang bisa dijadikan kata kunci jika suatu saat pengguna ingin mencari kata tersebut\n"+
    "10. Simpan"
    ],
    [
    "Menyalakan dan mematikan latar lagu",
    "1. Klik menu di sebelah kiri atas\n"+
    "2. Klik switch lagu menjadi nonaktif/aktif"
    ],
    [
    "Mengaktifkan atau menonaktifkan tampilan stiker",
    "1. Klik menu di sebelah kiri atas\n"+
    "2. Klik switch mode stiker menjadi nonaktif/aktif"
    ],
    [
    "Membagikan renungan ke aplikasi lain",
    "1. Klik menu di sebelah kiri atas\n"+
    "2. Pilih renungan\n"+
    "3. Pada halaman list renungan\n"+
    "4. Klik titik 3 yang ada di sebelah kanan atas renungan\n"+
    "5. Pilih share\n"+
    "6. Pilih ke aplikasi lain\n"+
    "7. Pilih aplikasi yang ingin dibagikan"
    ],
    [
    "Daftar",
    "1. Klik menu di sebelah kiri atas\n"+
    "2. Pilih profile\n"+
    "3. Daftar\n"+
    "4. Masukan data diri sesuai permintaan\n"+
    "5. Klik daftar"
    ],
    [
    "Masuk",
    "1. Klik menu di sebelah kiri atas\n"+
    "2. Pilih profile\n"+
    "3. Masuk\n"+
    "4. Masukan email dan kata sandi\n"+
    "5. Klik masuk"
    ],
    [
    "Edit Data Pribadi",
    "1. Klik menu di sebelah kiri atas\n"+
    "2. Pilih profile\n"+
    "3. Pilih data pribadi\n"+
    "4. Klik edit\n"+
    "5. Ganti semua data yang ingin diganti\n"+
    "6. Klik simpan"
    ],
    [
    "Bergabung dengan komunitas publik",
    "1. Klik menu di sebelah kiri atas\n"+
    "2. Pilih komunitas\n"+
    "3. Cari komunitas dengan keterangan publik yang pengguna ingin gabung\n"+
    "4. Klik gabung"
    ],
    [
    "Bergabung dengan komunitas privat",
    "1. Klik menu di sebelah kiri atas\n"+
    "2. Pilih komunitas\n"+
    "3. Cari komunitas dengan keterangan privat yang pengguna ingin gabung\n"+
    "4. Klik gabung \n"+
    "5. Masukan password komunitas\n"+
    "6. Gabung komunitas"
    ],
    [
    "Minta bantuan doa pada sebuah komunitas",
    "1. Klik menu di sebelah kiri atas\n"+
    "2. Pilih komunitas\n"+
    "3. Pilih komunitasku\n"+
    "4. Klik komunitas yang ingin dimintai doa\n"+
    "5. Klik titik 3 pada bagian atas kanan komunitas\n"+
    "6. Klik minta bantuan doa\n"+
    "6. Masukkan doa\n"+
    "7. Klik kirimkan pokok doa"
    ],
    [
    "Melihat anggota lain yang ada di komunitas",
    "1. Klik menu di sebelah kiri atas\n"+
    "2. Pilih komunitas\n"+
    "3. Pilih komunitasku\n"+
    "4. Klik komunitas yang ingin dilihat anggotanya\n"+
    "5. Pilih anggota"
    ],
    [
    "Membuat refleksi dari renungan komunitas",
    "1. Klik menu di sebelah kiri atas\n"+
    "2. Pilih komunitas\n"+
    "3. Pilih komunitasku\n"+
    "4. Klik komunitas yang ingin dibuat refleksi renungannya\n"+
    "5. Pilih renungan yang ingin dibuat refleksinya \n"+
    "6. Klik buat refleksi\n"+
    "7. Isi form refleksi dari renungan tersebut\n"+
    "8. Klik buat refleksi\n"+
    "9. Jika tidak ingin membagikannya ke komunitas juga, klik tidak"
    ],
    [
    "Mengikuti rencana baca yang \ndisediakan komunitas",
    "1. Klik menu di sebelah kiri atas\n"+
    "2. Pilih komunitas\n"+
    "3. Pilih komunitasku\n"+
    "4. Klik komunitas yang ingin diikuti rencana bacanya \n"+
    "5. Pilih rencana bacaan \n"+
    "6. Klik mulai pada rencana bacaan yang ingin diikuti"
    ],
    [
    "Share refleksi renungan ke komunitas",
    "1. Klik menu di sebelah kiri atas\n"+
    "2. Pilih renungan\n"+
    "3. Klik titik 3 yang ada di sebelah kanan atas renungan\n"+
    "4. Klik komunitas yang ingin diikuti rencana bacanya \n"+
    "5. Pilih share \n"+
    "6. Pilih ke komunitas"
    ],
    [
    "Share refleksi renungan ke explore",
    "1. Klik menu di sebelah kiri atas\n"+
    "2. Pilih renungan\n"+
    "3. Pada halaman list renungan\n"+
    "4. Klik titik 3 yang ada di sebelah kanan atas renungan \n"+
    "5. Pilih share \n"+
    "6. Pilih ke explore"
    ],
    [
    "Membuat komunitas",
    "1. Klik menu di sebelah kiri atas\n"+
    "2. Pilih komunitas\n"+
    "3. Klik tanda + di kanan bawah\n"+
    "4. Isi form sesuai ketentuan \n"+
    "5. Jika komunitas di privat maka, setiap anggota yang akan masuk harus memasukkan password"
    ],
    [
    "Edit Data Komunitas",
    "1. Klik menu di sebelah kiri atas\n"+
    "2. Pilih komunitas\n"+
    "3. Pilih komunitasku\n"+
    "4. Pilih komunitas yang pernah dibuat\n"+
    "5. Klik titik 3 pada bagian atas kanan komunitas\n"+
    "6. Pilih edit komunitas \n"+
    "7. Edit\n"+
    "8. Klik edit komunitas"
    ],
    [
    "Membuat renungan komunitas",
    "1. Klik menu di sebelah kiri atas\n"+
    "2. Pilih komunitas\n"+
    "3. Pilih komunitasku\n"+
    "4. Pilih komunitas yang pernah dibuat\n"+
    "5. Klik titik 3 pada bagian atas kanan komunitas\n"+
    "6. Pilih tambah renungan \n"+
    "7. Isi sesuai ketentuan \n"+
    "8. Klik tambah renungan"
    ],
    [
    "Membuat rencana bacaan",
    "1. Klik menu di sebelah kiri atas \n"+
    "2. Pilih komunitas\n"+
    "3. Pilih komunitasku\n"+
    "4. Pilih komunitas yang pernah dibuat\n"+
    "5. Klik titik 3 pada bagian atas kanan komunitas\n"+
    "6. Pilih tambah rencana bacaan \n"+
    "7. Anda bisa mengatur durasi dari rencana bacaan tersebut \n"+
    "8. Isi renungan tiap hari nya \n"+
    "9. Simpan rencana bacaan"
    ],
    [
    "Melihat list permintaan doa",
    "1. Klik menu di sebelah kiri atas \n"+
    "2. Pilih komunitas\n"+
    "3. Pilih komunitasku\n"+
    "4. Pilih komunitas yang pernah dibuat\n"+
    "5. Klik titik 3 pada bagian atas kanan komunitas \n"+
    "6. Pilih list doa"
    ],

  ];
  List<bool> liststatusopenorcloseusermanual=[];

  void initState() {
    super.initState();

    liststatusopenorcloseusermanual.clear();
    for (int i = 0; i < usermanual.length; i++) {
      liststatusopenorcloseusermanual.add(false);
    }
  }

  Widget usermanualwidget() {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: usermanual.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                        onTap: () {
                          setState(() {
                            liststatusopenorcloseusermanual[index] = !liststatusopenorcloseusermanual[index];
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(width: 1, color: Color(int.parse(globals.defaultcolor))),
                              bottom: BorderSide(width: 1, color: Color(int.parse(globals.defaultcolor)))
                            )
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(width: 10,),
                              Expanded(
                                  //padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Text(
                                    "${usermanual[index][0]} \n",
                                    overflow: TextOverflow.fade,
                                    style: GoogleFonts.nunito(
                                      textStyle: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 113, 9, 49)
                                      )
                                    ),
                                  ),
                                ),
                              liststatusopenorcloseusermanual[index] == false
                              ? Container(
                                padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                                child: const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Color.fromARGB(255, 113, 9, 49),
                                ),
                              )
                              : Container(
                                padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                                child: const Icon(
                                  Icons.keyboard_arrow_up,
                                  color: Color.fromARGB(255, 113, 9, 49),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
              Visibility(
                visible: liststatusopenorcloseusermanual[index],
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
                  child: Text(
                    "${usermanual[index][1]} \n",
                    style: GoogleFonts.nunito(
                        textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(int.parse(globals.defaultcolor)))),
                  ),
                ),
              ),
            ],
          );
          
        });
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
        title: Text(
          "Panduan Aplikasi",
          style: GoogleFonts.nunito(
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 113, 9, 49)
            )
          ),
        ),
        elevation: 0,
      ),
      body: usermanualwidget()
    );
  }
}