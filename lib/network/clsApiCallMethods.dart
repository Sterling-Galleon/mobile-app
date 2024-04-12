// ignore_for_file: camel_case_types, non_constant_identifier_names, file_names, no_leading_underscores_for_local_identifiers

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce/models/clsCommonResposneModel.dart';
import 'package:ecommerce/network/clsApiUrls.dart';
import 'package:ecommerce/localStorage/clsSharedPrefernceKeyValue.dart';
import 'package:ecommerce/localStorage/clsSharedPrefernce.dart';
import 'package:flutter/foundation.dart';

class clsApiCallMethods {
  static Dio? dio;

  // dio initialization
  Initialization() {
    dio ??= Dio();
    dio?.options.headers = GetHeadersValue();
    // dio?.options.headers[HttpHeaders.authorizationHeader] = "Basic";
  }

  // header method for passing value in dio?.options.headers
  static GetHeadersValue() {
    Map<String, dynamic> objHeadermap = <String, dynamic>{};
    objHeadermap['Content-Type'] = 'application/x-www-form-urlencoded';
    return objHeadermap;
  }

  static Future<bool> checkConectivity() async {
    var isConnected = false;
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result != ConnectivityResult.none) {
        isConnected = true;
      } else {
        isConnected = false;
      }
    });
    return isConnected;
  }

  //network connectivity check method call before any api call
  static Future<bool> NetworkConnectivityCheck() async {
    var objConnectivityResult = await (Connectivity().checkConnectivity());
    if (objConnectivityResult == ConnectivityResult.mobile ||
        objConnectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }

  static clsCommonResponseModel CastCommonResponse(String strApiCallResponse, {bool isCollectionItemsApi = false}) {
    return clsCommonResponseModelFromJson(strApiCallResponse.toString(), isCollectionItemsApi : isCollectionItemsApi);
  }

  static Future<clsCommonResponseModel> SocialLoginMethod(
      Map<String, String> objMap) async {
    try {
      dio?.options.headers = GetHeadersValue();
      var objdioresposne =
          await dio?.post(clsApiUrls.SOCIAL_LOGIN, data: objMap);
      if (objdioresposne?.statusCode == 200) {
        return clsApiCallMethods.CastCommonResponse(objdioresposne.toString());
      } else {
        return clsCommonResponseModel(
            error: "false", messages: ["Error Occurs"], data: [""]);
      }
    } on Exception {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    } catch (e) {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    }
  }

  static Future<clsCommonResponseModel> LoginMethod(
      Map<String, String> objMap) async {
    try {
      dio?.options.headers = GetHeadersValue();
      var objdioresposne = await dio?.post(clsApiUrls.LOGIN_API, data: objMap);
      if (objdioresposne?.statusCode == 200) {
        return clsApiCallMethods.CastCommonResponse(objdioresposne.toString());
      } else {
        return clsCommonResponseModel(
            error: "false", messages: ["Error Occurs"], data: [""]);
      }
    } on Exception {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    } catch (e) {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    }
  }

  static Future<clsCommonResponseModel> ChangePassword(
      Map<String, String> objMap) async {
    try {
      dio?.options.headers = GetHeadersValue();
      var objdioresposne = await dio?.post(
          clsApiUrls.CHANGE_PASSWORD +
              clsSharedPrefernce.objSharedPrefs!
                  .get(clsSharedPrefernceKeyValue.USER_TOKEN)
                  .toString(),
          data: objMap);
      if (objdioresposne?.statusCode == 200) {
        return clsApiCallMethods.CastCommonResponse(objdioresposne.toString());
      } else {
        return clsCommonResponseModel(
            error: "false", messages: ["Error Occurs"], data: [""]);
      }
    } on Exception {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    } catch (e) {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    }
  }

  static Future<clsCommonResponseModel> ForgetPassword(
      Map<String, String> objMap) async {
    try {
      dio?.options.headers = GetHeadersValue();
      var objdioresposne =
          await dio?.post(clsApiUrls.FORGET_PASSWORD_API, data: objMap);
      if (objdioresposne?.statusCode == 200) {
        return clsApiCallMethods.CastCommonResponse(objdioresposne.toString());
      } else {
        return clsCommonResponseModel(
            error: "false", messages: ["Error Occurs"], data: [""]);
      }
    } on Exception {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    } catch (e) {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    }
  }

  static Future<clsCommonResponseModel> SaveAddress(
      Map<String, String> objMap) async {
    try {
      dio?.options.headers = GetHeadersValue();
      var objdioresposne = await dio?.post(
          clsApiUrls.SAVE_ADDRESS +
              clsSharedPrefernce.objSharedPrefs!
                  .get(clsSharedPrefernceKeyValue.USER_TOKEN)
                  .toString(),
          data: objMap);
      if (objdioresposne?.statusCode == 200) {
        return clsApiCallMethods.CastCommonResponse(objdioresposne.toString());
      } else {
        return clsCommonResponseModel(
            error: "false", messages: ["Error Occurs"], data: [""]);
      }
    } on Exception {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    } catch (e) {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    }
  }

  static Future<clsCommonResponseModel> RegisterUserMethod(
      Map<String, String> objMap) async {
    try {
      dio?.options.headers = GetHeadersValue();
      var objdioresposne =
          await dio?.post(clsApiUrls.REGISTER_USER, data: objMap);
      if (objdioresposne?.statusCode == 200) {
        return clsApiCallMethods.CastCommonResponse(objdioresposne.toString());
      } else {
        return clsCommonResponseModel(
            error: "false", messages: ["Error Occurs"], data: [""]);
      }
    } on Exception {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    } catch (e) {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    }
  }

  static Future<clsCommonResponseModel> OTPMethod(
      Map<String, String> objMap) async {
    try {
      dio?.options.headers = GetHeadersValue();
      var objdioresposne = await dio?.post(clsApiUrls.OTP, data: objMap);
      if (objdioresposne?.statusCode == 200) {
        return clsApiCallMethods.CastCommonResponse(objdioresposne.toString());
      } else {
        return clsCommonResponseModel(
            error: "false", messages: ["Error Occurs"], data: [""]);
      }
    } on Exception {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    } catch (e) {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    }
  }

  static Future<clsCommonResponseModel> getTopHomeBannerList() async {
    try {
      dio?.options.headers = GetHeadersValue();
      var objdioresposne = await dio?.get(clsApiUrls.BANNER);
      if (objdioresposne?.statusCode == 200) {
        return clsApiCallMethods.CastCommonResponse(objdioresposne.toString());
      } else {
        return clsCommonResponseModel(
            error: "false", messages: ["Error Occurs"], data: [""]);
      }
    } on Exception {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    } catch (e) {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    }
  }

  static Future<clsCommonResponseModel> getProductCollections() async {
    try {
      dio?.options.headers = GetHeadersValue();
      var objdioresposne = await dio?.get(clsApiUrls.GET_PRODUCT_COLLECTIONS);
      if (objdioresposne?.statusCode == 200) {
        return clsApiCallMethods.CastCommonResponse(objdioresposne.toString());
      } else {
        return clsCommonResponseModel(
            error: "false", messages: ["Error Occurs"], data: [""]);
      }
    } on Exception {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    } catch (e) {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    }
  }

  static Future<clsCommonResponseModel> getProductByProductId(
      {required String strProductId}) async {
    try {
      dio?.options.headers = GetHeadersValue();
      debugPrint('url_api ${clsApiUrls.GET_PRODUCT_DETAILS_BY_PRODUCT_ID + strProductId}');
      var objdioresposne = await dio
          ?.get(clsApiUrls.GET_PRODUCT_DETAILS_BY_PRODUCT_ID + strProductId);
      if (objdioresposne?.statusCode == 200) {
        return clsApiCallMethods.CastCommonResponse(objdioresposne.toString());
      } else {
        return clsCommonResponseModel(
            error: "false", messages: ["Error Occurs"], data: [""]);
      }
    } on Exception {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    } catch (e) {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    }
  }

  static Future<clsCommonResponseModel> getCategories() async {
    try {
      dio?.options.headers = GetHeadersValue();
      var objdioresposne = await dio?.get(clsApiUrls.GET_ALL_CATEGORIES);
      if (objdioresposne?.statusCode == 200) {
        return clsApiCallMethods.CastCommonResponse(objdioresposne.toString());
      } else {
        return clsCommonResponseModel(
            error: "false", messages: ["Error Occurs"], data: [""]);
      }
    } on Exception {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    } catch (e) {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    }
  }

  static Future<clsCommonResponseModel> getProductCollectionsItems(
      {required String strKeywords, int page = 1}) async {
    try {
      dio?.options.headers = GetHeadersValue();
      var objdioresposne = await dio?.get(
          "${clsApiUrls.GET_PRODUCT_COLLECTIONS_ITEMS}$strKeywords&page=$page");
      if (objdioresposne?.statusCode == 200) {
        return clsApiCallMethods.CastCommonResponse(objdioresposne.toString());
      } else {
        return clsCommonResponseModel(
            error: "false", messages: ["Error Occurs"], data: [""]);
      }
    } on Exception {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    } catch (e) {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    }
  }

  static Future<clsCommonResponseModel> getNavCategory() async {
    try {
      dio?.options.headers = GetHeadersValue();
      var objdioresposne = await dio?.get(clsApiUrls.NAV_CATEGORY);
      if (objdioresposne?.statusCode == 200) {
        return clsApiCallMethods.CastCommonResponse(objdioresposne.toString());
      } else {
        return clsCommonResponseModel(
            error: "false", messages: ["Error Occurs"], data: [""]);
      }
    } on Exception {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    } catch (e) {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    }
  }

  static Future<clsCommonResponseModel> getAllAddresses() async {
    try {
      dio?.options.headers = GetHeadersValue();
      var objdioresposne = await dio?.get(clsApiUrls.GET_ALL_ADDRESSES +
          clsSharedPrefernce.objSharedPrefs!
              .get(clsSharedPrefernceKeyValue.USER_TOKEN)
              .toString());
      if (objdioresposne?.statusCode == 200) {
        return clsApiCallMethods.CastCommonResponse(objdioresposne.toString());
      } else {
        return clsCommonResponseModel(
            error: "false", messages: ["Error Occurs"], data: [""]);
      }
    } on Exception {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    } catch (e) {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    }
  }

  static Future<clsCommonResponseModel> deleteAddress(
      Map<String, String> objMap) async {
    try {
      dio?.options.headers = GetHeadersValue();
      var objdioresposne = await dio?.post(
          clsApiUrls.DELETE_ADDRESS +
              clsSharedPrefernce.objSharedPrefs!
                  .get(clsSharedPrefernceKeyValue.USER_TOKEN)
                  .toString(),
          data: objMap);
      if (objdioresposne?.statusCode == 200) {
        return clsApiCallMethods.CastCommonResponse(objdioresposne.toString());
      } else {
        return clsCommonResponseModel(
            error: "false", messages: ["Error Occurs"], data: [""]);
      }
    } on Exception {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    } catch (e) {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    }
  }

  static Future<clsCommonResponseModel> getTileCategory() async {
    try {
      dio?.options.headers = GetHeadersValue();
      var objdioresposne = await dio?.get(clsApiUrls.TILE_CATEGORY);
      if (objdioresposne?.statusCode == 200) {
        return clsApiCallMethods.CastCommonResponse(objdioresposne.toString());
      } else {
        return clsCommonResponseModel(
            error: "false", messages: ["Error Occurs"], data: [""]);
      }
    } on Exception {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    } catch (e) {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    }
  }
  // promotionEndPoint
    static Future<clsCommonResponseModel> getPromotionData() async {
    try {
      dio?.options.headers = GetHeadersValue();
      var objdioresposne = await dio?.get(clsApiUrls.promotionEndPoint);
      if (objdioresposne?.statusCode == 200) {
        return clsApiCallMethods.CastCommonResponse(objdioresposne.toString());
      } else {
        return clsCommonResponseModel(
            error: "false", messages: ["Error Occurs"], data: [""]);
      }
    } on Exception {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    } catch (e) {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    }
  }

  static Future<clsCommonResponseModel> getProductSearch(
      {required String productkeyword, int page = 1}) async {
    try {
      dio?.options.headers = GetHeadersValue();
      var objdioresposne = await dio
          ?.get("${clsApiUrls.PRODUCT_SEARCH}$productkeyword&page=$page");
      if (objdioresposne?.statusCode == 200) {
        return clsApiCallMethods.CastCommonResponse(objdioresposne.toString());
      } else {
        return clsCommonResponseModel(
            error: "false", messages: ["Error Occurs"], data: [""]);
      }
    } on Exception {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    } catch (e) {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    }
  }

  static Future<clsCommonResponseModel> getProductByCategoryId(
      {required String strcategory_id, int pageNo = 1,String? link}) async {
    try {
      dio?.options.headers = GetHeadersValue();
      bool isCollectionItemsApi = false;
      List pathList = (link??'').split('/');
      String apiEndpoint = pathList[pathList.length-1].toString().replaceAll('-c0', '');
      String apiUrl = '';
      if(strcategory_id == '0'){
        isCollectionItemsApi = true;
        apiUrl = '${clsApiUrls.GET_PRODUCT_COLLECTIONS_ITEMS}$apiEndpoint&page=${pageNo.toString()}';
      }
      else if(strcategory_id.isEmpty){
        apiUrl = "${clsApiUrls.PRODUCT_SEARCH}$apiEndpoint&page=${pageNo.toString()}";
      }
      else{
        apiUrl = "${clsApiUrls.GET_PRODUCT_BY_CATEGORY_ID}$strcategory_id?page=${pageNo.toString()}";
      }
      var objdioresposne = await dio?.get(apiUrl);
      if (objdioresposne?.statusCode == 200) {
        return clsApiCallMethods.CastCommonResponse(objdioresposne.toString(), isCollectionItemsApi : isCollectionItemsApi);
      } else {
        return clsCommonResponseModel(
            error: "false", messages: ["Error Occurs"], data: [""]);
      }
    } on Exception {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    } catch (e) {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    }
  }

  static Future<clsCommonResponseModel> getCartInformation() async {
    try {
      dio?.options.headers = GetHeadersValue();
      var objdioresposne = await dio?.get(clsApiUrls.GET_CART_INFORMATION +
          clsSharedPrefernce.objSharedPrefs!
              .get(clsSharedPrefernceKeyValue.USER_TOKEN)
              .toString());
      if (objdioresposne?.statusCode == 200) {
        return clsApiCallMethods.CastCommonResponse(objdioresposne.toString());
      } else {
        return clsCommonResponseModel(
            error: "false", messages: ["Error Occurs"], data: [""]);
      }
    } on Exception {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    } catch (e) {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    }
  }

  static Future<clsCommonResponseModel> getRegionByState(
      {required String strStateName}) async {
    try {
      dio?.options.headers = GetHeadersValue();
      var objdioresposne =
          await dio?.get(clsApiUrls.GET_REGION_BY_STATE + strStateName);
      if (objdioresposne?.statusCode == 200) {
        return clsApiCallMethods.CastCommonResponse(objdioresposne.toString());
      } else {
        return clsCommonResponseModel(
            error: "false", messages: ["Error Occurs"], data: [""]);
      }
    } on Exception {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    } catch (e) {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    }
  }

  static Future<clsCommonResponseModel> removecartItem(
      Map<String, String> objMap) async {
    try {
      dio?.options.headers = GetHeadersValue();
      var objdioresposne = await dio?.post(
          clsApiUrls.REMOVE_CART_ITEM +
              clsSharedPrefernce.objSharedPrefs!
                  .get(clsSharedPrefernceKeyValue.USER_TOKEN)
                  .toString(),
          data: objMap);
      if (objdioresposne?.statusCode == 200) {
        return clsApiCallMethods.CastCommonResponse(objdioresposne.toString());
      } else {
        return clsCommonResponseModel(
            error: "false", messages: ["Error Occurs"], data: [""]);
      }
    } on Exception {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    } catch (e) {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    }
  }

  static Future<clsCommonResponseModel> removeAllCoupons() async {
    try {
      dio?.options.headers = GetHeadersValue();
      var objdioresposne = await dio?.post(
        clsApiUrls.REMOVE_ALL_COUPONS +
            clsSharedPrefernce.objSharedPrefs!
                .get(clsSharedPrefernceKeyValue.USER_TOKEN)
                .toString(),
      );
      if (objdioresposne?.statusCode == 200) {
        return clsApiCallMethods.CastCommonResponse(objdioresposne.toString());
      } else {
        return clsCommonResponseModel(
            error: "false", messages: ["Error Occurs"], data: [""]);
      }
    } on Exception {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    } catch (e) {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    }
  }

  static Future<clsCommonResponseModel> getStateList() async {
    try {
      dio?.options.headers = GetHeadersValue();
      var objdioresposne = await dio?.get(
        clsApiUrls.GET_STATE_LIST,
      );
      if (objdioresposne?.statusCode == 200) {
        return clsApiCallMethods.CastCommonResponse(objdioresposne.toString());
      } else {
        return clsCommonResponseModel(
            error: "false", messages: ["Error Occurs"], data: [""]);
      }
    } on Exception {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    } catch (e) {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    }
  }

  static Future<clsCommonResponseModel> getCityList(
      {required String strStateId}) async {
    try {
      dio?.options.headers = GetHeadersValue();
      var objdioresposne =
          await dio?.get(clsApiUrls.GET_CITY_LIST + strStateId);
      if (objdioresposne?.statusCode == 200) {
        return clsApiCallMethods.CastCommonResponse(objdioresposne.toString());
      } else {
        return clsCommonResponseModel(
            error: "false", messages: ["Error Occurs"], data: [""]);
      }
    } on Exception {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    } catch (e) {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    }
  }

  static Future<clsCommonResponseModel> getBarangayList(
      {required String strCityId}) async {
    try {
      dio?.options.headers = GetHeadersValue();
      var objdioresposne =
          await dio?.get(clsApiUrls.GET_BARANGAY_LIST + strCityId);
      if (objdioresposne?.statusCode == 200) {
        return clsApiCallMethods.CastCommonResponse(objdioresposne.toString());
      } else {
        return clsCommonResponseModel(
            error: "false", messages: ["Error Occurs"], data: [""]);
      }
    } on Exception {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    } catch (e) {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    }
  }

  static Future<clsCommonResponseModel> getOrderDetails(
      {required String Id}) async {
    try {
      dio?.options.headers = GetHeadersValue();
      var objdioresposne = await dio?.get(
          "${clsApiUrls.GET_ORDER_DETAILS}${clsSharedPrefernce.objSharedPrefs!.get(clsSharedPrefernceKeyValue.USER_TOKEN)}&id=$Id");
      if (objdioresposne?.statusCode == 200) {
        return clsApiCallMethods.CastCommonResponse(objdioresposne.toString());
      } else {
        return clsCommonResponseModel(
            error: "false", messages: ["Error Occurs"], data: [""]);
      }
    } on Exception {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    } catch (e) {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    }
  }

  static Future<clsCommonResponseModel> ApplyCartCoupon(
      {required String strCouponCode}) async {
    try {
      dio?.options.headers = GetHeadersValue();
      var objdioresposne = await dio?.post(
          clsApiUrls.APPLY_CART_COUPON +
              clsSharedPrefernce.objSharedPrefs!
                  .get(clsSharedPrefernceKeyValue.USER_TOKEN)
                  .toString(),
          data: {"coupon": strCouponCode});
      if (objdioresposne?.statusCode == 200) {
        return clsApiCallMethods.CastCommonResponse(objdioresposne.toString());
      } else {
        return clsCommonResponseModel(
            error: "false", messages: ["Error Occurs"], data: [""]);
      }
    } on Exception {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    } catch (e) {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    }
  }

  static Future<clsCommonResponseModel> RecalculateCheckout(
      {required dynamic objData}) async {
    try {
      dio?.options.headers = GetHeadersValue();
      var objdioresposne = await dio?.post(
          clsApiUrls.RECALCULATE_CHECK_OUT_ONBASE_OF_SHIPPING_ADDRESS +
              clsSharedPrefernce.objSharedPrefs!
                  .get(clsSharedPrefernceKeyValue.USER_TOKEN)
                  .toString(),
          data: objData);
      if (objdioresposne?.statusCode == 200) {
        return clsApiCallMethods.CastCommonResponse(objdioresposne.toString());
      } else {
        return clsCommonResponseModel(
            error: "false", messages: ["Error Occurs"], data: [""]);
      }
    } on Exception {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    } catch (e) {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    }
  }

  static Future<clsCommonResponseModel>
      RecalculateCheckoutOnBaseofShippingAddress(
          {required dynamic objData}) async {
    try {
      dio?.options.headers = GetHeadersValue();
      var objdioresposne = await dio?.post(
          clsApiUrls.RECALCULATE_CHECK_OUT_ONBASE_OF_SHIPPING_ADDRESS +
              clsSharedPrefernce.objSharedPrefs!
                  .get(clsSharedPrefernceKeyValue.USER_TOKEN)
                  .toString(),
          data: objData);
      if (objdioresposne?.statusCode == 200) {
        return clsApiCallMethods.CastCommonResponse(objdioresposne.toString());
      } else {
        return clsCommonResponseModel(
            error: "false", messages: ["Error Occurs"], data: [""]);
      }
    } on Exception {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    } catch (e) {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    }
  }

  static Future<clsCommonResponseModel> SetCheckoutMethod(
      {required String shippingMethod}) async {
    try {
      dio?.options.headers = GetHeadersValue();
      String token = clsSharedPrefernce.objSharedPrefs!
          .get(clsSharedPrefernceKeyValue.USER_TOKEN)
          .toString();
      var objdioresposne = await dio?.post(
          clsApiUrls.GET_SHIPPING_TYPE(shipping: shippingMethod, token: token));
      if (objdioresposne?.statusCode == 200) {
        return clsApiCallMethods.CastCommonResponse(objdioresposne.toString());
      } else {
        return clsCommonResponseModel(
            error: "false", messages: ["Error Occurs"], data: [""]);
      }
    } on Exception {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    } catch (e) {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    }
  }

  static Future<clsCommonResponseModel> RecalculateCheckoutOnBaseofPayment(
      {required dynamic objData}) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      // dio?.options.headers = GetHeadersValue();
      String token = clsSharedPrefernce.objSharedPrefs!
          .get(clsSharedPrefernceKeyValue.USER_TOKEN)
          .toString();
      var objdioresposne = await dio?.post(
          clsApiUrls.RECALCULATE_CHECK_OUT_ONBASE_OF_PAYMENT_METHOD + token,
          data: objData);
      if (objdioresposne?.statusCode == 200) {
        return clsApiCallMethods.CastCommonResponse(objdioresposne.toString());
      } else {
        return clsCommonResponseModel(
            error: "false", messages: ["Error Occurs"], data: [""]);
      }
    } on Exception {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    } catch (e) {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    }
  }

  static Future<clsCommonResponseModel> PrepareCartForCheckout() async {
    try {
      dio?.options.headers = GetHeadersValue();
      var objdioresposne = await dio?.get(clsApiUrls.PREPARE_CART_FOR_CHECKOUT +
          clsSharedPrefernce.objSharedPrefs!
              .get(clsSharedPrefernceKeyValue.USER_TOKEN)
              .toString());
      if (objdioresposne?.statusCode == 200) {
        return clsApiCallMethods.CastCommonResponse(objdioresposne.toString());
      } else {
        return clsCommonResponseModel(
            error: "false", messages: ["Error Occurs"], data: [""]);
      }
    } on Exception {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    } catch (e) {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    }
  }
  // GET_ADDRESS_BY_REGION

  static Future<clsCommonResponseModel> GetAddressByRegion(
      {required String regionName}) async {
    try {
      dio?.options.headers = GetHeadersValue();
      String _url = clsApiUrls.GET_ADDRESS_BY_REGION + regionName;
      var objdioresposne = await dio?.get(
        _url,
      );
      if (objdioresposne?.statusCode == 200) {
        return clsApiCallMethods.CastCommonResponse(objdioresposne.toString());
      } else {
        return clsCommonResponseModel(
            error: "false", messages: ["Error Occurs"], data: [""]);
      }
    } on Exception {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    } catch (e) {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    }
  }

  static Future<clsCommonResponseModel> CreateOrder(
      {required dynamic objData}) async {
    try {
      dio?.options.headers = GetHeadersValue();
      String _url = clsApiUrls.SUBMIT_ORDER +
          clsSharedPrefernce.objSharedPrefs!
              .get(clsSharedPrefernceKeyValue.USER_TOKEN)
              .toString();
      var objdioresposne = await dio?.post(_url, data: objData);
      if (objdioresposne?.statusCode == 200) {
        return clsApiCallMethods.CastCommonResponse(objdioresposne.toString());
      } else {
        return clsCommonResponseModel(
            error: "false", messages: ["Error Occurs"], data: [""]);
      }
    } on Exception {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    } catch (e) {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    }
  }

  static Future<clsCommonResponseModel> UpdateProfileDetails(
      {required dynamic objData}) async {
    try {
      dio?.options.headers = GetHeadersValue();
      var objdioresposne = await dio?.post(
          clsApiUrls.UPDATE_PROFILE +
              clsSharedPrefernce.objSharedPrefs!
                  .get(clsSharedPrefernceKeyValue.USER_TOKEN)
                  .toString(),
          data: objData);
      if (objdioresposne?.statusCode == 200) {
        return clsApiCallMethods.CastCommonResponse(objdioresposne.toString());
      } else {
        return clsCommonResponseModel(
            error: "false", messages: ["Error Occurs"], data: [""]);
      }
    } on Exception {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    } catch (e) {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    }
  }

  static Future<clsCommonResponseModel> getWishlistProduct() async {
    try {
      dio?.options.headers = GetHeadersValue();
      var objdioresposne = await dio?.get(clsApiUrls.GET_WISHLIST_ITEMS +
          clsSharedPrefernce.objSharedPrefs!
              .get(clsSharedPrefernceKeyValue.USER_TOKEN)
              .toString());
      if (objdioresposne?.statusCode == 200) {
        return clsApiCallMethods.CastCommonResponse(objdioresposne.toString());
      } else {
        return clsCommonResponseModel(
            error: "false", messages: ["Error Occurs"], data: [""]);
      }
    } on Exception {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    } catch (e) {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    }
  }

  static Future<clsCommonResponseModel> getRelatedProductByProductId(
      {required String strProductId}) async {
    try {
      dio?.options.headers = GetHeadersValue();
      var objdioresposne = await dio
          ?.get(clsApiUrls.GET_RELATEDPRODUCT_BY_PRODUCT_ID + strProductId);
      if (objdioresposne?.statusCode == 200) {
        return clsApiCallMethods.CastCommonResponse(objdioresposne.toString());
      } else {
        return clsCommonResponseModel(
            error: "false", messages: ["Error Occurs"], data: [""]);
      }
    } on Exception {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    } catch (e) {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    }
  }

  static Future<clsCommonResponseModel> AddProductInCart(
      Map<String, String> objMap) async {
    try {
      dio?.options.headers = GetHeadersValue();
      var url = clsApiUrls.ADD_TO_CART +
          clsSharedPrefernce.objSharedPrefs!
              .get(clsSharedPrefernceKeyValue.USER_TOKEN)
              .toString();
      var objdioresposne = await dio?.post(url, data: objMap);
      if (objdioresposne?.statusCode == 200) {
        return clsApiCallMethods.CastCommonResponse(objdioresposne.toString());
      } else {
        return clsCommonResponseModel(
            error: "false", messages: ["Error Occurs"], data: [""]);
      }
    } on Exception {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    } catch (e) {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    }
  }

  static Future<clsCommonResponseModel> GiftCard(
      {required String strAction, required dynamic objMap}) async {
    try {
      var data = {};
      var dio = Dio();
      var objdioresposne = await dio.request(
        "${clsApiUrls.GIFT_CARD}${clsSharedPrefernce.objSharedPrefs!.get(clsSharedPrefernceKeyValue.USER_TOKEN)}&action=$strAction",
        options: Options(
          method: 'POST',
        ),
        data: data,
      );
      if (objdioresposne.statusCode == 200) {
        clsCommonResponseModel objclsCommonResponseModel =
            clsApiCallMethods.CastCommonResponse(objdioresposne.toString());

        return objclsCommonResponseModel;
      } else {
        return clsCommonResponseModel(
            error: "false", messages: ["Error Occurs"], data: [""]);
      }
    } on Exception {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    } catch (e) {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    }
  }

  static Future<clsCommonResponseModel> ItemsInCart() async {
    try {
      dio?.options.headers = GetHeadersValue();
      var url = clsApiUrls.ITEMS_IN_CART +
          clsSharedPrefernce.objSharedPrefs!
              .get(clsSharedPrefernceKeyValue.USER_TOKEN)
              .toString();
      var objdioresposne = await dio?.get(url);
      if (objdioresposne?.statusCode == 200) {
        clsCommonResponseModel objclsCommonResponseModel =
            clsApiCallMethods.CastCommonResponse(objdioresposne.toString());
        if (objclsCommonResponseModel.data != null) {
          if (objclsCommonResponseModel.data["items"] != null) {
            if (objclsCommonResponseModel.data["items"].length != null) {
              clsSharedPrefernce.objSharedPrefs!.setString(
                  clsSharedPrefernceKeyValue.ITEMS_IN_CART,
                  objclsCommonResponseModel.data["items"].length.toString());
            }
          }
        }
        return objclsCommonResponseModel;
      } else {
        return clsCommonResponseModel(
            error: "false", messages: ["Error Occurs"], data: [""]);
      }
    } on Exception {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    } catch (e) {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    }
  }

  static Future<clsCommonResponseModel> AddItemsInWhislist(
      Map<String, String> objMap) async {
    try {
      dio?.options.headers = GetHeadersValue();
      var url = clsApiUrls.ADD_ITEMS_IN_WHISLIST +
          clsSharedPrefernce.objSharedPrefs!
              .get(clsSharedPrefernceKeyValue.USER_TOKEN)
              .toString();
      var objdioresposne = await dio?.post(url, data: objMap);
      if (objdioresposne?.statusCode == 200) {
        clsCommonResponseModel objclsCommonResponseModel =
            clsApiCallMethods.CastCommonResponse(objdioresposne.toString());
        if (objclsCommonResponseModel.data != null) {
          // clsSharedPrefernce.objSharedPrefs!.setString(clsSharedPrefernceKeyValue.ITEMS_IN_CART, objclsCommonResponseModel.data["items"].length.toString());
        }
        return objclsCommonResponseModel;
      } else {
        return clsCommonResponseModel(
            error: "false", messages: ["Error Occurs"], data: [""]);
      }
    } on Exception {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    } catch (e) {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    }
  }

  static Future<bool> DeleteAccount() async {
    try {
      dio?.options.headers = GetHeadersValue();
      var url = clsApiUrls.DELETE_ACCOUNT +
          clsSharedPrefernce.objSharedPrefs!
              .get(clsSharedPrefernceKeyValue.USER_TOKEN)
              .toString();
      var objdioresposne = await dio?.post(url);
      if (objdioresposne?.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on Exception {
      return false;
    } catch (e) {
      return false;
    }
  }

  static Future<clsCommonResponseModel> RemoveItemsInWhislist(
      Map<String, String> objMap) async {
    try {
      dio?.options.headers = GetHeadersValue();
      var url = clsApiUrls.REMOVE_ITEMS_IN_WHISLIST +
          clsSharedPrefernce.objSharedPrefs!
              .get(clsSharedPrefernceKeyValue.USER_TOKEN)
              .toString();
      var objdioresposne = await dio?.post(url, data: objMap);
      if (objdioresposne?.statusCode == 200) {
        clsCommonResponseModel objclsCommonResponseModel =
            clsApiCallMethods.CastCommonResponse(objdioresposne.toString());
        if (objclsCommonResponseModel.data != null) {
          // clsSharedPrefernce.objSharedPrefs!.setString(clsSharedPrefernceKeyValue.ITEMS_IN_CART, objclsCommonResponseModel.data["items"].length.toString());
        }
        return objclsCommonResponseModel;
      } else {
        return clsCommonResponseModel(
            error: "false", messages: ["Error Occurs"], data: [""]);
      }
    } on Exception {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    } catch (e) {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    }
  }

  static Future<clsCommonResponseModel> GetOrderLists() async {
    try {
      dio?.options.headers = GetHeadersValue();
      var url =
          "${clsApiUrls.GET_ORDER_LIST}${clsSharedPrefernce.objSharedPrefs!.get(clsSharedPrefernceKeyValue.USER_TOKEN)}&page=1";
      var objdioresposne = await dio?.get(url);
      if (objdioresposne?.statusCode == 200) {
        clsCommonResponseModel objclsCommonResponseModel =
            clsApiCallMethods.CastCommonResponse(objdioresposne.toString());
        if (objclsCommonResponseModel.data != null) {
          // clsSharedPrefernce.objSharedPrefs!.setString(clsSharedPrefernceKeyValue.ITEMS_IN_CART, objclsCommonResponseModel.data["items"].length.toString());
        }
        return objclsCommonResponseModel;
      } else {
        return clsCommonResponseModel(
            error: "false", messages: ["Error Occurs"], data: [""]);
      }
    } on Exception {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    } catch (e) {
      return clsCommonResponseModel(
          error: "false", messages: ["Error Occurs"], data: [""]);
    }
  }
}
