class clsTileCategoryModel {
  clsTileCategoryModel({
    this.metaId,
    this.category,
    this.photo,
    this.order,
    this.link,
    this.categoryId,
  });

  String? metaId;
  String? category;
  String? photo;
  String? order;
  String? link;
  String? categoryId;

  factory clsTileCategoryModel.fromJson(Map<String, dynamic> json) => clsTileCategoryModel(
    metaId: json["meta_id"]??"",
    category: json["category"]??"",
    photo: json["photo"]??"",
    order: json["order"]??"",
    link: json["link"]??"",
    categoryId: json["category_id"]??"",
  );

  Map<String, dynamic> toJson() => {
    "meta_id": metaId,
    "category": category,
    "photo": photo,
    "order": order,
    "link": link,
    "category_id": categoryId,
  };
}
