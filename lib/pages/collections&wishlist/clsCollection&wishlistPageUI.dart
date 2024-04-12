import 'package:badges/badges.dart';
import 'package:ecommerce/constants/clsDimensConstants.dart';
import 'package:ecommerce/localStorage/clsSharedPrefernce.dart';
import 'package:ecommerce/localStorage/clsSharedPrefernceKeyValue.dart';
import 'package:ecommerce/network/clsApiCallMethods.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:google_fonts/google_fonts.dart';

import '../../constants/clsCommonWidget.dart';
import '../../main.dart';
import '../../models/clsProductModel.dart';
import '../clsCartPageUI.dart';
import '../clsLoginPageUI.dart';
import '../clsProductDetailsPageUI.dart';

class ClsCollectionPageUI extends StatefulWidget {
  const ClsCollectionPageUI({Key? key}) : super(key: key);

  @override
  State<ClsCollectionPageUI> createState() => _ClsCollectionPageUIState();
}

class _ClsCollectionPageUIState extends State<ClsCollectionPageUI> {

  List<clsProductModel> lstclsProductModel = <clsProductModel>[];

  @override
  void initState() {
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    getProductsList();
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
          "Collections & Wishlist",
          style: GoogleFonts.montserrat(fontSize: clsDimensConstants.douDp14, color: Colors.black, fontWeight: FontWeight.w500),
        ),
        actions: [
          InkWell(
            onTap: (){
              if (clsSharedPrefernce.objSharedPrefs!.getString(clsSharedPrefernceKeyValue.USER_TOKEN) == null) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const clsLoginPageUI()));
              } else if (clsSharedPrefernce.objSharedPrefs!.getString(clsSharedPrefernceKeyValue.USER_TOKEN)!.isEmpty) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const clsLoginPageUI()));
              }else{
                Navigator.push(context, MaterialPageRoute(builder: (context) => const clsCartPageUI())).then((value){
                  clsApiCallMethods.ItemsInCart().then((value){
                    setState(() {

                    });
                  });
                });
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 15, top: 8),
              child: Badge(
                // badgeStyle: BadgeStyle(badgeColor: Theme.of(context).primaryColor),
                position: BadgePosition.topEnd(),
                badgeContent: Text(
                  clsSharedPrefernce.objSharedPrefs!.getString(clsSharedPrefernceKeyValue.ITEMS_IN_CART) ?? "",
                  style: const TextStyle(color: Colors.white),
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
      body: lstclsProductModel.isNotEmpty?returnProductsList():const Center(child: Text("No Wishlist")),
    );
  }


  returnProductsList() {
    List<Widget> lstWidget = <Widget>[];

    for (var element in lstclsProductModel) {
      lstWidget.add(
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => clsProductDetailsPageUI(objclsProductModel: element,)));
          },
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  width: 170,
                  height: 210,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: const Offset(0, 1), // changes position of shadow
                        ),
                      ],
                      // border: Border.all(color: Colors.black),
                      borderRadius: const BorderRadius.all(Radius.circular(clsDimensConstants.douDp15)),
                      gradient: LinearGradient(colors: [Theme.of(context).cardColor, Theme.of(context).cardColor])),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Stack(
                        children: [
                          SizedBox(
                            height: 100,
                            child: Center(
                              child: Image.network(
                                element.productImages[0],
                                errorBuilder: (context, object, stackTrace) {
                                  return const Center(child: Text('Failed to load image'));
                                },
                                height: 100,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              removeWhishlistItem(pid: element.productId);
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(right: clsDimensConstants.douDp10),
                              child: Align(alignment: Alignment.centerRight,child: Icon(Icons.cancel)),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                        child: Padding(
                          padding: const EdgeInsets.only(left: clsDimensConstants.douDp10, right: clsDimensConstants.douDp10),
                          child: Text(
                            element.productName.toString(),
                            maxLines: 2,
                            style: GoogleFonts.montserrat(fontSize: clsDimensConstants.douDp12, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   height: 30,
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(left: clsDimensConstants.douDp10, right: clsDimensConstants.douDp10),
                      //     child: Text(
                      //       element.productDescription.toString(),
                      //       maxLines: 2,
                      //       style: GoogleFonts.montserrat(fontSize: clsDimensConstants.douDp12, fontWeight: FontWeight.w500),
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: clsDimensConstants.douDp10,
                            right: clsDimensConstants.douDp10,
                            top: clsDimensConstants.douDp10,
                            bottom: clsDimensConstants.douDp10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                "₱ ${CommaSeparatedAmount(element.productSrp.toString())??""}",
                                maxLines: 2,
                                style: GoogleFonts.montserrat(
                                    fontSize: clsDimensConstants.douDp12, fontWeight: FontWeight.w500, color: Theme.of(context).primaryColor),
                              ),
                            ),Padding(
                              padding: const EdgeInsets.symmetric(horizontal: clsDimensConstants.douDp8, vertical: clsDimensConstants.douDp8),
                              child: Row(
                                children: returnStarRating(strProductRating: (element.productRating ?? (element.product_rating_unknownfield_s ?? "0")).toString()),
                              ),
                            ),
                            // if(element.productRating!=null) Flexible(
                            //     child: Row(
                            //       children: returnStarRating(strProductRating: element.productRating!),
                            //     ))
                            // Flexible(
                            //   child: Row(
                            //     children: [
                            //       Icon(
                            //         Icons.star,
                            //         size: 15,
                            //       ),
                            //       Icon(
                            //         Icons.star,
                            //         size: 15,
                            //       ),
                            //       Icon(
                            //         Icons.star,
                            //         size: 15,
                            //       ),
                            //       Icon(
                            //         Icons.star,
                            //         size: 15,
                            //       ),
                            //       Icon(
                            //         Icons.star_half,
                            //         size: 15,
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),


              // product off Percentage
              if(element.productPriceSale!=null)Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(clsDimensConstants.douDp15)),
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
                    turns: const AlwaysStoppedAnimation(318 / 360),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 14),
                      child: Text(
                        "${element.productPriceSale}% off",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(fontSize: clsDimensConstants.douDp12, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    lstWidget.add(const Text(""));
    return Align(
      alignment: Alignment.topCenter,
      child: Wrap(
        children: lstWidget,
      ),
    );
  }



  getProductsList() {
    ShowLoader(context);
    clsApiCallMethods.getWishlistProduct().then((value) {
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
          lstclsProductModel = List<clsProductModel>.from(value.data.map((e) => clsProductModel.fromJson(e)));
          setState(() {});
        }
        else{
          lstclsProductModel.clear();
          setState(() {});
        }
      }
    });
  }


  removeWhishlistItem({required String pid}) {
    Map<String, String> objMap = {
      "pid": pid,
    };
    ShowLoader(context);
    clsApiCallMethods.RemoveItemsInWhislist(objMap).then((value) {
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
          ShowSnackbar(strMessage: value.messages[0].toString(), showheading: false);
          getProductsList();
      }
    });
  }

  returnStarRating({required String strProductRating}) {
    List<Widget> lstFullStar = <Widget>[];
    var parts = strProductRating.split('.');
    lstFullStar.clear();
    if(strProductRating == "0"){
      for(int i = 0; i<5; i++){
        lstFullStar.add(const Icon(
          Icons.star_outline,
          color: Colors.orange,
          size: 15,
        ));
      }
    }

    int index1 = int.parse(parts[0].trim());
    for (int i = 0; i < index1; i++) {
      lstFullStar.add(const Icon(
        Icons.star,
        color: Colors.orange,
        size: 15,
      ));
    }

    if (strProductRating.contains(".")) {
      int index2 = int.parse(parts[1].trim());
      if (index2 >= 5) {
        lstFullStar.add(const Icon(
          Icons.star_half,
          color: Colors.orange,
          size: 15,
        ));
      } else {
        lstFullStar.add(const Icon(
          Icons.star_outline,
          color: Colors.orange,
          size: 15,
        ));
      }
    }

    if(lstFullStar.length<5){
      for(int i = lstFullStar.length ; i<5;i++){
         lstFullStar.add(const Icon(
          Icons.star_outline,
          color: Colors.orange,
          size: 15,
        ));
      }
    }

    return lstFullStar;
  }
}
