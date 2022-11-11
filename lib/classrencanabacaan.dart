// ini nanti bisa dihapus
class MRencanaBacaan {
  String gambarURL;
  String durasihari;
  String judulbacaan;
  String deskripsibacaan;

  MRencanaBacaan(
    this.gambarURL,
    this.durasihari,
    this.judulbacaan,
    this.deskripsibacaan
  );

  static List<MRencanaBacaan> isiBacaan = [
    MRencanaBacaan(
      "assets/images/rencana1.jpg", 
      "4 Hari", 
      "Saya Percaya Diri", 
      "Sangat banyak dari kita tertatih di antara kegelisahan dan rasa percaya diri yang salah." "Rencana Alkitab empat hari dari Life.Church ini akan memberikan Anda dasar baru dalam percaya diri " "di dalam Tuhan. Mulai baca bagian keenam dari enam seri Tetap Positif."
    ),
    MRencanaBacaan(
      "assets/images/rencana2.jpg", 
      "7 Hari", 
      "Pimpinan Ilahi", 
      "Setiap hari, kita membuat pilihan yang membentuk cerita kehidupan kita. Seperti apa jadinya " "kehidupan Anda jika Anda adalah seorang yang ahli dalam membuat pilihat tersebut? Dalam Rencana Alkitab " "Pimpinan Ilahi, penulis terlari New York Times dan Pastor Senior dari Life.Church, Craig Groeschel, memberi " "semangat kepada Anda dengan tujuh prinsip dari bukunya, Divine Direction (Pimpinan Ilahi), untuk membantu " "Anda menemukan Hikmat Tuhan untuk keputusan sehari-hari Anda. Temukan bimbingan rohani yang Anda butuhkan untuk hidup " "dalam kisah yang menghormati Tuhan yang akan Anda sampaikan."
    ),
    MRencanaBacaan(
      "assets/images/rencana3.jpg", 
      "4 Hari", 
      "Memahami Hati Tuhan", 
      "Kita dapat dengan mudah percaya hal-hal yang tidak benar tentang Tuhan. Kadang kala, kita melihat " "hal-hal dalam media sosial atau berita-berita yang membuat kita mempertanyakan Dia. Jadi, apa yang benar " "tentang Tuhan? Apakah Dia mengetahui apa yang sedang dilakukan-Nya? Apakah Dia benar-benar penuh kasih dan baik, " "bahkan ketika hal-hal tampaknya tidak berjalan dengan baik? Dalam Rencana Bacaan Alkitab 4 hari ini, " "mari kita bersama-sama belajar bagaimana  memahami hati Tuhan."
    ),
    MRencanaBacaan(
      "assets/images/rencana4.jpg", 
      "12 Hari", 
      "Hikmat", 
      "Alkitab menantang kita untuk mencari hikmat melebihi apa pun. Dalam bacaan ini, Anda akan menjelajahi " "beberapa ayat yang berbicara langsung tentang hikmat- apakah hikmat itu, mengapa itu penting, dan " "bagaimana cara mengembangkannya."
    ),
  ];
}