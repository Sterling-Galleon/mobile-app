// ignore_for_file: camel_case_types, prefer_final_fields, non_constant_identifier_names, prefer_const_constructors, unnecessary_null_comparison, void_checks

import 'package:ecommerce/constants/clsDimensConstants.dart';
import 'package:ecommerce/localStorage/clsSharedPrefernce.dart';
import 'package:ecommerce/localStorage/clsSharedPrefernceKeyValue.dart';
import 'package:ecommerce/models/clsCommonResposneModel.dart';
import 'package:ecommerce/models/clsUserModel.dart';
import 'package:ecommerce/network/clsApiCallMethods.dart';
import 'package:ecommerce/pages/clsRegisterPageUI.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../constants/clsCommonWidget.dart';
import '../main.dart';
import 'clsHomePageUI.dart';

class clsLoginPageUI extends StatefulWidget {
  const clsLoginPageUI({Key? key}) : super(key: key);

  @override
  State<clsLoginPageUI> createState() => _clsLoginPageUIState();
}

class _clsLoginPageUIState extends State<clsLoginPageUI> {
  FocusNode _usernamefocusNode = FocusNode();
  FocusNode _passwordfocusNode = FocusNode();
  bool usernametextEditHasFocus = true;
  bool passwordtextEditHasFocus = true;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _ForgotpasswordController = TextEditingController();

