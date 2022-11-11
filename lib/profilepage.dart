import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './global.dart' as globals;
//import './homepage.dart';
import './profile.dart';
import './settings.dart';

class ProfilePageMenu extends StatefulWidget {
  const ProfilePageMenu({super.key});

  @override
  State<ProfilePageMenu> createState() => _ProfilePageMenuState();
}

class _ProfilePageMenuState extends State<ProfilePageMenu> {

  saveStatusLogin() async {
    globals.statusLogin = false;
    globals.emailUser = "";
    globals.password = "";

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("StatusUser", globals.statusLogin);
    prefs.setString("EmailUser", globals.emailUser);
    prefs.setString("PasswordUser", globals.password);
    globals.idUser = "";
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);  
            // Navigator.pop(context);
            // Navigator.pop(context);
            // Navigator.pop(context);
            // Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_rounded),
          color: const Color.fromARGB(255, 113, 9, 49)
        ),
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                globals.gantipp == true
                ? ClipOval(
                  child: Image.asset(
                    'assets/images/ppdummy-image.jpg',
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  )
                )
                : Icon(
                  Icons.account_circle_rounded, 
                  size: 100,
                  color: Color(int.parse(globals.defaultcolor)),
                ),
                // Container(
                //   width: 100,
                //   height: 100,
                //   child: Image.asset('assets/images/person_icon.png')
                // )
              ],
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  globals.namaDepanUser,
                  style: GoogleFonts.nunito(
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black
                    )
                  ),
                )
              ],
            ),
            const SizedBox(height: 20,),
            Container(
              height: 2,
              color: Colors.black,
            ),
            const SizedBox(height: 20,),
            ListTile(
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => const ProfilePage())
                );
              },
              // ignore: sized_box_for_whitespace
              leading: Container(
                height: 40,
                width: 40,
                child: Image.asset('assets/images/person_icon.png')
              ),
              title: Text(
                "Data Pribadi",
                style: GoogleFonts.nunito(
                  textStyle: TextStyle(
                    fontSize: 18, 
                    fontWeight: FontWeight.w500,
                    color: Color(int.parse(globals.defaultcolor))
                  )
                ),
              ),
              trailing: Text(
                ">",
                style: GoogleFonts.nunito(
                  textStyle: TextStyle(
                    fontSize: 18, 
                    fontWeight: FontWeight.w500,
                    color: Color(int.parse(globals.defaultcolor))
                  )
                ),
              ),
            ),
            const SizedBox(height: 10,),
            ListTile(
              onTap: () {
                Navigator.push(
                  context, 
                  // ignore: prefer_const_constructors
                  MaterialPageRoute(builder: (context) => SettingsPage())
                );
              },
              // ignore: sized_box_for_whitespace
              leading: Container(
                height: 40,
                width: 40,
                child: Image.asset('assets/images/person_icon.png')
              ),
              title: Text(
                "Pengaturan",
                style: GoogleFonts.nunito(
                  textStyle: TextStyle(
                    fontSize: 18, 
                    fontWeight: FontWeight.w500,
                    color: Color(int.parse(globals.defaultcolor))
                  )
                ),
              ),
              trailing: Text(
                ">",
                style: GoogleFonts.nunito(
                  textStyle: TextStyle(
                    fontSize: 18, 
                    fontWeight: FontWeight.w500,
                    color: Color(int.parse(globals.defaultcolor))
                  )
                ),
              ),
            ),
            const SizedBox(height: 10,),
            ListTile(
              onTap: () {
                saveStatusLogin();
                Navigator.pop(context);
              },
              // ignore: sized_box_for_whitespace
              leading: Container(
                height: 40,
                width: 40,
                child: Image.asset('assets/images/person_icon.png')
              ),
              title: Text(
                "Keluar",
                style: GoogleFonts.nunito(
                  textStyle: TextStyle(
                    fontSize: 18, 
                    color: Color(int.parse(globals.defaultcolor))
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}