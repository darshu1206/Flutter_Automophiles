import 'package:flutter/material.dart';
import 'package:flutter_splash_login_signup/SETTINGS/settings.dart';
import 'package:flutter_splash_login_signup/constants.dart';
import 'package:flutter_splash_login_signup/home_page.dart';
import 'package:google_fonts/google_fonts.dart';

class Notification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Notifications(),
    );
  }
}

class Notifications extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          toolbarHeight: 70,
          centerTitle: true,
          elevation: 0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
              gradient: LinearGradient(
                  colors: [
                    mainColor,
                    gradientColor,
                    mainColor2,
                  ]
              ),
            ),
          ),
          title: Text(
          'Notifications',
          style: GoogleFonts.lato(color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
                size: 20
            ),
            onPressed: () {
            Navigator.pop(context, MaterialPageRoute(builder: (context) => HomePage())
            );
          },
          ),
        ),
    );

  }

}