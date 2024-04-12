// ignore_for_file: file_names, must_be_immutable, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:badges/badges.dart';
import 'package:ecommerce/constants/clsDimensConstants.dart';
import 'package:ecommerce/localStorage/clsSharedPrefernce.dart';
import 'package:ecommerce/localStorage/clsSharedPrefernceKeyValue.dart';
import 'package:ecommerce/models/clsNewOrderDetailPagemodel.dart';
import 'package:ecommerce/network/clsApiCallMethods.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:google_fonts/google_fonts.dart';

import '../../constants/clsCommonWidget.dart';
import '../../main.dart';
import '../clsCartPageUI.dart';
import '../clsLoginPageUI.dart';
import 'clsOrdersPageUI.dart';

class ClsOrderDetailPageUI extends StatefulWidget {
  String intId;
  ClsOrderDetailPageUI({super.key, required this.intId});
  @override
  State<ClsOrderDetailPageUI> createState() => _ClsOrderDetailPageUIState();
}

class _ClsOrderDetailPageUIState extends State<ClsOrderDetailPageUI> {
  List<clsCommonFiltermodel> lstStatus = <clsCommonFiltermodel>[];
  List<clsCommonFiltermodel> lstTime = <clsCommonFiltermodel>[];

  clsNewOrderDetailPagemodel? objclsOrderDetailsModel;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getOrderDetailsById(intId: widget.intId);
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
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Orders Details",
          style: GoogleFonts.montserrat(
              fontSize: clsDimensConstants.douDp14,
              color: Colors.black,
              fontWeight: FontWeight.w500),
        ),
        actions: [
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
        child: (objclsOrderDetailsModel != null)
            ? Container(
                padding: EdgeInsets.all(clsDimensConstants.douDp10),
                child: Column(
                  children: [
                    if (objclsOrderDetailsModel!.quote != null)
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: objclsOrderDetailsModel!.quote!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: clsDimensConstants.douDp12,
                                  vertical: clsDimensConstants.douDp10),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.symmetric(
                                    horizontal: clsDimensConstants.douDp15,
                                    vertical: clsDimensConstants.douDp12),
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 3,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            clsDimensConstants.douDp5)),
                                    gradient: LinearGradient(colors: [
                                      (Colors.white),
                                      (Colors.white)
                                    ])),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        objclsOrderDetailsModel!
                                            .quote![index].productName
                                            .toString(),
                                        style: GoogleFonts.montserrat(
                                            fontSize:
                                                clsDimensConstants.douDp10,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Status :${objclsOrderDetailsModel!.invoiceStatus}",
                                            maxLines: 2,
                                            style: GoogleFonts.montserrat(
                                                fontSize:
                                                    clsDimensConstants.douDp10,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(
                                            "Date: ${returnDateFormat(intTimeId: int.parse(objclsOrderDetailsModel!.invoiceCreated.toString()))}",
                                            style: GoogleFonts.montserrat(
                                                fontSize:
                                                    clsDimensConstants.douDp10,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Invoice Id: ${objclsOrderDetailsModel!.quote![index].quoteInvoice.toString()}",
                                            maxLines: 2,
                                            style: GoogleFonts.montserrat(
                                                fontSize:
                                                    clsDimensConstants.douDp10,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(
                                            "Product Price: ${objclsOrderDetailsModel!.quote![index].productPriceTotal.toString()}",
                                            style: GoogleFonts.montserrat(
                                                fontSize:
                                                    clsDimensConstants.douDp10,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        showModalBottomSheet<void>(
                                          // context and builder are
                                          // required properties in this widget
                                          context: context,
                                          builder: (BuildContext context) {
                                            return SizedBox(
                                              height: 200,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal:
                                                            clsDimensConstants
                                                                .douDp8),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        "Breakdown Details",
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                fontSize:
                                                                    clsDimensConstants
                                                                        .douDp14,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            flex: 2,
                                                            child: RichText(
                                                              text: TextSpan(
                                                                // text: 'This item costs ',

                                                                children: <TextSpan>[
                                                                  TextSpan(
                                                                    text:
                                                                        'Shipping Rate: ',
                                                                    style: GoogleFonts.montserrat(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w700,
                                                                        fontSize:
                                                                            clsDimensConstants.douDp12),
                                                                  ),
                                                                  TextSpan(
                                                                    text: objclsOrderDetailsModel!
                                                                        .quote![
                                                                            index]
                                                                        .productJacBreakdown!
                                                                        .shippingRate,
                                                                    style: GoogleFonts.montserrat(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            clsDimensConstants.douDp12),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: RichText(
                                                              text: TextSpan(
                                                                // text: 'This item costs ',

                                                                children: <TextSpan>[
                                                                  TextSpan(
                                                                    text:
                                                                        'Volume: ',
                                                                    style: GoogleFonts.montserrat(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w700,
                                                                        fontSize:
                                                                            clsDimensConstants.douDp12),
                                                                  ),
                                                                  TextSpan(
                                                                    text: objclsOrderDetailsModel!
                                                                        .quote![
                                                                            index]
                                                                        .productJacBreakdown!
                                                                        .volume
                                                                        .toString(),
                                                                    style: GoogleFonts.montserrat(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            clsDimensConstants.douDp12),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            flex: 2,
                                                            child: RichText(
                                                              text: TextSpan(
                                                                // text: 'This item costs ',

                                                                children: <TextSpan>[
                                                                  TextSpan(
                                                                    text:
                                                                        'Delivery Charge: ',
                                                                    style: GoogleFonts.montserrat(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w700,
                                                                        fontSize:
                                                                            clsDimensConstants.douDp12),
                                                                  ),
                                                                  TextSpan(
                                                                    text: objclsOrderDetailsModel!
                                                                        .quote![
                                                                            index]
                                                                        .productJacBreakdown!
                                                                        .deliveryCharge,
                                                                    style: GoogleFonts.montserrat(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            clsDimensConstants.douDp12),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: RichText(
                                                              text: TextSpan(
                                                                // text: 'This item costs ',

                                                                children: <TextSpan>[
                                                                  TextSpan(
                                                                    text:
                                                                        'Flat Rate: ',
                                                                    style: GoogleFonts.montserrat(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w700,
                                                                        fontSize:
                                                                            clsDimensConstants.douDp12),
                                                                  ),
                                                                  TextSpan(
                                                                    text: objclsOrderDetailsModel!
                                                                        .quote![
                                                                            index]
                                                                        .productJacBreakdown!
                                                                        .flatRate
                                                                        .toString(),
                                                                    style: GoogleFonts.montserrat(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            clsDimensConstants.douDp12),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            flex: 2,
                                                            child: RichText(
                                                              text: TextSpan(
                                                                // text: 'This item costs ',

                                                                children: <TextSpan>[
                                                                  TextSpan(
                                                                    text:
                                                                        'Effective Premium: ',
                                                                    style: GoogleFonts.montserrat(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w700,
                                                                        fontSize:
                                                                            clsDimensConstants.douDp12),
                                                                  ),
                                                                  TextSpan(
                                                                    text: objclsOrderDetailsModel!
                                                                        .quote![
                                                                            index]
                                                                        .productJacBreakdown!
                                                                        .effectivePremium,
                                                                    style: GoogleFonts.montserrat(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            clsDimensConstants.douDp12),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: RichText(
                                                              text: TextSpan(
                                                                // text: 'This item costs ',

                                                                children: <TextSpan>[
                                                                  TextSpan(
                                                                    text:
                                                                        'Php Rate: ',
                                                                    style: GoogleFonts.montserrat(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w700,
                                                                        fontSize:
                                                                            clsDimensConstants.douDp12),
                                                                  ),
                                                                  TextSpan(
                                                                    text: objclsOrderDetailsModel!
                                                                        .quote![
                                                                            index]
                                                                        .productJacBreakdown!
                                                                        .phpRate
                                                                        .toString(),
                                                                    style: GoogleFonts.montserrat(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            clsDimensConstants.douDp12),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 2,
                                                            child: RichText(
                                                              text: TextSpan(
                                                                // text: 'This item costs ',

                                                                children: <TextSpan>[
                                                                  TextSpan(
                                                                    text:
                                                                        'Vat: ',
                                                                    style: GoogleFonts.montserrat(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w700,
                                                                        fontSize:
                                                                            clsDimensConstants.douDp12),
                                                                  ),
                                                                  TextSpan(
                                                                    text: objclsOrderDetailsModel!
                                                                        .quote![
                                                                            index]
                                                                        .productJacBreakdown!
                                                                        .vat
                                                                        .toString(),
                                                                    style: GoogleFonts.montserrat(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            clsDimensConstants.douDp12),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: RichText(
                                                              text: TextSpan(
                                                                // text: 'This item costs ',

                                                                children: <TextSpan>[
                                                                  TextSpan(
                                                                    text:
                                                                        'Total: ',
                                                                    style: GoogleFonts.montserrat(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w700,
                                                                        fontSize:
                                                                            clsDimensConstants.douDp12),
                                                                  ),
                                                                  TextSpan(
                                                                    text: objclsOrderDetailsModel!
                                                                        .quote![
                                                                            index]
                                                                        .productJacBreakdown!
                                                                        .total
                                                                        .toString(),
                                                                    style: GoogleFonts.montserrat(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            clsDimensConstants.douDp12),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          "View Break Down",
                                          style: GoogleFonts.montserrat(
                                              fontSize:
                                                  clsDimensConstants.douDp12,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(clsDimensConstants.douDp10),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 3,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 1), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.all(
                                Radius.circular(clsDimensConstants.douDp5)),
                            gradient: LinearGradient(colors: [
                              Theme.of(context).cardColor,
                              Theme.of(context).cardColor
                            ])),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Delivery Address ",
                              style: GoogleFonts.montserrat(
                                  fontSize: clsDimensConstants.douDp12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            RichText(
                              text: TextSpan(
                                // text: 'This item costs ',

                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Address User : ',
                                    style: GoogleFonts.montserrat(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: clsDimensConstants.douDp10),
                                  ),
                                  TextSpan(
                                    text: objclsOrderDetailsModel!
                                        .billing!.addressUser,
                                    style: GoogleFonts.montserrat(
                                        color: Colors.black,
                                        fontSize: clsDimensConstants.douDp10),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            RichText(
                              text: TextSpan(
                                // text: 'This item costs ',

                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Address phone : ',
                                    style: GoogleFonts.montserrat(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: clsDimensConstants.douDp10),
                                  ),
                                  TextSpan(
                                    text: objclsOrderDetailsModel!
                                        .billing!.addressPhone,
                                    style: GoogleFonts.montserrat(
                                        color: Colors.black,
                                        fontSize: clsDimensConstants.douDp10),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            RichText(
                              text: TextSpan(
                                // text: 'This item costs ',

                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Address street : ',
                                    style: GoogleFonts.montserrat(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: clsDimensConstants.douDp10),
                                  ),
                                  TextSpan(
                                    text: objclsOrderDetailsModel!
                                        .billing!.addressStreet,
                                    style: GoogleFonts.montserrat(
                                        color: Colors.black,
                                        fontSize: clsDimensConstants.douDp10),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            RichText(
                              text: TextSpan(
                                // text: 'This item costs ',

                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Address street 2 : ',
                                    style: GoogleFonts.montserrat(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: clsDimensConstants.douDp10),
                                  ),
                                  TextSpan(
                                    text: objclsOrderDetailsModel!
                                        .billing!.addressStreet2,
                                    style: GoogleFonts.montserrat(
                                        color: Colors.black,
                                        fontSize: clsDimensConstants.douDp10),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            RichText(
                              text: TextSpan(
                                // text: 'This item costs ',

                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Address City : ',
                                    style: GoogleFonts.montserrat(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: clsDimensConstants.douDp10),
                                  ),
                                  TextSpan(
                                    text: objclsOrderDetailsModel!
                                        .billing!.addressCity,
                                    style: GoogleFonts.montserrat(
                                        color: Colors.black,
                                        fontSize: clsDimensConstants.douDp10),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            RichText(
                              text: TextSpan(
                                // text: 'This item costs ',

                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Address Country : ',
                                    style: GoogleFonts.montserrat(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: clsDimensConstants.douDp10),
                                  ),
                                  TextSpan(
                                    text: objclsOrderDetailsModel!
                                        .billing!.addressCountry,
                                    style: GoogleFonts.montserrat(
                                        color: Colors.black,
                                        fontSize: clsDimensConstants.douDp10),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            RichText(
                              text: TextSpan(
                                // text: 'This item costs ',

                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Address State : ',
                                    style: GoogleFonts.montserrat(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: clsDimensConstants.douDp10),
                                  ),
                                  TextSpan(
                                    text: objclsOrderDetailsModel!
                                        .billing!.addressState,
                                    style: GoogleFonts.montserrat(
                                        color: Colors.black,
                                        fontSize: clsDimensConstants.douDp10),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            RichText(
                              text: TextSpan(
                                // text: 'This item costs ',

                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Address Barangay : ',
                                    style: GoogleFonts.montserrat(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: clsDimensConstants.douDp10),
                                  ),
                                  TextSpan(
                                    text: objclsOrderDetailsModel!
                                        .billing!.addressBarangay,
                                    style: GoogleFonts.montserrat(
                                        color: Colors.black,
                                        fontSize: clsDimensConstants.douDp10),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Center(
                child: Text("No Data Found"),
              ),
      ),
    );
  }

  getOrderDetailsById({required String intId}) {
    ShowLoader(context);
    clsApiCallMethods.getOrderDetails(Id: intId).then((value) {
      CancelLoader(context);
      if (value.error == "true") {
      } else {
        if (value.data != null) {
          objclsOrderDetailsModel =
              clsNewOrderDetailPagemodel.fromJson(value.data);
          setState(() {});
        }
      }
    });
  }

  returnDateFormat({required int intTimeId}) {
    final DateTime date1 =
        DateTime.fromMillisecondsSinceEpoch(intTimeId * 1000);
    return getDateFormat(date1);
  }

  returnStarRating({required String strProductRating}) {
    List<Widget> lstFullStar = <Widget>[];

    var parts = strProductRating.split('.');
    lstFullStar.clear();
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
          color: Colors.white,
          size: 15,
        ));
      } else {
        lstFullStar.add(Icon(
          Icons.star,
          color: Colors.white,
          size: 15,
        ));
      }
    }
    return lstFullStar;
  }
}
