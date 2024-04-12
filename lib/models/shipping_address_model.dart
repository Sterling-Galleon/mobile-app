class ShippingAddressModel {
  String? branchCode;
  String? branchName;
  String? branchAddress;
  String? branchRegion;
  String? branchCity;
  String? branchState;

  ShippingAddressModel(
      {this.branchCode,
      this.branchName,
      this.branchAddress,
      this.branchRegion,
      this.branchCity,
      this.branchState});

  ShippingAddressModel.fromJson(Map<String, dynamic> json) {
    branchCode = json['branch_code'];
    branchName = json['branch_name'];
    branchAddress = json['branch_address'];
    branchRegion = json['branch_region'];
    branchCity = json['branch_city'];
    branchState = json['branch_state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branch_code'] = this.branchCode;
    data['branch_name'] = this.branchName;
    data['branch_address'] = this.branchAddress;
    data['branch_region'] = this.branchRegion;
    data['branch_city'] = this.branchCity;
    data['branch_state'] = this.branchState;
    return data;
  }
}