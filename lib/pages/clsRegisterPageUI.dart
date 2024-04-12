import 'package:ecommerce/constants/clsCommonWidget.dart';
import 'package:ecommerce/constants/clsDimensConstants.dart';
import 'package:ecommerce/localStorage/clsSharedPrefernce.dart';
import 'package:ecommerce/localStorage/clsSharedPrefernceKeyValue.dart';
import 'package:ecommerce/models/clsCommonResposneModel.dart';
import 'package:ecommerce/my_webview.dart';
import 'package:ecommerce/network/clsApiCallMethods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';
import '../models/clsUserModel.dart';
import 'clsHomePageUI.dart';

class clsRegisterPageUI extends StatefulWidget {
  const clsRegisterPageUI({Key? key}) : super(key: key);

  @override
  State<clsRegisterPageUI> createState() => _clsRegisterPageUIState();
}

class _clsRegisterPageUIState extends State<clsRegisterPageUI> {
  FocusNode _firstnamefocusNode = FocusNode();
  FocusNode _lastnamefocusNode = FocusNode();
  FocusNode _usernamefocusNode = FocusNode();
  FocusNode _passwordfocusNode = FocusNode();
  FocusNode _confirmpasswordfocusNode = FocusNode();
  FocusNode _mobilefocusNode = FocusNode();
  bool firstnametextEditHasFocus = true;
  bool lastnametextEditHasFocus = true;
  bool usernametextEditHasFocus = true;
  bool passwordtextEditHasFocus = true;
  bool confirmpasswordtextEditHasFocus = true;
  bool mobiletextEditHasFocus = true;

  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();
  TextEditingController _otpFieldcontroller = TextEditingController();
  TextEditingController _mobilecontroller = TextEditingController();

