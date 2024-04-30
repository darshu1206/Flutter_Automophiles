import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_splash_login_signup/Model/EditProfile/EditProfileApi.dart';
import 'package:flutter_splash_login_signup/constants.dart';
import 'package:flutter_splash_login_signup/SETTINGS/settings.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EditProfilePage(),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController dateInput = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController numberplateController = TextEditingController();
  String? selectedBG;
  String? selectedValue;
  late EditProfileApi editProfileApi;
  int val = -1;


  getDetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      nameController.text = sharedPreferences.getString("NAME")!;
      emailController.text = sharedPreferences.getString("EMAIL")!;
      passwordController.text = sharedPreferences.getString("PASSWORD")!;
      phoneController.text = sharedPreferences.getString("PHONE")!;
      addressController.text = sharedPreferences.getString("ADDRESS")!;
      dateInput.text = sharedPreferences.getString("DOB")!;
      selectedBG = sharedPreferences.getString("BG")!;
      numberplateController.text = sharedPreferences.getString("CAR_NUMBER_PLATE")!;
    });
  }

  void initState() {
    getDetails();
    super.initState();
  }
  bool showPassword = false;
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

  editProfile(name,email,password,phone,address,bloodgroup,dob,numberplate) async{
    print(name);
    print(email);
    print(phone);
    print(address);
    print(bloodgroup);
    print(dob);
    print(numberplate);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    Map data = {
      'ID': sharedPreferences.getString("ID"),
      'NAME': name,
      'EMAIL': email,
      'PASSWORD' : password,
      'PHONE': phone,
      'ADDRESS': address,
      'BG': bloodgroup,
      'DOB': dob,
      'CAR_NUMBER_PLATE': numberplate
    };

    var response = await http.post(Uri.parse("https://tamable-fellows.000webhostapp.com/UPDATE.php"), body: data);
    editProfileApi = new EditProfileApi.fromJsonMap(json.decode(response.body.toString()));

    if(response.statusCode==200){
      if(!editProfileApi.error){
        setState((){
          _isLoading = false;
        });
        sharedPreferences.setString("NAME",name);
        sharedPreferences.setString("EMAIL",email);
        sharedPreferences.setString("PASSWORD",password);
        sharedPreferences.setString("PHONE",phone);
        sharedPreferences.setString("ADDRESS",address);
        sharedPreferences.setString("BG",bloodgroup);
        sharedPreferences.setString("DOB",dob);
        sharedPreferences.setString("CAR_NUMBER_PLATE",numberplate);
        Fluttertoast.showToast(
            msg:editProfileApi.message,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2
        );
        Navigator.pop(context, MaterialPageRoute(builder: (context) => SettingsPage()));
      }
      else{
        setState((){
          _isLoading = false;
        });
        Fluttertoast.showToast(
            msg:editProfileApi.message,
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
      Fluttertoast.showToast(
          msg:editProfileApi.message,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          'Edit Profile',
          style: GoogleFonts.lato(color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, right: 16),
          child: ListView(
            children: [
              SizedBox(
                height: 15,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    //username
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 5,top: 10),
                      child: Text(
                        'Username',
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: mainColor
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10,right: 10),
                      child: TextFormField(
                        cursorColor: mainColor,
                        keyboardType: TextInputType.text,
                        controller: nameController,
                        validator:(value){
                          if(value!.isEmpty){
                            return "please enter Full Name";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter your name',
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: mainColor)
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          contentPadding: EdgeInsets.all(5),
                          hintStyle: GoogleFonts.lato(
                            color: Colors.black45,
                          )
                        ),
                      ),
                    ),

                    //DOB
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 5,top: 10),
                      child: Text(
                        'Date of Birth',
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: mainColor
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10,right: 10),
                      child: TextFormField(
                        cursorColor: mainColor,
                        controller: dateInput,
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                            hintText: 'Select your Date of Birth',
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: mainColor)
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            contentPadding: EdgeInsets.all(5),
                            hintStyle: GoogleFonts.lato(
                              color: Colors.black45,
                            )
                        ),
                        readOnly: true,  //set it true, so that user will not able to edit text
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context, initialDate: DateTime.now(),
                              firstDate: DateTime(1950), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101)
                          ).then((pickedDate) {
                          if(pickedDate != null ){
                            dateInput.text = DateFormat('yyy-MM-dd').format(pickedDate);
                          }
                          });
                        },
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return 'Please Enter date.';
                          }
                          return null;
                        },
                      ),
                    ),

                    //EMAIL
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 5,top: 10),
                      child: Text(
                        'Email',
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: mainColor
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10,right: 10),
                      child: TextFormField(
                        controller: emailController,
                        cursorColor: mainColor,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value){
                          if(value!.isEmpty){
                            return "please enter email";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: 'Enter your Email',
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: mainColor)
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            contentPadding: EdgeInsets.all(5),
                            hintStyle: GoogleFonts.lato(
                              color: Colors.black45,
                            )
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 5,top: 10),
                      child: Text(
                        'Password',
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: mainColor
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10,right: 10),
                      child: TextFormField(
                        controller: passwordController,
                        cursorColor: mainColor,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value){
                          if(value!.isEmpty){
                            return "please enter password";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: 'Enter your Password',
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: mainColor)
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            contentPadding: EdgeInsets.all(5),
                            hintStyle: GoogleFonts.lato(
                              color: Colors.black45,
                            )
                        ),
                      ),
                    ),

                    //PHONE NUMBER
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 5,top: 10),
                      child: Text(
                        'Phone Number',
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: mainColor
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10,right: 10),
                      child: TextFormField(
                        cursorColor: mainColor,
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        validator:(value){
                          if(value!.isEmpty){
                            return "please enter Phone Number";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: 'Enter your phone number',
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: mainColor)
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            contentPadding: EdgeInsets.all(5),
                            hintStyle: GoogleFonts.lato(
                              color: Colors.black45,
                            )
                        ),
                      ),
                    ),

                    //ADDRESS
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 5,top: 10),
                      child: Text(
                        'Address',
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: mainColor
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10,right: 10),
                      child: TextFormField(
                        cursorColor: mainColor,
                        controller: addressController,
                        validator:(value){
                          if(value!.isEmpty){
                            return "please enter Address";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                            hintText: 'Enter your address',
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: mainColor)
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            contentPadding: EdgeInsets.all(5),
                            hintStyle: GoogleFonts.lato(
                              color: Colors.black45,
                            )
                        ),
                      ),
                    ),

                    //BG
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 5,top: 10),
                      child: Text(
                        'Blood Group',
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: mainColor
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10,right: 10),
                      child: DropdownButton2(
                        isExpanded: true,
                        hint: Row(
                          children: [
                            Expanded(
                                child: Text(
                                  selectedBG!,
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
                        itemHeight: 40,
                        itemPadding: const EdgeInsets.only(left: 14, right: 14),
                        dropdownMaxHeight: 200,
                        dropdownWidth: 200,
                        dropdownDecoration: BoxDecoration(
                            color: mainColor
                        ),
                        buttonPadding: EdgeInsets.all(5),
                        dropdownPadding: null,
                        dropdownElevation: 8,
                        scrollbarRadius: const Radius.circular(40),
                        scrollbarThickness: 6,
                        scrollbarAlwaysShow: true,
                        offset: const Offset(100, 100),
                      )
                    ),

                    //NUMBER PLATE
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 5,top: 10),
                      child: Text(
                        'Car Number Plate',
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: mainColor
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10,right: 10),
                      child: TextFormField(
                        cursorColor: mainColor,
                        keyboardType: TextInputType.text,
                        controller: numberplateController,
                        validator:(value){
                          if(value!.isEmpty){
                            return "please enter Car Number Plate";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: 'Enter your Car Number Plate',
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: mainColor)
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            contentPadding: EdgeInsets.all(5),
                            hintStyle: GoogleFonts.lato(
                              color: Colors.black45,
                            )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 20, right: 20,),
                  padding: EdgeInsets.only(left: 15, right: 15),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState((){
                            _isLoading = true;
                          });
                          editProfile(nameController.text, emailController.text, passwordController.text, phoneController.text, addressController.text, selectedValue, dateInput.text, numberplateController.text);
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
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'SAVE',
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
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
    );
  }
}