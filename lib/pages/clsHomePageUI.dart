// ignore_for_file: camel_case_types, prefer_final_fields, prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'dart:async';
import 'dart:io';

import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/app_utility.dart';
import 'package:ecommerce/constants/clsDimensConstants.dart';
import 'package:ecommerce/dynamic_link_service.dart';
import 'package:ecommerce/localStorage/clsSharedPrefernce.dart';
import 'package:ecommerce/localStorage/clsSharedPrefernceKeyValue.dart';
import 'package:ecommerce/models/clsNavCategoryModel.dart';
import 'package:ecommerce/models/clsProductModel.dart';
import 'package:ecommerce/models/clsTileCategoryModel.dart';
import 'package:ecommerce/my_webview.dart';
import 'package:ecommerce/network/clsApiCallMethods.dart';
import 'package:ecommerce/network/clsApiUrls.dart';
import 'package:ecommerce/pages/clsCartPageUI.dart';
import 'package:ecommerce/pages/clsCategoryPageUI.dart';
import 'package:ecommerce/pages/clsLoginPageUI.dart';
import 'package:ecommerce/pages/clsProductDetailsPageUI.dart';
import 'package:ecommerce/pages/profile/clsProfilePageUI.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/clsCommonWidget.dart';
import '../main.dart';
import '../models/clsBannerModel.dart';
import '../models/clsCollectionModel.dart';
import 'clsProductsPageUI.dart';

class clsHomePageUI extends StatefulWidget {
  const clsHomePageUI({Key? key}) : super(key: key);

  @override
  State<clsHomePageUI> createState() => _clsHomePageUIState();
}

class _clsHomePageUIState extends State<clsHomePageUI> {
  int index = 0;
  List<clsBannermodel> lstclsBannermodel = <clsBannermodel>[];
  List<clsBannermodel> lstfilterBannermodel1 = <clsBannermodel>[];
  List<clsBannermodel> lstfilterBannermodel2 = <clsBannermodel>[];
  List<clsNavCategoryModel> lstclsNavCategoryModel = <clsNavCategoryModel>[];
  List<clsCollectionModel> lstclsCollectionModel = <clsCollectionModel>[];
  List<clsTileCategoryModel> lstclsTileCategoryModel = <clsTileCategoryModel>[];
  List<clsProductModel>? lstclsProductModel = <clsProductModel>[];
  ScrollController _scrollController1 = ScrollController();
  ScrollController _scrollController2 = ScrollController();
  double minScrollExtent1 = 0.0;
  double maxScrollExtent1 = 0.0;
  double minScrollExtent2 = 0.0;
  double maxScrollExtent2 = 0.0;
  ScrollController _prodcutScrollCont = ScrollController();
  CarouselController buttonCarouselController = CarouselController();

  int pageNo = 1;
  bool _initialUriIsHandled = false;

  void handlePathRedirection(String path, String prams){
  if((path).contains('product')){
         String productId = (prams).split('/').last;
          Navigator.push(
                    navigatorKey.currentContext!,
                    MaterialPageRoute(
                        builder: (context) => clsProductDetailsPageUI(
                              objclsProductModel: clsProductModel(
                                productId: productId
                              ),
                            )));
        }
}

void _handleIncomingLinks() {
    if (!kIsWeb) {
      // It will handle app links while the app is already started - be it in
      // the foreground or in the background.
       uriLinkStream.listen((Uri? uri) {
        if(uri?.path != null){
          handlePathRedirection(uri?.host ?? '', uri?.path ?? '');
        }


      }, onError: (Object err) {
        print('got err: $err');

      });
    }
  }

