// ignore_for_file: file_names, camel_case_types

class clsNewOrderDetailPagemodel {
  clsNewOrderDetailPagemodel({
    this.invoiceId,
    this.invoiceUser,
    this.invoiceShipping,
    this.invoiceBilling,
    this.invoicePayment,
    this.invoiceStatus,
    this.invoicePrice,
    this.invoiceEta,
    this.invoiceOrderComplete,
    this.invoiceCreated,
    this.invoiceCode,
    this.invoiceDestination,
    this.invoiceDiscname,
    this.invoiceDiscpercent,
    this.invoiceDiscprice,
    this.invoiceFreight,
    this.invoiceGiftprice,
    this.invoiceNote,
    this.invoiceRefference,
    this.invoiceTracking,
    this.invoiceOldSubtotal,
    this.invoiceSubtotal,
    this.invoiceGalleonSubtotal,
    this.invoiceMerchantSubtotal,
    this.quote,
    this.shipping,
    this.billing,
    this.user,
    this.invoiceOldPrice,
  });

  String? invoiceId;
  String? invoiceUser;
  String? invoiceShipping;
  String? invoiceBilling;
  String? invoicePayment;
  String? invoiceStatus;
  String? invoicePrice;
  String? invoiceEta;
  dynamic invoiceOrderComplete;
  String? invoiceCreated;
  String? invoiceCode;
  String? invoiceDestination;
  String? invoiceDiscname;
  String? invoiceDiscpercent;
  String? invoiceDiscprice;
  String? invoiceFreight;
  String? invoiceGiftprice;
  String? invoiceNote;
  String? invoiceRefference;
  String? invoiceTracking;
  int? invoiceOldSubtotal;
  int? invoiceSubtotal;
  int? invoiceGalleonSubtotal;
  int? invoiceMerchantSubtotal;
  List<Quote>? quote;
  Ing? shipping;
  Ing? billing;
  User? user;
  int? invoiceOldPrice;

  factory clsNewOrderDetailPagemodel.fromJson(Map<String, dynamic> json) =>
      clsNewOrderDetailPagemodel(
        invoiceId: json["invoice_id"] ?? "",
        invoiceUser: json["invoice_user"] ?? "",
        invoiceShipping: json["invoice_shipping"] ?? "",
        invoiceBilling: json["invoice_billing"] ?? "",
        invoicePayment: json["invoice_payment"] ?? "",
        invoiceStatus: json["invoice_status"] ?? "",
        invoicePrice: json["invoice_price"] ?? "",
        invoiceEta: json["invoice_eta"] ?? "",
        invoiceOrderComplete: json["invoice_order_complete"] ?? "",
        invoiceCreated: json["invoice_created"] ?? "",
        invoiceCode: json["invoice_code"] ?? "",
        invoiceDestination: json["invoice_destination"] ?? "",
        invoiceDiscname: json["invoice_discname"] ?? "",
        invoiceDiscpercent: json["invoice_discpercent"] ?? "",
        invoiceDiscprice: json["invoice_discprice"] ?? "",
        invoiceFreight: json["invoice_freight"] ?? "",
        invoiceGiftprice: json["invoice_giftprice"] ?? "",
        invoiceNote: json["invoice_note"] ?? "",
        invoiceRefference: json["invoice_refference"] ?? "",
        invoiceTracking: json["invoice_tracking"] ?? "",
        invoiceOldSubtotal: json["invoice_old_subtotal"] ?? 0,
        invoiceSubtotal: json["invoice_subtotal"] ?? 0,
        invoiceGalleonSubtotal: json["invoice_galleon_subtotal"] ?? 0,
        invoiceMerchantSubtotal: json["invoice_merchant_subtotal"] ?? 0,
        quote: json["quote"] == null
            ? []
            : List<Quote>.from(json["quote"].map((x) => Quote.fromJson(x))),
        shipping:
            json["shipping"] == null ? Ing() : Ing.fromJson(json["shipping"]),
        billing:
            json["billing"] == null ? Ing() : Ing.fromJson(json["billing"]),
        user: json["user"] == null ? User() : User.fromJson(json["user"]),
        invoiceOldPrice: json["invoice_old_price"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "invoice_id": invoiceId,
        "invoice_user": invoiceUser,
        "invoice_shipping": invoiceShipping,
        "invoice_billing": invoiceBilling,
        "invoice_payment": invoicePayment,
        "invoice_status": invoiceStatus,
        "invoice_price": invoicePrice,
        "invoice_eta": invoiceEta,
        "invoice_order_complete": invoiceOrderComplete,
        "invoice_created": invoiceCreated,
        "invoice_code": invoiceCode,
        "invoice_destination": invoiceDestination,
        "invoice_discname": invoiceDiscname,
        "invoice_discpercent": invoiceDiscpercent,
        "invoice_discprice": invoiceDiscprice,
        "invoice_freight": invoiceFreight,
        "invoice_giftprice": invoiceGiftprice,
        "invoice_note": invoiceNote,
        "invoice_refference": invoiceRefference,
        "invoice_tracking": invoiceTracking,
        "invoice_old_subtotal": invoiceOldSubtotal,
        "invoice_subtotal": invoiceSubtotal,
        "invoice_galleon_subtotal": invoiceGalleonSubtotal,
        "invoice_merchant_subtotal": invoiceMerchantSubtotal,
        "quote": List<dynamic>.from(quote!.map((x) => x.toJson())),
        "shipping": shipping!.toJson(),
        "billing": billing!.toJson(),
        "user": user!.toJson(),
        "invoice_old_price": invoiceOldPrice,
      };
}

class Ing {
  Ing({
    this.addressId,
    this.addressName,
    this.addressUser,
    this.addressStreet,
    this.addressStreet2,
    this.addressCity,
    this.addressBarangay,
    this.addressState,
    this.addressCountry,
    this.addressPostal,
    this.addressPhone,
    this.addressMobile,
    this.addressEmail,
    this.addressSession,
    this.addressPhone2,
  });

