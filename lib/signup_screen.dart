import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_splash_login_signup/Model/LOGIN/LoginApi.dart';
import 'package:flutter_splash_login_signup/Model/SIGNUP/SignupApi.dart';
import 'package:flutter_splash_login_signup/constants.dart';
import 'package:flutter_splash_login_signup/home_page.dart';
import 'package:flutter_splash_login_signup/login_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<SignUpScreen> {

  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  bool _isObscure = true; //boolean value to track password view enable disable.
  TextEditingController nameController = TextEditingController();
  TextEditingController dateInput = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController numberplateController = TextEditingController();
  String? selectedValue;
  late SignupApi signupApi;
  //bool _value = false;
  int val = -1;

  List<String> items =[
    'A+',
    'B+',
    'O+',
    'AB+',
    'A-',
    'B-',
    'O-',
    'AB-',
  ];

  void initState() {
    dateInput.text = "";
    //set the initial value of text field
    super.initState();
  }

  signup(name,email,password,phone,address,bloodgroup,dob,numberplate) async{
    print(name);
    print(email);
    print(phone);
    print(address);
    print(bloodgroup);
    print(dob);
    print(numberplate);

    Map data = {
      'NAME': name,
      'EMAIL': email,
      'PASSWORD' : password,
      'PHONE': phone,
      'ADDRESS': address,
      'BG': bloodgroup,
      'DOB': dob,
      'CAR_NUMBER_PLATE': numberplate
    };

    var response = await http.post(Uri.parse("https://tamable-fellows.000webhostapp.com/SIGNUP.php"), body: data);
    signupApi = new SignupApi.fromJsonMap(json.decode(response.body.toString()));

    if(response.statusCode==200){
      if(!signupApi.error){
        setState((){
          _isLoading = false;
        });
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => LoginScreen()
        ));
      }
      else{
        setState((){
          _isLoading = false;
        });
        Fluttertoast.showToast(
            msg:signupApi.message,
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
      // print("");
    }
  }
  @override
  Widget build(BuildContext context) => initWidget();

  Widget initWidget() {
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
                      gradient: LinearGradient(colors: [mainColor, mainColor2,],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight
                      ),
                    ),
                    child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 50),
                              child: Image.asset(
                                "images/app_logo.png",
                                height: 150,
                                width: 150,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 20, top: 2),
                              alignment: Alignment.bottomRight,
                              child: Text(
                                "Register",
                                style: GoogleFonts.robotoSlab(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                ),
                              ),
                            )
                          ],
                        )
                    ),
                  ),

                  //FULL NAME
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 20, right: 20, top: 40),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey[200],
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 50,
                            color: Color(0xffEEEEEE)
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: nameController,
                      validator:(value){
                        if(value!.isEmpty){
                          return "please enter Full Name";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      cursorColor: mainColor,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: mainColor,
                        ),
                        hintText: "Full Name",
                        hintStyle: GoogleFonts.lato(
                          color: Colors.black45,
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),

                  //DOB
                  Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                      padding: EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.grey[200],
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 50,
                              color: Color(0xffEEEEEE)
                          ),
                        ],
                      ),
                      child: Center(
                        child: TextFormField(
                          keyboardType: TextInputType.datetime,
                          controller: dateInput,
                          cursorColor: mainColor,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.calendar_today,
                              color: mainColor,
                            ),
                            hintText: "Date of Birth",
                            hintStyle: GoogleFonts.lato(
                              color: Colors.black45,
                            ),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          readOnly: true,
                          validator:(value){
                          if(value!.isEmpty){
                            return "Date of Birth is not selected";
                          }
                          return null;
                        }, //set it true, so that user will not able to edit text
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context, initialDate: DateTime.now(),
                                firstDate: DateTime(1950), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2101)
                            );

                            if(pickedDate != null ){
                              print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                              String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                              print(formattedDate); //formatted date output using intl package =>  2021-03-16
                              //you can implement different kind of Date Format here according to your requirement

                              setState(() {
                                dateInput.text = formattedDate; //set output date to TextField value.
                              });
                            }else{
                              print("Date is not selected");
                            }
                          },
                        ),
                      )
                  ),

                  //EMAIL
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey[200],
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 50,
                            color: Color(0xffEEEEEE)
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
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
                        hintText: "Email",
                        hintStyle: GoogleFonts.lato(
                          color: Colors.black45,
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),

                  //PHONE NUMBER
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Color(0xffEEEEEE),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 20),
                            blurRadius: 100,
                            color: Color(0xffEEEEEE)
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      validator:(value){
                        if(value!.isEmpty){
                          return "please enter Phone Number";
                        }
                        return null;
                      },
                      cursorColor: mainColor,
                      decoration: InputDecoration(
                        focusColor:mainColor,
                        icon: Icon(
                          Icons.phone,
                          color: mainColor,
                        ),
                        hintText: "Phone Number",
                        hintStyle: GoogleFonts.lato(
                          color: Colors.black45,
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),

                  //PASSWORD
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
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      validator:(value){
                        if(value!.isEmpty){
                          return "please enter password";
                        }
                        return null;
                      },
                      obscureText: _isObscure,
                      cursorColor: mainColor,
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.vpn_key,
                            color: mainColor,
                          ),
                          hintText: "Enter Password",
                          suffixIcon: IconButton(
                              onPressed: () {
                                //add Icon button at end of TextField
                                setState(() {
                                  //refresh UI
                                  if (_isObscure) {
                                    //if passenable == true, make it false
                                    _isObscure = false;
                                  } else {
                                    _isObscure = true; //if passenable == false, make it true
                                  }
                                });
                              },
                              icon:
                              Icon(
                                _isObscure == true ? Icons.visibility_off : Icons.visibility,
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

                  //ADDRESS
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey[200],
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 50,
                            color: Color(0xffEEEEEE)
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: addressController,
                      keyboardType: TextInputType.multiline,
                      validator:(value){
                        if(value!.isEmpty){
                          return "please enter Address";
                        }
                        return null;
                      },
                      maxLines: null,
                      cursorColor: mainColor,
                      decoration: InputDecoration(
                        icon: Icon(
                          CupertinoIcons.placemark_fill,
                          color: mainColor,
                        ),
                        hintText: "Address",
                        hintStyle: GoogleFonts.lato(
                          color: Colors.black45,
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),

                  //BLOOD GROUP
                  Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                      padding: EdgeInsets.only(left: 20, right: 20, top: 4,bottom: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.grey[200],
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 50,
                              color: Color(0xffEEEEEE)
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                isExpanded: true,
                                hint: Row(
                                  children: [
                                    const Icon(
                                      Icons.bloodtype,
                                      color: mainColor,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                        child: Text(
                                          'Select Your Blood Group',
                                          style: GoogleFonts.lato(
                                            color: Colors.black45,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        )

                                    )
                                  ],
                                ),
                                items: items.map((items) => DropdownMenuItem<String>(
                                  value: items,
                                  child: Text(
                                    items,
                                    style: GoogleFonts.lato(
                                    ),
                                  ),
                                )
                                ).toList(),
                                value: selectedValue,
                                onChanged: (value){
                                  setState(() {
                                    selectedValue = value as String;
                                  });
                                },
                                icon: const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                ),
                                iconSize: 15,
                                iconEnabledColor: Colors.black54,
                                buttonDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: Colors.grey[200],
                                ),

                                itemHeight: 40,
                                itemPadding: const EdgeInsets.only(left: 14, right: 14),
                                dropdownMaxHeight: 200,
                                dropdownWidth: 200,
                                dropdownDecoration: BoxDecoration(
                                    color: mainColor
                                ),
                                dropdownPadding: null,
                                dropdownElevation: 8,
                                scrollbarRadius: const Radius.circular(40),
                                scrollbarThickness: 6,
                                scrollbarAlwaysShow: true,
                                offset: const Offset(-20, 0),
                              )
                          )
                        ],
                      )
                  ),

                  //NUMBER PLATE
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey[200],
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 50,
                            color: Color(0xffEEEEEE)
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: numberplateController,
                      keyboardType: TextInputType.text,
                      validator:(value){
                        if(value!.isEmpty){
                          return "please enter Vehicle Number Plate";
                        }
                        return null;
                      },
                      cursorColor: mainColor,
                      decoration: InputDecoration(
                        icon: Icon(
                          CupertinoIcons.car_detailed,
                          color: mainColor,
                        ),
                        hintText: "Vehicle Number Plate",
                        hintStyle: GoogleFonts.lato(
                          color: Colors.black45,
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),

                  //REGISTER BUTTON
                  Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 20, right: 20, top: 30),
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
                              signup(nameController.text, emailController.text, passwordController.text, phoneController.text, addressController.text, selectedValue, dateInput.text, numberplateController.text);
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
                                    text: 'REGISTER',
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
                    margin: EdgeInsets.only(top: 10, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Have You Already Member?  ",
                          style: GoogleFonts.lato(color: Colors.black),),
                        GestureDetector(
                          child: RichText(text:
                          TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Login Now',
                                  style: GoogleFonts.lato(
                                      color: mainColor,
                                      fontWeight: FontWeight.bold
                                  ),
                                )
                              ]
                          ),
                          ),
                          onTap: () {
                            // Write Tap Code Here.
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                  )
                ],
              )
          ),
        )
    );
  }
}