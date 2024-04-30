import 'package:flutter/material.dart';

// const mainColor = Color(0xFF00BCD4);
// const gradientColor = Color(0xFF26C6DA);
const bgColor = Color(0xFFE0F7FA);
const mainColor2 = Color(0xFFBBDEFB);

const mainColor = Color(0xFF1565C0);
const gradientColor = Color(0xFF42A5F5);

class Constants{
  static const Color PRIMARY_COLOR = Color(0xffFBFBFB);
  static const String OTP_GIF_IMAGE = "assets/app_logo.gif";

  static const String edit = 'Edit Relation';
  static const String delete = 'Delete';

  static const List<String> choices = <String>[
    edit,
    delete
  ];

}

ShapeBorder kBackButtonShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    topRight: Radius.circular(30)
  )
);

Widget kBackBtn = Icon(
  Icons.arrow_back_ios
);

Color kAppPrimaryColor = Colors.grey.shade200;
Color kWhite = Colors.white;
Color kLightBlack = Colors.black.withOpacity(0.075);
Color mCC = Colors.green.withOpacity(0.65);
Color fCL = Colors.grey.shade600;


IconData twitter = IconData(0xe900, fontFamily: "CustomIcons");
IconData facebook = IconData(0xe901, fontFamily: "CustomIcons");
IconData googlePlus =
IconData(0xe902, fontFamily: "CustomIcons");
IconData linkedin = IconData(0xe903, fontFamily: "CustomIcons");

const kSpacingUnit = 10;

final kTitleTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w600,
);

BoxDecoration avatarDecoration = BoxDecoration(
    shape: BoxShape.circle,
    color: kAppPrimaryColor,
    boxShadow: [
      BoxShadow(
        color: kWhite,
        offset: Offset(10, 10),
        blurRadius: 10,
      ),
      BoxShadow(
        color: kWhite,
        offset: Offset(-10, -10),
        blurRadius: 10,
      ),
    ]
);