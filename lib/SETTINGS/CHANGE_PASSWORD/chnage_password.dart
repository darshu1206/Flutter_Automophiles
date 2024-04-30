import 'package:flutter/material.dart';
import 'package:flutter_splash_login_signup/SETTINGS/CHANGE_PASSWORD/forgot_pass.dart';
import 'package:flutter_splash_login_signup/SETTINGS/settings.dart';
import 'package:flutter_splash_login_signup/constants.dart';
import 'package:flutter_splash_login_signup/home_page.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePassUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangePassword(),
    );
  }
}

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePassword> {
  late String password;
  bool passenable = true;
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
          'Change Password',
          style: GoogleFonts.lato(color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20
          ),
          onPressed: () {
            Navigator.pop(context, MaterialPageRoute(builder: (context) => SettingsPage())
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //old password
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 40),
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
                    hintText: "Current Password",
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

            //forgot password
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => {
                  // Write Click Listener Code Here
                  Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) => ForgotPasswordScreen2()
                  ))
                },
                child: Text(
                  "Forgot Password?",
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                    color: mainColor,
                  ),
                ),
              ),
            ),

            //new password
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
                    ElevatedButton(onPressed: () => snackBar("Password Updated Successfully!!"),
                    //     (){
                    //   Navigator.pushReplacement(context, MaterialPageRoute(
                    //       builder: (context) => LoginScreen()
                    //   ));
                    // },
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
                              text: 'CHANGE PASSWORD'.toUpperCase(),
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
  // snackBar Widget
  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: Duration(seconds: 2),
      ),
    );
  }
}

