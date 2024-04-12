class clsRecalculateCheckoutModel {
  clsRecalculateCheckoutModel({
     this.srpTotal,
     this.intlShipping,
     this.localShipping,
     this.discount,
     this.giftWrapFee,
     this.transactionFee,
     this.invoiceGrandTotal,
     this.codRange,
     this.isAllowedCod,
     this.status,
  });

  int? srpTotal;
  int? intlShipping;
  int? localShipping;
  int? discount;
  int? giftWrapFee;
  int? transactionFee;
  int? invoiceGrandTotal;
  int? codRange;
  bool? isAllowedCod;
  String? status;

  factory clsRecalculateCheckoutModel.fromJson(Map<String, dynamic> json) => clsRecalculateCheckoutModel(
    srpTotal: json["srpTotal"]??0,
    intlShipping: json["intlShipping"]??0,
    localShipping: json["localShipping"]??0,
    discount: json["discount"]??0,
    giftWrapFee: json["giftWrapFee"]??0,
    transactionFee: json["transactionFee"]??0,
    invoiceGrandTotal: json["invoiceGrandTotal"]??0,
    codRange: json["codRange"]??0,
    isAllowedCod: json["isAllowedCod"]??false,
    status: json["status"]??"",
  );

  Map<String, dynamic> toJson() => {
    "srpTotal": srpTotal,
    "intlShipping": intlShipping,
    "localShipping": localShipping,
    "discount": discount,
    "giftWrapFee": giftWrapFee,
    "transactionFee": transactionFee,
    "invoiceGrandTotal": invoiceGrandTotal,
    "codRange": codRange,
    "isAllowedCod": isAllowedCod,
    "status": status,
  };
}