class clsBarangayModel {
  clsBarangayModel({
    this.barangayName,
  });

  String? barangayName;

  factory clsBarangayModel.fromJson(Map<String, dynamic> json) => clsBarangayModel(
    barangayName: json["barangay_name"]??"",
  );

  Map<String, dynamic> toJson() => {
    "barangay_name": barangayName,
  };

  @override
  String toString() {
    // TODO: implement toString
    return barangayName.toString();
  }

}
