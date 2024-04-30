import 'package:flutter/material.dart';
import 'package:flutter_splash_login_signup/constants.dart';
import 'package:flutter_splash_login_signup/RESET_PASSWORD/forgot_password.dart';
import 'package:flutter_splash_login_signup/home_page.dart';
import 'package:flutter_splash_login_signup/login_screen.dart';
import 'package:flutter_splash_login_signup/signup_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPassScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => ResetPasswordState();

}

class ResetPasswordState extends State<ResetPassScreen>{
  late String password;
  bool passenable = true; //boolean value to track password view enable disable.
  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  Widget initWidget(){
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(90)),
                  color: mainColor,
                  gradient: LinearGradient(
                      colors: [mainColor, mainColor2, ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight
                  )
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 50),
                      child: Image.asset("images/app_logo.png"),
                      height: 150,
                      width: 150,
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 15, top: 2),
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "Reset Password",
                        style: GoogleFonts.robotoSlab(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            //new password
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 70),
              padding: EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey[200],
                boxShadow: [BoxShadow(
                    offset: Offset(0,10),
                    blurRadius: 50,
                    color: Color(0xffEEEEEE)
                )],
              ),
              alignment: Alignment.center,
              child: TextField(
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
                obscureText: passenable,
                cursorColor: mainColor,
                decoration: InputDecoration(
                    // icon: Icon(
                    //   Icons.vpn_key,
                    //   color: mainColor,
                    // ),
                    hintText: "New Password",
                    suffixIcon: IconButton(
                        onPressed: () {
                          //add Icon button at end of TextField
                          setState(() {
                            //refresh UI
                            if (passenable) {
                              //if passenable == true, make it false
                              passenable = false;
                            } else {
                              passenable = true; //if passenable == false, make it true
                            }
                          });
                        },
                        icon:
                        Icon(
                          passenable == true ? Icons.visibility_off : Icons.visibility,
                          color: mainColor,
                        )
                    ),

                    hintStyle: GoogleFonts.lato(
                      color: Colors.black45,
                    ),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none
                ),
              ),
            ),

            //confirm new password
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey[200],
                boxShadow: [BoxShadow(
                    offset: Offset(0,10),
                    blurRadius: 50,
                    color: Color(0xffEEEEEE)
                )],
              ),
              alignment: Alignment.center,
              child: TextField(
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
                obscureText: passenable,
                cursorColor: mainColor,
                decoration: InputDecoration(
                    // icon: Icon(
                    //   Icons.vpn_key,
                    //   color: mainColor,
                    // ),
                    hintText: "Repeat New Password",
                    suffixIcon: IconButton(
                        onPressed: () {
                          //add Icon button at end of TextField
                          setState(() {
                            //refresh UI
                            if (passenable) {
                              //if passenable == true, make it false
                              passenable = false;
                            } else {
                              passenable = true; //if passenable == false, make it true
                            }
                          });
                        },
                        icon:
                        Icon(
                          passenable == true ? Icons.visibility_off : Icons.visibility,
                          color: mainColor,
                        )
                    ),

                    hintStyle: GoogleFonts.lato(
                      color: Colors.black45,
                    ),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none
                ),
              ),
            ),

            Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 20, right: 20, top: 35),
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => LoginScreen()
                      ));
                    },
                      style: ElevatedButton.styleFrom(
                          primary: mainColor,
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(left: 20, right: 20),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50), topLeft: Radius.circular(50), bottomRight: Radius.circular(50))
                          ),
                          minimumSize: Size(250, 45),
                          textStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          )
                      ),
                      child: RichText
                        (text:
                      TextSpan(
                          children: [
                            TextSpan(
                              text: 'UPDATE PASSWORD'.toUpperCase(),
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ]
                      ),
                      ),
                    ),
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}

