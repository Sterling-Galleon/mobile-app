// ignore_for_file: file_names, camel_case_types

class clsNavCategoryModel {
  clsNavCategoryModel({
    this.metaId,
    this.category,
    this.link,
    this.categoryId,
  });

  String? metaId;
  String? category;
  String? link;
  String? categoryId;

  factory clsNavCategoryModel.fromJson(Map<String, dynamic> json) =>
      clsNavCategoryModel(
        metaId: json["meta_id"] ?? "",
        category: json["category"] ?? "",
        link: json["link"] ?? "",
        categoryId: json["category_id"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "meta_id": metaId,
        "category": category,
        "link": link,
        "category_id": categoryId,
      };
}
