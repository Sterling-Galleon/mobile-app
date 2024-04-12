import 'package:ecommerce/constants/clsDimensConstants.dart';
import 'package:ecommerce/models/clsAddressesModel.dart';
import 'package:ecommerce/network/clsApiCallMethods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/clsCommonWidget.dart';
import '../main.dart';
import 'clsAddressPageUI.dart';

class clsGetAddressPageUI extends StatefulWidget {
  const clsGetAddressPageUI({Key? key}) : super(key: key);

  @override
  State<clsGetAddressPageUI> createState() => _clsGetAddressPageUIState();
}

class _clsGetAddressPageUIState extends State<clsGetAddressPageUI> {
  List<clsAddresssModel> lstclsAddresssModel = <clsAddresssModel>[];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getAddressesList();
    });
    super.initState();
  }

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
          "Address",
          style: GoogleFonts.montserrat(fontSize: clsDimensConstants.douDp14, color: Colors.black, fontWeight: FontWeight.w500),
        ),
        actions: [
          InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => clsAddressPageUI())).then((value) {
                  getAddressesList();
                });
              },
              child: Icon(
                Icons.add,
                color: Colors.black,
              ))
        ],
      ),
      body: this.lstclsAddresssModel.length > 0
          ? ListView.builder(
              itemCount: this.lstclsAddresssModel.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: (){
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => clsAddressPageUI(objaddressmodel:this.lstclsAddresssModel[index]))).then((value) {
                    //   getAddressesList();
                    // });
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
                              offset: Offset(0, 1), // changes position of shadow
                            ),
                          ],
                          border: Border.all(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.all(Radius.circular(clsDimensConstants.douDp15)),
                          gradient: LinearGradient(colors: [Theme.of(context).cardColor, Theme.of(context).cardColor])),
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
                                      TextSpan(text: this.lstclsAddresssModel[index].addressName??"",style: TextStyle( fontSize: clsDimensConstants.douDp12,)),
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  // Icon(Icons.edit),
                                  // SizedBox(
                                  //   width: 10,
                                  // ),
                                  // Icon(Icons.check_circle_rounded),
                                  // SizedBox(
                                  //   width: 10,
                                  // ),
                                  InkWell(
                                      onTap: () {
                                        deleteAddress(address_id: this.lstclsAddresssModel[index].addressId!);
                                      },
                                      child: Icon(Icons.delete))
                                ],
                              )
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
                                TextSpan(text: this.lstclsAddresssModel[index].addressEmail??"",style: TextStyle( fontSize: clsDimensConstants.douDp12,)),
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
                                TextSpan(text: this.lstclsAddresssModel[index].addressPhone??"",style: TextStyle( fontSize: clsDimensConstants.douDp12,)),
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
                                TextSpan(text: this.lstclsAddresssModel[index].addressPhone2??"",style: TextStyle( fontSize: clsDimensConstants.douDp12,)),
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
                                TextSpan(text: "Philippines",style: TextStyle( fontSize: clsDimensConstants.douDp12,)),
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
                                TextSpan(text: this.lstclsAddresssModel[index].addressCity??"",style: TextStyle( fontSize: clsDimensConstants.douDp12,)),
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
                                TextSpan(text: this.lstclsAddresssModel[index].addressState??"",style: TextStyle( fontSize: clsDimensConstants.douDp12,)),
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
                                TextSpan(text: this.lstclsAddresssModel[index].addressBarangay??"",style: TextStyle( fontSize: clsDimensConstants.douDp12,)),
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
                                TextSpan(text: this.lstclsAddresssModel[index].addressStreet??"",style: TextStyle( fontSize: clsDimensConstants.douDp12,)),
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
                                TextSpan(text: this.lstclsAddresssModel[index].addressStreet2??"",style: TextStyle( fontSize: clsDimensConstants.douDp12,)),
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
                                TextSpan(text: this.lstclsAddresssModel[index].addressMobile??"",style: TextStyle( fontSize: clsDimensConstants.douDp12,)),
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
                                      borderRadius: BorderRadius.all(Radius.circular(clsDimensConstants.douDp15)),
                                      gradient: LinearGradient(colors: [Theme.of(context).primaryColor, Theme.of(context).primaryColor])),
                                  child: Center(
                                      child: Text(
                                    "Deliver to this Address",
                                    style: GoogleFonts.montserrat(fontSize: clsDimensConstants.douDp12, color: Colors.white),
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
    );
  }

  getAddressesList() {
    ShowLoader(context);
    clsApiCallMethods.getAllAddresses().then((value) {
      CancelLoader(context);
      if (value.error == "true") {
        if (value.fieldValidation != null) {
          if (value.fieldValidation!.firstname != "") {
            ShowSnackbar(strMessage: value.fieldValidation!.firstname.toString(), showheading: true);
          }
          if (value.fieldValidation!.lastname != "") {
            ShowSnackbar(strMessage: value.fieldValidation!.lastname.toString(), showheading: true);
          }
          if (value.fieldValidation!.email != "") {
            ShowSnackbar(strMessage: value.fieldValidation!.email.toString(), showheading: true);
          }
          if (value.fieldValidation!.password != "") {
            ShowSnackbar(strMessage: value.fieldValidation!.password.toString(), showheading: true);
          }
          if (value.fieldValidation!.confirmPassword != "") {
            ShowSnackbar(strMessage: value.fieldValidation!.confirmPassword.toString(), showheading: true);
          }
        }
      } else {
        if (value.data != null) {
          this.lstclsAddresssModel = List<clsAddresssModel>.from(value.data.map((e) => clsAddresssModel.fromJson(e)));
          setState(() {});
        }
      }
    });
  }

  deleteAddress({required String address_id}) {
    ShowLoader(context);
    clsApiCallMethods.deleteAddress({"address_id": address_id}).then((value) {
      CancelLoader(context);

      if (value.error == "true") {
        if (value.fieldValidation != null) {
          if (value.fieldValidation!.firstname != "") {
            ShowSnackbar(strMessage: value.fieldValidation!.firstname.toString(), showheading: true);
          }
          if (value.fieldValidation!.lastname != "") {
            ShowSnackbar(strMessage: value.fieldValidation!.lastname.toString(), showheading: true);
          }
          if (value.fieldValidation!.email != "") {
            ShowSnackbar(strMessage: value.fieldValidation!.email.toString(), showheading: true);
          }
          if (value.fieldValidation!.password != "") {
            ShowSnackbar(strMessage: value.fieldValidation!.password.toString(), showheading: true);
          }
          if (value.fieldValidation!.confirmPassword != "") {
            ShowSnackbar(strMessage: value.fieldValidation!.confirmPassword.toString(), showheading: true);
          }
        }
      } else {
          getAddressesList();
      }
    });
  }
}
