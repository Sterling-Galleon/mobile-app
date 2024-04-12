// ignore_for_file: file_names, constant_identifier_names, camel_case_types, non_constant_identifier_names, prefer_final_fields, prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, use_build_context_synchronously, no_leading_underscores_for_local_identifiers

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecommerce/constants/clsDimensConstants.dart';
import 'package:ecommerce/network/clsApiCallMethods.dart';
import 'package:ecommerce/pages/clsCartCouponsPageUI.dart';
import 'package:ecommerce/pages/clsOrderPlacedScreenPageUI.dart';
import 'package:ecommerce/pages/shipping_info.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_progress_indicators/simple_progress_indicators.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/clsCommonWidget.dart';
import '../main.dart';
import '../models/clsAddressesModel.dart';
import '../models/clsCartInfoModel.dart';
import '../models/clsRecalculateCheckoutModel.dart';
import 'clsAddressPageUI.dart';

import 'package:ecommerce/localStorage/clsSharedPrefernceKeyValue.dart';
import 'package:ecommerce/localStorage/clsSharedPrefernce.dart';

enum ShippingMethodEnum {
  GalleonOffice,
  LbcOffice,
  BillingAddress,
  InputShippingAddress;
}

class ShippingInfoModel {
  String? shippingName;
  String? shippingEmail;
  String? phoneNo;
  String? regionName;
  String? streetAddress;
  String? province;
  String? city;
  String? barangay;
  String? zipCode;
  String? lbcAddress;
  ShippingMethodEnum shippingMethodEnum;

  ShippingInfoModel(
      {this.shippingMethodEnum = ShippingMethodEnum.BillingAddress,
      this.shippingName,
      this.shippingEmail,
      this.phoneNo,
      this.regionName,
      this.barangay,
      this.city,
      this.province,
      this.streetAddress,
      this.zipCode,
      this.lbcAddress});
}

class clsCartPageUI extends StatefulWidget {
  const clsCartPageUI({Key? key}) : super(key: key);

  @override
  State<clsCartPageUI> createState() => _clsCartPageUIState();
}

class _clsCartPageUIState extends State<clsCartPageUI> {
  bool bolprogressIndicator_1 = false;
  bool bolprogressIndicator_2 = false;
  bool bolprogressIndicator_3 = false;
  bool isAllowedCod = false;

  String title = "Cart";

  // int incrementCount = 1;
  String? Paymentmethod;
  String? shippingmethod; //Todo : need to discuss with client on it
  String shippingmethodVia = "air";
  bool giftwrapcheckbox = false;
  int selectedGroupValue = 0;

  bool enableSubmit = false;
  bool showSea = false;
  bool isShowCartView = true;

  List<clsAddresssModel> lstclsAddresssModel = <clsAddresssModel>[];
  clsRecalculateCheckoutModel objclsRecalculateCheckoutModel =
      clsRecalculateCheckoutModel();