  bool rememberme_ischecked = false;
  bool privacy_ischecked = false;
  bool dataprivacy_ischecked = false;
  bool passordVisible = false;
  bool confirmPassVisible = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(clsDimensConstants.douDp25),
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Image.asset(
                "assets/images/img.png",
                height: 100,
              ),
              Align(
                child: Text(
                  'Welcome to Galleon !',
                  style: GoogleFonts.montserrat(
                      fontSize: clsDimensConstants.douDp25,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: clsDimensConstants.douDp20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Register',
                    style: GoogleFonts.montserrat(
                        fontSize: clsDimensConstants.douDp25,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  Container(
                    child: TextField(
                      focusNode: _firstnamefocusNode,
                      controller: _firstnameController,
                      decoration: InputDecoration(
                        // hintText: textEditHasFocus ? '' : 'Label',
                        // hintStyle: TextStyle(
                        //   color: Colors.grey,
                        // ),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        contentPadding: EdgeInsets.only(left: 10),
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 200),
                    left: firstnametextEditHasFocus ? 10 : 20,
                    top: firstnametextEditHasFocus ? -10 : 13,
                    child: InkWell(
                      onTap: () {
                        _firstnamefocusNode.requestFocus();
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 3),
                        color: Colors.white,
                        child: Text('FirstName'),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  Container(
                    child: TextField(
                      focusNode: _lastnamefocusNode,
                      controller: _lastnameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        contentPadding: EdgeInsets.only(left: 10),
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 200),
                    left: lastnametextEditHasFocus ? 10 : 20,
                    top: lastnametextEditHasFocus ? -10 : 13,
                    child: InkWell(
                      onTap: () {
                        _lastnamefocusNode.requestFocus();
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 3),
                        color: Colors.white,
                        child: Text('LastName'),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  Container(
                    child: TextField(
                      focusNode: _usernamefocusNode,
                      controller: _usernameController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        contentPadding: EdgeInsets.only(left: 10),
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 200),
                    left: usernametextEditHasFocus ? 10 : 20,
                    top: usernametextEditHasFocus ? -10 : 13,
                    child: InkWell(
                      onTap: () {
                        _usernamefocusNode.requestFocus();
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 3),
                        color: Colors.white,
                        child: Text('Email'),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  Container(
                    child: TextField(
                      obscureText: !passordVisible,
                      focusNode: _passwordfocusNode,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            passordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              passordVisible = !passordVisible;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        contentPadding: EdgeInsets.only(left: 10),
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 200),
                    left: passwordtextEditHasFocus ? 10 : 20,
                    top: passwordtextEditHasFocus ? -10 : 13,
                    child: InkWell(
                      onTap: () {
                        _passwordfocusNode.requestFocus();
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 3),
                        color: Colors.white,
                        child: Text('Password'),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  Container(
                    child: TextField(
                      obscureText: !confirmPassVisible,
                      focusNode: _confirmpasswordfocusNode,
                      controller: _confirmPassword,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            confirmPassVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              confirmPassVisible = !confirmPassVisible;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        contentPadding: EdgeInsets.only(left: 10),
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 200),
                    left: confirmpasswordtextEditHasFocus ? 10 : 20,
                    top: confirmpasswordtextEditHasFocus ? -10 : 13,
                    child: InkWell(
                      onTap: () {
                        _confirmpasswordfocusNode.requestFocus();
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 3),
                        color: Colors.white,
                        child: Text('Confirm Password'),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  Container(
                    child: TextField(
                      focusNode: _mobilefocusNode,
                      controller: _mobilecontroller,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp("[0-9]"),
                        ),
                      ],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        contentPadding: EdgeInsets.only(left: 10),
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 200),
                    left: mobiletextEditHasFocus ? 10 : 20,
                    top: mobiletextEditHasFocus ? -10 : 13,
                    child: InkWell(
                      onTap: () {
                        _mobilefocusNode.requestFocus();
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 3),
                        color: Colors.white,
                        child: Text('Mobile'),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.only(bottom: clsDimensConstants.douDp5),
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () {
                            if (this.rememberme_ischecked) {
                              rememberme_ischecked = false;
                            } else {
                              rememberme_ischecked = true;
                            }
                            setState(() {});
                          },
                          child: Icon(
                            this.rememberme_ischecked
                                ? Icons.check_box_rounded
                                : Icons.check_box_outline_blank,
                            color: Theme.of(context).primaryColor,
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                          child: Text.rich(TextSpan(
                              text: 'By registering you agree to Our ',
                              style: GoogleFonts.montserrat(
                                  fontSize: clsDimensConstants.douDp12,
                                  color: Colors.black),
                              children: <TextSpan>[
                            TextSpan(
                                text: 'Terms and Conditions',
                                style: GoogleFonts.montserrat(
                                    fontSize: clsDimensConstants.douDp12,
                                    color: Theme.of(context).primaryColor),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    _launchUrl(
                                        strURl:
                                            "https://www.galleon.ph/document/terms-and-conditions?mobile_view=true",
                                        title: "Terms and Conditions");
                                  }),
                            TextSpan(
                                text: ' and ',
                                style: GoogleFonts.montserrat(
                                    fontSize: clsDimensConstants.douDp12,
                                    color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Privacy Policy.',
                                      style: GoogleFonts.montserrat(
                                          fontSize: clsDimensConstants.douDp12,
                                          color:
                                              Theme.of(context).primaryColor),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          _launchUrl(
                                              strURl:
                                                  "https://www.galleon.ph/document/privacy-policy?mobile_view=true",
                                              title: "Privacy Policy");
                                        })
                                ])
                          ]))),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  if (!rememberme_ischecked) {
                    return ShowSnackbar(
                        strMessage:
                            "Please accept Terms and Conditions and Privacy Policy. ",
                        showheading: true);
                  }
                  String _ErrorMsg = '';
                  if (_firstnameController.value.text == "") {
                    if (_ErrorMsg != '') {
                      _ErrorMsg += ",";
                    }
                    _ErrorMsg += 'First Name ';
                  }
                  if (_lastnameController.value.text == "") {
                    if (_ErrorMsg != '') {
                      _ErrorMsg += ",";
                    }
                    _ErrorMsg += 'Last Name ';
                  }
                  if (_usernameController.value.text == "") {
                    if (_ErrorMsg != '') {
                      _ErrorMsg += ",";
                    }
                    _ErrorMsg += 'Email Id ';
                  }
                  if (_mobilecontroller.value.text == "") {
                    if (_ErrorMsg != '') {
                      _ErrorMsg += ",";
                    }
                    _ErrorMsg += 'Mobile No ';
                  }
                  if (_ErrorMsg != '') {
                    _ErrorMsg += " are Mandatory";
                  }
                  if ((_confirmPassword.value.text !=
                          _passwordController.value.text) &&
                      _passwordController.value.text == "") {
                    if (_ErrorMsg != '') {
                      _ErrorMsg += ",";
                    }
                    _ErrorMsg += 'Password and Confirm Password Should Matched';
                  }
                  if (_ErrorMsg != '') {
                    return ShowSnackbar(
                        strMessage: _ErrorMsg, showheading: true);
                  } else {
                    if (!_usernameController.value.text.contains("@") ||
                        !_usernameController.value.text.contains(".")) {
                      return ShowSnackbar(
                          strMessage: "Please Enter Valid Email Id",
                          showheading: true);
                    }
                    if (_mobilecontroller.value.text.length < 10 ||
                        _mobilecontroller.value.text.length > 11) {
                      return ShowSnackbar(
                          strMessage: "Please Enter Valid Mobile Number",
                          showheading: true);
                    }
                    if (_confirmPassword.value.text.length < 6) {
                      return ShowSnackbar(
                          strMessage: "Password should be atleast 6 characters",
                          showheading: true);
                    }
                    registerUserApicall();
                  }
                },
                child: Container(
                    height: 45,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(clsDimensConstants.douDp15)),
                        gradient: LinearGradient(colors: [
                          Theme.of(context).primaryColor,
                          Theme.of(context).primaryColor
                        ])),
                    child: Center(
                        child: Text(
                      "Register",
                      style: GoogleFonts.montserrat(
                          fontSize: clsDimensConstants.douDp14,
                          color: Colors.white),
                    ))),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          padding: EdgeInsets.all(clsDimensConstants.douDp20),
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(text: "Already have an Account?"),
                TextSpan(
                  text: ' Login',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

// otp Dialog

  registerUserApicall() {
    if (!rememberme_ischecked) {
      return ShowSnackbar(
          strMessage: "Please Accept Terms & Conditions", showheading: true);
    }

    if (_confirmPassword.value.text != _passwordController.value.text) {
      return ShowSnackbar(
          strMessage: "Password and Confirm Password should Match.",
          showheading: true);
    }

    Map<String, String> objMap = {
      "firstname": _firstnameController.value.text,
      "lastname": _lastnameController.value.text,
      "email": _usernameController.value.text,
      "mobile": _mobilecontroller.value.text,
      "password": _passwordController.value.text,
      "confirm_password": _confirmPassword.value.text,
    };

    // ShowLoader(context);
    clsApiCallMethods.RegisterUserMethod(objMap).then((value) {
      // CancelLoader(context);
      if (value.error == "true") {
        if (value.fieldValidation != null) {
          FieldValidation objFieldvalidation =
              FieldValidation.fromJson(value.fieldValidation);
          if (objFieldvalidation.firstname != "") {
            ShowSnackbar(
                strMessage: objFieldvalidation.firstname.toString(),
                showheading: true);
          }
          if (objFieldvalidation.lastname != "") {
            ShowSnackbar(
                strMessage: objFieldvalidation.lastname.toString(),
                showheading: true);
          }
          if (objFieldvalidation.email != "") {
            ShowSnackbar(
                strMessage: objFieldvalidation.email.toString(),
                showheading: true);
          }
          if (objFieldvalidation.password != "") {
            ShowSnackbar(
                strMessage: objFieldvalidation.password.toString(),
                showheading: true);
          }
          if (objFieldvalidation.confirmPassword != "") {
            ShowSnackbar(
                strMessage: objFieldvalidation.confirmPassword.toString(),
                showheading: true);
          }
          if (objFieldvalidation.mobile != "") {
            ShowSnackbar(
                strMessage: objFieldvalidation.mobile.toString(),
                showheading: true);
          }
        } else {
          if (value.messages.length != 0) {
            ShowSnackbar(
                strMessage: value.messages![0].toString(), showheading: true);
          }
        }
      } else {
        if (value.messages.length != 0) {
          ShowSnackbar(
              strMessage: value.messages![0].toString(), showheading: false);
        }

        Otp_Dialog().then((value) {
          if (value != null) {
            Map<String, String> objMap = {
              "email": _usernameController.value.text,
              "otp": _otpFieldcontroller.value.text,
            };
            ShowLoader(context);
            clsApiCallMethods.OTPMethod(objMap).then((value) {
              CancelLoader(context);
              if (value.error == "true") {
                if (value.fieldValidation != null) {
                  FieldValidation objFieldvalidation =
                      FieldValidation.fromJson(value.fieldValidation);
                  if (objFieldvalidation.otp != "") {
                    ShowSnackbar(
                        strMessage: objFieldvalidation.otp.toString(),
                        showheading: true);
                  }
                }
                if (value.messages.length != 0) {
                  ShowSnackbar(
                      strMessage: value.messages![0].toString(),
                      showheading: false);
                }
              } else {
                if (value.messages.length != 0) {
                  ShowSnackbar(
                      strMessage: value.messages![0].toString(),
                      showheading: false);
                }
                if (value.data != null) {
                  clsUserModel objClsUserModel =
                      clsUserModel.fromJson(value.data);
                  clsSharedPrefernce.objSharedPrefs!.setString(
                      clsSharedPrefernceKeyValue.USER_TOKEN,
                      objClsUserModel.token ?? "");
                  clsSharedPrefernce.objSharedPrefs!.setString(
                      clsSharedPrefernceKeyValue.USER_FIRSTNAME,
                      objClsUserModel.userFirst ?? "");
                  clsSharedPrefernce.objSharedPrefs!.setString(
                      clsSharedPrefernceKeyValue.USER_LASTNAME,
                      objClsUserModel.userLast ?? "");
                  clsSharedPrefernce.objSharedPrefs!.setString(
                      clsSharedPrefernceKeyValue.USER_EMAILNAME,
                      objClsUserModel.userEmail ?? "");
                  clsSharedPrefernce.objSharedPrefs!.setString(
                      clsSharedPrefernceKeyValue.USER_NAME,
                      (objClsUserModel.userFirst ?? "").toString() +
                          (objClsUserModel.userLast ?? "").toString());
                }
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => clsHomePageUI()),
                    (Route<dynamic> route) => false);
              }
            });
          }
        });
      }
    });
  }

  Future Otp_Dialog() async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              contentPadding: EdgeInsets.only(top: 10.0),
              content: Container(
                width: 400,
                padding: EdgeInsets.all(clsDimensConstants.douDp20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Center(
                      child: Text(
                        'One Time Password (OTP)',
                        style: GoogleFonts.montserrat(
                            fontSize: clsDimensConstants.douDp18,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          'Please enter OTP sent to your \n email or mobile device',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                              fontSize: clsDimensConstants.douDp12,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Stack(
                      clipBehavior: Clip.none,
                      children: <Widget>[
                        Container(
                          child: TextField(
                            controller: _otpFieldcontroller,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              contentPadding: EdgeInsets.only(left: 10),
                            ),
                          ),
                        ),
                        AnimatedPositioned(
                          duration: Duration(milliseconds: 200),
                          left: 10,
                          top: -10,
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.only(left: 3),
                              color: Colors.white,
                              child: Text('Enter OTP'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        if (_otpFieldcontroller.value.text.isEmpty) {
                          return ShowSnackbar(
                              strMessage: "Please Enter Otp",
                              showheading: true);
                        }
                        Navigator.pop(context, true);
                      },
                      child: Container(
                          height: 45,
                          width: 110,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(clsDimensConstants.douDp15)),
                              gradient: LinearGradient(colors: [
                                Theme.of(context).primaryColor,
                                Theme.of(context).primaryColor
                              ])),
                          child: Center(
                              child: Text(
                            "Verify",
                            style: GoogleFonts.montserrat(
                                fontSize: clsDimensConstants.douDp14,
                                color: Colors.white),
                          ))),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future Terms_Condition_Dialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              contentPadding: EdgeInsets.only(top: 10.0),
              content: Container(
                padding: EdgeInsets.all(clsDimensConstants.douDp20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Center(
                      child: Text(
                        'By registering you agree to out Terms and Conditions and Privacy Policy.',
                        style: GoogleFonts.montserrat(
                            fontSize: clsDimensConstants.douDp14,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Column(
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          if (this.privacy_ischecked) {
                                            privacy_ischecked = false;
                                          } else {
                                            privacy_ischecked = true;
                                          }
                                          setState(() {});
                                        },
                                        child: Icon(
                                          this.privacy_ischecked
                                              ? Icons.check_box_rounded
                                              : Icons.check_box_outline_blank,
                                          color: Theme.of(context).primaryColor,
                                        )),
                                    Text(
                                      "Privacy Policies:",
                                      style: GoogleFonts.montserrat(
                                          fontSize: clsDimensConstants.douDp12,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                )),
                            Text(
                              'The app will not proceed with the next options unless T&C is not accepted by the registrar.'
                              ' Galleon will share the URLs for the terms and conditions, and privacy policies,'
                              ' which will need to open in the mobile app. When customers click on the Terms and Conditions or Privacy Policies,'
                              ' a URL will open inside the mobile app and open the respective page. Confirmation of this is mandatory before successfully '
                              'registering the customer.Click to Agree Phrase: By registering you agree to out Terms and Conditions and Privacy Policy.',
                              textAlign: TextAlign.start,
                              style: GoogleFonts.montserrat(
                                  fontSize: clsDimensConstants.douDp12,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context, true);
                      },
                      child: Container(
                          height: 45,
                          width: 110,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(clsDimensConstants.douDp15)),
                              gradient: LinearGradient(colors: [
                                Theme.of(context).primaryColor,
                                Theme.of(context).primaryColor
                              ])),
                          child: Center(
                              child: Text(
                            "Accept",
                            style: GoogleFonts.montserrat(
                                fontSize: clsDimensConstants.douDp14,
                                color: Colors.white),
                          ))),
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  Future privacy_policy_Dialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              contentPadding: EdgeInsets.only(top: 10.0),
              content: Container(
                padding: EdgeInsets.all(clsDimensConstants.douDp20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Column(
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          if (this.dataprivacy_ischecked) {
                                            dataprivacy_ischecked = false;
                                          } else {
                                            dataprivacy_ischecked = true;
                                          }
                                          setState(() {});
                                        },
                                        child: Icon(
                                          this.dataprivacy_ischecked
                                              ? Icons.check_box_rounded
                                              : Icons.check_box_outline_blank,
                                          color: Theme.of(context).primaryColor,
                                        )),
                                    Text(
                                      "Data Privacy Policy:",
                                      style: GoogleFonts.montserrat(
                                          fontSize: clsDimensConstants.douDp12,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                )),
                            Text(
                              " In compliance with Republic Act 10173 or the Data Privacy Act of 2012as well as the Galleon Privacy Policy and express my consent thereto. "
                              "In the same manner, I hereby express my consent for Galleon to collect, record, organize, update or modify, retrieve, consult, use, consolidate, block, erase or destruct my personal data as part of my information."
                              " I hereby affirm my right to: (a) be informed; (b) object to processing; (c) access; (d) rectify, suspend or withdraw my personal data; (e) damages; and (f) data portability pursuant to the provisions of the Act"
                              " and its corresponding Implementing Rules and Regulations.",
                              textAlign: TextAlign.start,
                              style: GoogleFonts.montserrat(
                                  fontSize: clsDimensConstants.douDp12,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        if (!dataprivacy_ischecked) {
                          return ShowSnackbar(
                              strMessage: "Please Accept Data Privacy Policy",
                              showheading: true);
                        }

                        Navigator.pop(context, true);
                      },
                      child: Container(
                          height: 45,
                          width: 110,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(clsDimensConstants.douDp15)),
                              gradient: LinearGradient(colors: [
                                Theme.of(context).primaryColor,
                                Theme.of(context).primaryColor
                              ])),
                          child: Center(
                              child: Text(
                            "Accept",
                            style: GoogleFonts.montserrat(
                                fontSize: clsDimensConstants.douDp14,
                                color: Colors.white),
                          ))),
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  Future<void> _launchUrl({required String strURl, String? title}) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyWebView(
                  url: strURl,
                  title: title,
                )));
  }
}
