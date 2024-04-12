// ignore_for_file: camel_case_types, prefer_final_fields, non_constant_identifier_names, prefer_const_constructors, void_checks

import 'package:ecommerce/constants/clsCommonWidget.dart';
import 'package:ecommerce/constants/clsDimensConstants.dart';
import 'package:ecommerce/localStorage/clsSharedPrefernce.dart';
import 'package:ecommerce/localStorage/clsSharedPrefernceKeyValue.dart';
import 'package:ecommerce/network/clsApiCallMethods.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../main.dart';

class clsProfileDetailsEdit extends StatefulWidget {
  const clsProfileDetailsEdit({Key? key}) : super(key: key);

  @override
  State<clsProfileDetailsEdit> createState() => _clsProfileDetailsEditState();
}

class _clsProfileDetailsEditState extends State<clsProfileDetailsEdit> {
  FocusNode _firstnamefocusNode = FocusNode();
  FocusNode _LastNamefocusNode = FocusNode();
  FocusNode _emailfocusNode = FocusNode();
  FocusNode _mobilefocusNode = FocusNode();
  bool firstnametextEditHasFocus = true;
  bool lastnametextEditHasFocus = true;
  bool emailtextEditHasFocus = true;
  bool mobiletextEditHasFocus = true;
  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();

  @override
  void initState() {
    _firstnameController.text = clsSharedPrefernce.objSharedPrefs!
        .getString(clsSharedPrefernceKeyValue.USER_FIRSTNAME)
        .toString();
    _lastnameController.text = clsSharedPrefernce.objSharedPrefs!
        .getString(clsSharedPrefernceKeyValue.USER_LASTNAME)
        .toString();
    _emailController.text = clsSharedPrefernce.objSharedPrefs!
        .getString(clsSharedPrefernceKeyValue.USER_EMAILNAME)
        .toString();
    _mobileController.text = clsSharedPrefernce.objSharedPrefs!
            .getString(clsSharedPrefernceKeyValue.USER_MOBILE) ??
        "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Column(
          children: [
            Text(
              "Hi,${_firstnameController.value.text} ${_lastnameController.value.text}",
              style: GoogleFonts.montserrat(
                  fontSize: clsDimensConstants.douDp14,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              "Edit Profile",
              style: GoogleFonts.montserrat(
                  fontSize: clsDimensConstants.douDp14,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(clsDimensConstants.douDp10),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  TextField(
                    focusNode: _firstnamefocusNode,
                    controller: _firstnameController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]"))
                    ],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      contentPadding: EdgeInsets.only(left: 10),
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
                        child: Text('First Name'),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  TextField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]"))
                    ],
                    focusNode: _LastNamefocusNode,
                    controller: _lastnameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      contentPadding: EdgeInsets.only(left: 10),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 200),
                    left: lastnametextEditHasFocus ? 10 : 20,
                    top: lastnametextEditHasFocus ? -10 : 13,
                    child: InkWell(
                      onTap: () {
                        _firstnamefocusNode.requestFocus();
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 3),
                        color: Colors.white,
                        child: Text('Last Name'),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    child: TextField(
                      focusNode: _mobilefocusNode,
                      enabled: true,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(11)
                      ],
                      keyboardType: TextInputType.phone,
                      controller: _mobileController,
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
                height: 30,
              ),
              Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  Container(
                    color: Colors.grey[300],
                    child: TextField(
                      focusNode: _emailfocusNode,
                      enabled: false,
                      controller: _emailController,
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
                    left: emailtextEditHasFocus ? 10 : 20,
                    top: emailtextEditHasFocus ? -10 : 13,
                    child: InkWell(
                      onTap: () {
                        _emailfocusNode.requestFocus();
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
                height: 30,
              ),
              InkWell(
                onTap: () {
                  if (_firstnameController.value.text.isEmpty) {
                    return ShowSnackbar(
                        strMessage: "Please Enter FirstName",
                        showheading: true);
                  }
                  if (_lastnameController.value.text.isEmpty) {
                    return ShowSnackbar(
                        strMessage: "Please Enter LastName", showheading: true);
                  }
                  if (_mobileController.value.text.isEmpty) {
                    return ShowSnackbar(
                        strMessage: "Please Enter Mobile Number",
                        showheading: true);
                  }

                  if (_emailController.value.text.isEmpty) {
                    return ShowSnackbar(
                        strMessage: "Please Enter Email", showheading: true);
                  }

                  ShowLoader(context);
                  clsApiCallMethods.UpdateProfileDetails(objData: {
                    "firstname": _firstnameController.value.text,
                    "surname": _lastnameController.value.text,
                    "mobile": _mobileController.value.text,
                    "email": _emailController.value.text,
                  }).then((value) {
                    CancelLoader(context);
                    if (value.error == "true") {
                      if (value.messages.length != 0) {
                        ShowSnackbar(
                            strMessage: value.messages![0].toString(),
                            showheading: false);
                      }
                    } else {
                      clsSharedPrefernce.objSharedPrefs!.setString(
                          clsSharedPrefernceKeyValue.USER_FIRSTNAME,
                          _firstnameController.value.text);
                      clsSharedPrefernce.objSharedPrefs!.setString(
                          clsSharedPrefernceKeyValue.USER_LASTNAME,
                          _lastnameController.value.text);
                      clsSharedPrefernce.objSharedPrefs!.setString(
                          clsSharedPrefernceKeyValue.USER_EMAILNAME,
                          _emailController.value.text);
                      clsSharedPrefernce.objSharedPrefs!.setString(
                          clsSharedPrefernceKeyValue.USER_MOBILE,
                          _mobileController.value.text);
                      clsSharedPrefernce.objSharedPrefs!.setString(
                          clsSharedPrefernceKeyValue.USER_NAME,
                          (_firstnameController.value.text ?? "").toString() +
                              (_lastnameController.value.text ?? "").toString());
                      if (value.messages.length != 0) {
                        ShowSnackbar(
                            strMessage: value.messages![0].toString(),
                            showheading: false);
                      }
                    }
                  });
                },
                child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(clsDimensConstants.douDp15)),
                        gradient: LinearGradient(colors: [
                          Theme.of(context).primaryColor,
                          Theme.of(context).primaryColor
                        ])),
                    child: Center(
                        child: Text(
                      "Update Details",
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
}
