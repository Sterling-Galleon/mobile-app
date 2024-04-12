class clsCartInfoModel {
  clsCartInfoModel({
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
    this.transactionFee
  });

  List<Item>? items;
  Summary? summary;
  dynamic recent;
  bool? forSea;
  int? count;
  String? shipping;
  String? dedication;
  String? code;
  int? giftFee;
  String? couponType;
  String? transactionFee;

  factory clsCartInfoModel.fromJson(Map<String, dynamic> json) => clsCartInfoModel(
        items: json["items"] == null ? [] : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        summary: json["summary"] == null ? null : Summary.fromJson(json["summary"]),
        // recent: json["recent"] == null ? [] : List<dynamic>.from(json["recent"].map((x) => x)),
        recent: json["recent"] == null ? [] : json["recent"],
        forSea: json["forSea"] ?? false,
        count: json["count"] ?? 0,
        shipping: json["shipping"] ?? "",
        dedication: json["dedication"] ?? "",
        code: json["code"] ?? "",
    transactionFee:json["transactionFee"]??"",
        giftFee: json["giftFee"] ?? 0,
        couponType: json["couponType"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
        "summary": summary == null ? "" : summary!.toJson(),
        "recent": recent == null ? [] : List<dynamic>.from(recent!.map((x) => x)),
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
    this.quoteclsCartInfoModel,
  });

  int? quantity=0;
  Product? product;
  List<dynamic>? quoteclsCartInfoModel;
  // int incrementCount=1;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        quantity: json["quantity"] ?? 0,
        product: json["product"] == null ? null : Product.fromJson(json["product"]),
        quoteclsCartInfoModel: json["quoteclsCartInfoModel"] == null ? [] : List<dynamic>.from(json["quoteclsCartInfoModel"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "quantity": quantity,
        "product": product,
        "quoteclsCartInfoModel":quoteclsCartInfoModel==null?[]: List<dynamic>.from(quoteclsCartInfoModel!.map((x) => x)),
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
        productId: json["product_id"]??"",
        productName: json["product_name"]??"",
        imgThumb: json["imgThumb"]??"",
        productSrp: json["product_srp"]??"",
        productUrl: json["product_url"]??"",
        discountable: json["discountable"]??false,
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
  int? discount;
  int? giftWrapFee;
  int? transactionFee;
  int? invoiceGrandTotal;

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        srpTotal: json["srpTotal"]??0,
        intlShipping: json["intlShipping"]??0,
        localShipping: json["localShipping"]??0,
        discount: json["discount"]??0,
        giftWrapFee: json["giftWrapFee"]??0,
        transactionFee: json["transactionFee"]??0,
        invoiceGrandTotal: json["invoiceGrandTotal"]??0,
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
