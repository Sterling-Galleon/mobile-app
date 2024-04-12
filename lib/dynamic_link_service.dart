import 'package:ecommerce/pages/clsProductDetailsPageUI.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import 'models/clsProductModel.dart';

class DynamicLinkService {
  static DynamicLinkService? _instance;


  DynamicLinkService._(){
   
  }

  factory DynamicLinkService() => _instance ??= DynamicLinkService._();
}