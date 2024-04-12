import 'package:ecommerce/localStorage/clsSharedPrefernce.dart';
import 'package:ecommerce/models/clsProductModel.dart';
import 'package:ecommerce/network/clsApiCallMethods.dart';
import 'package:ecommerce/pages/clsProductDetailsPageUI.dart';
import 'package:ecommerce/pages/clsSplashPageUI.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:uni_links/uni_links.dart';

import 'pages/clsHomePageUI.dart';

bool _initialUriIsHandled = false;
final GlobalKey<NavigatorState> navigatorKey =  GlobalKey<NavigatorState>();




void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await clsApiCallMethods().Initialization();
  await clsSharedPrefernce.Init();
  await Firebase.initializeApp();
  // FlutterBranchSdk.validateSDKIntegration();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Galleon Shopping Online',
      theme: ThemeData(
        primaryColor: Colors.orange,
      ),
      home:  const clsSplashPageUI(),
    );
  }
}


class ScaffoldWrapper extends StatelessWidget {
 ScaffoldWrapper({super.key, required this.body,
  this.appBar, this.backgroundColor,
  this.bottomNavigationBar
 });
  final Widget body;
  final PreferredSizeWidget? appBar; 
  final Color? backgroundColor;

  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      appBar: appBar,
      backgroundColor: backgroundColor,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: FloatingActionButton(
        backgroundColor:  Colors.transparent,
        onPressed: (){
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> const clsHomePageUI()), (route) => false);
        },
        child: const Icon(Icons.home,color: Colors.white,),
      ),
    );
  }
}

