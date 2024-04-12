// ignore_for_file: file_names, camel_case_types, prefer_final_fields, non_constant_identifier_names, prefer_const_constructors

import 'package:ecommerce/constants/clsDimensConstants.dart';
import 'package:ecommerce/localStorage/clsSharedPrefernce.dart';
import 'package:ecommerce/models/clsCommonResposneModel.dart';
import 'package:ecommerce/network/clsApiCallMethods.dart';
import 'package:ecommerce/pages/clsLoginPageUI.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/clsCommonWidget.dart';
import '../main.dart';

class clschangePassword extends StatefulWidget {
  const clschangePassword({Key? key}) : super(key: key);

  @override
  State<clschangePassword> createState() => _clschangePasswordState();
}

class _clschangePasswordState extends State<clschangePassword> {
  FocusNode _oldfocusNode = FocusNode();
  FocusNode _confirmfocusNode = FocusNode();
  FocusNode _passwordfocusNode = FocusNode();
  bool oldpasswordtextEditHasFocus = true;
  bool newpasswordtextEditHasFocus = true;
  bool confirmpasswordtextEditHasFocus = true;
  TextEditingController _oldpasswordController = TextEditingController();
  TextEditingController _newpasswordController = TextEditingController();
  TextEditingController _ConfirmpasswordController = TextEditingController();
  bool oldPassVisible = false;
  bool newPassVisible = false;
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
                height: 50,
              ),
              SizedBox(
                height: 50,
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
                    'Change Password',
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
                  TextField(
                    focusNode: _oldfocusNode,
                    controller: _oldpasswordController,
                    obscureText: !oldPassVisible,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          oldPassVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            oldPassVisible = !oldPassVisible;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      contentPadding: EdgeInsets.only(left: 10),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 200),
                    left: oldpasswordtextEditHasFocus ? 10 : 20,
                    top: oldpasswordtextEditHasFocus ? -10 : 13,
                    child: InkWell(
                      onTap: () {
                        _oldfocusNode.requestFocus();
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 3),
                        color: Colors.white,
                        child: Text('Old Password'),
                        // child: Text('Mobile/Email/Username'),
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
                  TextField(
                    focusNode: _passwordfocusNode,
                    controller: _newpasswordController,
                    obscureText: !newPassVisible,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          newPassVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            newPassVisible = !newPassVisible;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      contentPadding: EdgeInsets.only(left: 10),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 200),
                    left: newpasswordtextEditHasFocus ? 10 : 20,
                    top: newpasswordtextEditHasFocus ? -10 : 13,
                    child: InkWell(
                      onTap: () {
                        _passwordfocusNode.requestFocus();
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 3),
                        color: Colors.white,
                        child: Text('New Password'),
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
                  TextField(
                    focusNode: _confirmfocusNode,
                    controller: _ConfirmpasswordController,
                    obscureText: !confirmPassVisible,
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
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      contentPadding: EdgeInsets.only(left: 10),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 200),
                    left: confirmpasswordtextEditHasFocus ? 10 : 20,
                    top: confirmpasswordtextEditHasFocus ? -10 : 13,
                    child: InkWell(
                      onTap: () {
                        _confirmfocusNode.requestFocus();
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
              InkWell(
                onTap: () {
                  changePasswordApiCall();
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
                      "Submit",
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
  }

  changePasswordApiCall() {
    Map<String, String> objMap = {
      "old_password": _oldpasswordController.value.text,
      "new_password": _newpasswordController.value.text,
      "confirm_new_password": _ConfirmpasswordController.value.text,
    };
    ShowLoader(context);
    clsApiCallMethods.ChangePassword(objMap).then((value) {
      CancelLoader(context);
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
        } else {
          ShowSnackbar(
              strMessage: value.messages![0].toString(), showheading: true);
        }
      } else {
        _newpasswordController.text = "";
        _oldpasswordController.text = "";
        _ConfirmpasswordController.text = "";
        if (value.messages.length != 0) {
          ShowSnackbar(
              strMessage: value.messages![0].toString(), showheading: true);
        }
        if (value.messages![0].toString() != "Password is Incorrect!") {
          clsSharedPrefernce.ClearRecords_SharedPrefernces();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => clsLoginPageUI()),
              (route) => false);
        }
      }
    });
  }
}
