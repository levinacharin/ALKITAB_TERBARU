import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import './editprofile.dart';
import './profilepage.dart';
import './global.dart' as globals;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool gantipp = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => const ProfilePageMenu())
            );
          },
          icon: const Icon(Icons.arrow_back_rounded),
          color: const Color.fromARGB(255, 113, 9, 49)
        ),
        title: Text(
          "Profile User",
          style: GoogleFonts.nunito(
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 113, 9, 49),
            )
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  globals.imagepath != "-"
                  ? ClipOval(
                    child: Image.network(
                      '${globals.urllocal}getimage?id=${globals.idUser}&folder=user',
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    )  
                  )
                  : Icon(
                    Icons.account_circle_outlined, 
                    color: Color(int.parse(globals.defaultcolor)),
                    size: 160,
                  )
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nama Depan", 
                          style: GoogleFonts.nunito(
                            textStyle: const TextStyle(
                              fontSize: 18, 
                              color: Color.fromARGB(255, 113, 9, 49)
                            )
                          )
                        ),
                        const SizedBox(height: 5,),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              color: Color(int.parse(globals.defaultcolor)),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            globals.namaDepanUser,
                            style: GoogleFonts.nunito(
                              textStyle: const TextStyle(
                              fontSize: 18,
                              color: Colors.black
                              )
                            ),
                          )
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nama Belakang", 
                          style: GoogleFonts.nunito(
                            textStyle: const TextStyle(
                              fontSize: 18, 
                              color: Color.fromARGB(255, 113, 9, 49)
                            )
                          )
                        ),
                        const SizedBox(height: 5,),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              color: Color(int.parse(globals.defaultcolor)),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            globals.namaBelakangUser,
                            style: GoogleFonts.nunito(
                              textStyle: const TextStyle(
                                fontSize: 18,
                                color: Colors.black
                              )
                            ),
                          )
                        ),
                      ],
                    )
                  ),
                ],
              ),
              const SizedBox(height: 30,),
              Text(
                "Email", 
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 18, 
                    color: Color.fromARGB(255, 113, 9, 49)
                  )
                )
              ),
              const SizedBox(height: 5,),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                    color: Color(int.parse(globals.defaultcolor)),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  globals.emailUser,
                  style: GoogleFonts.nunito(
                    textStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.black
                    )
                  ),
                )
              ),
              const SizedBox(height: 30,),
              Text(
                "Deskripsi", 
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 18, 
                    color: Color.fromARGB(255, 113, 9, 49)
                  )
                )
              ),
              const SizedBox(height: 5,),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                    color: Color(int.parse(globals.defaultcolor)),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  globals.deskripsiUser,
                  style: GoogleFonts.nunito(
                    textStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.black
                    )
                  ),
                )
              ),
              const SizedBox(height: 60),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () async {
                    final data = await Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => const EditProfile())
                    );

                    if (data == "refresh") {
                      setState(() {
                        gantipp = true;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(int.parse(globals.defaultcolor)),
                    elevation: 10,
                    padding: const EdgeInsets.all(5),
                  ),
                  child: Text(
                    "Edit", 
                    style: GoogleFonts.nunito(
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      )
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}