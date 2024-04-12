// ignore_for_file: must_be_immutable, camel_case_types, prefer_const_constructors, no_leading_underscores_for_local_identifiers, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/constants/clsDimensConstants.dart';
import 'package:ecommerce/localStorage/clsSharedPrefernce.dart';
import 'package:ecommerce/localStorage/clsSharedPrefernceKeyValue.dart';
import 'package:ecommerce/models/clsProductModel.dart';
import 'package:ecommerce/models/clsTileCategoryModel.dart';
import 'package:ecommerce/network/clsApiCallMethods.dart';
import 'package:ecommerce/pages/clsProductDetailsPageUI.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/clsCommonWidget.dart';
import '../main.dart';
import '../network/clsApiUrls.dart';
import 'clsCartPageUI.dart';
import 'clsLoginPageUI.dart';

class clsProductPageUI extends StatefulWidget {
  clsTileCategoryModel? objclsTileCategoryModel;
  bool isCollectionApiCall = false;
  List<clsProductModel>? widgetlstclsProductModel;
  String? strHeading = "";
  String? keyword;
  bool isCategory;
  bool isSearch;

  clsProductPageUI(
      {super.key,
      this.keyword,
      this.objclsTileCategoryModel,
      required this.isCollectionApiCall,
      this.widgetlstclsProductModel,
      this.strHeading,
      this.isCategory = false,
      this.isSearch = false});

  @override
  State<clsProductPageUI> createState() => _clsProductPageUIState();
}

class _clsProductPageUIState extends State<clsProductPageUI> {
  List<clsProductModel> lstclsProductModel = <clsProductModel>[];
  final ScrollController _scrollController = ScrollController();
  String? searchQuery;
  int page = 1;
  bool isSearch = false;
  StreamController<bool> isShowLoader = StreamController.broadcast();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (!widget.isCategory) {
        searchQuery = widget.keyword;
      }

      isSearch = widget.isSearch;

      if (widget.isCategory) {
        getProductsList();
      } else {
        if (widget.isCollectionApiCall) {
          lstclsProductModel = widget.widgetlstclsProductModel!;
          setState(() {});
        } else {
          getProductsList(pageNo: 1);
        }
      }
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        page++;
        if (!widget.isCategory) {
          searchQuery ??= widget.keyword;
        }

