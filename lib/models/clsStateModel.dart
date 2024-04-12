class clsStateModal {
  clsStateModal({
    this.provincesId,
    this.provincesName,
    this.provincesRegion,
    this.region,
  });

  String? provincesId;
  String? provincesName;
  String? provincesRegion;
  Region? region;

  factory clsStateModal.fromJson(Map<String, dynamic> json) => clsStateModal(
        provincesId: json["provinces_id"]??"",
        provincesName: json["provinces_name"]??"",
        provincesRegion: json["provinces_region"]??"",
        region: json["region"] == null ? null : Region.fromJson(json["region"]),
      );

  @override
  String toString() {
    // TODO: implement toString
    return provincesName.toString();
  }



}

class Region {
  Region({
    this.regionsId,
    this.regionsName,
  });

  String? regionsId;
  String? regionsName;

  factory Region.fromJson(Map<String, dynamic> json) => Region(
        regionsId: json["regions_id"]??"",
        regionsName: json["regions_name"] ?? "",
      );
}
