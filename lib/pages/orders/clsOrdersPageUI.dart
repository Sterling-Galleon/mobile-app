import 'package:badges/badges.dart';
import 'package:ecommerce/constants/clsDimensConstants.dart';
import 'package:ecommerce/localStorage/clsSharedPrefernce.dart';
import 'package:ecommerce/localStorage/clsSharedPrefernceKeyValue.dart';
import 'package:ecommerce/network/clsApiCallMethods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Badge;

import 'package:google_fonts/google_fonts.dart';

import '../../constants/clsCommonWidget.dart';
import '../../main.dart';
import '../../models/clsorderDetailsModel.dart';
import '../clsCartPageUI.dart';
import '../clsLoginPageUI.dart';
import 'clsOrderDetailPageUI.dart';

class clsCommonFiltermodel {
  clsCommonFiltermodel({required this.strFieldName, required this.isboolSelected});

  bool isboolSelected = false;
  String strFieldName = "";
}

class clsOrdersPageUI extends StatefulWidget {
  const clsOrdersPageUI({Key? key}) : super(key: key);

  @override
  State<clsOrdersPageUI> createState() => _clsOrdersPageUIState();
}

class _clsOrdersPageUIState extends State<clsOrdersPageUI> {
  List<clsCommonFiltermodel> lstStatus = <clsCommonFiltermodel>[];
  List<clsCommonFiltermodel> lstTime = <clsCommonFiltermodel>[];

  List<Order> lstclsOrderDetailsModel = <Order>[];

