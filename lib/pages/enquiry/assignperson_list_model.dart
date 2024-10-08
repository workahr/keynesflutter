// To parse this JSON data, do
//
//     final assignpersonListModel = assignpersonListModelFromJson(jsonString);

import 'dart:convert';

AssignpersonListModel assignpersonListModelFromJson(String str) =>
    AssignpersonListModel.fromJson(json.decode(str));

String assignpersonListModelToJson(AssignpersonListModel data) =>
    json.encode(data.toJson());

class AssignpersonListModel {
  String status;
  List<AssignPerson> list;
  String code;
  String message;

  AssignpersonListModel({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory AssignpersonListModel.fromJson(Map<String, dynamic> json) =>
      AssignpersonListModel(
        status: json["status"],
        list: List<AssignPerson>.from(
            json["list"].map((x) => AssignPerson.fromJson(x))),
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
        "code": code,
        "message": message,
      };
}

class AssignPerson {
  String fullname;
  int id;

  AssignPerson({
    required this.fullname,
    required this.id,
  });

  factory AssignPerson.fromJson(Map<String, dynamic> json) => AssignPerson(
        fullname: json["fullname"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "fullname": fullname,
        "id": id,
      };
}