  FocusNode _giftfocusNode = FocusNode();
  bool gifttextEditHasFocus = true;
  TextEditingController _giftController = TextEditingController();
  ShippingInfoModel shippingInfoModel =
      ShippingInfoModel(shippingMethodEnum: ShippingMethodEnum.BillingAddress);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getAddressesList();
      PrepareCartForCheckout();
    });
    super.initState();
  }

  clsCartInfoModel? objclsCartInfoModel;

  int intGiftwrapAmount = 0;

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: false,
          elevation: 0.0,
          shadowColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              if (bolprogressIndicator_3) {
                bolprogressIndicator_3 = false;
                title = "Payment Method";
                setState(() {});
              } else if (bolprogressIndicator_2) {
                bolprogressIndicator_2 = false;
                title = "Shipping Information";
                setState(() {});
              } else if (bolprogressIndicator_1) {
                bolprogressIndicator_1 = false;
                title = "Billing Information";
                setState(() {});
              } else {
                Navigator.pop(context);
              }
            },
          ),
          title: Text(
            title,
            style: GoogleFonts.montserrat(
                fontSize: clsDimensConstants.douDp14,
                color: Colors.black,
                fontWeight: FontWeight.w500),
          ),
          actions: [],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              isShowCartView
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                child: Center(
                                    child: Text(
                                  "1",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w700,
                                      fontSize: clsDimensConstants.douDp10),
                                )),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            clsDimensConstants.douDp15)),
                                    gradient: LinearGradient(
                                        colors: [Colors.white, Colors.white])),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: clsDimensConstants.douDp8),
                                child: Text(
                                  "Billing\nInformation",
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w700,
                                      fontSize: clsDimensConstants.douDp10),
                                ),
                              )
                            ],
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, bottom: clsDimensConstants.douDp18),
                              child: SizedBox(
                                width:
                                    MediaQuery.of(context).size.width / 4 - 35,
                                child: ProgressBar(
                                  value: bolprogressIndicator_1 ? 1 : 0,
                                  height: 5,
                                  color: Theme.of(context).primaryColor,
                                  backgroundColor: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                child: Center(
                                    child: Text(
                                  "2",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w700,
                                      fontSize: clsDimensConstants.douDp10),
                                )),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            clsDimensConstants.douDp15)),
                                    gradient: LinearGradient(
                                        colors: [Colors.white, Colors.white])),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: clsDimensConstants.douDp8),
                                child: Text(
                                  "Shipping\nInformation",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w700,
                                      fontSize: clsDimensConstants.douDp10),
                                ),
                              )
                            ],
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  bottom: clsDimensConstants.douDp18),
                              child: SizedBox(
                                width:
                                    MediaQuery.of(context).size.width / 4 - 35,
                                child: ProgressBar(
                                  value: bolprogressIndicator_2 ? 1 : 0,
                                  height: 5,
                                  color: Theme.of(context).primaryColor,
                                  backgroundColor: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                child: Center(
                                    child: Text(
                                  "3",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w700,
                                      fontSize: clsDimensConstants.douDp10),
                                )),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            clsDimensConstants.douDp15)),
                                    gradient: LinearGradient(
                                        colors: [Colors.white, Colors.white])),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: clsDimensConstants.douDp8),
                                child: Text(
                                  "Payment\nMethod",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w700,
                                      fontSize: clsDimensConstants.douDp10),
                                ),
                              )
                            ],
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  bottom: clsDimensConstants.douDp18),
                              child: SizedBox(
                                width:
                                    MediaQuery.of(context).size.width / 4 - 35,
                                child: ProgressBar(
                                  value: bolprogressIndicator_3 ? 1 : 0,
                                  height: 5,
                                  color: Theme.of(context).primaryColor,
                                  backgroundColor: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                child: Center(
                                    child: Text(
                                  "4",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w700,
                                      fontSize: clsDimensConstants.douDp10),
                                )),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            clsDimensConstants.douDp15)),
                                    gradient: LinearGradient(
                                        colors: [Colors.white, Colors.white])),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: clsDimensConstants.douDp8),
                                child: Text(
                                  "Summary",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w700,
                                      fontSize: clsDimensConstants.douDp10),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
              if (isShowCartView)
                CartView()
              else if (bolprogressIndicator_1 == false)
                AddressView()
              else if (bolprogressIndicator_1 && !bolprogressIndicator_2)
                ShpippingInfoView(
                  shippingInfoModel: shippingInfoModel,
                )
              else if (bolprogressIndicator_1 &&
                  bolprogressIndicator_2 &&
                  !bolprogressIndicator_3)
                Column(children: [CartView(), PaymentView()])
              else if (bolprogressIndicator_1 &&
                  bolprogressIndicator_2 &&
                  bolprogressIndicator_3)
                SummaryView(),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          //padding: const EdgeInsets.symmetric(horizontal: 14,),
          padding: const EdgeInsets.only(left:10,right:10,bottom: 20),
          child: bottomBtn(),
        ));
  }

  Widget bottomBtn() {
    if (isShowCartView || bolprogressIndicator_2) {
      return Row(
        children: [
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {},
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
                        Theme.of(context).cardColor,
                        Theme.of(context).cardColor
                      ])),
                  child: Center(
                      child: Text(
                    "₱ ${objclsCartInfoModel != null ? objclsCartInfoModel!.summary != null ? (CommaSeparatedAmount((objclsCartInfoModel!.summary!.invoiceGrandTotal!).toString()).toString()) : "0" : "0"} \n To be Paid",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                        fontSize: clsDimensConstants.douDp14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ))),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                if (isShowCartView) {
                  isShowCartView = false;
                  title = "Billing Information";
                  setState(() {});
                  return;
                }
                if (!bolprogressIndicator_1) {
                  bolprogressIndicator_1 = true;
                  title = "Billing Information";
                  PrepareCartForCheckout();
                } else if (bolprogressIndicator_1 &&
                    !bolprogressIndicator_2 &&
                    lstclsAddresssModel.isNotEmpty) {
                  bolprogressIndicator_2 = true;
                  title = "Payment";
                } else if (bolprogressIndicator_1 &&
                    bolprogressIndicator_2 &&
                    !bolprogressIndicator_3) {
                  if ((Paymentmethod ?? "").isEmpty) {
                    ShowSnackbar(
                        strMessage: "Please choose your payment method",
                        showheading: true);
                    return;
                  }
                  bolprogressIndicator_3 = true;
                  title = "Summary";
                  RecalculateCheckoutOnBaseofPayment();
                } else if (bolprogressIndicator_1 &&
                    bolprogressIndicator_2 &&
                    bolprogressIndicator_3) {
                  if (!enableSubmit) {
                    ShowSnackbar(
                        strMessage: "Please choose your payment method",
                        showheading: true);
                    return;
                  }

                  clsAddresssModel objselectedaddress = lstclsAddresssModel
                      .where((element) => element.isSelected == true)
                      .toList()[0];
                  String? shippingName = "";
                  String? shippingEmail = "";
                  String? shippingPhone = "";
                  String? addressStreet = "";
                  String? addressCity = "";
                  String? addressState = "";
                  String? addressCountry = "";
                  String? postal = "";
                  String? _shippingMethod;
                  if (shippingInfoModel.shippingMethodEnum ==
                      ShippingMethodEnum.BillingAddress) {
                    shippingName = objselectedaddress.addressName;
                    shippingEmail = objselectedaddress.addressEmail;
                    shippingPhone = objselectedaddress.addressPhone;
                    addressState = objselectedaddress.addressState;
                    addressCity = objselectedaddress.addressCity;
                    addressStreet = objselectedaddress.addressStreet;
                    addressCountry = objselectedaddress.addressCountry;
                    postal = objselectedaddress.addressPostal;
                    _shippingMethod = "billing";
                  } else if (shippingInfoModel.shippingMethodEnum ==
                      ShippingMethodEnum.InputShippingAddress) {
                    shippingName = shippingInfoModel.shippingName;
                    shippingEmail = shippingInfoModel.shippingEmail;
                    shippingPhone = shippingInfoModel.phoneNo;
                    addressStreet = shippingInfoModel.streetAddress;
                    addressCity = shippingInfoModel.city;
                    addressState = shippingInfoModel.province;
                    addressCountry = objselectedaddress.addressCountry;
                    postal = shippingInfoModel.zipCode;
                    _shippingMethod = "shipping";
                  }
                  if (shippingInfoModel.shippingMethodEnum ==
                      ShippingMethodEnum.LbcOffice) {
                    _shippingMethod = "lbc";
                  }
                  if (shippingInfoModel.shippingMethodEnum ==
                      ShippingMethodEnum.GalleonOffice) {
                    _shippingMethod = "pickup";
                  }

                  var data = {
                    "billing[address_name]": objselectedaddress.addressName,
                    "billing[address_email]": objselectedaddress.addressEmail,
                    "billing[address_phone]": objselectedaddress.addressPhone,
                    "billing[address_street]": objselectedaddress.addressStreet,
                    "billing[address_city]": objselectedaddress.addressCity,
                    "billing[address_state]": objselectedaddress.addressState,
                    "billing[address_country]":
                        objselectedaddress.addressCountry,
                    "billing[address_postal]": objselectedaddress.addressPostal,
                    "shipping_method": _shippingMethod,
                    "shipping[address_name]": shippingName,
                    "shipping[address_email]": shippingEmail,
                    "shipping[address_phone]": shippingPhone,
                    "shipping[address_street]": addressStreet,
                    "shipping[address_city]": addressCity,
                    "shipping[address_state]": addressState,
                    "shipping[address_country]": addressCountry,
                    "shipping[address_postal]": postal,
                    "lbc[address_name]": shippingInfoModel.shippingMethodEnum ==
                            ShippingMethodEnum.LbcOffice
                        ? shippingInfoModel.lbcAddress
                        : "",
                    "lbc[address_email]":
                        shippingInfoModel.shippingMethodEnum ==
                                ShippingMethodEnum.LbcOffice
                            ? shippingInfoModel.shippingEmail
                            : "",
                    "lbc[address_phone]":
                        shippingInfoModel.shippingMethodEnum ==
                                ShippingMethodEnum.LbcOffice
                            ? shippingInfoModel.phoneNo
                            : "",
                    "lbc[address_branch]":
                        shippingInfoModel.shippingMethodEnum ==
                                ShippingMethodEnum.LbcOffice
                            ? shippingInfoModel.regionName
                            : "",
                    "pickup[address_name]":
                        shippingInfoModel.shippingMethodEnum ==
                                ShippingMethodEnum.GalleonOffice
                            ? shippingInfoModel.shippingName
                            : "",
                    "shipping_dest": objselectedaddress.addressCountry,
                    "payment_type": Paymentmethod.toString(),
                  };
                  debugPrint("Data ${json.encode(data)}");
                  ShowLoader(context);
                  clsApiCallMethods.CreateOrder(objData: data).then((value) {
                    debugPrint("Data123 ${value.data}");
                    CancelLoader(context);
                    if (value.error == "false") {
                      late String invoiceId;
                      if (Paymentmethod == "cod" || Paymentmethod == "cup") {
                        if (value.data["invoice_id"] != null) {
                          invoiceId = value.data["invoice_id"];
                        } else {
                          invoiceId = value.data["extra"]["invoice_id"];
                        }
                      } else {
                        if (value.data["invoice_id"] != null) {
                          invoiceId = value.data["invoice_id"];
                        } else {
                          invoiceId = value.data["extra"]["invoice_id"];
                        }
                        if (value.data["extra"] != "") {
                          _launchUrl(
                              strURl: value.data["extra"]["payment_url"]);
                        }
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => clsOrderPlacedScreenPageUI(
                                  InvoiceNo: invoiceId)));
                    } else {
                      ShowSnackbar(
                          strMessage: value.messages.length > 0
                              ? value.messages[0].toString()
                              : "",
                          showheading: false);
                    }
                  });
                }
                setState(() {});
              },
              child: Container(
                  height: 45,
                  width: 150,
                  decoration: BoxDecoration(
                      // border: Border.all(color: Colors.white),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.all(
                          Radius.circular(clsDimensConstants.douDp5)),
                      gradient: LinearGradient(colors: [
                        Theme.of(context).primaryColor,
                        Theme.of(context).primaryColor
                      ])),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Continue",
                        style: GoogleFonts.montserrat(
                            fontSize: clsDimensConstants.douDp14,
                            color: Colors.white),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      )
                    ],
                  )),
            ),
          )
        ],
      );
    } else if (!bolprogressIndicator_2) {
      return Row(
        children: [
          Expanded(
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white)),
              child: Text("Back",style: GoogleFonts.montserrat(
                  fontSize: clsDimensConstants.douDp14,
                  color: Colors.black)),
              onPressed: () {
                if (!bolprogressIndicator_1) {
                  isShowCartView = true;
                  title = "Cart";
                  setState(() {});
                } else if (bolprogressIndicator_1) {
                  title = "Billing Information";
                  bolprogressIndicator_1 = false;
                  setState(() {});
                }
              },
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.orange)),
              child: Text("Next"),
              onPressed: () {
                if (bolprogressIndicator_1 == false) {
                  bolprogressIndicator_1 = true;
                  title = "Shipping Information";
                  setState(() {});
                } else {
                  if (shippingInfoModel.shippingMethodEnum ==
                      ShippingMethodEnum.GalleonOffice) {
                    if ((shippingInfoModel.shippingName ?? "").isEmpty) {
                      ShowSnackbar(
                          strMessage: "Please enter valid name.",
                          showheading: true);
                      return;
                    }
                  } else if (shippingInfoModel.shippingMethodEnum ==
                      ShippingMethodEnum.LbcOffice) {
                    if ((shippingInfoModel.shippingName ?? "").isEmpty) {
                      ShowSnackbar(
                          strMessage: "Please enter valid name.",
                          showheading: true);
                      return;
                    }
                    if ((shippingInfoModel.shippingEmail ?? "").isEmpty) {
                      ShowSnackbar(
                          strMessage: "Please enter valid email.",
                          showheading: true);
                      return;
                    }
                    if ((shippingInfoModel.phoneNo ?? "").isEmpty) {
                      ShowSnackbar(
                          strMessage: "Please enter valid phone.",
                          showheading: true);
                      return;
                    }
                    if ((shippingInfoModel.regionName ?? "").isEmpty) {
                      ShowSnackbar(
                          strMessage: "Please enter valid region.",
                          showheading: true);
                      return;
                    }
                  } else if (shippingInfoModel.shippingMethodEnum ==
                      ShippingMethodEnum.InputShippingAddress) {
                    if ((shippingInfoModel.shippingName ?? "").isEmpty) {
                      ShowSnackbar(
                          strMessage: "Please enter valid name.",
                          showheading: true);
                      return;
                    }
                    if ((shippingInfoModel.shippingEmail ?? "").isEmpty) {
                      ShowSnackbar(
                          strMessage: "Please enter valid email.",
                          showheading: true);
                      return;
                    }
                    if ((shippingInfoModel.phoneNo ?? "").isEmpty) {
                      ShowSnackbar(
                          strMessage: "Please enter valid phone.",
                          showheading: true);
                      return;
                    }
                    if ((shippingInfoModel.streetAddress ?? "").isEmpty) {
                      ShowSnackbar(
                          strMessage: "Please enter valid street address.",
                          showheading: true);
                      return;
                    }
                    if ((shippingInfoModel.province ?? "").isEmpty) {
                      ShowSnackbar(
                          strMessage: "Please select valid province.",
                          showheading: true);
                      return;
                    }
                    if ((shippingInfoModel.city ?? "").isEmpty) {
                      ShowSnackbar(
                          strMessage: "Please select valid city.",
                          showheading: true);
                      return;
                    }
                    if ((shippingInfoModel.barangay ?? "").isEmpty) {
                      ShowSnackbar(
                          strMessage: "Please select valid barangay.",
                          showheading: true);
                      return;
                    }
                    if ((shippingInfoModel.zipCode ?? "").isEmpty) {
                      ShowSnackbar(
                          strMessage: "Please enter valid zipCode.",
                          showheading: true);
                      return;
                    }
                  }
                  bolprogressIndicator_2 = true;
                  title = "Payment Method";
                  RecalculateCheckoutOnBaseofPayment();

                  setState(() {});
                }
              },
            ),
          )
        ],
      );
    }
    return const SizedBox();
  }

  Future<void> _launchUrl({required String strURl}) async {
    if (!await launchUrl(Uri.parse(strURl))) {
      ShowSnackbar(strMessage: "Failed to load", showheading: false);
      // throw Exception('Could not launch $_url');
    }
  }

  CartView() {
    if (objclsCartInfoModel != null) {
      if (objclsCartInfoModel!.items != null &&
          objclsCartInfoModel!.items!.isNotEmpty) {
        return Column(
          children: [
            if (!bolprogressIndicator_1 && !bolprogressIndicator_2)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => clsCartCouponsPageUI()))
                        .then((value) {
                      if (value != null) {
                        PrepareCartForCheckout();
                      }
                    });
                  },
                  child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.all(
                              Radius.circular(clsDimensConstants.douDp5)),
                          gradient: LinearGradient(colors: [
                            Theme.of(context).primaryColor,
                            Theme.of(context).primaryColor
                          ])),
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.confirmation_number_rounded,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "APPLY COUPON",
                                style: GoogleFonts.montserrat(
                                    fontSize: clsDimensConstants.douDp14,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ))),
                ),
              ),
            returnListofProducts(),
            SizedBox(
              height: 10,
            ),
            if (objclsCartInfoModel!.summary != null)
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: clsDimensConstants.douDp20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Sub Total",
                        style: GoogleFonts.montserrat(
                            fontSize: clsDimensConstants.douDp14,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        CommaSeparatedAmount(
                            objclsCartInfoModel!.summary!.srpTotal.toString()),
                        textAlign: TextAlign.end,
                        style: GoogleFonts.montserrat(
                            fontSize: clsDimensConstants.douDp14,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(
              height: 10,
            ),
            if (objclsCartInfoModel!.summary != null)
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: clsDimensConstants.douDp20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Discount",
                        style: GoogleFonts.montserrat(
                            fontSize: clsDimensConstants.douDp14,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        objclsCartInfoModel!.summary!.discount.toString(),
                        textAlign: TextAlign.end,
                        style: GoogleFonts.montserrat(
                            fontSize: clsDimensConstants.douDp14,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(
              height: 10,
            ),
            if (objclsCartInfoModel!.summary != null)
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: clsDimensConstants.douDp20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        "International Shipping Fee",
                        style: GoogleFonts.montserrat(
                            fontSize: clsDimensConstants.douDp14,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        CommaSeparatedAmount(objclsCartInfoModel!
                                .summary!.intlShipping
                                .toString())
                            .toString(),
                        textAlign: TextAlign.end,
                        style: GoogleFonts.montserrat(
                            fontSize: clsDimensConstants.douDp14,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(
              height: 10,
            ),
            if (objclsCartInfoModel!.summary != null)
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: clsDimensConstants.douDp20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Local Shipping Fee",
                        style: GoogleFonts.montserrat(
                            fontSize: clsDimensConstants.douDp14,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        CommaSeparatedAmount(objclsCartInfoModel!
                                .summary!.localShipping
                                .toString())
                            .toString(),
                        textAlign: TextAlign.end,
                        style: GoogleFonts.montserrat(
                            fontSize: clsDimensConstants.douDp14,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(
              height: 10,
            ),
            if (objclsCartInfoModel!.summary != null)
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: clsDimensConstants.douDp20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Transaction Fee",
                        style: GoogleFonts.montserrat(
                            fontSize: clsDimensConstants.douDp14,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        CommaSeparatedAmount(objclsCartInfoModel!
                                .summary!.transactionFee
                                .toString())
                            .toString(),
                        textAlign: TextAlign.end,
                        style: GoogleFonts.montserrat(
                            fontSize: clsDimensConstants.douDp14,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(
              height: 10,
            ),
            (objclsCartInfoModel!.giftFee != null)
                ? Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: clsDimensConstants.douDp20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Gift Wrap Fee",
                                style: GoogleFonts.montserrat(
                                    fontSize: clsDimensConstants.douDp14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                CommaSeparatedAmount(objclsCartInfoModel!
                                        .summary!.giftWrapFee
                                        .toString())
                                    .toString(),
                                textAlign: TextAlign.end,
                                style: GoogleFonts.montserrat(
                                    fontSize: clsDimensConstants.douDp14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  )
                : const SizedBox(),
            if (bolprogressIndicator_1 &&
                bolprogressIndicator_2 &&
                !bolprogressIndicator_2)
              Padding(
                  child: PaymentView(),
                  padding: EdgeInsets.symmetric(
                      horizontal: clsDimensConstants.douDp5)),
          ],
        );
      } else {
        return Center(child: Text("Your Cart Is Empty"));
      }
    } else {
      return Center(child: Text("Your Cart Is Loading"));
    }
  }

  void resetPaymentSummary(data) {
    objclsCartInfoModel!.summary!.intlShipping = data["intlShipping"];
    objclsCartInfoModel!.summary!.srpTotal = data["srpTotal"];
    objclsCartInfoModel!.summary!.localShipping = data["localShipping"];
    objclsCartInfoModel!.summary!.discount = data["discount"];
    objclsCartInfoModel!.summary!.giftWrapFee = data["giftWrapFee"];
    objclsCartInfoModel!.summary!.transactionFee = data["transactionFee"];
    objclsCartInfoModel!.summary!.invoiceGrandTotal = data["invoiceGrandTotal"];
    setState(() {});
  }

  PaymentView() {
    return Column(
      children: [
        Text(
          "Shipping Method",
          style: GoogleFonts.montserrat(
              fontSize: clsDimensConstants.douDp14,
              color: Colors.black,
              fontWeight: FontWeight.w700),
        ),
        Row(
          children: [
            Flexible(
              child: RadioListTile(
                title: Text("Via Air"),
                value: "air",
                groupValue: shippingmethodVia,
                onChanged: (value) async {
                  setState(() {
                    shippingmethodVia = value.toString();
                  });
                  ShowLoader(context);
                  await clsApiCallMethods.SetCheckoutMethod(
                          shippingMethod: "air")
                      .then((value) {
                    CancelLoader(context);
                    if (value.error == "false") {
                      if (value.data != null) {
                        resetPaymentSummary(value.data["summary"]);
                      }
                    }
                  });
                  // RecalculateCheckoutOnBaseofPayment();
                },
              ),
            ),
            Visibility(
              visible: showSea,
              child: Flexible(
                child: RadioListTile(
                  title: Text("Via Sea"),
                  value: "sea",
                  groupValue: shippingmethodVia,
                  onChanged: (value) async {
                    setState(() {
                      shippingmethodVia = value.toString();
                    });
                    ShowLoader(context);
                    await clsApiCallMethods.SetCheckoutMethod(
                            shippingMethod: "sea")
                        .then((value) {
                      CancelLoader(context);
                      if (value.error == "false") {
                        if (value.data != null) {
                          resetPaymentSummary(value.data["summary"]);
                        }
                      }
                    });

                    //  RecalculateCheckoutOnBaseofPayment();
                  },
                ),
              ),
            )
          ],
        ),
        Text(
          "Payment Method",
          style: GoogleFonts.montserrat(
              fontSize: clsDimensConstants.douDp14,
              color: Colors.black,
              fontWeight: FontWeight.w700),
        ),
        Row(
          children: [
            Radio(
                value: 1,
                groupValue: selectedGroupValue,
                onChanged: (val) {
                  Paymentmethod = null;
                  selectedGroupValue = 1;
                  setState(() {});
                }),
            SizedBox(
              width: 120,
              child: Text("Online banking"),
            ),
            SizedBox(
              width: 18,
            ),
            SizedBox(
              width: 120,
              child: DropdownButton(
                  isExpanded: true,
                  value: selectedGroupValue == 1 ? Paymentmethod : null,
                  items: onlineBanking.map((e) {
                    return DropdownMenuItem(
                        child: Text(e.text), value: e.value);
                  }).toList(),
                  onChanged: selectedGroupValue == 1
                      ? (value) {
                          setState(() {
                            Paymentmethod = value.toString();
                          });
                          RecalculateCheckoutOnBaseofPayment();
                        }
                      : null),
            )
          ],
        ),
        Row(
          children: [
            Radio(
                value: 2,
                groupValue: selectedGroupValue,
                onChanged: (val) {
                  Paymentmethod = null;
                  selectedGroupValue = 2;
                  setState(() {});
                }),
            SizedBox(
              width: 120,
              child: Text("E-wallet"),
            ),
            SizedBox(
              width: 18,
            ),
            SizedBox(
              width: 120,
              child: DropdownButton(
                  isExpanded: true,
                  value: selectedGroupValue == 2 ? Paymentmethod : null,
                  items: eWalletMethods.map((e) {
                    return DropdownMenuItem(
                        child: Text(e.text), value: e.value);
                  }).toList(),
                  onChanged: selectedGroupValue == 2
                      ? (value) {
                          setState(() {
                            Paymentmethod = value.toString();
                          });
                          RecalculateCheckoutOnBaseofPayment();
                        }
                      : null),
            )
          ],
        ),
        Row(
          children: [
            Radio(
                value: 3,
                groupValue: selectedGroupValue,
                onChanged: (val) {
                  Paymentmethod = dragonpayPayMethod.value;
                  selectedGroupValue = 3;
                  setState(() {});
                  RecalculateCheckoutOnBaseofPayment();
                }),
            SizedBox(
              width: 200,
              child: Text(dragonpayPayMethod.text),
            ),
          ],
        ),
        Row(
          children: [
            Radio(
                value: 4,
                groupValue: selectedGroupValue,
                onChanged: (val) {
                  Paymentmethod = payPalOrCreditDebitCard.value;
                  selectedGroupValue = 4;
                  setState(() {});
                  RecalculateCheckoutOnBaseofPayment();
                }),
            SizedBox(
              width: 200,
              child: Text(payPalOrCreditDebitCard.text),
            ),
          ],
        ),
        Row(
          children: [
            Radio(
                value: 5,
                groupValue: selectedGroupValue,
                onChanged: (val) {
                  Paymentmethod = installmentPayMethod.value;
                  selectedGroupValue = 5;
                  setState(() {});
                  RecalculateCheckoutOnBaseofPayment();
                }),
            SizedBox(
              width: 200,
              child: Text(installmentPayMethod.text),
            ),
          ],
        ),
        Visibility(
          visible: isAllowedCod,
          child: Row(
            children: [
              Radio(
                  value: 6,
                  groupValue: selectedGroupValue,
                  onChanged: (val) {
                    Paymentmethod = cashOnDeliveryPayMethod.value;
                    selectedGroupValue = 6;
                    setState(() {});
                    RecalculateCheckoutOnBaseofPayment();
                  }),
              SizedBox(
                width: 200,
                child: Text(cashOnDeliveryPayMethod.text),
              ),
            ],
          ),
        ),
        Visibility(
          visible: isAllowedCod,
          child: Row(
            children: [
              Radio(
                  value: 7,
                  groupValue: selectedGroupValue,
                  onChanged: (val) {
                    Paymentmethod = cashUponPickupPayMethod.value;
                    selectedGroupValue = 7;
                    setState(() {});
                    RecalculateCheckoutOnBaseofPayment();
                  }),
              SizedBox(
                width: 200,
                child: Text(cashUponPickupPayMethod.text),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 18,
        ),
        Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            TextField(
              focusNode: _giftfocusNode,
              controller: _giftController,
              decoration: InputDecoration(
                // hintText: textEditHasFocus ? '' : 'Label',
                // hintStyle: TextStyle(
                //   color: Colors.grey,
                // ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                contentPadding: EdgeInsets.only(left: 10),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              left: gifttextEditHasFocus ? 10 : 20,
              top: gifttextEditHasFocus ? -10 : 13,
              child: InkWell(
                onTap: () {
                  _giftfocusNode.requestFocus();
                },
                child: Container(
                  padding: EdgeInsets.only(left: 3),
                  color: Colors.white,
                  child: Text('Add Gift Wrap Text'),
                ),
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.all(clsDimensConstants.douDp10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    InkWell(
                        onTap: () async {
                          if (!giftwrapcheckbox) {
                            giftwrapcheckbox = true;
                            ShowLoader(context);
                            String token = clsSharedPrefernce.objSharedPrefs!
                                .get(clsSharedPrefernceKeyValue.USER_TOKEN)
                                .toString();
                            var data = {
                              'gift_dedication': _giftController.value.text
                            };
                            var dio = Dio();
                            var response = await dio.request(
                              'https://rest.galleon.ph/cart/gift?token=$token&action=add',
                              options: Options(
                                method: 'POST',
                              ),
                              data: data,
                            );
                            intGiftwrapAmount =
                                response.data["data"]["value"] ?? 100;
                            CancelLoader(context);
                          } else {
                            String token = clsSharedPrefernce.objSharedPrefs!
                                .get(clsSharedPrefernceKeyValue.USER_TOKEN)
                                .toString();
                            ShowLoader(context);
                            giftwrapcheckbox = false;
                            var data = {
                              'gift_dedication': _giftController.value.text
                            };
                            var dio = Dio();
                            await dio.request(
                              'https://rest.galleon.ph/cart/gift?token=$token&action=clear',
                              options: Options(
                                method: 'POST',
                              ),
                              data: data,
                            );
                            intGiftwrapAmount = 0;
                            CancelLoader(context);
                          }
                          RecalculateCheckoutOnBaseofPayment();
                          setState(() {});
                        },
                        child: Icon(
                          giftwrapcheckbox
                              ? Icons.check_box_rounded
                              : Icons.check_box_outline_blank,
                          color: Colors.black,
                        )),
                    Text(
                      "Gift Wrapping",
                      style: GoogleFonts.montserrat(
                          fontSize: clsDimensConstants.douDp14,
                          color: Colors.black),
                    ),
                  ],
                ),
                Text(
                  intGiftwrapAmount.toString(),
                  style: GoogleFonts.montserrat(
                      fontSize: clsDimensConstants.douDp14,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(clsDimensConstants.douDp10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Grand Total",
                style: GoogleFonts.montserrat(
                    fontSize: clsDimensConstants.douDp14,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                objclsCartInfoModel != null
                    ? objclsCartInfoModel!.summary != null
                        ? CommaSeparatedAmount((objclsCartInfoModel!
                                    .summary!.invoiceGrandTotal!)
                                .toString())
                            .toString()
                        : "0"
                    : "0",
                style: GoogleFonts.montserrat(
                    fontSize: clsDimensConstants.douDp14,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
        )
      ],
    );
  }

  AddressView() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => clsAddressPageUI())).then((value) {
                getAddressesList();
              });
            },
            child: Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.add,
                    color: Theme.of(context).primaryColor,
                  ),
                  Text(
                    "Add new Address",
                    style: GoogleFonts.montserrat(
                        fontSize: clsDimensConstants.douDp14,
                        color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
            ),
          ),
        ),
        lstclsAddresssModel.isNotEmpty
            ? ListView.builder(
                itemCount: lstclsAddresssModel.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      for (var element in lstclsAddresssModel) {
                        element.isSelected = false;
                      }
                      lstclsAddresssModel[index].isSelected = true;
                      setState(() {});
                      getRegionName(
                          strStateName: lstclsAddresssModel[index]
                              .addressState
                              .toString());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.all(clsDimensConstants.douDp5),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset:
                                    Offset(0, 1), // changes position of shadow
                              ),
                            ],
                            border: Border.all(
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.all(
                                Radius.circular(clsDimensConstants.douDp15)),
                            gradient: LinearGradient(colors: [
                              Theme.of(context).cardColor,
                              Theme.of(context).cardColor
                            ])),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Biller Name:- ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                clsDimensConstants.douDp12,
                                          ),
                                        ),
                                        TextSpan(
                                            text: lstclsAddresssModel[index]
                                                    .addressName ??
                                                "",
                                            style: TextStyle(
                                              fontSize:
                                                  clsDimensConstants.douDp12,
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                                if (lstclsAddresssModel[index].isSelected)
                                  InkWell(
                                      onTap: () {
                                        // deleteAddress(address_id: this.lstclsAddresssModel[index].addressId!);
                                      },
                                      child: Icon(
                                        Icons.check_circle,
                                        color: Theme.of(context).primaryColor,
                                      ))
                              ],
                            ),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Email:- ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: clsDimensConstants.douDp12,
                                    ),
                                  ),
                                  TextSpan(
                                      text: lstclsAddresssModel[index]
                                              .addressEmail ??
                                          "",
                                      style: TextStyle(
                                        fontSize: clsDimensConstants.douDp12,
                                      )),
                                ],
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Phone:- ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: clsDimensConstants.douDp12,
                                    ),
                                  ),
                                  TextSpan(
                                      text: lstclsAddresssModel[index]
                                              .addressPhone ??
                                          "",
                                      style: TextStyle(
                                        fontSize: clsDimensConstants.douDp12,
                                      )),
                                ],
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Secondary Phone:- ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: clsDimensConstants.douDp12,
                                    ),
                                  ),
                                  TextSpan(
                                      text: lstclsAddresssModel[index]
                                              .addressPhone2 ??
                                          "",
                                      style: TextStyle(
                                        fontSize: clsDimensConstants.douDp12,
                                      )),
                                ],
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Country:- ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: clsDimensConstants.douDp12,
                                    ),
                                  ),
                                  TextSpan(
                                      text: "Philippines",
                                      style: TextStyle(
                                        fontSize: clsDimensConstants.douDp12,
                                      )),
                                ],
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'City:- ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: clsDimensConstants.douDp12,
                                    ),
                                  ),
                                  TextSpan(
                                      text: lstclsAddresssModel[index]
                                              .addressCity ??
                                          "",
                                      style: TextStyle(
                                        fontSize: clsDimensConstants.douDp12,
                                      )),
                                ],
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'State:- ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: clsDimensConstants.douDp12,
                                    ),
                                  ),
                                  TextSpan(
                                      text: lstclsAddresssModel[index]
                                              .addressState ??
                                          "",
                                      style: TextStyle(
                                        fontSize: clsDimensConstants.douDp12,
                                      )),
                                ],
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Barangay:- ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: clsDimensConstants.douDp12,
                                    ),
                                  ),
                                  TextSpan(
                                      text: lstclsAddresssModel[index]
                                              .addressBarangay ??
                                          "",
                                      style: TextStyle(
                                        fontSize: clsDimensConstants.douDp12,
                                      )),
                                ],
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'House/Bldg.#, Lot, Blk:- ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: clsDimensConstants.douDp12,
                                    ),
                                  ),
                                  TextSpan(
                                      text: lstclsAddresssModel[index]
                                              .addressStreet ??
                                          "",
                                      style: TextStyle(
                                        fontSize: clsDimensConstants.douDp12,
                                      )),
                                ],
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Street Address:- ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: clsDimensConstants.douDp12,
                                    ),
                                  ),
                                  TextSpan(
                                      text: lstclsAddresssModel[index]
                                              .addressStreet2 ??
                                          "",
                                      style: TextStyle(
                                        fontSize: clsDimensConstants.douDp12,
                                      )),
                                ],
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Address Mobile:- ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: clsDimensConstants.douDp12,
                                    ),
                                  ),
                                  TextSpan(
                                      text: lstclsAddresssModel[index]
                                              .addressMobile ??
                                          "",
                                      style: TextStyle(
                                        fontSize: clsDimensConstants.douDp12,
                                      )),
                                ],
                              ),
                            ),
                            Center(
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                    height: 30,
                                    width: 200,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                clsDimensConstants.douDp15)),
                                        gradient: LinearGradient(colors: [
                                          Theme.of(context).primaryColor,
                                          Theme.of(context).primaryColor
                                        ])),
                                    child: Center(
                                        child: Text(
                                      "Deliver to this Address",
                                      style: GoogleFonts.montserrat(
                                          fontSize: clsDimensConstants.douDp12,
                                          color: Colors.white),
                                    ))),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                })
            : Center(
                child: Text("No Address Found"),
              ),
        SizedBox(
          height: 200,
        ),
      ],
    );
  }

  SummaryView() {
    return Column(
      children: [
        returnListofProducts(),
        SizedBox(
          height: 20,
        ),
        if (objclsCartInfoModel!.summary != null)
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: clsDimensConstants.douDp20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Sub Total",
                    style: GoogleFonts.montserrat(
                        fontSize: clsDimensConstants.douDp14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Expanded(
                  child: Text(
                    CommaSeparatedAmount(
                        objclsCartInfoModel!.summary!.srpTotal.toString()),
                    textAlign: TextAlign.end,
                    style: GoogleFonts.montserrat(
                        fontSize: clsDimensConstants.douDp14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        SizedBox(
          height: 10,
        ),
        if (objclsCartInfoModel!.summary != null)
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: clsDimensConstants.douDp20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Discount",
                    style: GoogleFonts.montserrat(
                        fontSize: clsDimensConstants.douDp14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Expanded(
                  child: Text(
                    objclsCartInfoModel!.summary!.discount.toString(),
                    textAlign: TextAlign.end,
                    style: GoogleFonts.montserrat(
                        fontSize: clsDimensConstants.douDp14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        SizedBox(
          height: 10,
        ),
        if (objclsCartInfoModel!.summary != null)
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: clsDimensConstants.douDp20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    "International Shipping Fee",
                    style: GoogleFonts.montserrat(
                        fontSize: clsDimensConstants.douDp14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Expanded(
                  child: Text(
                    CommaSeparatedAmount(objclsCartInfoModel!
                            .summary!.intlShipping
                            .toString())
                        .toString(),
                    textAlign: TextAlign.end,
                    style: GoogleFonts.montserrat(
                        fontSize: clsDimensConstants.douDp14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        SizedBox(
          height: 10,
        ),
        if (objclsCartInfoModel!.summary != null)
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: clsDimensConstants.douDp20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    "Local Shipping Fee",
                    style: GoogleFonts.montserrat(
                        fontSize: clsDimensConstants.douDp14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Expanded(
                  child: Text(
                    CommaSeparatedAmount(objclsCartInfoModel!
                            .summary!.localShipping
                            .toString())
                        .toString(),
                    textAlign: TextAlign.end,
                    style: GoogleFonts.montserrat(
                        fontSize: clsDimensConstants.douDp14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        SizedBox(
          height: 10,
        ),
        if (objclsCartInfoModel!.summary != null)
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: clsDimensConstants.douDp20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    "Transaction Fee",
                    style: GoogleFonts.montserrat(
                        fontSize: clsDimensConstants.douDp14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Expanded(
                  child: Text(
                    CommaSeparatedAmount(objclsCartInfoModel!
                            .summary!.transactionFee
                            .toString())
                        .toString(),
                    textAlign: TextAlign.end,
                    style: GoogleFonts.montserrat(
                        fontSize: clsDimensConstants.douDp14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        SizedBox(
          height: 10,
        ),
        if (objclsCartInfoModel!.summary?.giftWrapFee != null &&
            (objclsCartInfoModel!.summary?.giftWrapFee ?? 0) > 0)
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: clsDimensConstants.douDp20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    "Gift Wrap Fee",
                    style: GoogleFonts.montserrat(
                        fontSize: clsDimensConstants.douDp14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Expanded(
                  child: Text(
                    CommaSeparatedAmount(objclsCartInfoModel!
                            .summary?.giftWrapFee
                            .toString())
                        .toString(),
                    textAlign: TextAlign.end,
                    style: GoogleFonts.montserrat(
                        fontSize: clsDimensConstants.douDp14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: clsDimensConstants.douDp20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  "Grand Total",
                  style: GoogleFonts.montserrat(
                      fontSize: clsDimensConstants.douDp18,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Expanded(
                child: Text(
                  CommaSeparatedAmount(
                          (objclsCartInfoModel!.summary!.invoiceGrandTotal!)
                              .toString())
                      .toString(),
                  textAlign: TextAlign.end,
                  style: GoogleFonts.montserrat(
                      fontSize: clsDimensConstants.douDp18,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        if (lstclsAddresssModel.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.all(clsDimensConstants.douDp5),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                  border: Border.all(color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.all(
                      Radius.circular(clsDimensConstants.douDp15)),
                  gradient: LinearGradient(colors: [
                    Theme.of(context).cardColor,
                    Theme.of(context).cardColor
                  ])),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Biller Name:- ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: clsDimensConstants.douDp12,
                                ),
                              ),
                              TextSpan(
                                  text: lstclsAddresssModel
                                          .where((element) =>
                                              element.isSelected == true)
                                          .toList()[0]
                                          .addressName ??
                                      "",
                                  style: TextStyle(
                                    fontSize: clsDimensConstants.douDp12,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Email:- ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: clsDimensConstants.douDp12,
                          ),
                        ),
                        TextSpan(
                            text: lstclsAddresssModel
                                    .where(
                                        (element) => element.isSelected == true)
                                    .toList()[0]
                                    .addressEmail ??
                                "",
                            style: TextStyle(
                              fontSize: clsDimensConstants.douDp12,
                            )),
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Phone:- ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: clsDimensConstants.douDp12,
                          ),
                        ),
                        TextSpan(
                            text: lstclsAddresssModel
                                    .where(
                                        (element) => element.isSelected == true)
                                    .toList()[0]
                                    .addressPhone ??
                                "",
                            style: TextStyle(
                              fontSize: clsDimensConstants.douDp12,
                            )),
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Secondary Phone:- ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: clsDimensConstants.douDp12,
                          ),
                        ),
                        TextSpan(
                            text: lstclsAddresssModel
                                    .where(
                                        (element) => element.isSelected == true)
                                    .toList()[0]
                                    .addressPhone2 ??
                                "",
                            style: TextStyle(
                              fontSize: clsDimensConstants.douDp12,
                            )),
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Country:- ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: clsDimensConstants.douDp12,
                          ),
                        ),
                        TextSpan(
                            text: "Philippines",
                            style: TextStyle(
                              fontSize: clsDimensConstants.douDp12,
                            )),
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'City:- ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: clsDimensConstants.douDp12,
                          ),
                        ),
                        TextSpan(
                            text: lstclsAddresssModel
                                    .where(
                                        (element) => element.isSelected == true)
                                    .toList()[0]
                                    .addressCity ??
                                "",
                            style: TextStyle(
                              fontSize: clsDimensConstants.douDp12,
                            )),
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'State:- ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: clsDimensConstants.douDp12,
                          ),
                        ),
                        TextSpan(
                            text: lstclsAddresssModel
                                    .where(
                                        (element) => element.isSelected == true)
                                    .toList()[0]
                                    .addressState ??
                                "",
                            style: TextStyle(
                              fontSize: clsDimensConstants.douDp12,
                            )),
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Barangay:- ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: clsDimensConstants.douDp12,
                          ),
                        ),
                        TextSpan(
                            text: lstclsAddresssModel
                                    .where(
                                        (element) => element.isSelected == true)
                                    .toList()[0]
                                    .addressBarangay ??
                                "",
                            style: TextStyle(
                              fontSize: clsDimensConstants.douDp12,
                            )),
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'House/Bldg.#, Lot, Blk:- ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: clsDimensConstants.douDp12,
                          ),
                        ),
                        TextSpan(
                            text: lstclsAddresssModel
                                    .where(
                                        (element) => element.isSelected == true)
                                    .toList()[0]
                                    .addressStreet ??
                                "",
                            style: TextStyle(
                              fontSize: clsDimensConstants.douDp12,
                            )),
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Street Address:- ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: clsDimensConstants.douDp12,
                          ),
                        ),
                        TextSpan(
                            text: lstclsAddresssModel
                                    .where(
                                        (element) => element.isSelected == true)
                                    .toList()[0]
                                    .addressStreet2 ??
                                "",
                            style: TextStyle(
                              fontSize: clsDimensConstants.douDp12,
                            )),
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Address Mobile:- ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: clsDimensConstants.douDp12,
                          ),
                        ),
                        TextSpan(
                            text: lstclsAddresssModel
                                    .where(
                                        (element) => element.isSelected == true)
                                    .toList()[0]
                                    .addressMobile ??
                                "",
                            style: TextStyle(
                              fontSize: clsDimensConstants.douDp12,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
      ],
    );
  }

  returnListofProducts() {
    List<Widget> lstWidget = <Widget>[];

    if (objclsCartInfoModel!.items != null) {
      for (var element in objclsCartInfoModel!.items!) {
        lstWidget.add(
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                  border: Border.all(color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.all(
                      Radius.circular(clsDimensConstants.douDp15)),
                  gradient: LinearGradient(colors: [
                    Theme.of(context).cardColor,
                    Theme.of(context).cardColor
                  ])),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: clsDimensConstants.douDp10,
                          right: clsDimensConstants.douDp10),
                      child: Image.network(
                        element.product!.imgThumb!,
                        width: 50,
                        height: 100,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: clsDimensConstants.douDp5,
                                vertical: clsDimensConstants.douDp2),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                element.product!.productName.toString(),
                                style: GoogleFonts.montserrat(
                                    fontSize: clsDimensConstants.douDp10,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: clsDimensConstants.douDp5,
                                vertical: clsDimensConstants.douDp2),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "₱ ${CommaSeparatedAmount(element.product!.productSrp ?? "0")}",
                                style: GoogleFonts.montserrat(
                                    fontSize: clsDimensConstants.douDp10,
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (!bolprogressIndicator_1 && !bolprogressIndicator_2)
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: clsDimensConstants.douDp5,
                            vertical: clsDimensConstants.douDp2),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: clsDimensConstants.douDp8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: clsDimensConstants.douDp5,
                                      vertical: clsDimensConstants.douDp2),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Quantity",
                                      style: GoogleFonts.montserrat(
                                          fontSize: clsDimensConstants.douDp10,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: clsDimensConstants.douDp8),
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          if (element.quantity != 0) {
                                            element.quantity =
                                                element.quantity! - 1;
                                            setState(() {});
                                            addToCart(
                                                strPid: element
                                                    .product!.productId
                                                    .toString(),
                                                strQuantity: element.quantity
                                                    .toString());
                                          } else {
                                            RemoveItemInWhishlist(
                                                pid: element.product!.productId
                                                    .toString());
                                          }
                                        },
                                        child: Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.3),
                                                  spreadRadius: 3,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      1), // changes position of shadow
                                                ),
                                              ],
                                              border: Border.all(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      clsDimensConstants
                                                          .douDp15)),
                                              gradient: LinearGradient(colors: [
                                                Theme.of(context).cardColor,
                                                Theme.of(context).cardColor
                                              ])),
                                          child: Center(
                                              child: Text(
                                            "-",
                                            style: GoogleFonts.montserrat(
                                                fontSize:
                                                    clsDimensConstants.douDp12,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500),
                                          )),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        element.quantity.toString(),
                                        style: GoogleFonts.montserrat(
                                            fontSize:
                                                clsDimensConstants.douDp12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          element.quantity =
                                              element.quantity! + 1;
                                          addToCart(
                                              strPid: element.product!.productId
                                                  .toString(),
                                              strQuantity:
                                                  element.quantity.toString());

                                          setState(() {});
                                        },
                                        child: Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.3),
                                                  spreadRadius: 3,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      1), // changes position of shadow
                                                ),
                                              ],
                                              border: Border.all(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      clsDimensConstants
                                                          .douDp15)),
                                              gradient: LinearGradient(colors: [
                                                Theme.of(context).primaryColor,
                                                Theme.of(context).primaryColor
                                              ])),
                                          child: Center(
                                              child: Text(
                                            "+",
                                            style: GoogleFonts.montserrat(
                                                fontSize:
                                                    clsDimensConstants.douDp12,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500),
                                          )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    RemoveItemInWhishlist(
                                        pid: element.product!.productId
                                            .toString());
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: clsDimensConstants.douDp5,
                                        top: clsDimensConstants.douDp15),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Remove Item",
                                        style: GoogleFonts.montserrat(
                                            fontSize:
                                                clsDimensConstants.douDp10,
                                            color: Colors.red,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (bolprogressIndicator_2)
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: clsDimensConstants.douDp8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: clsDimensConstants.douDp5,
                                  vertical: clsDimensConstants.douDp2),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Quantity",
                                  style: GoogleFonts.montserrat(
                                      fontSize: clsDimensConstants.douDp10,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: clsDimensConstants.douDp8),
                              child: Center(
                                child: Text(
                                  element.quantity.toString(),
                                  style: GoogleFonts.montserrat(
                                      fontSize: clsDimensConstants.douDp16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
        );
      }
    }

    lstWidget.add(const Text(""));
    return Wrap(
      children: lstWidget,
    );
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

  GiftCard({required String strAction}) {
    ShowLoader(context);
    clsApiCallMethods.GiftCard(
        strAction: strAction,
        objMap: {"gift_dedication": _giftController.value.text}).then((value) {
      CancelLoader(context);
      if (value.error == "true") {
        intGiftwrapAmount = 0;
        Future.delayed(Duration(seconds: 1)).then((value) {
          RecalculateCheckoutOnBaseofPayment();
        });
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
          // ShowSnackbar(strMessage: value.data.toString(), showheading: false);
          if (value.data["value"] != null) {
            intGiftwrapAmount = value.data["value"];
          } else {
            intGiftwrapAmount = 0;
          }
          setState(() {});
        } else {
          intGiftwrapAmount = 0;
        }
        RecalculateCheckoutOnBaseofPayment();
      }
    });
  }

  addToCart({required String strPid, required String strQuantity}) {
    Map<String, String> objMap = {
      "pid": strPid,
      "qty": strQuantity,
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
          getCartInformation();
        }
      }
    });
  }

  getAddressesList() {
    ShowLoader(context);
    clsApiCallMethods.getAllAddresses().then((value) {
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
          lstclsAddresssModel = List<clsAddresssModel>.from(
              value.data.map((e) => clsAddresssModel.fromJson(e)));
          if (lstclsAddresssModel.isNotEmpty) {
            lstclsAddresssModel[0].isSelected = true;
            getRegionName(
                strStateName: lstclsAddresssModel[0].addressState.toString());
          }
          setState(() {});
        }
      }
    });
  }

  getCartInformation() {
    ShowLoader(context);
    clsApiCallMethods.getCartInformation().then((value) async {
      if (value.error == "true") {
        CancelLoader(context);
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
          showSea = objclsCartInfoModel!.forSea ?? false;

          if (objclsCartInfoModel != null) {
            if (objclsCartInfoModel!.items!.isEmpty) {
              await clsApiCallMethods.removeAllCoupons();
              ShowSnackbar(
                  strMessage: "Your cart is empty.", showheading: true);
              Navigator.pop(context);
            }
          }
          CancelLoader(context);

          setState(() {});
        } else {
          CancelLoader(context);
        }
      }
    });
  }

  getRegionName({required String strStateName}) {
    clsApiCallMethods
        .getRegionByState(strStateName: strStateName)
        .then((value) {
      if (value.error == "false") {
        recalcuateCheckoutonBaseofShippingAddress(
            strRegionName: value.data["region_name"]);
      }
    });
  }

  recalcuateCheckoutonBaseofShippingAddress({required String strRegionName}) {
    // ShowLoader(context);
    clsApiCallMethods.RecalculateCheckoutOnBaseofShippingAddress(objData: {
      "region": strRegionName.toLowerCase(),
      "isPickup": (shippingInfoModel.shippingMethodEnum ==
                  ShippingMethodEnum.LbcOffice ||
              shippingInfoModel.shippingMethodEnum ==
                  ShippingMethodEnum.GalleonOffice)
          ? 1
          : 0
    }).then((value) {
      // CancelLoader(context);
      if (value.error == "true") {
        if (value.fieldValidation != null) {}
      } else {
        if (value.data != null) {
          objclsRecalculateCheckoutModel =
              clsRecalculateCheckoutModel.fromJson(value.data);
          objclsCartInfoModel!.summary!.intlShipping =
              objclsRecalculateCheckoutModel.intlShipping;
          objclsCartInfoModel!.summary!.srpTotal =
              objclsRecalculateCheckoutModel.srpTotal;
          objclsCartInfoModel!.summary!.localShipping =
              objclsRecalculateCheckoutModel.localShipping;
          objclsCartInfoModel!.summary!.discount =
              objclsRecalculateCheckoutModel.discount;
          objclsCartInfoModel!.summary!.giftWrapFee =
              objclsRecalculateCheckoutModel.giftWrapFee;
          objclsCartInfoModel!.summary!.transactionFee =
              objclsRecalculateCheckoutModel.transactionFee;
          objclsCartInfoModel!.summary!.invoiceGrandTotal =
              objclsRecalculateCheckoutModel.invoiceGrandTotal;
          isAllowedCod = objclsRecalculateCheckoutModel.isAllowedCod ?? false;
          setState(() {});
        }
      }
    });
  }

  RecalculateCheckoutOnBaseofPayment() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    ShowLoader(context);
    await Future.delayed(const Duration(milliseconds: 1000));

    clsAddresssModel objselectedaddress =lstclsAddresssModel
        .where((element) => element.isSelected == true)
        .toList().length <= 0 ?new clsAddresssModel(): lstclsAddresssModel
        .where((element) => element.isSelected == true)
        .toList()[0];
    getRegionName(strStateName: objselectedaddress.addressState ?? "");
    clsApiCallMethods.RecalculateCheckoutOnBaseofPayment(
        objData: {"paymentType": Paymentmethod?.toUpperCase()}).then((value) {
      CancelLoader(context);
      if (value.error == "true") {
        enableSubmit = false;
        if (value.messages.length != 0) {
          ShowSnackbar(
              strMessage: value.messages![0].toString(), showheading: true);
        }
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
          enableSubmit = true;
          objclsRecalculateCheckoutModel =
              clsRecalculateCheckoutModel.fromJson(value.data);
          objclsCartInfoModel!.summary!.intlShipping =
              objclsRecalculateCheckoutModel.intlShipping;
          objclsCartInfoModel!.summary!.srpTotal =
              objclsRecalculateCheckoutModel.srpTotal;
          objclsCartInfoModel!.summary!.localShipping =
              objclsRecalculateCheckoutModel.localShipping;
          objclsCartInfoModel!.summary!.discount =
              objclsRecalculateCheckoutModel.discount;
          objclsCartInfoModel!.summary!.giftWrapFee =
              objclsRecalculateCheckoutModel.giftWrapFee;
          objclsCartInfoModel!.summary!.transactionFee =
              objclsRecalculateCheckoutModel.transactionFee;
          objclsCartInfoModel!.summary!.invoiceGrandTotal =
              objclsRecalculateCheckoutModel.invoiceGrandTotal;
          isAllowedCod = objclsRecalculateCheckoutModel.isAllowedCod ?? false;
          setState(() {});
        } else {
          enableSubmit = false;
          if (value.messages.length != 0) {
            ShowSnackbar(
                strMessage: value.messages![0].toString(), showheading: true);
          }
        }
      }
    });
  }

  PrepareCartForCheckout() {
    ShowLoader(context);
    clsApiCallMethods.PrepareCartForCheckout().then((value) {
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
        getCartInformation();
        if (value.data != null) {}
      }
    });
  }
}

