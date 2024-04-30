import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_splash_login_signup/Model/Temp/TempListApi.dart';
import 'package:flutter_splash_login_signup/constants.dart';
import 'package:flutter_splash_login_signup/home_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:http/http.dart' as http;


void main(){
  runApp(
    MaterialApp(
      home: TempSensor(),
    ),
  );
}

class TempSensor extends StatefulWidget{
  const TempSensor({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => TempSensorState();

}

class TempSensorState extends State<TempSensor>{
  bool _isLoading = false;
  late TempListApi TempApi;
  Timer? timeapi;

  getTemp() async {

    final response = await http.get(
      Uri.parse('https://tamable-fellows.000webhostapp.com/tempdata.php'),
    );
    TempApi = new TempListApi.fromJsonMap(json.decode(response.body.toString()));
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
    _isLoading=true;
    timeapi = Timer.periodic(Duration(seconds:2), (timer) { getTemp();});
    getTemp();
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,size: 20,color: Colors.white,),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text("Temperature",style: GoogleFonts.lato(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20,),),
      ),
        body:  _isLoading ? Center(
            child: CircularProgressIndicator(
              color: mainColor,
            )) :
        ListView.builder(
          shrinkWrap: true,
          itemCount: TempApi.temp.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(left: 16, right: 16,top: 16),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: mainColor2,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child:  Text("TEMP_VALUE:",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child:  Text(TempApi.temp[index].TEMP_VALUE),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child:  Text("READING_TIME: ",
                              style: TextStyle(fontWeight: FontWeight.bold),),
                          ),
                          Expanded(
                            flex: 1,
                            child:  Text(TempApi.temp[index].READING_TIME),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        )
    );
  }

}