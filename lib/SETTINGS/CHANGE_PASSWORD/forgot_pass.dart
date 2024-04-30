import 'package:flutter/material.dart';
import 'package:flutter_splash_login_signup/SETTINGS/CHANGE_PASSWORD/otp_veri.dart';
import 'package:flutter_splash_login_signup/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordScreen2 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => InitState();

}

class InitState extends State<ForgotPasswordScreen2>{
  late String email,password;
  bool passenable = true; //boolean value to track password view enable disable.
  @override
  Widget build(BuildContext context) {
    return forgotPassword();
  }

  Widget forgotPassword(){
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
                      colors: [mainColor, mainColor2,],
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
                      margin: EdgeInsets.only(right: 10, top: 2),
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "Forgot Password?",
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

            Container(
              margin: EdgeInsets.only(top: 70,left: 25,right: 25),
              child:
              Text("Enter your registered email for the verification process, we will send 4 digits code to your email.",
                style: GoogleFonts.lato(color: Colors.black87, fontSize: 15, ),
                textAlign: TextAlign.justify,
              ),
            ),

            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 30),
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
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
                cursorColor: mainColor,
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.email,
                      color: mainColor,
                    ),
                    hintText: "Enter Registered Email",
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
                margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                padding: EdgeInsets.only(left: 20, right: 20),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => OTP2()
                      ));
                      // push(context, Invite(randomNum: rNum));
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
                      child: RichText(
                          text:TextSpan(
                            text: 'Get OTP',
                            style: GoogleFonts.lato(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          )
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