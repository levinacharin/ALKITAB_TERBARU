

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'global.dart' as globals;

class ListDoa {
  String iddoa;
  String iduser;
  String idkomunitas;
  String namadepan;
  String namabelakang;
  String isidoa;

  ListDoa({
    required this.iddoa,
    required this.iduser,
    required this.idkomunitas,
    required this.namadepan,
    required this.namabelakang,
    required this.isidoa
  });

  factory ListDoa.createData(Map<String, dynamic> object) {
    return ListDoa(
      iddoa: object['iddoa'].toString(),
      iduser: object['iduser'].toString(),
      idkomunitas: object['idkomunitas'].toString(),
      namadepan: object['namadepan'],
      namabelakang: object['namabelakang'],
      isidoa: object['isidoa']
    );
  }

  static Future<List<ListDoa>> getAllData() async {
    var url = "${globals.urllocal}listdoaall?idkomunitas=${int.parse(globals.idkomunitas)}";
    var apiResult = await http.get(Uri.parse(url), headers: {
      "Accept" : "application/json",
      "Access-Control-Allow-Origin" : "*"
    });
    var jsonObject = json.decode(apiResult.body);
    var data = (jsonObject as Map<String, dynamic>)['data'];
    List<ListDoa> listData = [];
    if (data.toString() == "null") {
      return listData;
    } else {
      for (int i = 0; i < data.length; i++) {
        listData.add(ListDoa.createData(data[i]));
      }
      return listData;
    }
  }
}

class ListDoaPage extends StatefulWidget {
  const ListDoaPage({super.key});

  @override
  State<ListDoaPage> createState() => _ListDoaPageState();
}

class _ListDoaPageState extends State<ListDoaPage> {
  List<ListDoa> listDoa = [];

  Future<void> getListDoa() async {
    ListDoa.getAllData().then((value) async {
      setState(() {
        listDoa = value;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListDoa();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 113, 9, 49),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: listDoa.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Card(
                elevation: 3,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ClipOval(
                            child: Image.asset(
                              'assets/images/pp1.jpg',
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 5,),
                          Text(
                            "${listDoa[index].namadepan} ${listDoa[index].namabelakang}",
                            style: GoogleFonts.nunito(
                              textStyle: const TextStyle(
                                fontSize: 18, 
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 113, 9, 49)
                              )
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Text(
                        listDoa[index].isidoa,
                        style: GoogleFonts.nunito(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            color: Colors.black
                          )
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        }
      )
    );
  }
}