import 'package:badges/badges.dart';
import 'package:ecommerce/constants/clsCommonWidget.dart';
import 'package:ecommerce/constants/clsDimensConstants.dart';
import 'package:ecommerce/localStorage/clsSharedPrefernce.dart';
import 'package:ecommerce/localStorage/clsSharedPrefernceKeyValue.dart';
import 'package:ecommerce/network/clsApiCallMethods.dart';
import 'package:ecommerce/pages/clsGetAddressPageUI.dart';
import 'package:ecommerce/pages/clsLoginPageUI.dart';
import 'package:ecommerce/pages/collections&wishlist/clsCollection&wishlistPageUI.dart';
import 'package:ecommerce/pages/orders/clsOrdersPageUI.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../main.dart';
import '../../my_webview.dart';
import '../clsCartPageUI.dart';
import '../clschangePassword.dart';
import 'clsProfileDetailsEdit.dart';

class clsProfilePageUI extends StatefulWidget {
  const clsProfilePageUI({Key? key}) : super(key: key);

  @override
  State<clsProfilePageUI> createState() => _clsProfilePageUIState();
}

class _clsProfilePageUIState extends State<clsProfilePageUI> {
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
          "My Profile",
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
                // badgeStyle: BadgeStyle(badgeColor: Theme.of(context).primaryColor),
                position: BadgePosition.topEnd(),
                badgeContent: Text(
                  clsSharedPrefernce.objSharedPrefs!.getString(clsSharedPrefernceKeyValue.ITEMS_IN_CART) ?? "",
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            color: Color(0XFFFEE3C8),
                            height: 100,
                          ),
                          Container(
                            color: Colors.white,
                            height: 100,
                          )
                        ],
                      ),
                      Center(
                          child: Padding(
                              padding: const EdgeInsets.only(top: 40),
                              child: Container(
                                  color: Colors.grey,
                                  height: 100,
                                  width: 120,
                                  child: Icon(
                                    Icons.person,
                                    size: 120,
                                    color: Colors.grey[200],
                                  ))
                              // child: Image.asset("assets/images/profile_detail.png",width: 130,),
                              ))
                    ],
                  ),
                ),

                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => clsOrdersPageUI()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/order.png",
                              width: 30,
                              height: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [Align(alignment: Alignment.centerLeft, child: Text("My Orders")), Text("Order Details")],
                            ),
                          ],
                        ),
                      ),
                      Align(alignment: Alignment.centerRight, child: Icon(Icons.arrow_forward_ios)),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ClsCollectionPageUI()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/collections.png",
                              width: 30,
                              height: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(alignment: Alignment.centerLeft, child: Text("Wishlist")),
                                Text("All your selected products")
                              ],
                            ),
                          ],
                        ),
                      ),
                      Align(alignment: Alignment.centerRight, child: Icon(Icons.arrow_forward_ios)),
                    ],
                  ),
                ),
                // InkWell(
                //   onTap: (){
                //     // Navigator.push(context, MaterialPageRoute(builder: (context)=>clsWalletPageUI(
                //     // )));
                //   },
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Row(
                //           children: [
                //             Image.asset("assets/images/wallets.png",width: 30,height: 20,),
                //             SizedBox(
                //               width: 10,
                //             ),
                //             Column(
                //               mainAxisAlignment: MainAxisAlignment.start,
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Align(alignment:Alignment.centerLeft,child: Text("Galleon Wallets")),
                //                 Text("Manage Your gift cards & refunds")
                //               ],
                //             ),
                //           ],
                //         ),
                //       ),
                //       Align(alignment: Alignment.centerRight,child: Icon(Icons.arrow_forward_ios)),
                //     ],
                //   ),
                // ),
                // InkWell(
                //   onTap: (){
                //     Navigator.push(context, MaterialPageRoute(builder: (context)=>clsCardsPageUI()));
                //   },
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Row(
                //           children: [
                //             Image.asset("assets/images/cards.png",width: 30,height: 20,),
                //             SizedBox(
                //               width: 10,
                //             ),
                //             Column(
                //               mainAxisAlignment: MainAxisAlignment.start,
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Align(alignment:Alignment.centerLeft,child: Text("Saved Cards")),
                //                 Text("Manage Your cards for faster checkout")
                //               ],
                //             ),
                //           ],
                //         ),
                //       ),
                //       Align(alignment: Alignment.centerRight,child: Icon(Icons.arrow_forward_ios)),
                //     ],
                //   ),
                // ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => clsGetAddressPageUI()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/address.png",
                              width: 30,
                              height: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(alignment: Alignment.centerLeft, child: Text("Addresses")),
                                Text("")
                              ],
                            ),
                          ],
                        ),
                      ),
                      Align(alignment: Alignment.centerRight, child: Icon(Icons.arrow_forward_ios)),
                    ],
                  ),
                ),

                // InkWell(
                //   onTap: (){
                //     Navigator.push(context, MaterialPageRoute(builder: (context)=>clsCompanyCouponPageUI()));
                //   },
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Row(
                //           children: [
                //             Image.asset("assets/images/coupon.png",width: 30,height: 20,),
                //             SizedBox(
                //               width: 10,
                //             ),
                //             Column(
                //               mainAxisAlignment: MainAxisAlignment.start,
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Align(alignment:Alignment.centerLeft,child: Text("Coupons")),
                //                 Text("Manage Coupons for extra discounts")
                //               ],
                //             ),
                //           ],
                //         ),
                //       ),
                //       Align(alignment: Alignment.centerRight,child: Icon(Icons.arrow_forward_ios)),
                //     ],
                //   ),
                // ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => clsProfileDetailsEdit()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/profile_detail.png",
                              width: 30,
                              height: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(alignment: Alignment.centerLeft, child: Text("Profile Details")),
                                Text("Change your profile")
                              ],
                            ),
                          ],
                        ),
                      ),
                      Align(alignment: Alignment.centerRight, child: Icon(Icons.arrow_forward_ios)),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => clschangePassword()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            Icon(
                              Icons.password,
                              size: 24,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(alignment: Alignment.centerLeft, child: Text("Change Password")),
                                // Text("Change your profile & password")
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Align(alignment: Alignment.centerRight,child: Icon(Icons.arrow_forward_ios)),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    showExitDialog(context).then((value) {
                      if (value) {
                        clsSharedPrefernce.objSharedPrefs!.clear();
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => clsLoginPageUI()), (route) => false);
                      }
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            Icon(
                              Icons.logout_outlined,
                              size: 24,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(alignment: Alignment.centerLeft, child: Text("Logout")),
                                // Text("Change your profile & password")
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Align(alignment: Alignment.centerRight,child: Icon(Icons.arrow_forward_ios)),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.dialog(AlertDialog(
                      title: Text("Do you want to delete your accout?"),
                      actions: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                              side: BorderSide(color: Colors.blue),
                            ))
                          ),
                          onPressed: (){
                          Navigator.pop(context);
                        }, child: Text("Cancel",
                          style: TextStyle(color: Colors.blue),
                        )),
                        ElevatedButton(onPressed: ()async{
                          Navigator.pop(context);
                          ShowLoader(context);
                          await clsApiCallMethods.DeleteAccount();
                          CancelLoader(context);
                        clsSharedPrefernce.objSharedPrefs!.clear();
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => clsLoginPageUI()), (route) => false);
                      
                        }, child: Text("Yes")),
                      ],
                    ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.backpack_sharp,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(alignment: Alignment.centerLeft, child: Text("Delete Account")),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    _launchUrl(strURl: "https://galleonph.zendesk.com/hc/en-us?mobile_view=true",
                      title: "FAQ"
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.backpack_sharp,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(alignment: Alignment.centerLeft, child: Text("FAQ")),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    _launchUrl(strURl: "https://www.galleon.ph/document/about-us?mobile_view=true",
                      title: "About Us"
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.backpack_sharp,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(alignment: Alignment.centerLeft, child: Text("ABOUT US")),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    _launchUrl(strURl: "https://www.galleon.ph/document/terms-and-conditions?mobile_view=true",
                      title: "Terms & Conditions"
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.backpack_sharp,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(alignment: Alignment.centerLeft, child: Text("Terms & Conditions")),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    _launchUrl(strURl: "https://www.galleon.ph/document/privacy-policy?mobile_view=true",
                      title: "Customer Policies"
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.backpack_sharp,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(alignment: Alignment.centerLeft, child: Text("Customer Policies")),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future showExitDialog(BuildContext context) async {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(clsDimensConstants.douDp10))),
      title: Text(
        "Exit",
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      content: const Text("Are you sure you want to exit?"),
      actions: [
        TextButton(
          child: const Text("Yes"),
          onPressed: () {
            // preferences.remove("");
            // preferences.clear();
            // SystemNavigator.pop();
            Navigator.pop(context, true);
          },
        ),
        TextButton(
          child: Text("No"),
          onPressed: () {
            Navigator.pop(context, false);
            // locationfetchCheck(REQUEST_CODE: 302);
          },
        )
      ],
    );

    // show the dialog
    var res = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
    return res;
  }

  Future<void> _launchUrl({required String strURl, String? title}) async {
    Navigator.push(context, MaterialPageRoute(builder: (context)=> MyWebView(url: strURl,
       title: title,
    )));
  }
}