  bool _passwordVisible = false;

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
              InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => clsHomePageUI()),
                      (Route<dynamic> route) => false);
                },
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Skip",
                      style: GoogleFonts.montserrat(
                          fontSize: clsDimensConstants.douDp14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    )),
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
                    'Login',
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
                    focusNode: _usernamefocusNode,
                    controller: _usernameController,
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
                  TextField(
                    focusNode: _passwordfocusNode,
                    controller: _passwordController,
                    obscureText:
                        !_passwordVisible, //This will obscure text dynamically
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            _passwordVisible = !_passwordVisible;
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
              InkWell(
                onTap: () {
                  userloginApicall();
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
                      "Login",
                      style: GoogleFonts.montserrat(
                          fontSize: clsDimensConstants.douDp14,
                          color: Colors.white),
                    ))),
              ),
              InkWell(
                onTap: () {
                  forgetPassword_Dialog();
                },
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: clsDimensConstants.douDp10),
                  child: Text(
                    "Forgot Password",
                    style: GoogleFonts.montserrat(
                        fontSize: clsDimensConstants.douDp14,
                        color: Colors.black),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: clsDimensConstants.douDp20),
                child: Text(
                  "-----------------------  OR  -----------------------",
                  style: GoogleFonts.montserrat(
                      fontSize: clsDimensConstants.douDp14,
                      color: Colors.black),
                ),
              ),
              InkWell(
                onTap: () async {
                  // AuthService.signinGoogle();
                  await GoogleSignIn().signOut();
                  GoogleSignIn().signIn().then((value) {
                    if (value != null) {
                      SocialLogin(value);
                    }
                  });
                },
                child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.all(
                            Radius.circular(clsDimensConstants.douDp25)),
                        gradient: LinearGradient(colors: [
                          Theme.of(context).cardColor,
                          Theme.of(context).cardColor
                        ])),
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(clsDimensConstants.douDp2),
                          child: CircleAvatar(
                              backgroundColor: Colors.grey[100],
                              child: Container(
                                padding:
                                    EdgeInsets.all(clsDimensConstants.douDp2),
                                child: Image.asset(
                                  "assets/images/google.png",
                                  width: 30,
                                ),
                              )),
                        ),
                        Center(
                          child: Text(
                            "Continue With Google",
                            style: GoogleFonts.montserrat(
                                fontSize: clsDimensConstants.douDp14,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () async {
                  await FacebookAuth.instance.logOut();
                  FacebookAuth.instance.login(
                      permissions: ["public_profile", "email"]).then((value) {
                    FacebookAuth.instance.getUserData().then((userdata) async {
                      FacebookLogin(userdata);
                    });
                  });
                },
                child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.all(
                            Radius.circular(clsDimensConstants.douDp25)),
                        gradient: LinearGradient(colors: [
                          Theme.of(context).cardColor,
                          Theme.of(context).cardColor
                        ])),
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(clsDimensConstants.douDp2),
                          child: CircleAvatar(
                              backgroundColor: Colors.blue,
                              child: Container(
                                padding:
                                    EdgeInsets.all(clsDimensConstants.douDp2),
                                child: Image.asset(
                                  "assets/images/facebook.png",
                                  width: 30,
                                ),
                              )),
                        ),
                        Center(
                          child: Text(
                            "Continue With Facebook",
                            style: GoogleFonts.montserrat(
                                fontSize: clsDimensConstants.douDp14,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              // SignInWithAppleButton(
              //   onPressed: () async {
              //     final credential = await SignInWithApple.getAppleIDCredential(
              //       scopes: [
              //         AppleIDAuthorizationScopes.email,
              //         AppleIDAuthorizationScopes.fullName,
              //       ],
              //     );
              //
              //     print(credential);
              //
              //     // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
              //     // after they have been validated with Apple (see `Integration` section for more information on how to do this)
              //   },
              // ),
              InkWell(
                onTap: () async {
                  final credential = await SignInWithApple.getAppleIDCredential(
                    scopes: [
                      AppleIDAuthorizationScopes.email,
                      AppleIDAuthorizationScopes.fullName,
                    ],
                  );
                  AppleLogin(credential);
                },
                child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.all(
                            Radius.circular(clsDimensConstants.douDp25)),
                        gradient: LinearGradient(colors: [
                          Theme.of(context).cardColor,
                          Theme.of(context).cardColor
                        ])),
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(clsDimensConstants.douDp2),
                          child: CircleAvatar(
                              backgroundColor: Colors.black,
                              child: Container(
                                padding:
                                    EdgeInsets.all(clsDimensConstants.douDp2),
                                child: Image.asset(
                                  "assets/images/apple.png",
                                  width: 20,
                                  color: Colors.white,
                                ),
                              )),
                        ),
                        Center(
                          child: Text(
                            "Continue With Apple Id",
                            style: GoogleFonts.montserrat(
                                fontSize: clsDimensConstants.douDp14,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => clsRegisterPageUI()));
        },
        child: Container(
          padding: EdgeInsets.all(clsDimensConstants.douDp20),
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(text: "Don't have an account?"),
                TextSpan(
                  text: ' Create Account',
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

  SocialLogin(GoogleSignInAccount value) {
    Map<String, String> objMap = {
      "firstname": value.displayName.toString(),
      "lastname": "",
      "email": value.email.toString(),
      "mobile": "",
      "token": value.serverAuthCode.toString(),
      "social_media": "Google",
      "social_id": value.id,
    };
    ShowLoader(context);
    clsApiCallMethods.SocialLoginMethod(objMap).then((value) {
      CancelLoader(context);
      if (value != null) {
        if (value.error == "true") {
          if (value.messages.length != 0) {
            ShowSnackbar(
                strMessage: value.messages![0].toString(), showheading: true);
          }
        } else {
          if (value.messages.length != 0) {
            ShowSnackbar(
                strMessage: value.messages![0].toString(), showheading: true);
          }
          clsUserModel objClsUserModel = clsUserModel.fromJson(value.data);
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
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => clsHomePageUI()),
              (Route<dynamic> route) => false);
        }
      }
    });
  }

  FacebookLogin(Map<String, dynamic> userdata) {
    List<String> nameList = userdata["name"].toString().trim().split(' ');
    Map<String, String> objMap = {
      "firstname": nameList[0],
      "lastname": nameList.length > 1 ? nameList[1] : "",
      "email": userdata["email"].toString(),
      "mobile": "",
      "token": userdata["id"].toString(),
      "social_media": "Facebook",
      "social_id": userdata["id"].toString(),
    };
    ShowLoader(context);
    clsApiCallMethods.SocialLoginMethod(objMap).then((value) {
      CancelLoader(context);
      if (value != null) {
        if (value.error == "true") {
          if (value.messages.length != 0) {
            ShowSnackbar(
                strMessage: value.messages![0].toString(), showheading: true);
          }
        } else {
          if (value.messages.length != 0) {
            ShowSnackbar(
                strMessage: value.messages![0].toString(), showheading: true);
          }
          clsUserModel objClsUserModel = clsUserModel.fromJson(value.data);
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
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => clsHomePageUI()),
              (Route<dynamic> route) => false);
        }
      }
    });
  }

  AppleLogin(AuthorizationCredentialAppleID value) {
    Map<String, String> objMap = {
      "firstname": value.givenName.toString(),
      "lastname": value.familyName.toString(),
      "email": value.email.toString(),
      "mobile": "",
      "token": value.identityToken.toString(),
      "social_media": "Apple",
      "social_id": value.authorizationCode.toString(),
    };
    ShowLoader(context);
    clsApiCallMethods.SocialLoginMethod(objMap).then((value) {
      CancelLoader(context);
      if (value != null) {
        if (value.error == "true") {
          if (value.messages.length != 0) {
            ShowSnackbar(
                strMessage: value.messages![0].toString(), showheading: true);
          }
        } else {
          if (value.messages.length != 0) {
            ShowSnackbar(
                strMessage: value.messages![0].toString(), showheading: true);
          }
          clsUserModel objClsUserModel = clsUserModel.fromJson(value.data);
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
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => clsHomePageUI()),
              (Route<dynamic> route) => false);
        }
      }
    });
  }

  userloginApicall() {
    Map<String, String> objMap = {
      "email": _usernameController.value.text,
      "password": _passwordController.value.text,
    };
    ShowLoader(context);
    clsApiCallMethods.LoginMethod(objMap).then((value) {
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
        if (value.messages.length != 0) {
          ShowSnackbar(
              strMessage: value.messages![0].toString(), showheading: true);
        }

        if (value.data != null) {
          clsUserModel objClsUserModel = clsUserModel.fromJson(value.data);
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
              clsSharedPrefernceKeyValue.USER_MOBILE,
              objClsUserModel.userMobile ?? "");
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

  ForgotPasswordApicall() {
    Map<String, String> objMap = {
      "email": _ForgotpasswordController.value.text,
    };
    ShowLoader(context);
    clsApiCallMethods.ForgetPassword(objMap).then((value) {
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
        if (value.messages.length != 0) {
          ShowSnackbar(
              strMessage: value.messages![0].toString(), showheading: true);
        }

        Navigator.pop(context);
      }
    });
  }

  forgetPassword_Dialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: 400,
              padding: EdgeInsets.all(clsDimensConstants.douDp5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Center(
                    child: Text(
                      'Forgot Password',
                      style: GoogleFonts.montserrat(
                          fontSize: clsDimensConstants.douDp18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        'Reset Password Link will be sent to your mail. \n Please Check your mail',
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: clsDimensConstants.douDp10),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: <Widget>[
                        TextField(
                          controller: _ForgotpasswordController,
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
                        AnimatedPositioned(
                          duration: Duration(milliseconds: 200),
                          left: 10,
                          top: -10,
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.only(left: 3),
                              color: Colors.white,
                              child: Text('Enter Email'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      if (_ForgotpasswordController.value.text.isEmpty) {
                        return ShowSnackbar(
                            strMessage: "Please Enter Your Email",
                            showheading: true);
                      }

                      ForgotPasswordApicall();
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
                          "Submit",
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
  }
}
