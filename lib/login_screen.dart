import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_splash_login_signup/Model/LOGIN/LoginApi.dart';
import 'package:flutter_splash_login_signup/constants.dart';
import 'package:flutter_splash_login_signup/home_page.dart';
import 'package:flutter_splash_login_signup/signup_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'Model/LOGIN/LoginApi.dart';

class LoginScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<LoginScreen>{
  late String email,password;
  bool _isLoading = false;
  bool passenable = true;
  late LoginApi loginApi;
  final formKey = new GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  login(email,password) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'EMAIL': email,
      'PASSWORD' : password,
    };

    var response = await http.post(Uri.parse("https://tamable-fellows.000webhostapp.com/LOGIN.php"), body: data);
    loginApi = new LoginApi.fromJsonMap(json.decode(response.body.toString()));

    if(response.statusCode==200){
      if(!loginApi.error){
        setState((){
          _isLoading = false;
        });
        sharedPreferences.setString("ID",loginApi.user.ID);
        sharedPreferences.setString("NAME",loginApi.user.NAME);
        sharedPreferences.setString("EMAIL",loginApi.user.EMAIL);
        sharedPreferences.setString("PASSWORD",loginApi.user.PASSWORD);
        sharedPreferences.setString("PHONE",loginApi.user.PHONE);
        sharedPreferences.setString("ADDRESS",loginApi.user.ADDRESS);
        sharedPreferences.setString("BG",loginApi.user.BG);
        sharedPreferences.setString("DOB",loginApi.user.DOB);
        sharedPreferences.setString("CAR_NUMBER_PLATE",loginApi.user.CAR_NUMBER_PLATE);
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
            builder: (BuildContext context) => HomePage()), (
            Route<dynamic> route) => false);
    }
    else{
        setState((){
          _isLoading = false;
        });
        Fluttertoast.showToast(
            msg:loginApi.message,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2
        );
    }
  }
    else{
      setState((){
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  Widget initWidget(){
    return Scaffold(
      body: _isLoading ? Center(child: CircularProgressIndicator(color: mainColor,)) : Form(
       key: formKey,
       child: SingleChildScrollView(
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
                       margin: EdgeInsets.only(right: 20, top: 2),
                       alignment: Alignment.bottomRight,
                       child: Text(
                         "Login",
                         style: GoogleFonts.robotoSlab(
                             fontSize: 30,
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
               child: TextFormField(
                 keyboardType: TextInputType.emailAddress,
                 controller: emailController,
                 validator: (value){
                   if(value!.isEmpty){
                     return "please enter email";
                   }
                   return null;
                 },
                 cursorColor: mainColor,
                 decoration: InputDecoration(
                     icon: Icon(
                       Icons.email,
                       color: mainColor,
                     ),

                     hintText: "Enter Email",
                     hintStyle: GoogleFonts.lato(
                       color: Colors.black45,
                     ),
                     enabledBorder: InputBorder.none,
                     focusedBorder: InputBorder.none
                 ),
               ),
             ),
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
               child: TextFormField(
                 keyboardType: TextInputType.text,
                 controller: passwordController,
                 validator:(value){
                   if(value!.isEmpty){
                     return "please enter password";
                   }
                   return null;
                 },
                 obscureText: passenable,
                 cursorColor: mainColor,
                 decoration: InputDecoration(
                     icon: Icon(
                       Icons.vpn_key,
                       color: mainColor,
                     ),
                     hintText: "Enter Password",
                     suffixIcon: IconButton(
                         onPressed: () {
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
               margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
               alignment: Alignment.centerRight,
               child: GestureDetector(
                 onTap: () => { },
                 child: Text(
                   "Forgot Password?",
                   style: GoogleFonts.lato(
                     fontWeight: FontWeight.bold,
                     color: mainColor,
                   ),
                 ),
               ),
             ),
             Container(
                 alignment: Alignment.center,
                 margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                 padding: EdgeInsets.only(left: 20, right: 20),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     ElevatedButton(onPressed: (){
                       final form = formKey.currentState;
                       if(form!.validate()){
                         setState((){
                           _isLoading = true;
                         });
                         login(emailController.text,passwordController.text);
                       }
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
                               text: 'LOGIN',
                               style: GoogleFonts.lato(
                                 color: Colors.white,
                                 fontSize: 20,
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

             Container(
               margin: EdgeInsets.only(top: 10),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text("Don't Have an Account?  ",
                     style: GoogleFonts.lato(color: Colors.black),
                   ),
                   GestureDetector(
                     onTap: () => {
                       Navigator.push(context, MaterialPageRoute(
                           builder: (context) => SignUpScreen()
                       ))
                     },
                     child: RichText(
                       text:
                     TextSpan(
                         children: [
                           TextSpan(
                             text: 'Register Now',
                             style: GoogleFonts.lato(
                                 color: mainColor,
                                 fontWeight: FontWeight.bold
                             ),
                           )
                         ]
                     ),
                     ),
                   )
                 ],
               ),
             )
           ],
         ),
       ),
      )
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

