import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_splash_login_signup/Model/FamilyList/FamilyDetailListApi.dart';
import 'package:flutter_splash_login_signup/SETTINGS/addFamilyMember.dart';
import 'package:flutter_splash_login_signup/SETTINGS/editFamilyMember.dart';
import 'package:flutter_splash_login_signup/SETTINGS/settings.dart';
import 'package:flutter_splash_login_signup/constants.dart';
import 'package:flutter_splash_login_signup/home_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:humanitarian_icons/humanitarian_icons.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


void main(){
  runApp(
    MaterialApp(
      home: FamilyDetail(),
    ),
  );
}

class FamilyDetail extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => InitState();

}

class InitState extends State<FamilyDetail>{
  bool _isLoading = false;
  late FamilyDetailListApi familyDetailListApi;

  getFamilyDetailList() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print(sharedPreferences.getString("ID"));
    Map data = {
      'ID': sharedPreferences.getString("ID"),
    };
    final response = await http.post(
      Uri.parse('https://tamable-fellows.000webhostapp.com/fetchfamilydetails.php'), body: data,
    );
    familyDetailListApi = new FamilyDetailListApi.fromJsonMap(json.decode(response.body.toString()));
    if(response.statusCode == 200) {
      if (response != null) {
        setState(() {
          _isLoading = false;
        });
        print(response.body);
      }
    }else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }

  @override
  void initState() {
    _isLoading = true;
    getFamilyDetailList();
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
          'Family members',
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
          body: _isLoading ? Center(child: CircularProgressIndicator(color: mainColor,)) : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                      children: [
                        Container(
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => AddMembers()),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                              color: bgColor,
                              borderRadius: BorderRadius.all(Radius.circular(14)),
                          ),

                              child: Container(
                                child: Row(
                                    children: [
                                      IconButton(
                                          padding: EdgeInsets.zero,
                                            icon: Icon(
                                              CupertinoIcons.add_circled_solid,
                                              color: mainColor,
                                            size: 35,
                                            ),
                                        onPressed: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => AddMembers()),
                                          );
                                          },
                                        ),
                                      Container(
                                        margin: EdgeInsets.only(left: 8,right: 8, bottom: 8, top: 8),
                                        child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Add Members',
                                            style: GoogleFonts.lato(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold
                                            ),
                                          ),
                                    ],
                                  ),
                                )
                            ],
                          ),
                        ),
                ),
        ),
      ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:familyDetailListApi.flame.length,
                          itemBuilder: (BuildContext context, int index) {
                            return   Container(
                              child: GestureDetector(
                                onTap: (){
                                //  Navigator.push(context, MaterialPageRoute(builder: (context) => FamilyDetail()),);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: mainColor,
                                    borderRadius: BorderRadius.all(Radius.circular(14)),
                                  ),

                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                                alignment: Alignment.center,
                                                margin: EdgeInsets.only(left: 8,right: 8, bottom: 8, top: 8),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                                ),
                                                width: 40,
                                                height: 40,
                                                child: Center(
                                                  child: IconButton(
                                                    padding: EdgeInsets.zero,
                                                    icon: Icon(
                                                      LineAwesomeIcons.heart_1,
                                                      color: mainColor,
                                                      size: 28,
                                                    ),
                                                    onPressed: () {
                                                  //    Navigator.push(context, MaterialPageRoute(builder: (context) => FamilyDetail()),);
                                                    },
                                                  ),
                                                )
                                            ),
                                            Container(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    familyDetailListApi.flame[index].FAMILY_NAME,
                                                    style: GoogleFonts.lato(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.bold
                                                    ),
                                                  ),
                                                  Text(
                                                    familyDetailListApi.flame[index].RELATION,
                                                    style: GoogleFonts.lato(
                                                        color: Colors.black38,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.bold
                                                    ),
                                                  ),

                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        IconButton(
                                          padding: EdgeInsets.zero,
                                          icon: Icon(
                                            CupertinoIcons.forward,
                                            color: Colors.white,
                                            size: 35,
                                          ),
                                          onPressed: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => EditMembers(familyId: familyDetailListApi.flame[index].FAMILY_ID,familyName: familyDetailListApi.flame[index].FAMILY_NAME,familyEmail: familyDetailListApi.flame[index].FAMILY_EMAIL,familyContact: familyDetailListApi.flame[index].CONTACT,familyRelation: familyDetailListApi.flame[index].RELATION,)),
                                            ).whenComplete(() => getFamilyDetailList());
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
              ),
            ),
          ),
    );
  }
}
