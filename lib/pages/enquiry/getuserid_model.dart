// To parse this JSON data, do
//
//     final getuseridmodel = getuseridmodelFromJson(jsonString);

import 'dart:convert';

Getuseridmodel getuseridmodelFromJson(String str) =>
    Getuseridmodel.fromJson(json.decode(str));

String getuseridmodelToJson(Getuseridmodel data) => json.encode(data.toJson());

class Getuseridmodel {
  String status;
  List<String> mobileId;
  String code;
  String message;

  Getuseridmodel({
    required this.status,
    required this.mobileId,
    required this.code,
    required this.message,
  });

  factory Getuseridmodel.fromJson(Map<String, dynamic> json) => Getuseridmodel(
        status: json["status"],
        mobileId: List<String>.from(json["mobile_id"].map((x) => x)),
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "mobile_id": List<dynamic>.from(mobileId.map((x) => x)),
        "code": code,
        "message": message,
      };
}
