// To parse this JSON data, do
//
//     final enquiryAddModel = enquiryAddModelFromJson(jsonString);

import 'dart:convert';

EnquiryAddModel enquiryAddModelFromJson(String str) => EnquiryAddModel.fromJson(json.decode(str));

String enquiryAddModelToJson(EnquiryAddModel data) => json.encode(data.toJson());

class EnquiryAddModel {
    String status;
    String code;
    String message;

    EnquiryAddModel({
        required this.status,
        required this.code,
        required this.message,
    });

    factory EnquiryAddModel.fromJson(Map<String, dynamic> json) => EnquiryAddModel(
        status: json["status"],
        code: json["code"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
    };
}
