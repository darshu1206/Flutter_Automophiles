import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_splash_login_signup/Model/Emergency/EmergencyApi.dart';
import 'package:flutter_splash_login_signup/SENSORS/FLAME_SENSOR.dart';
import 'package:flutter_splash_login_signup/SENSORS/MQ4GAS_SENSOR.dart';
import 'package:flutter_splash_login_signup/SENSORS/SMOKE_SENSOR.dart';
import 'package:flutter_splash_login_signup/SENSORS/SOUND_SENSOR.dart';
import 'package:flutter_splash_login_signup/SENSORS/TEMPRATURE_SENSOR.dart';
import 'package:flutter_splash_login_signup/constants.dart';
import 'package:flutter_splash_login_signup/SETTINGS/settings.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:humanitarian_icons/humanitarian_icons.dart';
import 'package:flutter_splash_login_signup/Model/DashBoard/DashBoardListApi.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main(){
  runApp(
    MaterialApp(
      home: HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage>{
  bool _isLoading = false;
  late DashBoardListApi DashBoardApi;
  late EmergencyApi emergencyApi;
  Timer? timeapi;

  getDashBoard() async {

    final response = await http.get(
      Uri.parse("https://tamable-fellows.000webhostapp.com/QWERT.php"),
    );
    DashBoardApi = new DashBoardListApi.fromJsonMap(json.decode(response.body.toString()));
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

  emergency(lat,long) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print(lat);
    print(long);

    Map data = {
      'lat': lat,
      'long' : long,
      'lid': sharedPreferences.getString("ID"),
    };

    var response = await http.post(Uri.parse("https://tamable-fellows.000webhostapp.com/sms.php"), body: data);
    emergencyApi = new EmergencyApi.fromJsonMap(json.decode(response.body.toString()));

    if(response.statusCode==200){
      if(!emergencyApi.error){
        setState((){
          _isLoading = false;
        });
        Fluttertoast.showToast(
            msg:emergencyApi.message,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2
        );
      }
      else{
        setState((){
          _isLoading = false;
        });
        Fluttertoast.showToast(
            msg:emergencyApi.message,
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
          msg:emergencyApi.message,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2
      );
    }
  }

  @override
  void initState() {
    _isLoading=true;
    timeapi = Timer.periodic(Duration(seconds:2), (timer) { getDashBoard();});
    getDashBoard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: mainColor,
          appBar: AppBar(
            // titleSpacing: 0,
            title: Text('Automophiles',
              style: GoogleFonts.cookie(fontSize: 40, color: Colors.white),
            ),
            elevation: 0,
            backgroundColor: mainColor,
            actions: [
              Container(
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: bgColor,
                          child: Icon(
                            CupertinoIcons.profile_circled,
                            color: mainColor,
                            size: 25,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),

          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              setState(() {
                _isLoading = true;
              });
              await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
                  .then((Position position) {
                setState(() {
                  emergency(position.latitude.toString(),  position.longitude.toString() );
                });
              }).catchError((e) async {
                GeolocatorPlatform.instance.openAppSettings();
                print(e);
              });

            },
            backgroundColor: Colors.red,
            icon: Icon(HumanitarianIcons.ambulance),
            splashColor: mainColor,
            elevation: 4,
            label: Text(
              'Emergency',
             style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold
                ),
              ),
            ),
          body:
          Container(
            margin: EdgeInsets.only(top: 30),
            padding: EdgeInsets.only(left: 10, right: 10,top: 15,bottom: 10),
            decoration: BoxDecoration(
              color: bgColor,
              boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 30,
                          color: Color(0xffEEEEEE)
                      ),
                    ],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40)
              )
            ),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: _isLoading ? Center(child:
              CircularProgressIndicator(
              color: mainColor,
            )
            ) :GridView.count(
                crossAxisCount: 2,
                children: [
                    GridTile(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SmokeSensor()),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  mainColor,
                                  gradientColor,
                                  mainColor2,],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter
                            ),
                        // color: mainColor,
                        borderRadius: BorderRadius.all(Radius.circular(14)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black38,
                            offset: const Offset(4.0, 4.0),
                            blurRadius: 6.0,
                            spreadRadius: 1.0
                          ),
                          BoxShadow(
                            color: Colors.white,
                            offset: const Offset(0.0, 0.0),
                            blurRadius: 0.0,
                            spreadRadius: 0.0
                          )
                        ]
                      ),
                        child: Column(
                          children: [
                            Text(
                              'SMOKE',
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Image.asset('images/smoke.png',height: 100,width: 100,),
                            Text(
                                DashBoardApi.SMOKE,
                              style: GoogleFonts.lato(
                                fontSize: 16,
                                //fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  GridTile(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => FlameSensor()),
                        );
                        },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      mainColor,
                                      gradientColor,
                                      mainColor2,],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter
                                ),
                              // color: mainColor,
                              borderRadius: BorderRadius.all(Radius.circular(14)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black38,
                                  offset: const Offset(4.0, 4.0),
                                  blurRadius: 6.0,
                                  spreadRadius: 1.0
                                ),
                                BoxShadow(
                                  color: Colors.white,
                                  offset: const Offset(0.0, 0.0),
                                  blurRadius: 0.0,
                                  spreadRadius: 0.0
                                )
                              ]
                            ),
                          child: Column(
                            children: [
                              Text(
                                'FIRE',
                                style: GoogleFonts.lato(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              Image.asset('images/fire.png',height: 100,width: 100,),
                              Text(DashBoardApi.FLAME,
                                style: GoogleFonts.lato(
                                  fontSize: 16,
                                  //fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                GridTile(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SoundSensor()),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    mainColor,
                                    gradientColor,
                                    mainColor2,],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter
                              ),
                          //color: mainColor,
                          borderRadius: BorderRadius.all(Radius.circular(14)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38,
                              offset: const Offset(4.0, 4.0),
                              blurRadius: 6.0,
                              spreadRadius: 1.0
                            ),
                            BoxShadow(
                              color: Colors.white,
                              offset: const Offset(0.0, 0.0),
                              blurRadius: 0.0,
                              spreadRadius: 0.0
                            )
                          ]
                        ),
                          child: Column(
                            children: [
                              Text(
                                'SOUND',
                                style: GoogleFonts.lato(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Image.asset('images/sound.png',height: 90,width: 90,),
                              SizedBox(
                                height: 5,
                              ),

                              Text(DashBoardApi.SOUND,
                                style: GoogleFonts.lato(
                                  fontSize: 16,
                                  //fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                GridTile(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => TempSensor()),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    mainColor,
                                    gradientColor,
                                    mainColor2,],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter
                              ),
                            //color: mainColor,
                            borderRadius: BorderRadius.all(Radius.circular(14)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black38,
                                offset: const Offset(4.0, 4.0),
                                blurRadius: 6.0,
                                spreadRadius: 1.0
                              ),
                              BoxShadow(
                                color: Colors.white,
                                offset: const Offset(0.0, 0.0),
                                blurRadius: 0.0,
                                spreadRadius: 0.0
                              )
                            ]
                          ),
                          child: Column(
                            children: [
                              Text(
                                'TEMPERATURE',
                                style: GoogleFonts.lato(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              Image.asset('images/temp.png',height: 100,width: 100,),
                              Text(DashBoardApi.TEMP,
                                style: GoogleFonts.lato(
                                  fontSize: 16,
                                  //fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                GridTile(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MQ4Sensor()),
                          );
                        },
                        child: Container(
                        padding: const EdgeInsets.all(5),
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  mainColor,
                                  gradientColor,
                                  mainColor2,],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter
                            ),
                          //color: mainColor,
                          borderRadius: BorderRadius.all(Radius.circular(14)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38,
                              offset: const Offset(4.0, 4.0),
                              blurRadius: 6.0,
                              spreadRadius: 1.0
                            ),
                            BoxShadow(
                              color: Colors.white,
                              offset: const Offset(0.0, 0.0),
                              blurRadius: 0.0,
                              spreadRadius: 0.0
                            )
                          ]
                        ),
                        child: Column(
                          children: [
                            Text(
                              'CNG GAS',
                              style: GoogleFonts.lato(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Image.asset('images/cng.png',height: 90,width: 90,),
                            SizedBox(
                              height: 5,
                            ),
                            Text(DashBoardApi.MQ4,
                              style: GoogleFonts.lato(
                                fontSize: 16,
                                //fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                  ),
                ),
              ), 
                ],
              ),
          )
        );
  }
}