library my_prj.globals;

import 'package:alkitab/listrencanauser.dart';

import 'detailkomunitas.dart';
import 'homepage.dart';
import 'mergeayat.dart';

// cPasal pasalC = cPasal();
// List<cPasal> listPasalPerKitab = [];

String defaultcolor = '0xFF373A54';

cKitab kitabC = cKitab();
List<cKitab> listNamaKitab = [];

int? counterList; // untuk hitung list pembanding
List<AyatPembanding> listAyatPembanding = [];
List<DataAyatPembanding> listDataPembanding = [];
List alkitab = [];

double sizeStickerLay = 0.0;

// akun profile user
String idUser = ""; // diambil dari email untuk upload di foto
String emailUser = "";
String password = "";
String namaDepanUser = "";
String namaBelakangUser = "";
String deskripsiUser = "";
String imagepath = "";
bool statusLogin = false;
// end of akun profile

double sizeStack = 0.0;

int lastIdCatatan = 0;  // untuk detail catatan setelah add
int lastIdRenunganUser = 1;  // untuk detail renungan setelah add

bool logininput = false;

bool call = true;

bool buatkomunitas = false;
String urllocal = "http://bible.crossnet.co.id:1234/";

bool refreshpage = false;

// akun profile komunitas
String idkomunitas = "";
String namakomunitas = "";
String statuskomunitas = "";
String deskripsikomunitas = "";
String passwordkomunitas = "";
String tanggalpembuatan = "";
String imagepathkomunitas = "";
String jumlahanggota = "";
String roleuser = "";
// end of akun profile komunitas

// renungan komunitas
String idrenungankomunitas = "";
String tanggalrenungan = "";
String judulrenungan = "";
String kitabbacaan = "";
String ayatbacaan = "";
String isirenungan = "";
String linkrenungan = "";
String tagline = "";
// end of renungan komunitas

// refleksi user
String idrefleksi = "";
String iduserrefleksi = "";
String tanggalrefleksi = "";
String namaduserrefleksi = "";
String namabuserrefleksi = "";
String imagepathrefleksi = "";
String ayatberkesan = "";
String tindakansaya = "";
// end of refleksi user

// explore
String idexplore = "";
String tanggalposting = "";
String komentar = "";
String suka = "";
String lastIdRDatabase = "";
// end of explore


// rencana bacaan 
String idrencana = "";
String judulrencana = "";
String imagepathrencana = "";
List<DetailRencana> listDetailRencana = []; // dari menu komunitas
List listDetailRUser = []; // dari menu user

// List<String> statusBaca = []; // kasih status per konten nya
// end of rencana bacaan


// bacaan liturgi
List<BacaanLiturgi> listBacaLiturgi = [];
String informasiliturgi = "";
String titletanggal = "";
// end of bacaan liturgi