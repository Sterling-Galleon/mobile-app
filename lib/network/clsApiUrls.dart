// ignore_for_file: file_names, prefer_interpolation_to_compose_strings, constant_identifier_names, non_constant_identifier_names, camel_case_types

String CHAT_URL =
    "https://static.zdassets.com/web_widget/latest/liveChat.html?v=10#key=galleonph.zendesk.com&locale=en";

class clsApiUrls {
  static const String BASE_URL = "https://rest.galleon.ph";
  static const String SOCIAL_LOGIN = BASE_URL + "/user/sociallogin";
  static const String LOGIN_API = BASE_URL + "/user/login";
  static const String OTP = BASE_URL + "/user/otp";
  static const String CHANGE_PASSWORD =
      BASE_URL + "/user/changepassword?token=";
  static const String FORGET_PASSWORD_API = BASE_URL + "/user/forgotpassword";
  static const String REGISTER_USER = BASE_URL + "/user/register";
  static const String BANNER = BASE_URL + "/dashboard/banner";
  static const String TILE_CATEGORY = BASE_URL + "/dashboard/tilecategory";
  static const String NAV_CATEGORY = BASE_URL + "/dashboard/navcategory";
  static const String CATEGORY_BY_ID = BASE_URL + "category/product";
  static const String PRODUCT_SEARCH = BASE_URL + "/product/search?keyword=";
  static const String GET_PRODUCT_BY_CATEGORY_ID =
      BASE_URL + "/category/product/";
  static const String GET_RELATEDPRODUCT_BY_PRODUCT_ID =
      BASE_URL + "/product/related/";
  static const String GET_PRODUCT_COLLECTIONS =
      BASE_URL + "/product/collection";
  static const String GET_ALL_CATEGORIES = BASE_URL + "/category/all";
  static const String GET_PRODUCT_COLLECTIONS_ITEMS =
      BASE_URL + "/product/collectionitems?name=";
  static const String ADD_TO_CART = BASE_URL + "/cart/add?token=";
  static const String ITEMS_IN_CART = BASE_URL + "/cart/items?token=";
  static const String GET_WISHLIST_ITEMS = BASE_URL + "/wishlist/all?token=";
  static const String ADD_ITEMS_IN_WHISLIST = BASE_URL + "/wishlist/add?token=";
  static const String REMOVE_ITEMS_IN_WHISLIST =
      BASE_URL + "/wishlist/delete?token=";
  static const String SAVE_ADDRESS = BASE_URL + "/address/new?token=";
  static const String GET_ALL_ADDRESSES = BASE_URL + "/address/all?token=";
  static const String GET_CART_INFORMATION = BASE_URL + "/cart/items?token=";
  static const String REMOVE_CART_ITEM = BASE_URL + "/cart/remove?token=";
  static const String REMOVE_ALL_COUPONS =
      BASE_URL + "/cart/removecoupon?token=";
  static const String DELETE_ADDRESS = BASE_URL + "/address/delete?token=";
  static const String DELETE_ACCOUNT = BASE_URL + "/user/delete?token=";
  static const String GET_STATE_LIST = BASE_URL + "/location/states";
  static const String GET_CITY_LIST = BASE_URL + "/location/cities/";
  static const String GET_BARANGAY_LIST = BASE_URL + "/location/barangay/";
  static const String GET_ORDER_DETAILS = BASE_URL + "/order/details?token=";
  static const String APPLY_CART_COUPON = BASE_URL + "/cart/coupon?token=";
  static const String SUBMIT_ORDER = BASE_URL + "/checkout?token=";
  static const String UPDATE_PROFILE = BASE_URL + "/user/update?token=";
  static const String GIFT_CARD = BASE_URL + "/cart/gift?token=";
  static const String GET_PRODUCT_DETAILS_BY_PRODUCT_ID =
      BASE_URL + "/product/view/";
  static const String GET_ORDER_LIST = BASE_URL + "/order/list?token=";
  static const String RECALCULATE_CHECK_OUT_ONBASE_OF_SHIPPING_ADDRESS =
      BASE_URL + "/checkout/shipping?token=";
  static const String RECALCULATE_CHECK_OUT_ONBASE_OF_PAYMENT_METHOD =
      BASE_URL + "/checkout/payment?token=";
  static const String PREPARE_CART_FOR_CHECKOUT =
      BASE_URL + "/cart/checkout?token=";
  static const String GET_REGION_BY_STATE =
      BASE_URL + "/location/regionbystate?state=";
  static const String GET_ADDRESS_BY_REGION =
      BASE_URL + "/courier/lbcbyregion?region=";
  static String GET_SHIPPING_TYPE(
          {required String token, required String shipping}) =>
      BASE_URL + "/cart/shipping?shipping=$shipping&token=$token";
  static const String promotionEndPoint = '$BASE_URL/dashboard/promotion';
}
