// ignore_for_file: must_be_immutable, camel_case_types, prefer_final_fields, prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, non_constant_identifier_names

import 'package:badges/badges.dart';
import 'package:ecommerce/app_utility.dart';
import 'package:ecommerce/constants/clsDimensConstants.dart';
import 'package:ecommerce/localStorage/clsSharedPrefernce.dart';
import 'package:ecommerce/localStorage/clsSharedPrefernceKeyValue.dart';
import 'package:ecommerce/models/clsProductModel.dart';
import 'package:ecommerce/network/clsApiCallMethods.dart';
import 'package:ecommerce/pages/clsImagePreview.dart';
import 'package:ecommerce/pages/clsLoginPageUI.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:google_fonts/google_fonts.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/clsCommonWidget.dart';
import '../main.dart';
import '../network/clsApiUrls.dart';
import 'clsCartPageUI.dart';

class clsProductDetailsPageUI extends StatefulWidget {
  clsProductModel objclsProductModel;

  clsProductDetailsPageUI({super.key, required this.objclsProductModel});

  @override
  State<clsProductDetailsPageUI> createState() =>
      _clsProductDetailsPageUIState();
}

class _clsProductDetailsPageUIState extends State<clsProductDetailsPageUI> {
  bool addIconInWhislist = false;
  List<clsProductModel> lstclsProductModel = <clsProductModel>[];
  clsProductModel? objclsProductModel;
  ScrollController _scrollController = ScrollController();

  int intTextLimitCount = 400;
  bool showMoreBullets = false;
  bool bollessmoreclicable = true;

