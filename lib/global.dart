library my_prj.globals;

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

// akun profile user
String idUser = ""; // diambil dari email untuk upload di foto
String emailUser = "";
String password = "";
String namaDepanUser = "";
String namaBelakangUser = "";
String deskripsiUser = "";
bool statusLogin = false;
// end of akun profile

int lastIdCatatan = 0;  // untuk detail catatan setelah add
int lastIdRenunganUser = 1;  // untuk detail renungan setelah add

bool call = true;

bool buatkomunitas = false;
bool buatcatatan = false;
bool buatrenungan = false;
String urllocal = "http://bible.crossnet.co.id:1234/";

// akun profile komunitas
String idkomunitas = "";
String namakomunitas = "";
String statuskomunitas = "";
String deskripsikomunitas = "";
String passwordkomunitas = "";
String tanggalpembuatan = "";
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
List<DetailRencana> listDetailRencana = []; // dari komunitas
List listDetailRUser = []; // dari menu user
List<String> rencanaDone = [];
// end of rencana bacaan