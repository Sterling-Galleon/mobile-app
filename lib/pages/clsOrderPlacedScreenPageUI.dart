import 'package:ecommerce/constants/clsDimensConstants.dart';
import 'package:ecommerce/localStorage/clsSharedPrefernce.dart';
import 'package:ecommerce/localStorage/clsSharedPrefernceKeyValue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';
import 'clsHomePageUI.dart';

class clsOrderPlacedScreenPageUI extends StatelessWidget {
  final String InvoiceNo;
  const clsOrderPlacedScreenPageUI({Key? key, required this.InvoiceNo }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>clsHomePageUI()), (route) => false);
        return true;
      },
      child: ScaffoldWrapper(
        backgroundColor: Theme.of(context).primaryColor,
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width - 40,
            height: MediaQuery.of(context).size.width - 40,
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
                borderRadius: BorderRadius.all(Radius.circular(clsDimensConstants.douDp15)),
                gradient: LinearGradient(colors: [Theme.of(context).cardColor, Theme.of(context).cardColor])),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle_rounded,
                  size: 100,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Hey, Mr./ Ms. ${clsSharedPrefernce.objSharedPrefs!.getString(clsSharedPrefernceKeyValue.USER_NAME)}",
                  style: GoogleFonts.montserrat(fontSize: clsDimensConstants.douDp16, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Your Order #$InvoiceNo is Confirmed!",
                  style: GoogleFonts.montserrat(fontSize: clsDimensConstants.douDp16, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "You will be receiving a confirmation email with order details",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(fontSize: clsDimensConstants.douDp14, fontWeight: FontWeight.w300),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>clsHomePageUI()), (Route<dynamic> route) => false);
                  },
                  child: Container(
                      height: 45,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(clsDimensConstants.douDp20)),
                          gradient: LinearGradient(colors: [Theme.of(context).primaryColor, Theme.of(context).primaryColor])),
                      child: Center(
                          child: Text(
                            "OK",
                            style: GoogleFonts.montserrat(fontSize: clsDimensConstants.douDp14, color: Colors.white),
                          ))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
