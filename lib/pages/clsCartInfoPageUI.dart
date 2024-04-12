// ignore_for_file: camel_case_types, prefer_const_constructors, non_constant_identifier_names, file_names, avoid_types_as_parameter_names, sized_box_for_whitespace

import 'package:ecommerce/constants/clsDimensConstants.dart';
import 'package:ecommerce/localStorage/clsSharedPrefernce.dart';
import 'package:ecommerce/localStorage/clsSharedPrefernceKeyValue.dart';
import 'package:ecommerce/models/clsCartInfoModel.dart';
import 'package:ecommerce/network/clsApiCallMethods.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/clsCommonWidget.dart';
import '../main.dart';
import 'clsCartPageUI.dart';

class clsCartInfoPage extends StatefulWidget {
  const clsCartInfoPage({super.key});

  @override
  State<clsCartInfoPage> createState() => _clsCartInfoPageState();
}

class _clsCartInfoPageState extends State<clsCartInfoPage> {
  clsCartInfoModel objclsCartInfoModel = clsCartInfoModel();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getCartInformation();
    });
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
        title: Text(
          "Cart",
          style: GoogleFonts.montserrat(
              fontSize: clsDimensConstants.douDp14,
              color: Colors.black,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: objclsCartInfoModel.items != null
          ? objclsCartInfoModel.items!.isNotEmpty
              ? returnListofProducts()
              : Center(child: Text("No Items"))
          : Center(child: Text("No Items")),
      bottomNavigationBar: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => clsCartPageUI()));
        },
        child: Container(
            height: 45,
            width: 150,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.all(
                    Radius.circular(clsDimensConstants.douDp5)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                gradient: LinearGradient(colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColor
                ])),
            child: Center(
                child: Text(
              "Buy Now",
              style: GoogleFonts.montserrat(
                  fontSize: clsDimensConstants.douDp14, color: Colors.white),
            ))),
      ),
    );
  }

  returnListofProducts() {
    List<Widget> lstWidget = <Widget>[];

    for (var element in objclsCartInfoModel.items!) {
      lstWidget.add(
        InkWell(
          onTap: () {},
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(4.0),
                child: Container(
                  width: 170,
                  height: 210,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                      // border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.all(
                          Radius.circular(clsDimensConstants.douDp15)),
                      gradient: LinearGradient(colors: [
                        Theme.of(context).cardColor,
                        Theme.of(context).cardColor
                      ])),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Stack(
                        children: [
                          Container(
                            height: 100,
                            child: Image.network(
                              element.product!.imgThumb!,
                              errorBuilder: (context, Object, StackTrace) {
                                return Center(
                                    child: Text('Failed to load image'));
                              },
                              height: 100,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              RemoveItemInWhishlist(
                                  pid: element.product!.productId!);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: clsDimensConstants.douDp10),
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Icon(Icons.cancel)),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: clsDimensConstants.douDp10,
                              right: clsDimensConstants.douDp10),
                          child: Text(
                            element.product!.productName!.toString(),
                            maxLines: 2,
                            style: GoogleFonts.montserrat(
                                fontSize: clsDimensConstants.douDp12,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: clsDimensConstants.douDp10,
                            right: clsDimensConstants.douDp10,
                            top: clsDimensConstants.douDp10,
                            bottom: clsDimensConstants.douDp10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                "₱ ${element.product!.productSrp ?? ""}",
                                maxLines: 2,
                                style: GoogleFonts.montserrat(
                                    fontSize: clsDimensConstants.douDp12,
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    lstWidget.add(Text(""));
    return Align(
      alignment: Alignment.topCenter,
      child: Wrap(
        children: lstWidget,
      ),
    );
  }

  addToCart({required String strPid}) {
    Map<String, String> objMap = {
      "pid": strPid,
    };
    ShowLoader(context);
    clsApiCallMethods.AddProductInCart(objMap).then((value) {
      CancelLoader(context);
      if (value.error == "true") {
        if (value.fieldValidation != null) {
          if (value.fieldValidation!.firstname != "") {
            ShowSnackbar(
                strMessage: value.fieldValidation!.firstname.toString(),
                showheading: true);
          }
          if (value.fieldValidation!.lastname != "") {
            ShowSnackbar(
                strMessage: value.fieldValidation!.lastname.toString(),
                showheading: true);
          }
          if (value.fieldValidation!.email != "") {
            ShowSnackbar(
                strMessage: value.fieldValidation!.email.toString(),
                showheading: true);
          }
          if (value.fieldValidation!.password != "") {
            ShowSnackbar(
                strMessage: value.fieldValidation!.password.toString(),
                showheading: true);
          }
          if (value.fieldValidation!.confirmPassword != "") {
            ShowSnackbar(
                strMessage: value.fieldValidation!.confirmPassword.toString(),
                showheading: true);
          }
        }
      } else {
        if (value.data != null) {
          if (clsSharedPrefernce.objSharedPrefs!
              .getString(clsSharedPrefernceKeyValue.USER_TOKEN)!
              .isNotEmpty) {
            clsApiCallMethods.ItemsInCart().then((value) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => clsCartPageUI()));
            });
          }
        }
      }
    });
  }

  getCartInformation() {
    ShowLoader(context);
    clsApiCallMethods.getCartInformation().then((value) {
      CancelLoader(context);
      if (value.error == "true") {
        if (value.fieldValidation != null) {
          if (value.fieldValidation!.firstname != "") {
            ShowSnackbar(
                strMessage: value.fieldValidation!.firstname.toString(),
                showheading: true);
          }
          if (value.fieldValidation!.lastname != "") {
            ShowSnackbar(
                strMessage: value.fieldValidation!.lastname.toString(),
                showheading: true);
          }
          if (value.fieldValidation!.email != "") {
            ShowSnackbar(
                strMessage: value.fieldValidation!.email.toString(),
                showheading: true);
          }
          if (value.fieldValidation!.password != "") {
            ShowSnackbar(
                strMessage: value.fieldValidation!.password.toString(),
                showheading: true);
          }
          if (value.fieldValidation!.confirmPassword != "") {
            ShowSnackbar(
                strMessage: value.fieldValidation!.confirmPassword.toString(),
                showheading: true);
          }
        }
      } else {
        if (value.data != null) {
          objclsCartInfoModel = clsCartInfoModel.fromJson(value.data);
          setState(() {});
        }
      }
    });
  }

  RemoveItemInWhishlist({required String pid}) {
    Map<String, String> objMap = {
      "pid": pid,
    };
    ShowLoader(context);
    clsApiCallMethods.removecartItem(objMap).then((value) {
      CancelLoader(context);
      if (value.error == "true") {
        if (value.fieldValidation != null) {
          if (value.fieldValidation!.firstname != "") {
            ShowSnackbar(
                strMessage: value.fieldValidation!.firstname.toString(),
                showheading: true);
          }
          if (value.fieldValidation!.lastname != "") {
            ShowSnackbar(
                strMessage: value.fieldValidation!.lastname.toString(),
                showheading: true);
          }
          if (value.fieldValidation!.email != "") {
            ShowSnackbar(
                strMessage: value.fieldValidation!.email.toString(),
                showheading: true);
          }
          if (value.fieldValidation!.password != "") {
            ShowSnackbar(
                strMessage: value.fieldValidation!.password.toString(),
                showheading: true);
          }
          if (value.fieldValidation!.confirmPassword != "") {
            ShowSnackbar(
                strMessage: value.fieldValidation!.confirmPassword.toString(),
                showheading: true);
          }
        }
      } else {
        if (value.data != null) {
          getCartInformation();
        }
      }
    });
  }
}
