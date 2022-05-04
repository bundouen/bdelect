import 'dart:convert';

OtpLoginResponeModel otpLoginResponeModel(String str) =>
    OtpLoginResponeModel.fromJson(
      json.decode(str),
    );

class OtpLoginResponeModel {
  late final String message;
  late final String? data;
  OtpLoginResponeModel({
    required this.message,
    required this.data,
  });
  OtpLoginResponeModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'];
  }
}