  String? addressId;
  String? addressName;
  String? addressUser;
  String? addressStreet;
  String? addressStreet2;
  String? addressCity;
  dynamic addressBarangay;
  String? addressState;
  String? addressCountry;
  String? addressPostal;
  String? addressPhone;
  String? addressMobile;
  String? addressEmail;
  String? addressSession;
  dynamic addressPhone2;

  factory Ing.fromJson(Map<String, dynamic> json) => Ing(
        addressId: json["address_id"] ?? "",
        addressName: json["address_name"] ?? "",
        addressUser: json["address_user"] ?? "",
        addressStreet: json["address_street"] ?? "",
        addressStreet2: json["address_street2"] ?? "",
        addressCity: json["address_city"] ?? "",
        addressBarangay: json["address_barangay"] ?? "",
        addressState: json["address_state"] ?? "",
        addressCountry: json["address_country"] ?? "",
        addressPostal: json["address_postal"] ?? "",
        addressPhone: json["address_phone"] ?? "",
        addressMobile: json["address_mobile"] ?? "",
        addressEmail: json["address_email"] ?? "",
        addressSession: json["address_session"] ?? "",
        addressPhone2: json["address_phone2"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "address_id": addressId,
        "address_name": addressName,
        "address_user": addressUser,
        "address_street": addressStreet,
        "address_street2": addressStreet2,
        "address_city": addressCity,
        "address_barangay": addressBarangay,
        "address_state": addressState,
        "address_country": addressCountry,
        "address_postal": addressPostal,
        "address_phone": addressPhone,
        "address_mobile": addressMobile,
        "address_email": addressEmail,
        "address_session": addressSession,
        "address_phone2": addressPhone2,
      };
}

class Quote {
  Quote({
    this.quoteId,
    this.quoteSession,
    this.quoteInvoice,
    this.quoteUser,
    this.quoteProduct,
    this.quoteMerchant,
    this.quotePrice,
    this.quantity,
    this.productId,
    this.productName,
    this.productAmazon,
    this.productUrl,
    this.productPrice,
    this.productCategory,
    this.productWeight,
    this.productPriceMargin,
    this.productPriceInternational,
    this.productPriceLocal,
    this.productPriceTotal,
    this.productPriceSale,
    this.productJacBreakdown,
    this.productLbcBreakdown,
  });

  String? quoteId;
  String? quoteSession;
  String? quoteInvoice;
  String? quoteUser;
  String? quoteProduct;
  String? quoteMerchant;
  String? quotePrice;
  String? quantity;
  String? productId;
  String? productName;
  String? productAmazon;
  String? productUrl;
  String? productPrice;
  String? productCategory;
  dynamic productWeight;
  String? productPriceMargin;
  String? productPriceInternational;
  String? productPriceLocal;
  String? productPriceTotal;
  dynamic productPriceSale;
  ProductJacBreakdown? productJacBreakdown;
  ProductLbcBreakdown? productLbcBreakdown;

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
        quoteId: json["quote_id"] ?? "",
        quoteSession: json["quote_session"] ?? "",
        quoteInvoice: json["quote_invoice"] ?? "",
        quoteUser: json["quote_user"] ?? "",
        quoteProduct: json["quote_product"] ?? "",
        quoteMerchant: json["quote_merchant"] ?? "",
        quotePrice: json["quote_price"] ?? "",
        quantity: json["quantity"] ?? "",
        productId: json["product_id"] ?? "",
        productName: json["product_name"] ?? "",
        productAmazon: json["product_amazon"] ?? "",
        productUrl: json["product_url"] ?? "",
        productPrice: json["product_price"] ?? "",
        productCategory: json["product_category"] ?? "",
        productWeight: json["product_weight"] ?? 0.0,
        productPriceMargin: json["product_price_margin"] ?? "",
        productPriceInternational: json["product_price_international"] ?? "",
        productPriceLocal: json["product_price_local"] ?? "",
        productPriceTotal: json["product_price_total"] ?? "",
        productPriceSale: json["product_price_sale"] ?? "",
        productJacBreakdown: json["product_jac_breakdown"] == null
            ? ProductJacBreakdown()
            : ProductJacBreakdown.fromJson(json["product_jac_breakdown"]),
        productLbcBreakdown: json["product_lbc_breakdown"] == null
            ? ProductLbcBreakdown()
            : ProductLbcBreakdown.fromJson(json["product_lbc_breakdown"]),
      );