        if (searchQuery == null) {
          getProductsList(pageNo: page);
        } else {
          if (widget.isSearch) {
            widget.strHeading = searchQuery;
          }
          getProductSearchApi(searchQuery!, page: page, isSearch: isSearch);
        }
      }
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.isCollectionApiCall
              ? widget.strHeading!
              : (widget.objclsTileCategoryModel == null
                  ? ""
                  : widget.objclsTileCategoryModel!.category.toString()),
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
      body: RefreshIndicator(
        onRefresh: () async {
          // this.lstclsProductModel.clear();
          if (widget.isCollectionApiCall) {
            lstclsProductModel = widget.widgetlstclsProductModel!;
            setState(() {});
          } else {
            lstclsProductModel.clear();
            getProductsList();
          }
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(clsDimensConstants.douDp15)),
                      gradient: LinearGradient(colors: [
                        Theme.of(context).primaryColor,
                        Theme.of(context).primaryColor
                      ])),
                  child: TextField(
                    onSubmitted: (value) {
                      if (widget.isSearch) {
                        widget.strHeading = value;
                      }
                      lstclsProductModel.clear();
                      searchQuery = value;
                      page = 1;
                      isSearch = true;
                      getProductSearchApi(value, page: page, isSearch: true);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintStyle: GoogleFonts.montserrat(
                          fontSize: clsDimensConstants.douDp14,
                          color: Colors.white),
                      prefixIcon: Icon(Icons.search, color: Colors.white),
                      suffixIcon: InkWell(
                          onTap: () {
                            _launchUrl(strURl: CHAT_URL);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Image.asset(
                              "assets/images/chat.png",
                              width: 10,
                              height: 10,
                              color: Colors.white,
                            ),
                          )),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(clsDimensConstants.douDp14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.isCollectionApiCall
                          ? widget.strHeading!
                          : (widget.objclsTileCategoryModel == null
                              ? ""
                              : widget.objclsTileCategoryModel!.category
                                  .toString()),
                      style: GoogleFonts.montserrat(
                          fontSize: clsDimensConstants.douDp14,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              lstclsProductModel.isNotEmpty
                  ? returnListofProducts()
                  : StreamBuilder<bool>(stream: isShowLoader.stream,
                  builder: ((context, AsyncSnapshot<bool> snapshot) {
                    if(snapshot.hasData){
                      if(snapshot.data !=null && snapshot.data!){
                        return Text('Loading Products');
                      }
                      else{
                        return SizedBox(
                      height: MediaQuery.of(context).size.height / 1.5,
                      child: const Center(
                        child: Text("No Records Found"),
                      ),
                    );
                      }
                    }
                    else{
                      return const SizedBox();
                    }
                  }))
            ],
          ),
        ),
      ),
    );
  }

  getProductSearchApi(String strproductkeyword,
      {int page = 1, isSearch = false}) {
    ShowLoader(context);
    isShowLoader.add(true);
    (!isSearch
            ? clsApiCallMethods.getProductCollectionsItems(
                strKeywords: strproductkeyword, page: page)
            : clsApiCallMethods.getProductSearch(
                productkeyword: strproductkeyword, page: page))
        .then((value) {
      CancelLoader(context);
      isShowLoader.add(false);
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
        isShowLoader.add(false);
        if (value.data != null && isSearch) {
          List<clsProductModel> newProductList = [];
          newProductList = List<clsProductModel>.from(
              value.data["rows"].map((e) => clsProductModel.fromJson(e)));
          if (newProductList.isNotEmpty) {
            newProductList.map((e) {
              lstclsProductModel.add(e);
            }).toList();
          }
          setState(() {});
        } else {
          if (value.data != null) {
            List<clsProductModel> _lstclsProductModel =
                List<clsProductModel>.from(
                    value.data.map((e) => clsProductModel.fromJson(e)));
            if (_lstclsProductModel.isNotEmpty) {
              _lstclsProductModel.map((e) {
                lstclsProductModel.add(e);
              }).toList();
              setState(() {});
            }
          }
        }
      }
    });
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
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => clsProductDetailsPageUI(
                          objclsProductModel: element,
                        ))).then((value) {
              setState(() {});
            });
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
                        // border: Border.all(color: Colors.black),
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
                        if (element.productImages != null)
                          SizedBox(
                            height: 100,
                            child: (element.productImages!.length > 0)
                                ? CachedNetworkImage(
                                    imageUrl : element.productImages![0].toString(),
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
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: clsDimensConstants.douDp10,
                              right: clsDimensConstants.douDp10,
                              top: clsDimensConstants.douDp10,
                              bottom: clsDimensConstants.douDp10),
                          child: Column(
                            children: [
                             element.productComputedListprice== null || element.productPriceSale == null ? const SizedBox() : Padding(
                               padding: const EdgeInsets.only(bottom: 6),
                               child: Row(
                                 children: [
                                  Text("Before ",
                                              maxLines: 2,
                                              style: GoogleFonts.montserrat(
                                                  fontSize: clsDimensConstants.douDp12,
                                                  fontWeight: FontWeight.w500,
                                                  color:Colors.grey),
                                            ),
                                   Text(
                                              "₱ ${CommaSeparatedAmount(element.productComputedListprice ?? "0").toString()}",
                                              maxLines: 2,
                                              style: GoogleFonts.montserrat(
                                                  decoration: TextDecoration.lineThrough,
                                                  fontSize: clsDimensConstants.douDp12,
                                                  fontWeight: FontWeight.w500,
                                                  color:Colors.grey),
                                            ),
                                 ],
                               ),
                             ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  (CommaSeparatedAmount(
                                                  element.productSrp ?? "0")
                                              .toString()[0] ==
                                          "0")
                                      ? Text(
                                          "Get Price",
                                          maxLines: 2,
                                          style: GoogleFonts.montserrat(
                                              fontSize: clsDimensConstants.douDp12,
                                              fontWeight: FontWeight.w500,
                                              color:
                                                  Theme.of(context).primaryColor),
                                        )
                                      : Text(
                                          "₱ ${CommaSeparatedAmount(element.productSrp ?? "0").toString()}",
                                          maxLines: 2,
                                          style: GoogleFonts.montserrat(
                                              fontSize: clsDimensConstants.douDp12,
                                              fontWeight: FontWeight.w500,
                                              color:
                                                  Theme.of(context).primaryColor),
                                        ),
                                  Row(
                                      children: returnStarRating(
                                    strProductRating: (element.productRating ??
                                        (element.product_rating_unknownfield_s ??
                                            "0"))
                                    .toString(),
                                  ))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // product off Percentage
                if (element.productPriceSale != null)
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(clsDimensConstants.douDp15)),
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
                          padding: const EdgeInsets.only(top: 14),
                          child: Text(
                            "${element.productPriceSale}% off",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                                fontSize: clsDimensConstants.douDp12,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    }

    lstWidget.add(Text(""));
    return Wrap(
      children: lstWidget,
    );
  }

  getProductsList({int pageNo = 1}) {
    ShowLoader(context);
    isShowLoader.add(true);
    clsApiCallMethods
        .getProductByCategoryId(
            strcategory_id:
                widget.objclsTileCategoryModel!.categoryId.toString(),
            pageNo: pageNo,
            link: widget.objclsTileCategoryModel?.link
            )
        .then((value) {
      CancelLoader(context);
      isShowLoader.add(false);
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
          List<clsProductModel> _data;
          if(value.data is List){
            _data = List<clsProductModel>.from(
              value.data.map((e) => clsProductModel.fromJson(e)));
          }
          else{
           _data = List<clsProductModel>.from(
              value.data["rows"].map((e) => clsProductModel.fromJson(e)));
          }
          
          if (_data.isNotEmpty) {
            _data.map((e) {
              lstclsProductModel.add(e);
            }).toList();
          }
          setState(() {});
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

  returnStarRating({required String strProductRating}) {
    List<Widget> lstFullStar = <Widget>[];

    if (strProductRating == "0") {
      for (int i = 0; i < 5; i++) {
        lstFullStar.add(Icon(
          Icons.star_outline,
          color: Colors.orange,
          size: 15,
        ));
      }
      return lstFullStar;
    }

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
}
