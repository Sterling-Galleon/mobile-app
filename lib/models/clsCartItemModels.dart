class clsCartItemsModel {
  clsCartItemsModel({
    this.items,
    this.summary,
    this.recent,
    this.forSea,
    this.count,
    this.shipping,
    this.dedication,
    this.code,
    this.giftFee,
    this.couponType,
  });

  List<Item>? items;
  Summary? summary;
  Recent? recent;
  bool? forSea;
  int? count;
  String? shipping;
  String? dedication;
  String? code;
  int? giftFee;
  String? couponType;

  factory clsCartItemsModel.fromJson(Map<String, dynamic> json) => clsCartItemsModel(
        items: json["items"] == null ? null : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        summary: json["summary"] == null ? null : Summary.fromJson(json["summary"]),
        recent: json["recent"] == null ? null : Recent.fromJson(json["recent"]),
        forSea: json["forSea"] ?? false,
        count: json["count"] ?? 0,
        shipping: json["shipping"] ?? "",
        dedication: json["dedication"] ?? "",
        code: json["code"] ?? "",
        giftFee: json["giftFee"] ?? 0,
        couponType: json["couponType"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
        "summary": summary!.toJson(),
        "recent": recent!.toJson(),
        "forSea": forSea,
        "count": count,
        "shipping": shipping,
        "dedication": dedication,
        "code": code,
        "giftFee": giftFee,
        "couponType": couponType,
      };
}

class Item {
  Item({
    this.quantity,
    this.product,
    this.quoteData,
  });

  int? quantity;
  Product? product;
  List<dynamic>? quoteData;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        quantity: json["quantity"] ?? 0,
        product: json["product"] == null ? null : Product.fromJson(json["product"]),
        quoteData: json["quoteData"] == null ? null : List<dynamic>.from(json["quoteData"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "quantity": quantity,
        "product": product!.toJson(),
        "quoteData": List<dynamic>.from(quoteData!.map((x) => x)),
      };
}

class Product {
  Product({
    this.productId,
    this.productName,
    this.imgThumb,
    this.productSrp,
    this.productUrl,
    this.discountable,
  });

  String? productId;
  String? productName;
  String? imgThumb;
  String? productSrp;
  String? productUrl;
  bool? discountable;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json["product_id"] ?? "",
        productName: json["product_name"] ?? "",
        imgThumb: json["imgThumb"] ?? "",
        productSrp: json["product_srp"] ?? "",
        productUrl: json["product_url"] ?? "",
        discountable: json["discountable"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "product_name": productName,
        "imgThumb": imgThumb,
        "product_srp": productSrp,
        "product_url": productUrl,
        "discountable": discountable,
      };
}

class Recent {
  Recent({
    this.productId,
    this.active,
    this.productName,
    this.productFullCategoryName,
  });

  String? productId;
  String? active;
  String? productName;
  String? productFullCategoryName;

  factory Recent.fromJson(Map<String, dynamic> json) => Recent(
        productId: json["product_id"] ?? "",
        active: json["active"] ?? "",
        productName: json["product_name"] ?? "",
        productFullCategoryName: json["product_full_category_name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "active": active,
        "product_name": productName,
        "product_full_category_name": productFullCategoryName,
      };
}

class Summary {
  Summary({
    this.srpTotal,
    this.intlShipping,
    this.localShipping,
    this.discount,
    this.giftWrapFee,
    this.transactionFee,
    this.invoiceGrandTotal,
  });

  int? srpTotal;
  int? intlShipping;
  int? localShipping;
  double? discount;
  int? giftWrapFee;
  int? transactionFee;
  int? invoiceGrandTotal;

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        srpTotal: json["srpTotal"] ?? 0,
        intlShipping: json["intlShipping"] ?? 0,
        localShipping: json["localShipping"] ?? 0,
        discount: json["discount"] == null ? 0.0 : json["discount"].toDouble(),
        giftWrapFee: json["giftWrapFee"] ?? 0,
        transactionFee: json["transactionFee"] ?? 0,
        invoiceGrandTotal: json["invoiceGrandTotal"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "srpTotal": srpTotal,
        "intlShipping": intlShipping,
        "localShipping": localShipping,
        "discount": discount,
        "giftWrapFee": giftWrapFee,
        "transactionFee": transactionFee,
        "invoiceGrandTotal": invoiceGrandTotal,
      };
}
