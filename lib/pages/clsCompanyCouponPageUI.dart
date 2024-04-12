// clsCompanyCouponPageUI

import 'package:ecommerce/constants/clsDimensConstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';

class clsCompanyCouponPageUI extends StatefulWidget {
  @override
  State<clsCompanyCouponPageUI> createState() => _clsCompanyCouponPageUIState();
}

class _clsCompanyCouponPageUIState extends State<clsCompanyCouponPageUI> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 0.0,
        shadowColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Coupons",
          style: GoogleFonts.montserrat(fontSize: clsDimensConstants.douDp14, color: Colors.black, fontWeight: FontWeight.w500),
        ),
        actions: [],
      ),
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext ctxt, int index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(clsDimensConstants.douDp15)),
                    gradient: LinearGradient(colors: [Theme.of(context).cardColor, Theme.of(context).cardColor])),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.all(clsDimensConstants.douDp12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(clsDimensConstants.douDp15)),
                                  gradient: LinearGradient(colors: [Theme.of(context).cardColor, Theme.of(context).cardColor])),
                              child: Image.asset("assets/images/img.png",height: 50,)),
                        ),
                        Expanded(
                          child: Center(
                              child: Container(
                                  child: Center(child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Align(alignment: Alignment.centerLeft,child: Text("Shop online with galleon discounts  ")),
                                      Text("Shop "),
                                    ],
                                  )))),
                        ),
                      ],
                    ),
                    Divider(
                      height: 10,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Expiry : JAN 09 2023| 11:59:00 PM",
                        style: GoogleFonts.montserrat(fontSize: clsDimensConstants.douDp12, color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
