import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_splash_login_signup/constants.dart';
import 'package:flutter_splash_login_signup/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => InitState();

}

class InitState extends State<SplashScreen>{

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async{
    var duration = Duration(seconds: 3);
    return new Timer(duration, LoginRoute);
  }

  LoginRoute() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString('ID') != null) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
          builder: (BuildContext context) => HomePage()), (
          Route<dynamic> route) => false);
    }else{
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
          builder: (BuildContext context) => LoginScreen()), (
          Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  Widget initWidget(){
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              //color: Colors.white,
              gradient: LinearGradient(
                colors: [mainColor, mainColor2, mainColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
                )
            ),
          ),
          Center(
            child: Container(
              child: Image.asset(
                "images/app_logo.png",
                width: 200,
                height: 200,
              ), 
            ),
          )
        ],
      ),
    );
  }
}