  Map<String, dynamic> toJson() => {
        "quote_id": quoteId,
        "quote_session": quoteSession,
        "quote_invoice": quoteInvoice,
        "quote_user": quoteUser,
        "quote_product": quoteProduct,
        "quote_merchant": quoteMerchant,
        "quote_price": quotePrice,
        "quantity": quantity,
        "product_id": productId,
        "product_name": productName,
        "product_amazon": productAmazon,
        "product_url": productUrl,
        "product_price": productPrice,
        "product_category": productCategory,
        "product_weight": productWeight,
        "product_price_margin": productPriceMargin,
        "product_price_international": productPriceInternational,
        "product_price_local": productPriceLocal,
        "product_price_total": productPriceTotal,
        "product_price_sale": productPriceSale,
        "product_jac_breakdown": productJacBreakdown!.toJson(),
        "product_lbc_breakdown": productLbcBreakdown!.toJson(),
      };
}

class ProductJacBreakdown {
  ProductJacBreakdown({
    this.shippingRate,
    this.volume,
    this.deliveryCharge,
    this.flatRate,
    this.effectivePremium,
    this.phpRate,
    this.vat,
    this.total,
  });

  String? shippingRate;
  int? volume;
  String? deliveryCharge;
  String? flatRate;
  String? effectivePremium;
  String? phpRate;
  double? vat;
  String? total;

  factory ProductJacBreakdown.fromJson(Map<String, dynamic> json) =>
      ProductJacBreakdown(
        shippingRate: json["shipping_rate"] ?? "",
        volume: json["volume"] ?? 0,
        deliveryCharge: json["delivery_charge"] ?? "",
        flatRate: json["flat_rate"] ?? "",
        effectivePremium: json["effective_premium"] ?? "",
        phpRate: json["php_rate"] ?? "",
        vat: json["vat"] ?? 0.0,
        total: json["total"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "shipping_rate": shippingRate,
        "volume": volume,
        "delivery_charge": deliveryCharge,
        "flat_rate": flatRate,
        "effective_premium": effectivePremium,
        "php_rate": phpRate,
        "vat": vat,
        "total": total,
      };
}

class ProductLbcBreakdown {
  ProductLbcBreakdown({
    this.volume,
    this.weight,
    this.rate,
  });

  String? volume;
  dynamic weight;
  Rate? rate;

  factory ProductLbcBreakdown.fromJson(Map<String, dynamic> json) =>
      ProductLbcBreakdown(
        volume: json["volume"] ?? "",
        weight: json["weight"] ?? 0.0,
        rate: json["rate"] == null ? Rate() : Rate.fromJson(json["rate"]),
      );

  Map<String, dynamic> toJson() => {
        "volume": volume,
        "weight": weight,
        "rate": rate!.toJson(),
      };
}

class Rate {
  Rate({
    this.ncr,
    this.luzon,
    this.visayas,
    this.mindanao,
  });

  int? ncr;
  int? luzon;
  int? visayas;
  int? mindanao;

  factory Rate.fromJson(Map<String, dynamic> json) => Rate(
        ncr: json["ncr"] ?? 0,
        luzon: json["luzon"] ?? 0,
        visayas: json["visayas"] ?? 0,
        mindanao: json["mindanao"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "ncr": ncr,
        "luzon": luzon,
        "visayas": visayas,
        "mindanao": mindanao,
      };
}

class User {
  User({
    this.userId,
    this.userFacebook,
    this.userFirst,
    this.userLast,
    this.userEmail,
  });

  String? userId;
  String? userFacebook;
  String? userFirst;
  String? userLast;
  String? userEmail;

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["user_id"] ?? "",
        userFacebook: json["user_facebook"] ?? "",
        userFirst: json["user_first"] ?? "",
        userLast: json["user_last"] ?? "",
        userEmail: json["user_email"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_facebook": userFacebook,
        "user_first": userFirst,
        "user_last": userLast,
        "user_email": userEmail,
      };
}
