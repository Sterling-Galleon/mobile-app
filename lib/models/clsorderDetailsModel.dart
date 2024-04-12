// ignore_for_file: file_names, camel_case_types

class clsOrderDetailsModel {
  clsOrderDetailsModel({
    required this.total,
    required this.orders,
  });

  int? total;
  List<Order>? orders;

  factory clsOrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      clsOrderDetailsModel(
        total: json["total"],
        orders: json["orders"] == null
            ? []
            : List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
      );
}

class Order {
  Order({
    this.id,
    this.invoiceId,
    this.invoiceUser,
    this.invoiceShipping,
    this.invoiceBilling,
    this.invoicePayment,
    this.invoiceStatus,
    this.invoicePrice,
    this.invoiceEta,
    this.invoiceCreated,
    this.invoiceCorporation,
    this.invoiceBalance,
    this.invoiceSecondEmail,
    this.shippingName,
    this.shippingEmail,
    this.shippingPhone,
    this.billingName,
    this.billingNameString,
    this.billingEmail,
    this.billingPhone,
    this.userFirst,
    this.userLast,
    this.orderComments,
    this.orderProducts,
    this.version,
    this.quote,
  });

  String? invoiceEta;
  String? invoiceCreated;
  String? invoiceCorporation;
  String? invoicePayment;
  String? invoiceStatus;
  String? id;
  String? invoiceSecondEmail;
  String? shippingName;
  String? shippingEmail;
  String? shippingPhone;
  String? billingName;
  String? billingNameString;
  String? billingEmail;
  String? billingPhone;
  String? userFirst;
  String? userLast;
  List<String>? orderComments;
  List<String>? orderProducts;
  double? version;
  List<Quote>? quote;
  dynamic invoiceId;
  dynamic invoiceUser;
  dynamic invoiceShipping;
  dynamic invoiceBilling;
  dynamic invoicePrice;
  dynamic invoiceBalance;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"] ?? "",
        invoiceId: json["invoice_id"] ?? "",
        invoiceUser: json["invoice_user"] ?? 0,
        invoiceShipping: json["invoice_shipping"] ?? 0,
        invoiceBilling: json["invoice_billing"] ?? 0,
        invoicePayment: json["invoice_payment"] ?? "",
        invoiceStatus: json["invoice_status"] ?? "",
        invoicePrice: json["invoice_price"] ?? 0,
        invoiceEta: json["invoice_eta"] ?? "",
        invoiceCreated: json["invoice_created"] ?? "",
        invoiceCorporation: json["invoice_corporation"] ?? "",
        invoiceBalance: json["invoice_balance"] ?? 0,
        invoiceSecondEmail: json["invoice_second_email"] ?? "",
        shippingName: json["shipping_name"] ?? "",
        shippingEmail: json["shipping_email"] ?? "",
        shippingPhone: json["shipping_phone"] ?? "",
        billingName: json["billing_name"] ?? "",
        billingNameString: json["billing_name_string"] ?? "",
        billingEmail: json["billing_email"] ?? "",
        billingPhone: json["billing_phone"] ?? "",
        userFirst: json["user_first"] ?? "",
        userLast: json["user_last"] ?? "",
        orderComments: json["order_comments"] == null
            ? []
            : List<String>.from(json["order_comments"].map((x) => x)),
        orderProducts: json["order_products"] == null
            ? []
            : List<String>.from(json["order_products"].map((x) => x)),
        version: json["_version_"]?.toDouble(),
        quote: List<Quote>.from(json["quote"].map((x) => Quote.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "invoice_id": invoiceId,
        "invoice_user": invoiceUser,
        "invoice_shipping": invoiceShipping,
        "invoice_billing": invoiceBilling,
        "invoice_payment": invoicePayment,
        "invoice_status": invoiceStatus,
        "invoice_price": invoicePrice,
        "invoice_eta": invoiceEta,
        "invoice_created": invoiceCreated,
        "invoice_corporation": invoiceCorporation,
        "invoice_balance": invoiceBalance,
        "invoice_second_email": invoiceSecondEmail,
        "shipping_name": shippingName,
        "shipping_email": shippingEmail,
        "shipping_phone": shippingPhone,
        "billing_name": billingName,
        "billing_name_string": billingNameString,
        "billing_email": billingEmail,
        "billing_phone": billingPhone,
        "user_first": userFirst,
        "user_last": userLast,
        "order_comments": List<dynamic>.from(orderComments!.map((x) => x)),
        "order_products": List<dynamic>.from(orderProducts!.map((x) => x)),
        "_version_": version,
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
    // this.productJacBreakdown,
    // this.productLbcBreakdown,
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
  String? productPriceSale;

  // ProductJacBreakdown? productJacBreakdown;
  // ProductLbcBreakdown? productLbcBreakdown;

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
        productWeight: json["product_weight"],
        productPriceMargin: json["product_price_margin"] ?? "",
        productPriceInternational: json["product_price_international"] ?? "",
        productPriceLocal: json["product_price_local"] ?? "",
        productPriceTotal: json["product_price_total"] ?? "",
        productPriceSale: json["product_price_sale"] ?? "",
        // productJacBreakdown: ProductJacBreakdown.fromJson(json["product_jac_breakdown"]),
        // productLbcBreakdown: ProductLbcBreakdown.fromJson(json["product_lbc_breakdown"]),
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
      };
}

class ProductJacBreakdown {
  ProductJacBreakdown({
    required this.shippingRate,
    required this.volume,
    required this.deliveryCharge,
    required this.flatRate,
    required this.effectivePremium,
    required this.phpRate,
    required this.vat,
    required this.total,
  });

  String shippingRate;
  int volume;
  String deliveryCharge;
  String flatRate;
  String effectivePremium;
  String phpRate;
  double vat;
  String total;

  factory ProductJacBreakdown.fromJson(Map<String, dynamic> json) =>
      ProductJacBreakdown(
        shippingRate: json["shipping_rate"],
        volume: json["volume"],
        deliveryCharge: json["delivery_charge"],
        flatRate: json["flat_rate"],
        effectivePremium: json["effective_premium"],
        phpRate: json["php_rate"],
        vat: json["vat"]?.toDouble(),
        total: json["total"],
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
    required this.volume,
    required this.weight,
    required this.rate,
  });

  String volume;
  double weight;
  Rate rate;

  factory ProductLbcBreakdown.fromJson(Map<String, dynamic> json) =>
      ProductLbcBreakdown(
        volume: json["volume"],
        weight: json["weight"]?.toDouble(),
        rate: Rate.fromJson(json["rate"]),
      );

  Map<String, dynamic> toJson() => {
        "volume": volume,
        "weight": weight,
        "rate": rate.toJson(),
      };
}

class Rate {
  Rate({
    required this.ncr,
    required this.luzon,
    required this.visayas,
    required this.mindanao,
  });

  int ncr;
  int luzon;
  int visayas;
  int mindanao;

  factory Rate.fromJson(Map<String, dynamic> json) => Rate(
        ncr: json["ncr"],
        luzon: json["luzon"],
        visayas: json["visayas"],
        mindanao: json["mindanao"],
      );

  Map<String, dynamic> toJson() => {
        "ncr": ncr,
        "luzon": luzon,
        "visayas": visayas,
        "mindanao": mindanao,
      };
}
