// ignore_for_file: file_names, camel_case_types

import 'dart:convert';

clsCommonResponseModel clsCommonResponseModelFromJson(String str, {bool isCollectionItemsApi = false}) =>
    clsCommonResponseModel.fromJson(json.decode(str));

String clsCommonResponseModelToJson(clsCommonResponseModel data) =>
    json.encode(data.toJson());

class clsCommonResponseModel {
  clsCommonResponseModel({
    this.error,
    this.fieldValidation,
    this.messages,
    this.data,
  });

  String? error;
  dynamic fieldValidation;
  dynamic messages;
  dynamic data;

  factory clsCommonResponseModel.fromJson(Map<String, dynamic> json) =>
      clsCommonResponseModel(
        error: json["error"] ?? "",
        fieldValidation: json.containsKey("field_validation")
            ? json["field_validation"]
            : null,
        messages: json.containsKey("messages") ? json["messages"] : null,
        data: json.containsKey("data") ? json["data"] : null,
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "field_validation": fieldValidation!.toJson(),
        "messages": messages,
        "data": data,
      };
}

class FieldValidation {
  FieldValidation(
      {this.firstname,
      this.lastname,
      this.email,
      this.password,
      this.confirmPassword,
      this.otp,
      this.mobile});

  String? firstname;
  String? lastname;
  String? email;
  String? password;
  String? confirmPassword;
  String? mobile;
  String? otp;

  factory FieldValidation.fromJson(Map<String, dynamic> json) =>
      FieldValidation(
        firstname: json["firstname"] ?? "",
        lastname: json["lastname"] ?? "",
        email: json["email"] ?? "",
        password: json["password"] ?? "",
        confirmPassword: json["confirm_password"] ?? "",
        mobile: json["mobile"] ?? "",
        otp: json["otp"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "password": password,
        "mobile": mobile,
        "confirm_password": confirmPassword,
        "otp": otp,
      };
}