  /// Handle the initial Uri - the one the app was started with
  ///
  /// **ATTENTION**: `getInitialLink`/`getInitialUri` should be handled
  /// ONLY ONCE in your app's lifetime, since it is not meant to change
  /// throughout your app's life.
  ///
  /// We handle all exceptions, since it is called from initState.
  Future<void> _handleInitialUri() async {
    // In this example app this is an almost useless guard, but it is here to
    // show we are not going to call getInitialUri multiple times, even if this
    // was a weidget that will be disposed of (ex. a navigation route change).
    if (!_initialUriIsHandled) {
      _initialUriIsHandled = true;
      try {
        final uri = await getInitialUri();
        if (uri == null) {
          print('no initial uri');
        } else {
          handlePathRedirection(uri.host, uri.path);

        }
      } on PlatformException {
        // Platform messages may fail but we ignore the exception
        print('falied to get initial uri');
      } on FormatException catch (err) {
        print('malformed initial uri $err');
      }
    }
  }

  bool bolreachend = false;
  @override
  void initState() {
    Future.delayed(Duration(seconds: 8),(){
       _handleIncomingLinks();
       _handleInitialUri();
    });
    getTileCategoryList();
    getNavCategoryList();
    getTopBannerList();
    _prodcutScrollCont.addListener(() {
      debugPrint("Scrolling_prod");
      if (_prodcutScrollCont.position.pixels ==
          _prodcutScrollCont.position.maxScrollExtent) {
        pageNo++;
        if (lstclsCollectionModel.isNotEmpty) {
          lstclsCollectionModel.asMap().forEach((index, element) {
            getProductCollectionsItems(
                objclsCollectionModel: element, index: index, page: pageNo);
          });
        }
      }
    });
    if (clsSharedPrefernce.objSharedPrefs!
            .getString(clsSharedPrefernceKeyValue.USER_TOKEN) !=
        null) {
      clsApiCallMethods.ItemsInCart().then((value) {
        setState(() {});
      });
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getProductCollections();
      getPromotionData();
    });

