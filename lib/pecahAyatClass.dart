// ignore: file_names
class Stacks {
  String data;
  String op;
  String next;
  Stacks(this.op, this.data, this.next);
}

class Bacaan {
  String kitab;
  String pasal;
  String ayat;
  Bacaan(this.kitab, this.pasal, this.ayat);
}

class Alkitab {
  String kitab;
  String pasal;
  String ayat;
  String isi;
  String tipe;
  Alkitab(this.kitab, this.pasal, this.ayat, this.isi, this.tipe);
}

class Kitab {
  String kitab;
  List<Pasal> listPasal;
  Kitab(this.kitab, this.listPasal);
}

class Pasal {
  int pasal;
  List<Ayat> listAyat;
  Pasal(this.pasal, this.listAyat);
}

class Ayat {
  int ayat;
  String isi;
  String tipe;
  Ayat(this.ayat, this.isi, this.tipe);
}

class AyatN {
  Bacaan bacaan;
  String isi;
  AyatN(this.bacaan, this.isi);
}
