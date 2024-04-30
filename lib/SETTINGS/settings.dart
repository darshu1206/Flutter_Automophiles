import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_splash_login_signup/SETTINGS/dos_donts.dart';
import 'package:flutter_splash_login_signup/constants.dart';
import 'package:flutter_splash_login_signup/SETTINGS/edit_profile.dart';
import 'package:flutter_splash_login_signup/SETTINGS/family_details.dart';
import 'package:flutter_splash_login_signup/SETTINGS/profilelistitem.dart';
import 'package:flutter_splash_login_signup/home_page.dart';
import 'package:flutter_splash_login_signup/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:avatar_view/avatar_view.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SettingsPage(),
    );
  }
}
class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String name="";
  String email="";

  getProfileDetail() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      name =  sharedPreferences.getString("NAME")!;
      email =  sharedPreferences.getString("EMAIL")!;
    });

  }

  @override
  void initState() {
    getProfileDetail();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        backgroundColor: mainColor,
        titleSpacing: 0,
        title: Text(
          'Settings',
          style: GoogleFonts.lato(color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, MaterialPageRoute(builder: (context) => HomePage()));
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
              size: 20
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  AvatarView(
                    radius: 40,
                    avatarType: AvatarType.CIRCLE,
                    backgroundColor: mainColor,
                    imagePath: "images/logo1.png",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                    Container(
                       child: Column(
                          children: [
                            Text(
                              name,
                              style: GoogleFonts.sanchez(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              email,
                              style: GoogleFonts.sanchez(
                                fontSize: 12,
                                color: Colors.white70,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        )
                    )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.only(left: 10, right: 10,top: 25,bottom: 15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 30,
                        color: Color(0xffEEEEEE)
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)
                  )
              ),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ProfileListItems(),
            ),
          ],
        ),
      )
    );
  }

  Row buildNotificationOptionRow(String title, bool isActive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.lato(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600]),
        ),
        Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              value: isActive,
              onChanged: (bool val) {},
            ))
      ],
    );
  }
}
class ProfileListItems extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
          children: [
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage()),
                );
              },
              child: ProfileListItem(
                icon: LineAwesomeIcons.edit,
                text: 'Edit Profile',
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => FamilyDetail()),
                );
              },
              child: ProfileListItem(
                icon: LineAwesomeIcons.heart,
                text: 'Family Details',
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Important()),
                );
              },
              child: ProfileListItem(
                icon: LineAwesomeIcons.list,
                text: "Important DO'S and DON'TS ",
              ),
            ),

            // GestureDetector(
            //   onTap: (){
            //     Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePassword()),
            //     );
            //   },
            //   child: ProfileListItem(
            //     icon: LineAwesomeIcons.cog,
            //     text: 'Change Password',
            //   ),
            // ),

            GestureDetector(
              onTap: (){
                Alert(context: context,
                    //type: AlertType.error,
                    style: AlertStyle(
                        backgroundColor: bgColor,
                        alertBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                                color: mainColor
                            )
                        ),
                        descStyle: GoogleFonts.lato(
                            color: Colors.black
                        ),
                        titleStyle: GoogleFonts.lato(
                            color: mainColor,
                            fontSize: 25,
                            fontWeight: FontWeight.bold
                        )
                    ),
                    title: 'Are You Sure?',
                    desc: 'Do you want to logout?',
                    buttons: [
                      DialogButton(
                        child: Text(
                          "Cancel",
                          style: GoogleFonts.lato(
                              color: mainColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        onPressed:() {
                          Navigator.of(context).pop();
                        },
                        color: Colors.white,
                      ),
                      DialogButton(
                        child: Text(
                          "Confirm",
                          style: GoogleFonts.lato(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        onPressed: () async {
                          final pref = await SharedPreferences.getInstance();
                          await pref.clear();
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                              builder: (BuildContext context) => LoginScreen()), (
                              Route<dynamic> route) => false);
                        },
                        color: mainColor,
                      ),
                    ]
                ).show();
              },
              child: ProfileListItem(
                icon: LineAwesomeIcons.alternate_sign_out,
                text: 'Logout',
                hasNavigation: false,
              ),
            ),
          ],
        )
    );
  }
}