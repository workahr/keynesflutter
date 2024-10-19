// To parse this JSON data, do
//
//     final authorityListModel = authorityListModelFromJson(jsonString);

import 'dart:convert';

AuthorityListModel authorityListModelFromJson(String str) => AuthorityListModel.fromJson(json.decode(str));

String authorityListModelToJson(AuthorityListModel data) => json.encode(data.toJson());

class AuthorityListModel {
    String status;
    List<AuthorityListData> list;
    String code;
    String message;

    AuthorityListModel({
        required this.status,
        required this.list,
        required this.code,
        required this.message,
    });

    factory AuthorityListModel.fromJson(Map<String, dynamic> json) => AuthorityListModel(
        status: json["status"],
        list: List<AuthorityListData>.from(json["list"].map((x) => AuthorityListData.fromJson(x))),
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

class AuthorityListData {
    int id;
    String authorityCode;
    String authorityName;
    String? mobile;
    String? url;
    String? location;
    int status;
    int createdBy;
    DateTime createdDate;
    int? updatedBy;
    DateTime? updatedDate;

    AuthorityListData({
        required this.id,
        required this.authorityCode,
        required this.authorityName,
         this.mobile,
         this.url,
         this.location,
        required this.status,
        required this.createdBy,
        required this.createdDate,
         this.updatedBy,
         this.updatedDate,
    });

    factory AuthorityListData.fromJson(Map<String, dynamic> json) => AuthorityListData(
        id: json["id"],
        authorityCode: json["authority_code"],
        authorityName: json["authority_name"],
        mobile: json["mobile"],
        url: json["url"],
        location: json["location"],
        status: json["status"],
        createdBy: json["created_by"],
        createdDate: DateTime.parse(json["created_date"]),
         updatedBy: json["updated_by"],
        updatedDate: json["updated_date"] == null
            ? null
            : DateTime.parse(json["updated_date"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "authority_code": authorityCode,
        "authority_name": authorityName,
        "mobile": mobile,
        "url": url,
        "location": location,
        "status": status,
        "created_by": createdBy,
        "created_date": createdDate.toIso8601String(),
         "updated_by": updatedBy,
        "updated_date": updatedDate?.toIso8601String(),
    };
}