  @override
  void initState() {
    super.initState();

    if (clsSharedPrefernce.objSharedPrefs!
            .getString(clsSharedPrefernceKeyValue.USER_TOKEN) ==
        null) {
      clsApiCallMethods.ItemsInCart().then((value) {
        setState(() {});
      });
    } else if (clsSharedPrefernce.objSharedPrefs!
        .getString(clsSharedPrefernceKeyValue.USER_TOKEN)!
        .isNotEmpty) {
      clsApiCallMethods.ItemsInCart().then((value) {
        setState(() {});
      });
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getProductByProductId();
      getRelatedProductByProductId();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Details",
          style: GoogleFonts.montserrat(
              fontSize: clsDimensConstants.douDp14,
              color: Colors.black,
              fontWeight: FontWeight.w500),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15, top: 8),
            child: IconButton(
              onPressed: () {
                if (clsSharedPrefernce.objSharedPrefs!
                        .getString(clsSharedPrefernceKeyValue.USER_TOKEN) ==
                    null) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => clsLoginPageUI()));
                } else if (clsSharedPrefernce.objSharedPrefs!
                    .getString(clsSharedPrefernceKeyValue.USER_TOKEN)!
                    .isEmpty) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => clsLoginPageUI()));
                } else {
                  if (addIconInWhislist) {
                    addIconInWhislist = false;
                    RemoveItemInWhishlist();
                  } else {
                    addIconInWhislist = true;
                    addItemInWhishlist();
                  }
                  setState(() {});
                }
              },
              icon: Icon(
                Icons.favorite,
                color: addIconInWhislist
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              _launchUrl(strURl: CHAT_URL);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 15, top: 8),
              child: Image.asset(
                "assets/images/chat.png",
                width: 20,
                height: 20,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              if (clsSharedPrefernce.objSharedPrefs!
                      .getString(clsSharedPrefernceKeyValue.USER_TOKEN) ==
                  null) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => clsLoginPageUI()));
              } else if (clsSharedPrefernce.objSharedPrefs!
                  .getString(clsSharedPrefernceKeyValue.USER_TOKEN)!
                  .isEmpty) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => clsLoginPageUI()));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => clsCartPageUI())).then((value) {
                  clsApiCallMethods.ItemsInCart().then((value) {
                    setState(() {});
                  });
                });
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 15, top: 8),
              child: Badge(
                // badgeStyle:
                //     BadgeStyle(badgeColor: Theme.of(context).primaryColor),
                position: BadgePosition.topEnd(),
                badgeContent: Text(
                  clsSharedPrefernce.objSharedPrefs!.getString(
                          clsSharedPrefernceKeyValue.ITEMS_IN_CART) ??
                      "",
                  style: TextStyle(color: Colors.white),
                ),
                child: Icon(
                  Icons.local_grocery_store,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: (objclsProductModel != null)
            ? Column(
                children: [
                  Stack(
                    children: [
                      if (objclsProductModel!.productImages != null)
                        SizedBox(
                          height: 225, // <-- you should put some value here
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                objclsProductModel!.productImages!.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => clsImagePreview(
                                                strURl: objclsProductModel!
                                                    .productImages[index],
                                                strImageUrl: objclsProductModel!
                                                    .productImages,
                                              )));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    width: 230,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            spreadRadius: 3,
                                            blurRadius: 7,
                                            offset: Offset(0,
                                                1), // changes position of shadow
                                          ),
                                        ],
                                        // border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                clsDimensConstants.douDp15)),
                                        gradient: LinearGradient(colors: [
                                          Theme.of(context).cardColor,
                                          Theme.of(context).cardColor
                                        ])),
                                    padding: const EdgeInsets.all(8.0),
                                    child: PinchZoom(
                                      resetDuration:
                                          const Duration(milliseconds: 100),
                                      maxScale: 2.5,
                                      child: Image.network(objclsProductModel!
                                          .productImages[index]),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                      // product off percentage and share button
                      if (objclsProductModel!.productPriceSale != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  stops: [.5, .5],
                                  begin: Alignment.bottomRight,
                                  end: Alignment.topLeft,
                                  colors: [
                                    Colors.transparent,
                                    Colors.red, // top Right part
                                  ],
                                ),
                              ),
                              child: RotationTransition(
                                turns: AlwaysStoppedAnimation(318 / 360),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, left: 30),
                                  child: Text(
                                    "${CommaSeparatedAmount(objclsProductModel!.productPriceSale ?? "0")}% \n off",
                                    style: GoogleFonts.montserrat(
                                        fontSize: clsDimensConstants.douDp12,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              objclsProductModel!.productName.toString(),
                              style: GoogleFonts.montserrat(
                                fontSize: clsDimensConstants.douDp14,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              ShowLoader(context);

                                  await Share.share(
                                  'https://www.galleon.ph/sharer/p/${objclsProductModel?.productId}');
                                  CancelLoader(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 15, top: 8),
                              child: Column(children: [
                                Icon(
                                  Icons.share,
                                  color: Theme.of(context).primaryColor,
                                ),
                                Text(
                                  "Share",
                                  style: GoogleFonts.montserrat(
                                    fontSize: clsDimensConstants.douDp10,
                                    color: Colors.black,
                                  ),
                                )
                              ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (objclsProductModel!.productSrp.toString() != "0")
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: clsDimensConstants.douDp8),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: objclsProductModel!
                                        .productComputedListprice ==
                                    null || objclsProductModel?.productPriceSale == null
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(bottom: 6),
                                    child: RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                          text: 'Before ',
                                          style: GoogleFonts.montserrat(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              fontSize:
                                                  clsDimensConstants.douDp14,
                                              color: Colors.grey),
                                        ),
                                        TextSpan(
                                          text:
                                              '₱ ${CommaSeparatedAmount(objclsProductModel!.productComputedListprice ?? "0").toString()}',
                                          style: GoogleFonts.montserrat(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              fontSize:
                                                  clsDimensConstants.douDp14,
                                              color: Colors.grey),
                                        ),
                                      ]),
                                    ),
                                  ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text:
                                        '₱ ${CommaSeparatedAmount(objclsProductModel!.productSrp ?? "0").toString()}',
                                    style: GoogleFonts.montserrat(
                                        fontSize: clsDimensConstants.douDp14,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: clsDimensConstants.douDp8),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Contact Customer Service",
                              style: GoogleFonts.montserrat(
                                  fontSize: clsDimensConstants.douDp14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return SizedBox(
                                    height: 100,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal:
                                              clsDimensConstants.douDp8),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Contact Customer Service",
                                              style: GoogleFonts.montserrat(
                                                  fontSize: clsDimensConstants
                                                      .douDp14,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  launch("tel:09178425012");
                                                },
                                                child: Container(
                                                  width: 100,
                                                  padding: EdgeInsets.all(
                                                      clsDimensConstants
                                                          .douDp10),
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
                                                      borderRadius: BorderRadius
                                                          .all(Radius.circular(
                                                              clsDimensConstants
                                                                  .douDp15)),
                                                      gradient: LinearGradient(
                                                          colors: [
                                                            Theme.of(context)
                                                                .cardColor,
                                                            Theme.of(context)
                                                                .cardColor
                                                          ])),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.call,
                                                        size: clsDimensConstants
                                                            .douDp18,
                                                        color: Colors.red,
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text("Globe")
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  launch("tel:09186364116");
                                                },
                                                child: Container(
                                                  width: 100,
                                                  padding: EdgeInsets.all(
                                                      clsDimensConstants
                                                          .douDp10),
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
                                                      borderRadius: BorderRadius
                                                          .all(Radius.circular(
                                                              clsDimensConstants
                                                                  .douDp15)),
                                                      gradient: LinearGradient(
                                                          colors: [
                                                            Theme.of(context)
                                                                .cardColor,
                                                            Theme.of(context)
                                                                .cardColor
                                                          ])),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.call,
                                                        size: clsDimensConstants
                                                            .douDp18,
                                                        color: Colors.red,
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text("Smart")
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  launch("tel:0284250153");
                                                },
                                                child: Container(
                                                  width: 120,
                                                  padding: EdgeInsets.all(
                                                      clsDimensConstants
                                                          .douDp10),
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
                                                      borderRadius: BorderRadius
                                                          .all(Radius.circular(
                                                              clsDimensConstants
                                                                  .douDp15)),
                                                      gradient: LinearGradient(
                                                          colors: [
                                                            Theme.of(context)
                                                                .cardColor,
                                                            Theme.of(context)
                                                                .cardColor
                                                          ])),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.call,
                                                        size: clsDimensConstants
                                                            .douDp18,
                                                        color: Colors.red,
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text("Landline")
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Icon(
                              Icons.call,
                              size: clsDimensConstants.douDp18,
                              color: Colors.red,
                            ),
                          )
                        ],
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: clsDimensConstants.douDp8,
                        vertical: clsDimensConstants.douDp8),
                    child: Row(
                      children: returnStarRating(
                          strProductRating:
                              (objclsProductModel!.productRating ??
                                      (objclsProductModel!
                                              .product_rating_unknownfield_s ??
                                          "0"))
                                  .toString()),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: clsDimensConstants.douDp8,
                        vertical: clsDimensConstants.douDp4),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Product Infomation: ",
                        style: GoogleFonts.montserrat(
                            fontSize: clsDimensConstants.douDp12,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: RichText(
                                text: TextSpan(
                                  // text: 'This item costs ',

                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Galleon Product Id : ',
                                      style: GoogleFonts.montserrat(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: clsDimensConstants.douDp10),
                                    ),
                                    TextSpan(
                                      text: objclsProductModel!.productId,
                                      style: GoogleFonts.montserrat(
                                          color: Colors.black,
                                          fontSize: clsDimensConstants.douDp10),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: RichText(
                                text: TextSpan(
                                  // text: 'This item costs ',
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Model : ',
                                      style: GoogleFonts.montserrat(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: clsDimensConstants.douDp10),
                                    ),
                                    TextSpan(
                                      text: objclsProductModel!.productModel,
                                      style: GoogleFonts.montserrat(
                                          color: Colors.black,
                                          fontSize: clsDimensConstants.douDp10),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: RichText(
                                text: TextSpan(
                                  // text: 'This item costs ',

                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'UPC / ISBN               : ',
                                      style: GoogleFonts.montserrat(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: clsDimensConstants.douDp10),
                                    ),
                                    TextSpan(
                                      text:
                                          objclsProductModel!.productUpc ?? "",
                                      style: GoogleFonts.montserrat(
                                          color: Colors.black,
                                          fontSize: clsDimensConstants.douDp10),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: RichText(
                                text: TextSpan(
                                  // text: 'This item costs ',

                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Manufacturer : ',
                                      style: GoogleFonts.montserrat(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: clsDimensConstants.douDp10),
                                    ),
                                    TextSpan(
                                      text: objclsProductModel!
                                          .productManufacturer,
                                      style: GoogleFonts.montserrat(
                                          color: Colors.black,
                                          fontSize: clsDimensConstants.douDp10),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: RichText(
                                text: TextSpan(
                                  // text: 'This item costs ',

                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Shipping Weight  : ',
                                      style: GoogleFonts.montserrat(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: clsDimensConstants.douDp10),
                                    ),
                                    TextSpan(
                                      text:
                                          "${(double.parse(objclsProductModel!.productWeight.toString()) / 100).toStringAsFixed(2)} lbs",
                                      style: GoogleFonts.montserrat(
                                          color: Colors.black,
                                          fontSize: clsDimensConstants.douDp10),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: RichText(
                                text: TextSpan(
                                  // text: 'This item costs ',
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Dimensions : ',
                                      style: GoogleFonts.montserrat(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: clsDimensConstants.douDp10),
                                    ),
                                    TextSpan(
                                      text:
                                          "${(double.parse(objclsProductModel!.productLength.toString()) / 100).toStringAsFixed(2)} * ${(double.parse(objclsProductModel!.productWidth.toString()) / 100).toStringAsFixed(2)} * ${(double.parse(objclsProductModel!.productHeight.toString()) / 100).toStringAsFixed(2)} inches",
                                      style: GoogleFonts.montserrat(
                                          color: Colors.black,
                                          fontSize: clsDimensConstants.douDp10),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  replaceHtmlFromStrings(bollessmoreclicable
                      ? objclsProductModel!.productDescription
                          .toString()
                          .substring(
                              0,
                              (objclsProductModel!.productDescription ?? " ")
                                          .toString()
                                          .length >
                                      200
                                  ? 200
                                  : ((objclsProductModel!.productDescription ??
                                              "")
                                          .toString()
                                          .isEmpty
                                      ? 0
                                      : objclsProductModel!.productDescription
                                          .toString()
                                          .length))
                      : objclsProductModel!.productDescription.toString()),
                  ((objclsProductModel!.productDescription ?? "")
                          .toString()
                          .isEmpty)
                      ? const SizedBox()
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: clsDimensConstants.douDp8,
                              vertical: clsDimensConstants.douDp4),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: (!bollessmoreclicable)
                                        ? "See Less "
                                        : " See more",
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        if (bollessmoreclicable) {
                                          intTextLimitCount = 1000;
                                          bollessmoreclicable = false;
                                        } else {
                                          intTextLimitCount = 200;
                                          bollessmoreclicable = true;
                                        }

                                        setState(() {});
                                      },
                                    style: GoogleFonts.montserrat(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: clsDimensConstants.douDp12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: clsDimensConstants.douDp8,
                        vertical: clsDimensConstants.douDp4),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Product Features: ",
                        style: GoogleFonts.montserrat(
                            fontSize: clsDimensConstants.douDp12,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  if (objclsProductModel!.productFeatures != null)
                    Column(
                      children: returnProductFeatures(
                          objclsProductModel!.productFeatures!),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: clsDimensConstants.douDp8,
                        vertical: clsDimensConstants.douDp4),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Related Products",
                        style: GoogleFonts.montserrat(
                            fontSize: clsDimensConstants.douDp12,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  if (lstclsProductModel.isNotEmpty) returnListofProducts()
                ],
              )
            : SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Center(child: Text("")),
              ),
      ),
      bottomNavigationBar: Opacity(
        opacity:
            (objclsProductModel?.productSrp ?? 0).toString() == "0" ? 0.5 : 1,
        child: IgnorePointer(
          ignoring: (objclsProductModel?.productSrp ?? 0).toString() == "0",
          child: Padding(
            padding: const EdgeInsets.only(left:10,right:10,bottom: 20),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      if (clsSharedPrefernce.objSharedPrefs!
                              .getString(clsSharedPrefernceKeyValue.USER_TOKEN) ==
                          null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => clsLoginPageUI()));
                      } else {
                        addToCart(bolBuynow: false);
                      }
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
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            gradient: LinearGradient(colors: [
                              Theme.of(context).cardColor,
                              Theme.of(context).cardColor
                            ])),
                        child: Center(
                            child: Text(
                          "ADD TO CART",
                          style: GoogleFonts.montserrat(
                              fontSize: clsDimensConstants.douDp14,
                              color: Colors.black),
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
                      if (clsSharedPrefernce.objSharedPrefs!
                              .getString(clsSharedPrefernceKeyValue.USER_TOKEN) ==
                          null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => clsLoginPageUI()));
                      } else {
                        addToCart(bolBuynow: true);
                      }
                    },
                    child: Container(
                        height: 45,
                        width: 150,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
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
                              "BUY NOW ",
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
            ),
          ),
        ),
      ),
    );
  }

  returnListofProducts() {
    List<Widget> lstWidget = <Widget>[];
    double width = MediaQuery.of(context).size.width;
    debugPrint('item_width $width');
    double productItemWidth = 200;
    bool isOnlyTwoItem = false;
    if(productItemWidth * 3 > width){
      isOnlyTwoItem = true;
    }
    for (var element in lstclsProductModel) {
      lstWidget.add(
        InkWell(
          onTap: () {
            objclsProductModel = element;
            getRelatedProductByProductId();
            _scrollController.animateTo(
                _scrollController.position.minScrollExtent,
                duration: Duration(milliseconds: 500),
                curve: Curves.ease);
            setState(() {});
          },
          child: Container(
            constraints: isOnlyTwoItem ? null : BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.50
                ),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Container(
                    width: isOnlyTwoItem ? width * 0.45 : 180,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
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
                        SizedBox(
                          height: 100,
                          child: (element.productImages!.length > 0)
                              ? Image.network(
                                  element.productImages![0].toString(),
                                  height: 100,
                                )
                              : null,
                        ),
                        SizedBox(
                          height: 30,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: clsDimensConstants.douDp10,
                                right: clsDimensConstants.douDp10),
                            child: Text(
                              element.productName.toString(),
                              maxLines: 2,
                              style: GoogleFonts.montserrat(
                                  fontSize: clsDimensConstants.douDp12,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: clsDimensConstants.douDp10,
                                right: clsDimensConstants.douDp10),
                            child: Text(
                              element.productDescription ?? "",
                              maxLines: 2,
                              style: GoogleFonts.montserrat(
                                  fontSize: clsDimensConstants.douDp12,
                                  fontWeight: FontWeight.w500),
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
                              Text(
                                "₱ ${CommaSeparatedAmount(element.productSrp ?? "0").toString()}",
                                maxLines: 2,
                                style: GoogleFonts.montserrat(
                                    fontSize: clsDimensConstants.douDp12,
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context).primaryColor),
                              ),
                              Row(
                                children: returnStarRating(
                                strProductRating: (element.productRating ??
                                    (element.product_rating_unknownfield_s ??
                                        "0"))),
                              )
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
        ),
      );
    }

    return Wrap(
      children: lstWidget,
    );
  }

  returnStarRating({required String strProductRating}) {
    List<Widget> lstFullStar = <Widget>[];
    var parts = strProductRating.split('.');
    lstFullStar.clear();
    if (strProductRating == "0") {
      for (int i = 0; i < 5; i++) {
        lstFullStar.add(Icon(
          Icons.star_outline,
          color: Colors.orange,
          size: 15,
        ));
      }
    }

    int index1 = int.parse(parts[0].trim());
    for (int i = 0; i < index1; i++) {
      lstFullStar.add(Icon(
        Icons.star,
        color: Colors.orange,
        size: 15,
      ));
    }

    if (strProductRating.contains(".")) {
      int index2 = int.parse(parts[1].trim());
      if (index2 >= 5) {
        lstFullStar.add(Icon(
          Icons.star_half,
          color: Colors.orange,
          size: 15,
        ));
      } else {
        lstFullStar.add(Icon(
          Icons.star_outline,
          color: Colors.orange,
          size: 15,
        ));
      }
    }

    if (lstFullStar.length < 5) {
      for (int i = lstFullStar.length; i < 5; i++) {
        lstFullStar.add(Icon(
          Icons.star_outline,
          color: Colors.orange,
          size: 15,
        ));
      }
    }

    return lstFullStar;
  }

  returnProductFeatures(List<dynamic> listproductfeatures) {
    List<Widget> lstWidget = <Widget>[];
    if (listproductfeatures.length > 3 && !showMoreBullets) {
      for (int index = 0; index < 3; index++) {
        lstWidget.add(Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: clsDimensConstants.douDp8,
              vertical: clsDimensConstants.douDp4),
          child: Align(
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: '(${index + 1}) ',
                    style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: clsDimensConstants.douDp12),
                  ),
                  TextSpan(
                    text: listproductfeatures[index].toString(),
                    style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: clsDimensConstants.douDp12),
                  ),
                ],
              ),
            ),
          ),
        ));
      }
    } else {
      for (int index = 0; index < listproductfeatures.length; index++) {
        lstWidget.add(Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: clsDimensConstants.douDp8,
              vertical: clsDimensConstants.douDp4),
          child: Align(
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: '(${index + 1}) ',
                    style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: clsDimensConstants.douDp12),
                  ),
                  TextSpan(
                    text: listproductfeatures[index].toString(),
                    style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: clsDimensConstants.douDp12),
                  ),
                ],
              ),
            ),
          ),
        ));
      }
    }

    if (lstclsProductModel.length < 3) {
      lstWidget.add(
        InkWell(
          onTap: () {
            if (showMoreBullets) {
              showMoreBullets = false;
            } else {
              showMoreBullets = true;
            }
            setState(() {});
          },
          child: Text(
            showMoreBullets ? " See Less " : " See More",
            maxLines: 2,
            style: GoogleFonts.montserrat(
                fontSize: clsDimensConstants.douDp12,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).primaryColor),
          ),
        ),
      );
    }

    return lstWidget;
  }

  addToCart({required bool bolBuynow}) {
    Map<String, String> objMap = {
      "pid": objclsProductModel!.productId.toString(),
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
          ShowSnackbar(strMessage: "Item Added to Cart", showheading: false);

          if (clsSharedPrefernce.objSharedPrefs!
                  .getString(clsSharedPrefernceKeyValue.USER_TOKEN) ==
              null) {
            clsApiCallMethods.ItemsInCart().then((value) {
              setState(() {});
            });
          } else if (clsSharedPrefernce.objSharedPrefs!
              .getString(clsSharedPrefernceKeyValue.USER_TOKEN)!
              .isNotEmpty) {
            clsApiCallMethods.ItemsInCart().then((value) {
              setState(() {});
            });
          }

          if (bolBuynow) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => clsCartPageUI()));
          }
        }
      }
    });
  }

  addItemInWhishlist() {
    Map<String, String> objMap = {
      "pid": objclsProductModel!.productId.toString(),
    };
    ShowLoader(context);
    clsApiCallMethods.AddItemsInWhislist(objMap).then((value) {
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
          ShowSnackbar(
              strMessage: value.messages[0].toString(), showheading: false);
        }
      }
    });
  }

  RemoveItemInWhishlist() {
    Map<String, String> objMap = {
      "pid": objclsProductModel!.productId.toString(),
    };
    ShowLoader(context);
    clsApiCallMethods.RemoveItemsInWhislist(objMap).then((value) {
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
          ShowSnackbar(
              strMessage: value.messages[0].toString(), showheading: false);
        }
      }
    });
  }

  Future<void> _launchUrl({required String strURl}) async {
    if (!await launchUrl(Uri.parse("$strURl?mobile_view=true"))) {
      ShowSnackbar(strMessage: "Failed to load", showheading: false);
      // throw Exception('Could not launch $_url');
    }
  }

  getProductByProductId() {
    ShowLoader(context);
    clsApiCallMethods
        .getProductByProductId(
            strProductId: widget.objclsProductModel.productId.toString())
        .then((value) {
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
          objclsProductModel = clsProductModel.fromJson(value.data);
          print(value.data);
          setState(() {});
        }
      }
    });
  }

  getRelatedProductByProductId() {
    ShowLoader(context);
    clsApiCallMethods
        .getRelatedProductByProductId(
            strProductId: widget.objclsProductModel.productId.toString())
        .then((value) {
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
          lstclsProductModel = List<clsProductModel>.from(
              value.data.map((e) => clsProductModel.fromJson(e)));
          setState(() {});
        }
      }
    });
  }
}
