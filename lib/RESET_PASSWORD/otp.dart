import 'package:flutter/material.dart';
import 'package:flutter_splash_login_signup/RESET_PASSWORD/reset_password.dart';
import 'package:flutter_splash_login_signup/constants.dart';
import 'package:flutter_splash_login_signup/signup_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';

void main() => runApp(OTP());

class OTP extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<OTP> {
  int _otpCodeLength = 4;
  bool _isLoadingButton = false;
  bool _enableButton = false;
  String _otpCode = "";
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final intRegex = RegExp(r'\d+', multiLine: true);
  TextEditingController textEditingController = new TextEditingController(text: "");

  @override
  void initState() {
    super.initState();
    _getSignatureCode();
    _startListeningSms();
  }

  @override
  void dispose() {
    super.dispose();
    SmsVerification.stopListening();
  }

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(
          color: mainColor,
        width: 2
      ),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  /// get signature code
  _getSignatureCode() async {
    String? signature = await SmsVerification.getAppSignature();
    print("signature $signature");
  }

  /// listen sms
  _startListeningSms()  {
    SmsVerification.startListeningSms().then((message) {
      setState(() {
        _otpCode = SmsVerification.getCode(message, intRegex);
        textEditingController.text = _otpCode;
        _onOtpCallBack(_otpCode, true);
      });
    });
  }

  _onSubmitOtp() {
    setState(() {
      _isLoadingButton = !_isLoadingButton;
      _verifyOtpCode();
    });
  }

  _onClickRetry() {
    _startListeningSms();
  }

  _onOtpCallBack(String otpCode, bool isAutofill) {
    setState(() {
      this._otpCode = otpCode;
      if (otpCode.length == _otpCodeLength && isAutofill) {
        _enableButton = false;
        _isLoadingButton = true;
        _verifyOtpCode();
      } else if (otpCode.length == _otpCodeLength && !isAutofill) {
        _enableButton = true;
        _isLoadingButton = false;
      } else {
        _enableButton = false;
      }
    });
  }

  _verifyOtpCode() {
    FocusScope.of(context).requestFocus(new FocusNode());
    Timer(Duration(milliseconds: 4000), () {
      setState(() {
        _isLoadingButton = false;
        _enableButton = false;
      });

      // _scaffoldKey.currentState?.showSnackBar(
      //     SnackBar(content: Text("Verification OTP Code $_otpCode Success")));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
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
                      margin: EdgeInsets.only(right: 15, top: 2),
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "OTP Verification",
                        style: GoogleFonts.robotoSlab(
                            fontSize: 22,
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
              margin: EdgeInsets.only(top: 50),
              child:
              Text("Enter 4 Digits Code",
                style: GoogleFonts.robotoSlab(color: mainColor, fontSize: 25, fontWeight: FontWeight.bold ),
                textAlign: TextAlign.center,
              ),
          ),
            Container(
              margin: EdgeInsets.only(top: 20,left: 25,right: 25),
              child:
              Text("Please enter the 4 digit code that you received on your email.",
                style: GoogleFonts.lato(color: Colors.black87, fontSize: 15, ),
                textAlign: TextAlign.justify,
              ),
          ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 50),
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFieldPin(
                      textController: textEditingController,
                      autoFocus: true,
                      codeLength: _otpCodeLength,
                      alignment: MainAxisAlignment.center,
                      defaultBoxSize: 46.0,
                      margin: 10,
                      selectedBoxSize: 46.0,
                      textStyle: TextStyle(fontSize: 16),
                      defaultDecoration: _pinPutDecoration.copyWith(
                          border: Border.all(
                              color: gradientColor,)),
                      selectedDecoration: _pinPutDecoration,
                      onChange: (code) {
                        _onOtpCallBack(code,false);
                      }),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Didn't get code?  ",
                          style: GoogleFonts.lato(color: Colors.black),
                        ),
                        GestureDetector(
                          onTap: () => {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => SignUpScreen()
                            ))
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(
                                color: mainColor,
                                width: 1.0
                              ))
                            ),
                            child: Text(
                              "Resend OTP",
                              style: GoogleFonts.lato(
                                    color: mainColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          )
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                     padding: EdgeInsets.only(left: 20, right: 20),
                    width: double.maxFinite,
                    child: MaterialButton(
                      padding: EdgeInsets.only(left: 20, right: 20,top: 10,bottom: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50), topLeft: Radius.circular(50), bottomRight: Radius.circular(50))
                      ),
                      onPressed: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) => ResetPassScreen()
                        ));
                      _enableButton ? _onSubmitOtp : null;
                      },
                      child: _setUpButtonChild(),
                      color: mainColor,
                      disabledColor: mainColor2,
                    ),
                  ),
                  // Container(
                  //   width: double.maxFinite,
                  //   child: TextButton(
                  //     onPressed: _onClickRetry,
                  //     child: Text(
                  //       "Retry",
                  //       style: TextStyle(color: Colors.orange),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            )
  ]
    )
        ),
    );
  }

  Widget _setUpButtonChild() {
    if (_isLoadingButton) {
      return Container(
        width: 19,
        height: 19,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    } else {
      return Text(
        "Verify".toUpperCase(),
        style: GoogleFonts.lato(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,),
      );
    }
  }
}