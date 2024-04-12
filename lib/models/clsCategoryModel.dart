class clsCategoryModel {
  clsCategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.createdDate,
    required this.updatedDate,
    required this.parentCategoriesId,
    this.childCategories,
  });

  String? id;
  String? name;
  String? description;
  String? createdDate;
  String? updatedDate;
  String? parentCategoriesId;
  List<clsCategoryModel>? childCategories;
  bool bolexpand=false;

  factory clsCategoryModel.fromJson(Map<String, dynamic> json) => clsCategoryModel(
    id: json["id"]??"",
    name: json["name"]??"",
    description: json["description"]??"",
    createdDate: json["created_date"]??"",
    updatedDate: json["updated_date"]??"",
    parentCategoriesId: json["parent_categories_id"]??"",
    childCategories: json["child_categories"] == null ? [] : List<clsCategoryModel>.from(json["child_categories"]!.map((x) => clsCategoryModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "created_date": createdDate,
    "updated_date": updatedDate,
    "parent_categories_id": parentCategoriesId,
    "child_categories": childCategories == null ? [] : List<dynamic>.from(childCategories!.map((x) => x.toJson())),
  };
}