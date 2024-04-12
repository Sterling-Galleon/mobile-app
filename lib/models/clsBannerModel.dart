class clsBannermodel {
  clsBannermodel({
    this.bannerId,
    this.bannerImg,
    this.bannerLink,
    this.bannerSlider,
    this.bannerPosition,
  });

  String? bannerId;
  String? bannerImg;
  String? bannerLink;
  String? bannerSlider;
  String? bannerPosition;

  factory clsBannermodel.fromJson(Map<String, dynamic> json) => clsBannermodel(
    bannerId: json["banner_id"]??"",
    bannerImg: json["banner_img"]??"",
    bannerLink: json["banner_link"]??"",
    bannerSlider: json["banner_slider"]??"",
    bannerPosition: json["banner_position"]??"",
  );

  Map<String, dynamic> toJson() => {
    "banner_id": bannerId,
    "banner_img": bannerImg,
    "banner_link": bannerLink,
    "banner_slider": bannerSlider,
    "banner_position": bannerPosition,
  };
}
