import 'dataclass.dart';
import 'dart:convert';
import 'package:flutter/services.dart';


class Service{
  static Future<List<cData>> getAllData() async {
    try {
      final result =
          jsonDecode(await rootBundle.loadString('assets/Alkitab.json')) as List;

      return result.map((data) => cData.fromJson(data)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  // static Future<List<cData>> getkitab() async {
  //   try {
  //     final result =
  //         jsonDecode(await rootBundle.loadString('assets/Alkitab.json')) as List;

  //     return result.map((data) => cData.fromJson(data)).toList();
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

  // static Future<List<cData>> getpasal() async {
  //   try {
  //     final result =
  //         jsonDecode(await rootBundle.loadString('assets/Alkitab.json')) as List;

  //     return result.map((data) => cData.fromJson(data)).toList();
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

  // static Future<List<cData>> getayat() async {
  //   try {
  //     final result =
  //         jsonDecode(await rootBundle.loadString('assets/Alkitab.json')) as List;

  //     return result.map((data) => cData.fromJson(data)).toList();
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

}