  @override
  void initState() {
    this.lstStatus.add(clsCommonFiltermodel(strFieldName: "All", isboolSelected: true));
    this.lstStatus.add(clsCommonFiltermodel(strFieldName: "On the Way", isboolSelected: false));
    this.lstStatus.add(clsCommonFiltermodel(strFieldName: "Delievered", isboolSelected: false));
    this.lstStatus.add(clsCommonFiltermodel(strFieldName: "Cancelled", isboolSelected: false));
    this.lstStatus.add(clsCommonFiltermodel(strFieldName: "Returned", isboolSelected: false));

    this.lstTime.add(clsCommonFiltermodel(strFieldName: "Anytime", isboolSelected: true));
    this.lstTime.add(clsCommonFiltermodel(strFieldName: "Last 30 days", isboolSelected: true));
    this.lstTime.add(clsCommonFiltermodel(strFieldName: "Last 6 months", isboolSelected: true));
    this.lstTime.add(clsCommonFiltermodel(strFieldName: "Last year", isboolSelected: true));

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getOrderDetails();
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
          "Orders",
          style: GoogleFonts.montserrat(fontSize: clsDimensConstants.douDp14, color: Colors.black, fontWeight: FontWeight.w500),
        ),
        actions: [
          InkWell(
            onTap: () {
              if (clsSharedPrefernce.objSharedPrefs!.getString(clsSharedPrefernceKeyValue.USER_TOKEN) == null) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => clsLoginPageUI()));
              } else if (clsSharedPrefernce.objSharedPrefs!.getString(clsSharedPrefernceKeyValue.USER_TOKEN)!.isEmpty) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => clsLoginPageUI()));
              } else {
                Navigator.push(context, MaterialPageRoute(builder: (context) => clsCartPageUI())).then((value) {
                  clsApiCallMethods.ItemsInCart().then((value) {
                    setState(() {});
                  });
                });
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 15, top: 8),
              child: Badge(
                // badgeStyle: BadgeStyle(badgeColor: Theme
                //     .of(context)
                //     .primaryColor),
                position: BadgePosition.topEnd(),
                badgeContent: Text(
                  clsSharedPrefernce.objSharedPrefs!.getString(clsSharedPrefernceKeyValue.ITEMS_IN_CART) ?? "",
                  style: TextStyle(color: Colors.white),
                ),
                child: Icon(
                  Icons.local_grocery_store,
                  color: Theme
                      .of(context)
                      .primaryColor,
                ),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: returnListofWidget(),
        ),
      ),
    );
  }

  returnListofWidget() {
    List<Widget> lstwidget = <Widget>[];

    if (this.lstclsOrderDetailsModel.length > 0) {
      for (int index = 0; index < this.lstclsOrderDetailsModel.length; index++) {
        lstwidget.add(Container(
          padding: EdgeInsets.all(clsDimensConstants.douDp10),
          child: Column(
            children: [

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: clsDimensConstants.douDp12),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: clsDimensConstants.douDp15, vertical: clsDimensConstants.douDp12),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(clsDimensConstants.douDp5)),
                      gradient: LinearGradient(colors: [(Colors.white), (Colors.white)])),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Status :"+this.lstclsOrderDetailsModel[index].invoiceStatus.toString(),
                              maxLines: 2,
                              style: GoogleFonts.montserrat(fontSize: clsDimensConstants.douDp10, color: Colors.black, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "Date: " + returnDateFormat(intTimeId: int.parse(this.lstclsOrderDetailsModel[index].invoiceCreated.toString())),
                              style: GoogleFonts.montserrat(fontSize: clsDimensConstants.douDp10, color: Colors.black, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          this.lstclsOrderDetailsModel[index].quote![0].productName.toString(),
                          style: GoogleFonts.montserrat(fontSize: clsDimensConstants.douDp10, color: Colors.black, fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Invoice Id: " + this.lstclsOrderDetailsModel[index].quote![0].quoteInvoice.toString(),
                              maxLines: 2,
                              style: GoogleFonts.montserrat(fontSize: clsDimensConstants.douDp10, color: Colors.black, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "Product Price: " + this.lstclsOrderDetailsModel[index].quote![0].productPriceTotal.toString(),
                              style: GoogleFonts.montserrat(fontSize: clsDimensConstants.douDp10, color: Colors.black, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Visibility(
                        visible: false,
                          child: Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ClsOrderDetailPageUI(intId: this.lstclsOrderDetailsModel[index].id!)));
                          },
                          child: Container(
                            height: 30,
                            width: 50,
                            padding: EdgeInsets.all(clsDimensConstants.douDp5),
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
                                borderRadius: BorderRadius.all(Radius.circular(clsDimensConstants.douDp10)),
                                gradient: LinearGradient(colors: [Theme.of(context).cardColor, Theme.of(context).cardColor])),
                            child: Center(child: Text("View")),
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
      }
    } else {
      lstwidget.add(Center(
        child: Text("No Orders Found"),
      ));
    }

    return Column(
      children: lstwidget,
    );
  }


  returnDateFormat({required int intTimeId}){
    final DateTime date1 = DateTime.fromMillisecondsSinceEpoch(intTimeId * 1000);
    print(date1);

    return  getDateFormat(date1);
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

  void filtermodalsheet(context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (context) => StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return Container(
          height: MediaQuery.of(context).size.height / 1.6,
          padding: EdgeInsets.all(clsDimensConstants.douDp12),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Filters Orders",
                      style: GoogleFonts.montserrat(fontSize: clsDimensConstants.douDp16, color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.cancel))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(4),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Status",
                    style: GoogleFonts.montserrat(fontSize: clsDimensConstants.douDp14, color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Container(
                height: 170,
                child: ListView.builder(
                  itemCount: this.lstStatus.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (_, index) {
                    return InkWell(
                      onTap: () {
                        this.lstStatus.forEach((element) {
                          element.isboolSelected = false;
                        });
                        setState(() {
                          this.lstStatus[index].isboolSelected = true;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.all(4),
                        child: Row(
                          children: [
                            this.lstStatus[index].isboolSelected
                                ? Icon(
                                    Icons.radio_button_checked,
                                    color: Theme.of(context).primaryColor,
                                  )
                                : Icon(Icons.radio_button_unchecked),
                            Text(
                              this.lstStatus[index].strFieldName,
                              style: GoogleFonts.montserrat(fontSize: clsDimensConstants.douDp14, color: Colors.black, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(4),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Time",
                    style: GoogleFonts.montserrat(fontSize: clsDimensConstants.douDp14, color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Container(
                height: 150,
                child: ListView.builder(
                  itemCount: this.lstTime.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (_, index) {
                    return InkWell(
                      onTap: () {
                        this.lstTime.forEach((element) {
                          element.isboolSelected = false;
                        });
                        setState(() {
                          this.lstTime[index].isboolSelected = true;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.all(4),
                        child: Row(
                          children: [
                            this.lstTime[index].isboolSelected
                                ? Icon(
                                    Icons.radio_button_checked,
                                    color: Theme.of(context).primaryColor,
                                  )
                                : Icon(Icons.radio_button_unchecked),
                            Text(
                              this.lstTime[index].strFieldName,
                              style: GoogleFonts.montserrat(fontSize: clsDimensConstants.douDp14, color: Colors.black, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              InkWell(
                onTap: () {},
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: 45,
                    width: 100,
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
                        borderRadius: BorderRadius.all(Radius.circular(clsDimensConstants.douDp15)),
                        gradient: LinearGradient(colors: [Theme.of(context).primaryColor, Theme.of(context).primaryColor])),
                    child: Center(
                      child: Text(
                        "Apply",
                        style: GoogleFonts.montserrat(fontSize: clsDimensConstants.douDp14, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  getOrderDetails() {
    ShowLoader(context);
    clsApiCallMethods.GetOrderLists().then((value) {
      CancelLoader(context);
      if (value.error == "true") {
      } else {
        print(value.data);
        if (value.data != null) {
          if (value.data["orders"] != null) {
            this.lstclsOrderDetailsModel = List<Order>.from(value.data["orders"].map((e) => Order.fromJson(e)));
          }
          print(this.lstclsOrderDetailsModel.length);
          // this.lstclsStateModal = List<clsStateModal>.from(value.data.map((e) => clsStateModal.fromJson(e)));
          // if(lstclsStateModal.length>0){
          //   getCityList(strStateId: lstclsStateModal[1].provincesId.toString());
          // }

          setState(() {});
        }
      }
    });
  }
}
