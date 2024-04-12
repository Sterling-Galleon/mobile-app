import 'package:ecommerce/constants/clsCommonWidget.dart';
import 'package:ecommerce/constants/clsDimensConstants.dart';
import 'package:ecommerce/network/clsApiCallMethods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';

class clsCartCouponsPageUI extends StatefulWidget {
  const clsCartCouponsPageUI({Key? key}) : super(key: key);

  @override
  State<clsCartCouponsPageUI> createState() => _clsCartCouponsPageUIState();
}

class _clsCartCouponsPageUIState extends State<clsCartCouponsPageUI> {

  TextEditingController couponcodeEditingController=TextEditingController();

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
          "Coupons & Others",
          style: GoogleFonts.montserrat(fontSize: clsDimensConstants.douDp14, color: Colors.black, fontWeight: FontWeight.w500),
        ),
        actions: [],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Stack(
            //         clipBehavior: Clip.none,
            //         children: <Widget>[
            //           Container(
            //             width: MediaQuery.of(context).size.width - 130,
            //             child: TextField(
            //               decoration: InputDecoration(
            //                 border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
            //                 focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
            //                 contentPadding: EdgeInsets.only(left: 10),
            //               ),
            //             ),
            //           ),
            //           AnimatedPositioned(
            //             duration: Duration(milliseconds: 200),
            //             left: 10,
            //             top: -10,
            //             child: InkWell(
            //               onTap: () {},
            //               child: Container(
            //                 padding: EdgeInsets.only(left: 3),
            //                 color: Colors.white,
            //                 child: Text('Discount Code'),
            //               ),
            //             ),
            //           ),
            //           // Positioned.fill(
            //           //   child: Align(
            //           //     alignment: Alignment.centerLeft,
            //           //     child: Container(
            //           //       padding: EdgeInsets.only(left: 10),
            //           //       color: Colors.transparent,
            //           //       child: Icon(Icons.email),
            //           //     ),
            //           //   ),
            //           // ),
            //         ],
            //       ),
            //       SizedBox(
            //         width: 10,
            //       ),
            //       InkWell(
            //         onTap: () {},
            //         child: Container(
            //             height: 45,
            //             width: 100,
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.all(Radius.circular(clsDimensConstants.douDp15)),
            //                 gradient: LinearGradient(colors: [Theme.of(context).primaryColor, Theme.of(context).primaryColor])),
            //             child: Center(
            //                 child: Text(
            //               "Apply",
            //               style: GoogleFonts.montserrat(fontSize: clsDimensConstants.douDp14, color: Colors.white),
            //             ))),
            //       ),
            //     ],
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width - 130,
                        child: TextField(
                          controller: couponcodeEditingController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
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
                            child: Text('Voucher Code'),
                          ),
                        ),
                      ),
                      // Positioned.fill(
                      //   child: Align(
                      //     alignment: Alignment.centerLeft,
                      //     child: Container(
                      //       padding: EdgeInsets.only(left: 10),
                      //       color: Colors.transparent,
                      //       child: Icon(Icons.email),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      if(couponcodeEditingController.value.text.isEmpty){
                        return ShowSnackbar(strMessage: "Please Enter Voucher Code", showheading: true);
                      }
ShowLoader(context);
                      clsApiCallMethods.ApplyCartCoupon(strCouponCode: couponcodeEditingController.value.text).then((value){
                        CancelLoader(context);
                        if(value.error==false || value.error =="false"){

                          Navigator.pop(context,couponcodeEditingController.value.text);
                        }else{
                          ShowSnackbar(strMessage: value.messages.length>0?value.messages[0]:"Coupon Code is Invalid/has already expired.", showheading: false);
                        }
                      });

                    },
                    child: Container(
                        height: 45,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(clsDimensConstants.douDp15)),
                            gradient: LinearGradient(colors: [Theme.of(context).primaryColor, Theme.of(context).primaryColor])),
                        child: Center(
                            child: Text(
                          "Apply",
                          style: GoogleFonts.montserrat(fontSize: clsDimensConstants.douDp14, color: Colors.white),
                        ))),
                  ),
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Divider(
            //     height: 5,
            //     color: Colors.black,
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Align(
            //     alignment: Alignment.centerLeft,
            //     child: Text(
            //       "Available",
            //       style: GoogleFonts.montserrat(fontSize: clsDimensConstants.douDp14, color: Colors.black, fontWeight: FontWeight.w700),
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Expanded(flex: 4,child: Text("Shop online with galleon discounts coupons with great saving in every day")),
            //
            //       Expanded(
            //         child: InkWell(
            //           onTap: () {},
            //           child: Container(
            //               height: 25,
            //               width: 70,
            //               decoration: BoxDecoration(
            //                   borderRadius: BorderRadius.all(Radius.circular(clsDimensConstants.douDp15)),
            //                   gradient: LinearGradient(colors: [Theme.of(context).primaryColor, Theme.of(context).primaryColor])),
            //               child: Center(
            //                   child: Text(
            //                 "Apply",
            //                 style: GoogleFonts.montserrat(fontSize: clsDimensConstants.douDp14, color: Colors.white),
            //               ))),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }





}
