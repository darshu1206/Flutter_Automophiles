import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_splash_login_signup/Model/AddFamilyDetail/AddFamilyDetailApi.dart';
import 'package:flutter_splash_login_signup/constants.dart';
import 'package:flutter_splash_login_signup/SETTINGS/family_details.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home_page.dart';
import 'package:http/http.dart' as http;


class EditMembers extends StatefulWidget{
  final String familyId;
  final String familyName;
  final String familyEmail;
  final String familyContact;
  final String familyRelation;
  EditMembers({required this.familyId,required this.familyName,required this.familyEmail,required this.familyContact,required this.familyRelation});

  @override
  State<StatefulWidget> createState() => InitState();

}

class InitState extends State<EditMembers> {
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  TextEditingController familyNameController = TextEditingController();
  TextEditingController familyEmailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  String? selectedValue;
  List<String> items =[
    'Father',
    'Mother',
    'Son',
    'Daughter',
    'Husband',
    'Wife',
    'Brother',
    'Sister',
    'Uncle',
    'Aunt',
    'Cousin',
    'GrandFather',
    'GrandMother',
  ];
  late AddFamilyDetailApi addFamilyDetailApi;


  editFamilyDetail(familyName,contact,familyEmail,relation) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print(familyName);
    print(contact);
    print(familyEmail);
    print(relation);

    Map data = {
      'FAMILY_ID': widget.familyId,
      'FAMILY_NAME': familyName,
      'CONTACT' : contact,
      'FAMILY_EMAIL': familyEmail,
      'RELATION': relation
    };

    var response = await http.post(Uri.parse("https://tamable-fellows.000webhostapp.com/family_update.php"), body: data);
    addFamilyDetailApi = new AddFamilyDetailApi.fromJsonMap(json.decode(response.body.toString()));

    if(response.statusCode==200){
      if(!addFamilyDetailApi.error){
        setState((){
          _isLoading = false;
        });
        Fluttertoast.showToast(
            msg:addFamilyDetailApi.message,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2
        );
        Navigator.of(context).pop();
      }
      else{
        setState((){
          _isLoading = false;
        });
        Fluttertoast.showToast(
            msg:addFamilyDetailApi.message,
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
          msg:addFamilyDetailApi.message,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2
      );
    }
  }

  @override
  void initState() {
    familyNameController.text = widget.familyName;
    contactController.text = widget.familyContact;
    familyEmailController.text = widget.familyEmail;
    super.initState();
  }
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
            'Update family members',
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          leading: new IconButton(
            icon: Icon(Icons.arrow_back_ios,size: 20,),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),

        ),
        body: _isLoading ? Center(child: CircularProgressIndicator(color: mainColor,)) : SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10,top: 10,bottom: 10),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(left: 10, right: 10, top: 20),
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
                            controller: familyNameController,
                            keyboardType: TextInputType.text,
                            cursorColor: mainColor,
                            validator:(value){
                              if(value!.isEmpty){
                                return "please enter Family Member's Full Name";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.person,
                                color: mainColor,
                              ),
                              hintText: "Family Member's Full Name",
                              hintStyle: GoogleFonts.lato(
                                color: Colors.black45,
                              ),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(left: 10, right: 10, top: 20),
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
                            controller: familyEmailController,
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: mainColor,
                            validator:(value){
                              if(value!.isEmpty){
                                return "please enter Family Member's Email";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.email,
                                color: mainColor,
                              ),
                              hintText: "Family Member's Email",
                              hintStyle: GoogleFonts.lato(
                                color: Colors.black45,
                              ),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                          padding: EdgeInsets.only(left: 20, right: 15),
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
                            controller: contactController,
                            keyboardType: TextInputType.number,
                            cursorColor: mainColor,
                            validator:(value){
                              if(value!.isEmpty){
                                return "please enter Family Member's Contact Number";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              focusColor:mainColor,
                              icon: Icon(
                                Icons.phone,
                                color: mainColor,
                              ),
                              hintText: "Family Member's Contact Number",
                              hintStyle: GoogleFonts.lato(
                                color: Colors.black45,
                              ),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ),
                     Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                        padding: EdgeInsets.only(left: 20, right: 20, top: 4, bottom: 4),
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
                        child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              isExpanded: true,
                              hint: Row(
                                children: [
                                  const Icon(
                                    CupertinoIcons.sparkles,
                                    color: mainColor,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                      child: Text(
                                        widget.familyRelation,
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
                              offset: const Offset(60, 5),
                            )
                        )
                      ),
                        Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                            padding: EdgeInsets.only(left: 20, right: 20),

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(onPressed: (){
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  if(selectedValue==""||selectedValue==null){
                                   editFamilyDetail(familyNameController.text, contactController.text, familyEmailController.text, widget.familyRelation);
                                  }else{
                                    editFamilyDetail(familyNameController.text, contactController.text, familyEmailController.text, selectedValue);
                                  }

                                },
                                  style: ElevatedButton.styleFrom(
                                      primary: mainColor,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.only(left: 20, right: 20),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50)
                                      ),
                                      minimumSize: Size(200, 45),
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
                                          text: 'Update',
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
                      ],
                    ),
                  ),
                )
              ]
          ),
        )

    );
  }
}