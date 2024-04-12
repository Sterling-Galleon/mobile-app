import 'package:ecommerce/constants/clsDimensConstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';

class clsWalletPageUI extends StatefulWidget {
  const clsWalletPageUI({Key? key}) : super(key: key);

  @override
  State<clsWalletPageUI> createState() => _clsWalletPageUIState();
}

class _clsWalletPageUIState extends State<clsWalletPageUI> {
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
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Galleon Wallet",
          style: GoogleFonts.montserrat(fontSize: clsDimensConstants.douDp14, color: Colors.black, fontWeight: FontWeight.w500),
        ),
        actions: [],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           Icon(Icons.wallet,size: 150,color: Colors.orange,),
            Center(
              child: Text(
                "Your Galleon Wallets have",
                style: GoogleFonts.montserrat(fontSize: clsDimensConstants.douDp14, color: Colors.black, fontWeight: FontWeight.w700),
              ),
            ),
            Text(
              "₱ 0.00",
              style: GoogleFonts.montserrat(fontSize: clsDimensConstants.douDp25, color: Colors.black, fontWeight: FontWeight.w700),
            ),
            Divider(
              height: 10,
              color: Colors.black,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Transaction Log",
                  style: GoogleFonts.montserrat(fontSize: clsDimensConstants.douDp14, color: Colors.black, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Divider(
              height: 10,
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Order Placed",
                        style: GoogleFonts.montserrat(fontSize: clsDimensConstants.douDp12, color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "Jan 08,2023",
                        style: GoogleFonts.montserrat(fontSize: clsDimensConstants.douDp12, color: Colors.black, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Order No. 1234567890",
                        style: GoogleFonts.montserrat(fontSize: clsDimensConstants.douDp12, color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "-₱ 599",
                        style: GoogleFonts.montserrat(fontSize: clsDimensConstants.douDp12, color: Colors.black, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
