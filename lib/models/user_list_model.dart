// To parse this JSON data, do
//
//     final usersListModel = usersListModelFromJson(jsonString);

import 'dart:convert';

UsersListModel usersListModelFromJson(String str) =>
    UsersListModel.fromJson(json.decode(str));

String usersListModelToJson(UsersListModel data) => json.encode(data.toJson());

class UsersListModel {
  String status;
  List<UserListData> list;
  String code;
  String message;

  UsersListModel({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory UsersListModel.fromJson(Map<String, dynamic> json) => UsersListModel(
        status: json["status"],
        list: List<UserListData>.from(
            json["list"].map((x) => UserListData.fromJson(x))),
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

class UserListData {
  int id;
  String? username;
  String? password;
  String fullname;
  String email;
  String mobile;
  String? emiratesId;
  DateTime? dob;
  String? imageUrl;
  String? type;
  int role;
  int status;
  int active;
  int createdBy;
  DateTime createdDate;
  int? updatedBy;
  DateTime? updatedDate;

  UserListData({
    required this.id,
    this.username,
    this.password,
    required this.fullname,
    required this.email,
    required this.mobile,
    required this.emiratesId,
    required this.dob,
    required this.imageUrl,
    required this.type,
    required this.role,
    required this.status,
    required this.active,
    required this.createdBy,
    required this.createdDate,
    required this.updatedBy,
    required this.updatedDate,
  });

  factory UserListData.fromJson(Map<String, dynamic> json) => UserListData(
        id: json["id"],
        username: json["username"],
        password: json["password"],
        fullname: json["fullname"],
        email: json["email"],
        mobile: json["mobile"],
        emiratesId: json["emirates_id"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        imageUrl: json["image_url"],
        type: json["type"],
        role: json["role"],
        status: json["status"],
        active: json["active"],
        createdBy: json["created_by"],
        createdDate: DateTime.parse(json["created_date"]),
        updatedBy: json["updated_by"],
        updatedDate: json["updated_date"] == null
            ? null
            : DateTime.parse(json["updated_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "password": password,
        "fullname": fullname,
        "email": email,
        "mobile": mobile,
        "emirates_id": emiratesId,
        "dob":
            "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "image_url": imageUrl,
        "type": type,
        "role": role,
        "status": status,
        "active": active,
        "created_by": createdBy,
        "created_date": createdDate.toIso8601String(),
        "updated_by": updatedBy,
        "updated_date": updatedDate?.toIso8601String(),
      };
}