class PaymentMethodModel {
  final String text;
  final String value;
  PaymentMethodModel({required this.text, required this.value});
}

List<PaymentMethodModel> onlineBanking = [
  PaymentMethodModel(text: "UBP", value: "paynamics-ubp_online"),
  PaymentMethodModel(text: "BPI", value: "paynamics-bpi_ph"),
  PaymentMethodModel(text: "BDO", value: "paynamics-br_bdo_ph"),
  //PaymentMethodModel(text: "PNB",value : "paynamics-pnbonline_ph"),
  //PaymentMethodModel(text: "RCBC",value : "paynamics-br_rcbc_ph"),
];
List<PaymentMethodModel> eWalletMethods = [
  PaymentMethodModel(text: "GCash", value: "gcash"),
  PaymentMethodModel(text: "Maya", value: "maya")
];

PaymentMethodModel payPalOrCreditDebitCard =
    PaymentMethodModel(text: "Credit/Debit Card via Paypal", value: "paypal");

PaymentMethodModel dragonpayPayMethod = PaymentMethodModel(
    text: "Over-the-counter via Dragonpay", value: "dragonpay");

PaymentMethodModel installmentPayMethod =
    PaymentMethodModel(text: "Installement via Bill Ease", value: "billease");
PaymentMethodModel cashOnDeliveryPayMethod =
    PaymentMethodModel(text: "Cash on Delivery", value: "cod");
PaymentMethodModel cashUponPickupPayMethod =
    PaymentMethodModel(text: "Cash upon Pickup", value: "cup");
