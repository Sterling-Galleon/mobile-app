import 'package:ecommerce/constants/clsDimensConstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';

class clsCardsPageUI extends StatefulWidget {
  const clsCardsPageUI({Key? key}) : super(key: key);

  @override
  State<clsCardsPageUI> createState() => _clsCardsPageUIState();
}

class _clsCardsPageUIState extends State<clsCardsPageUI> {
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
          "Your Cards",
          style: GoogleFonts.montserrat(fontSize: clsDimensConstants.douDp14, color: Colors.black, fontWeight: FontWeight.w500),
        ),
        actions: [],
      ),
      body:  Column(
        children: [
          SizedBox(
            height: 164, // <-- you should put some value here
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: 300,
                    height: 130,
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
                        gradient: LinearGradient(colors: [Theme.of(context).primaryColor, Theme.of(context).primaryColor])),
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 8),
                          child: Text("ICICI Bank",
                            style: GoogleFonts.montserrat(fontSize: clsDimensConstants.douDp14, color: Colors.deepPurple, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text("XXXX XXXX XXXX 1234",
                              style: GoogleFonts.montserrat(fontSize: clsDimensConstants.douDp14, color: Colors.white, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Valid \n 05/2024",
                                style: GoogleFonts.montserrat(fontSize: clsDimensConstants.douDp12, color: Colors.white, fontWeight: FontWeight.w500),
                              ),
                              Text("VISA",
                                style: GoogleFonts.montserrat(fontSize: clsDimensConstants.douDp18, color: Colors.deepPurple, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "UPI",
                style: GoogleFonts.montserrat(fontSize: clsDimensConstants.douDp18, color: Colors.black, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          SizedBox(
            height: 100, // <-- you should put some value here
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child:   Container(
                    width: 130,
                    height: 80,
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
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Icon(Icons.payment),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: clsDimensConstants.douDp5),
                          child: Text("Phonepe UPI",
                            style: GoogleFonts.montserrat(fontSize: clsDimensConstants.douDp12, color: Colors.black, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: clsDimensConstants.douDp5),
                          child: Text("9978674567@ybi",
                            style: GoogleFonts.montserrat(fontSize: clsDimensConstants.douDp12, color: Colors.black, fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

        ],
      ),
    );
  }
}
