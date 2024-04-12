class clsCityModel {
  clsCityModel({
    this.citiesId,
    this.citiesName,
    this.citiesProvinces,
  });

  String? citiesId;
  String? citiesName;
  String? citiesProvinces;

  factory clsCityModel.fromJson(Map<String, dynamic> json) => clsCityModel(
    citiesId: json["cities_id"]??"",
    citiesName: json["cities_name"]??"",
    citiesProvinces: json["cities_provinces"]??"",
  );

  Map<String, dynamic> toJson() => {
    "cities_id": citiesId,
    "cities_name": citiesName,
    "cities_provinces": citiesProvinces,
  };

  @override
  String toString() {
    // TODO: implement toString
    return citiesName.toString();
  }

}