    _scrollController1.addListener(() {
      if (_scrollController1.hasClients) {
        if (_scrollController1.position.pixels ==
            _scrollController1.position.maxScrollExtent) {
          bolreachend = true;
        } else if (_scrollController1.position.pixels ==
            _scrollController1.position.minScrollExtent) {
          bolreachend = false;
        }
      }
    });
    _scrollController2.addListener(() {
      if (_scrollController2.hasClients) {
        if (_scrollController2.position.pixels ==
            _scrollController2.position.maxScrollExtent) {
          bolreachend = true;
        } else if (_scrollController1.position.pixels ==
            _scrollController1.position.minScrollExtent) {
          bolreachend = false;
        }
      }
    });
    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (Timer t) async {
      if (lstfilterBannermodel1.isNotEmpty) {
        if (_scrollController1.hasClients && !bolreachend) {
          await _scrollController1.animateTo(
              _scrollController1.position.maxScrollExtent,
              duration: Duration(seconds: 1),
              curve: Curves.easeIn);
        }
      }
    });
    Timer.periodic(oneSec, (Timer t) async {
      if (lstfilterBannermodel2.isNotEmpty) {
        if (_scrollController2.hasClients && !bolreachend) {
          await _scrollController2.animateTo(
              _scrollController2.position.maxScrollExtent,
              duration: Duration(seconds: 1),
              curve: Curves.easeIn);
        }
      }
    });
    super.initState();
  }

  getPromotionData() async {
    clsApiCallMethods.getPromotionData().then((value) async {
      if(value.data == null || value.data[0] == null || value.data[0]['link'] == null){
        return;
      }
      await Future.delayed(Duration(seconds: 3));
// ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (BuildContext context1) => Dialog(
              backgroundColor: Colors.transparent, //this right here
              child: SizedBox(
                height: 200,
                child: Stack(children: [
                  Padding(
                    padding: EdgeInsets.only(top: 0),
                    child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context1,
                          MaterialPageRoute(
                              builder: (context) => MyWebView(
                                    url: value.data[0]["link"],
                                  )));
                    },
                    child: Center(
                        child: CachedNetworkImage(
                      imageUrl: value.data[0]["photo"],
                      fit: BoxFit.fill,
                    )),
                  ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: GestureDetector(
                      onTap: (){
                        Get.back();
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.black
                        ),
                        child: Icon(
                          Icons.clear,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    )
                  )
                ]),
              )));
      // Get.dialog(
      //   Stack(
      //     children: [
      //       Container(
      //         margin: EdgeInsets.only(top: 30),
      //         child: Center(child: CircularProgressIndicator()),
      //       ),
      //       Center(
      //   child: imageWidget
      // ),
      // Positioned(
      //   top: 2,
      //   right: 2,
      //   child: IconButton(onPressed: (){

      //   }, icon: Icon(Icons.cancel)),
      // )
      //     ],
      //   )
      // );
    });
  }

  Future animateToMaxMin(double max, double min, double direction, int seconds,
      ScrollController scrollController) async {
    scrollController
        .animateTo(direction,
            duration: Duration(seconds: seconds), curve: Curves.easeIn)
        .then((value) {});
  }

  @override
  Widget build(BuildContext context) {
     debugPrint("Home_build");
    return ScaffoldWrapper(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                    Radius.circular(clsDimensConstants.douDp15)),
                gradient: LinearGradient(colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColor
                ])),
            child: TextField(
              onSubmitted: (value) {
                getProductSearchApi(value);
              },
              decoration: InputDecoration(
                hintText: 'Search Galleon..',
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintStyle: GoogleFonts.montserrat(
                    fontSize: clsDimensConstants.douDp14, color: Colors.white),
                prefixIcon: Icon(Icons.search, color: Colors.white),
                suffixIcon: InkWell(
                    onTap: () {
                      _launchUrl(strURl: CHAT_URL, isShowAppBar: true);
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
          actions: [
            InkWell(
              onTap: () {
                if (clsSharedPrefernce.objSharedPrefs!
                        .getString(clsSharedPrefernceKeyValue.USER_TOKEN) ==
                    null) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => clsLoginPageUI()));
                } else if (clsSharedPrefernce.objSharedPrefs!
                    .getString(clsSharedPrefernceKeyValue.USER_TOKEN)!
                    .isEmpty) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => clsLoginPageUI()));
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
                    size: 45,
                  ),
                ),
              ),
            )
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            lstclsBannermodel.clear();
            lstclsCollectionModel.clear();
            lstclsNavCategoryModel.clear();
            lstclsTileCategoryModel.clear();
            lstclsProductModel?.clear();
            getTileCategoryList();
            getNavCategoryList();
            getTopBannerList();
            getProductCollections();
            return;
          },
          child: SingleChildScrollView(
            controller: _prodcutScrollCont,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (lstfilterBannermodel1.isNotEmpty)
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height *
                        0.15, // <-- you should put some value here
                    constraints: BoxConstraints(maxHeight: 200),
                    child: CarouselSlider.builder(
                      itemCount: lstfilterBannermodel1.length,
                      itemBuilder: ((context, index, realIndex) {
                        return Container(
                            color: Colors.white,
                            width: MediaQuery.of(context).size.width,
                            child: InkWell(
                                onTap: () {
                                  if(lstfilterBannermodel1[index]
                                      .bannerLink
                                      .toString().isNotEmpty)
                                    {
                                      _launchUrlBanner(
                                          strURl: lstfilterBannermodel1[index]
                                              .bannerLink
                                              .toString())
                                          .whenComplete(() {});
                                    }
                                },
                                child: Image.network(
                                  lstfilterBannermodel1[index]
                                      .bannerImg
                                      .toString(),
                                  width: double.infinity,
                                  fit: BoxFit.fill,
                                )));
                      }),
                      carouselController: buttonCarouselController,
                      options: CarouselOptions(
                        autoPlay: true,
                        enlargeCenterPage: false,
                        viewportFraction: 1,
                        aspectRatio: 2.0,
                        initialPage: 2,
                        disableCenter: true,

                        // padEnds: false
                      ),
                    ),
                  ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 163, // <-- you should put some value here
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: lstclsTileCategoryModel.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => clsProductPageUI(
                                        isCategory: true,
                                        // keyword: ,
                                        isCollectionApiCall: false,
                                        objclsTileCategoryModel:
                                            lstclsTileCategoryModel[index],
                                      )));
                        },
                        child: Padding(
                          padding: index == 0
                              ? EdgeInsets.only(
                                  left: 20, right: 4, top: 4, bottom: 4)
                              : EdgeInsets.all(4.0),
                          child: Container(
                            width: 120,
                            height: 160,
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
                                borderRadius: BorderRadius.all(Radius.circular(
                                    clsDimensConstants.douDp15)),
                                gradient: LinearGradient(colors: [
                                  Theme.of(context).cardColor,
                                  Theme.of(context).cardColor
                                ])),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        lstclsTileCategoryModel[index]
                                            .category!,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.montserrat(
                                            fontSize:
                                                clsDimensConstants.douDp10,
                                            fontWeight: FontWeight.w500),
                                      )),
                                ),
                                Divider(
                                  color: Colors.black,
                                ),
                                Container(
                                  width: 120,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          lstclsTileCategoryModel[index]
                                              .photo!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                returnProductComponents(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).cardColor,
          selectedFontSize: 14,
          unselectedFontSize: 10,
          type: BottomNavigationBarType.fixed,
          selectedIconTheme:
              IconThemeData(color: Theme.of(context).primaryColor, size: 24),
          unselectedIconTheme: IconThemeData(color: Colors.black, size: 24),
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.black,
          selectedLabelStyle:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
          unselectedLabelStyle:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.black,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.category,
                color: Colors.black,
              ),
              label: 'Category',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.call,
                color: Colors.black,
              ),
              label: 'Call',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.question_mark,
                color: Colors.black,
              ),
              label: 'FAQ',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: Colors.black,
              ),
              label: 'Me',
            ),
          ],
          currentIndex: index,
          onTap: (int i) {
            if (i == 4) {
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
                            builder: (context) => clsProfilePageUI()))
                    .then((value) {
                  index = 0;
                  setState(() {});
                });
              }
            } else if (i == 3) {
              _launchUrl(strURl: "https://galleonph.zendesk.com/hc/en-us")
                  .then((value) {
                index = 0;
                setState(() {});
              });
            } else if (i == 2) {
              if (Platform.isIOS) {
                CallByTelcoDialog();
                return;
              }
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return SizedBox(
                      height: 100,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Contact Customer Service",
                              style: GoogleFonts.montserrat(
                                  fontSize: clsDimensConstants.douDp14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    CallByTelcoDialog();
                                  },
                                  child: Container(
                                    width: 100,
                                    padding: EdgeInsets.all(
                                        clsDimensConstants.douDp10),
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            spreadRadius: 3,
                                            blurRadius: 7,
                                            offset: Offset(0,
                                                1), // changes position of shadow
                                          ),
                                        ],
                                        // border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                clsDimensConstants.douDp15)),
                                        gradient: LinearGradient(colors: [
                                          Theme.of(context).cardColor,
                                          Theme.of(context).cardColor
                                        ])),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.call,
                                          size: clsDimensConstants.douDp18,
                                          color: Colors.red,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text("Call Via Telco")
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MyWebView(
                                                  url:
                                                      "https://omnichannel.galleon.ph:8443/c2c/click-to-talk",
                                                )));
                                  },
                                  child: Container(
                                    width: 100,
                                    padding: EdgeInsets.all(
                                        clsDimensConstants.douDp10),
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            spreadRadius: 3,
                                            blurRadius: 7,
                                            offset: Offset(0,
                                                1), // changes position of shadow
                                          ),
                                        ],
                                        // border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                clsDimensConstants.douDp15)),
                                        gradient: LinearGradient(colors: [
                                          Theme.of(context).cardColor,
                                          Theme.of(context).cardColor
                                        ])),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.call,
                                          size: clsDimensConstants.douDp18,
                                          color: Colors.red,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text("Call Via Internet")
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  });
            } else if (i == 1) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => clsCategoryPageUI()));
            }

            setState(() {
              index = i;
            });
          },
        ));
  }

  CallByTelcoDialog() {
    showModalBottomSheet<void>(
      // context and builder are
      // required properties in this widget
      context: context,
      builder: (BuildContext context) {
        // we set up a container inside which
        // we create center column and display text

        // Returning SizedBox instead of a Container
        return SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: clsDimensConstants.douDp8),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Call By Telco",
                    style: GoogleFonts.montserrat(
                        fontSize: clsDimensConstants.douDp14,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        // ignore: deprecated_member_use
                        launch("tel:09178425012");
                      },
                      child: Container(
                        width: 100,
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
                            // border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.all(
                                Radius.circular(clsDimensConstants.douDp15)),
                            gradient: LinearGradient(colors: [
                              Theme.of(context).cardColor,
                              Theme.of(context).cardColor
                            ])),
                        child: Row(
                          children: [
                            Icon(
                              Icons.call,
                              size: clsDimensConstants.douDp18,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Globe")
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // ignore: deprecated_member_use
                        launch("tel:09186364116");
                      },
                      child: Container(
                        width: 100,
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
                            // border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.all(
                                Radius.circular(clsDimensConstants.douDp15)),
                            gradient: LinearGradient(colors: [
                              Theme.of(context).cardColor,
                              Theme.of(context).cardColor
                            ])),
                        child: Row(
                          children: [
                            Icon(
                              Icons.call,
                              size: clsDimensConstants.douDp18,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Smart")
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // ignore: deprecated_member_use
                        launch("tel:0284250153");
                      },
                      child: Container(
                        width: 120,
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
                            // border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.all(
                                Radius.circular(clsDimensConstants.douDp15)),
                            gradient: LinearGradient(colors: [
                              Theme.of(context).cardColor,
                              Theme.of(context).cardColor
                            ])),
                        child: Row(
                          children: [
                            Icon(
                              Icons.call,
                              size: clsDimensConstants.douDp18,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Landline")
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _launchUrl(
      {required String strURl, bool isShowAppBar = true}) async {
    if (strURl.contains("?")) {
      strURl = "$strURl&mobile_view=true";
    } else {
      strURl = "$strURl?mobile_view=true";
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                MyWebView(url: strURl, isShowAppBar: isShowAppBar)));
  }

  Future<void> _launchUrlBanner(
      {required String strURl, bool isShowAppBar = true}) async {
        if(strURl.isEmpty){
          Fluttertoast.showToast(msg: 'something went wrong \ntry again');
          return;
        }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                MyWebView(url: strURl, isShowAppBar: isShowAppBar)));
  }

  // api calls
  getTopBannerList() {
    clsApiCallMethods.getTopHomeBannerList().then((value) async {
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
          lstclsBannermodel = List<clsBannermodel>.from(
              value.data.map((e) => clsBannermodel.fromJson(e)));
          if (lstclsBannermodel.isNotEmpty) {
            lstfilterBannermodel1 = lstclsBannermodel
                .where((element) => element.bannerSlider == "1")
                .toList();
            lstfilterBannermodel2 = lstclsBannermodel
                .where((element) => element.bannerSlider == "2")
                .toList();
          }

          setState(() {});
        }

        await Future.delayed(Duration(seconds: 2));
        setState(() {});
      }
    });
  }

  getTileCategoryList() {
    clsApiCallMethods.getTileCategory().then((value) {
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
          lstclsTileCategoryModel = List<clsTileCategoryModel>.from(
              value.data.map((e) => clsTileCategoryModel.fromJson(e)));
          setState(() {});
        }
      }
    });
  }

  getNavCategoryList() {
    clsApiCallMethods.getNavCategory().then((value) {
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
          lstclsNavCategoryModel = List<clsNavCategoryModel>.from(
              value.data.map((e) => clsNavCategoryModel.fromJson(e)));
          setState(() {});
        }
      }
    });
  }

  getProductCollections() {
    ShowLoader(context);
    clsApiCallMethods.getProductCollections().then((value) {
      CancelLoader(context);
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
          lstclsCollectionModel = List<clsCollectionModel>.from(
              value.data.map((e) => clsCollectionModel.fromJson(e)));
          if (lstclsCollectionModel.isNotEmpty) {
            lstclsCollectionModel.asMap().forEach((index, element) {
              getProductCollectionsItems(
                  objclsCollectionModel: element, index: index);
            });
          }
        }
      }
    });
  }

  getProductCollectionsItems(
      {required clsCollectionModel objclsCollectionModel,
      required int index,
      int page = 1}) {
    ShowLoader(context);
    clsApiCallMethods
        .getProductCollectionsItems(
            strKeywords: objclsCollectionModel.keyword!, page: page)
        .then((value) {
      CancelLoader(context);
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
          List<clsProductModel> lstclsProductModel = List<clsProductModel>.from(
              value.data.map((e) => clsProductModel.fromJson(e)));
          if (lstclsProductModel.isNotEmpty) {
            objclsCollectionModel.lstclsProductModel ??= [];
            lstclsProductModel.map((e) {
              objclsCollectionModel.lstclsProductModel?.add(e);
            }).toList();
          }
        }
      }
      if ((index + 1) == lstclsCollectionModel.length) {
        Future.delayed(const Duration(milliseconds: 500), () {
          setState(() {});
        });
      }
    });
  }

  returnProductComponents() {
    double width = MediaQuery.of(context).size.width;
    debugPrint('item_width $width');
    double productItemWidth = 200;
    bool isOnlyTwoItem = false;
    if(productItemWidth * 3 > width){
      isOnlyTwoItem = true;
    }
    
    List<Widget> lstWidget = <Widget>[];

    lstclsCollectionModel.asMap().forEach((index, element) {
      if (index == 1 && lstfilterBannermodel2.isNotEmpty) {
        lstWidget.add(
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height *
                  0.15, // <-- you should put some value here
              constraints: const BoxConstraints(maxHeight: 200),
              child: CarouselSlider.builder(
                itemCount: lstfilterBannermodel2.length,
                itemBuilder: ((context, index, realIndex) {
                  return Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      child: InkWell(
                          onTap: () {
                            if(lstfilterBannermodel2[index]
                                .bannerLink
                                .toString().isNotEmpty)
                              {
                                _launchUrlBanner(
                                    strURl: lstfilterBannermodel2[index]
                                        .bannerLink
                                        .toString())
                                    .whenComplete(() {});
                              }

                          },
                          child: Image.network(
                            lstfilterBannermodel2[index].bannerImg.toString(),
                            width: double.infinity,
                            fit: BoxFit.fill,
                          )));
                }),
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: false,
                  viewportFraction: 1,
                  aspectRatio: 2.0,
                  initialPage: 2,
                  disableCenter: true,
                ),
              )),
        );
      }

      lstWidget.add(Padding(
        padding: const EdgeInsets.all(clsDimensConstants.douDp14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              element.name ?? "",
              style: GoogleFonts.montserrat(
                  fontSize: clsDimensConstants.douDp14,
                  fontWeight: FontWeight.w500),
            ),
            if (element.lstclsProductModel != null)
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => clsProductPageUI(
                                keyword: element.keyword,
                                isCollectionApiCall: true,
                                strHeading: element.name,
                                objclsTileCategoryModel:
                                    lstclsTileCategoryModel[index],
                                widgetlstclsProductModel:
                                    element.lstclsProductModel!,
                              )));
                },
                child: Container(
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(clsDimensConstants.douDp10)),
                        gradient: LinearGradient(colors: [
                          Theme.of(context).primaryColor,
                          Theme.of(context).primaryColor
                        ])),
                    child: Center(
                        child: Text(
                      "View All",
                      style: GoogleFonts.montserrat(
                          fontSize: clsDimensConstants.douDp10,
                          color: Colors.white),
                    ))),
              ),
          ],
        ),
      ));
      if (element.lstclsProductModel != null) {
        if (element.lstclsProductModel!.isNotEmpty) {
          element.lstclsProductModel!.forEach((elementsub) {
            lstWidget.add(InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => clsProductDetailsPageUI(
                              objclsProductModel: elementsub,
                            )));
              },
              child: Container(
                constraints: isOnlyTwoItem ? null : BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.50
                ),
                child: Padding(
                  padding: index == 0
                      ? EdgeInsets.only(left: 2, right: 2, top: 4, bottom: 4)
                      : EdgeInsets.all(4.0),
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
                                  offset:
                                      Offset(0, 1), // changes position of shadow
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
                            children: [
                              SizedBox(
                                height: 190,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      height: 140,
                                      child: ((elementsub.productImages ?? [])
                                                  .length >
                                              0)
                                          ? Image.network(
                                              elementsub.productImages![0]
                                                  .toString(),
                                              height: 100,
                                            )
                                          : null,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: clsDimensConstants.douDp10,
                                          right: clsDimensConstants.douDp10),
                                      child: Text(
                                        elementsub.productName ?? "",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.montserrat(
                                            fontSize: clsDimensConstants.douDp12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: clsDimensConstants.douDp10,
                                    right: clsDimensConstants.douDp10,
                                    bottom: clsDimensConstants.douDp10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    elementsub.productComputedListprice == null || elementsub.productPriceSale == null
                                        ? const SizedBox()
                                        : Padding(
                                            padding:
                                                const EdgeInsets.only(bottom: 6),
                                            child: RichText(
                                              text: TextSpan(children: [
                                                TextSpan(
                                                  text: "Before ",
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: clsDimensConstants
                                                          .douDp12,
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.grey),
                                                ),
                                                elementsub.productComputedListprice ==
                                                        null
                                                    ? TextSpan()
                                                    : TextSpan(
                                                        text:
                                                            "₱ ${CommaSeparatedAmount(elementsub.productComputedListprice)}",
                                                        style: GoogleFonts.montserrat(
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                            fontSize:
                                                                clsDimensConstants
                                                                    .douDp12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.grey),
                                                      )
                                              ]),
                                            ),
                                          ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                                text:
                                                    "₱ ${CommaSeparatedAmount(elementsub.productSrp ?? "0")}",
                                                style: TextStyle(
                                                    fontSize: clsDimensConstants
                                                        .douDp12,
                                                    fontWeight: FontWeight.w500,
                                                    color: Theme.of(context)
                                                        .primaryColor)),
                                          ]),
                                        ),
                                        Row(
                                          children: returnStarRating(
                                              strProductRating: (elementsub
                                                          .productRating ??
                                                      (elementsub
                                                              .product_rating_unknownfield_s ??
                                                          "0"))
                                                  .toString()),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (elementsub.productPriceSale != null)
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                      clsDimensConstants.douDp15)),
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
                                  "${elementsub.productPriceSale}% off",
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
            ));
          });
        }
      } else {
        lstWidget.add(Text("No Products Found"));
      }
    });

    return SingleChildScrollView(
      primary: false,
      child: Wrap(
        alignment: WrapAlignment.center,
        children: lstWidget,
      ),
    );
    // return GridView(
    //   primary: false,
    //   shrinkWrap: true,
    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount
    //   (crossAxisCount: 2),
    //   // alignment: WrapAlignment.center,
    //   children: lstWidget,
    // );
  }

  returnStarRating({required String strProductRating}) {
    List<Widget> lstFullStar = <Widget>[];
    lstFullStar.clear();
    if (strProductRating == "0") {
      for (int i = 0; i < 5; i++) {
        lstFullStar.add(Icon(
          Icons.star_outline,
          color: Colors.orange,
          size: 15,
        ));
      }
    }

    var parts = strProductRating.split('.');

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

  getProductSearchApi(String strproductkeyword) {
    ShowLoader(context);
    clsApiCallMethods
        .getProductSearch(productkeyword: strproductkeyword)
        .then((value) {
      CancelLoader(context);
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
          lstclsProductModel = List<clsProductModel>.from(
              value.data["rows"].map((e) => clsProductModel.fromJson(e)));
          if (lstclsProductModel != null) {
            if (lstclsProductModel!.isNotEmpty) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => clsProductPageUI(
                            isSearch: true,
                            keyword: strproductkeyword,
                            isCollectionApiCall: true,
                            strHeading: strproductkeyword,
                            objclsTileCategoryModel: null,
                            widgetlstclsProductModel: lstclsProductModel,
                          )));
            }
          }
          setState(() {});
        }
      }
    });
  }
}
