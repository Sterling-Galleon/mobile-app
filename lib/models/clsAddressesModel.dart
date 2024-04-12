class clsAddresssModel {
  clsAddresssModel({
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
  String? addressBarangay;
  String? addressState;
  String? addressCountry;
  String? addressPostal;
  String? addressPhone;
  String? addressMobile;
  String? addressEmail;
  String? addressSession;
  String? addressPhone2;
  bool isSelected=false;

  factory clsAddresssModel.fromJson(Map<String, dynamic> json) => clsAddresssModel(
    addressId: json["address_id"]??"",
    addressName: json["address_name"]??"",
    addressUser: json["address_user"]??"",
    addressStreet: json["address_street"]??"",
    addressStreet2: json["address_street2"]??"",
    addressCity: json["address_city"]??"",
    addressBarangay: json["address_barangay"]??"",
    addressState: json["address_state"]??"",
    addressCountry: json["address_country"]??"",
    addressPostal: json["address_postal"]??"",
    addressPhone: json["address_phone"]??"",
    addressMobile: json["address_mobile"]??"",
    addressEmail: json["address_email"]??"",
    addressSession: json["address_session"]??"",
    addressPhone2: json["address_phone2"]??"",
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
