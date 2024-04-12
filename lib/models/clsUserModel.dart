class clsUserModel {
  clsUserModel({
    this.userId,
    this.userFacebook,
    this.userFirst,
    this.userLast,
    this.userEmail,
    this.userVerified,
    this.userOtpCreatedAt,
    this.token,
    this.userMobile,
  });

  String? userId;
  String? userFacebook;
  String? userFirst;
  String? userLast;
  String? userEmail;
  String? userMobile;
  String? userVerified;
  String? userOtpCreatedAt;
  String? token;

  factory clsUserModel.fromJson(Map<String, dynamic> json) => clsUserModel(
    userId: json["user_id"]??"",
    userFacebook: json["user_facebook"]??"",
    userFirst: json["user_first"]??"",
    userLast: json["user_last"]??"",
    userEmail: json["user_email"]??"",
    userMobile: json["user_mobile"]??"",
    userVerified: json["user_verified"]??"",
    userOtpCreatedAt: json["user_otp_created_at"]??"",
    token: json["token"]??"",
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "user_facebook": userFacebook,
    "user_first": userFirst,
    "userMobile": userMobile,
    "user_last": userLast,
    "user_email": userEmail,
    "user_verified": userVerified,
    "user_otp_created_at": userOtpCreatedAt,
    "token": token,
  };
}
