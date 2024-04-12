import 'clsProductModel.dart';

class clsCollectionModel {
  clsCollectionModel({
    this.name,
    this.keyword,
    this.status,
    this.lstclsProductModel,
  });

  String? name;
  String? keyword;
  int? status;
  List<clsProductModel>? lstclsProductModel;

  factory clsCollectionModel.fromJson(Map<String, dynamic> json) => clsCollectionModel(
        name: json["name"] ?? "",
        keyword: json["keyword"] ?? "",
        status: json["status"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "keyword": keyword,
        "status": status,
      };
}
