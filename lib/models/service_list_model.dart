// To parse this JSON data, do
//
//     final serviceListModel = serviceListModelFromJson(jsonString);

import 'dart:convert';

ServiceListModel serviceListModelFromJson(String str) => ServiceListModel.fromJson(json.decode(str));

String serviceListModelToJson(ServiceListModel data) => json.encode(data.toJson());

class ServiceListModel {
    String status;
    List<ServicesListData> list;
    String code;
    String message;

    ServiceListModel({
        required this.status,
        required this.list,
        required this.code,
        required this.message,
    });

    factory ServiceListModel.fromJson(Map<String, dynamic> json) => ServiceListModel(
        status: json["status"],
        list: List<ServicesListData>.from(json["list"].map((x) => ServicesListData.fromJson(x))),
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

class ServicesListData {
    int id;
    String name;
    String description;
    String price;
    int status;
    int createdBy;
    DateTime createdDate;
    int? updatedBy;
    DateTime? updatedDate;

    ServicesListData({
        required this.id,
        required this.name,
        required this.description,
        required this.price,
        required this.status,
        required this.createdBy,
        required this.createdDate,
         this.updatedBy,
         this.updatedDate,
    });

    factory ServicesListData.fromJson(Map<String, dynamic> json) => ServicesListData(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        status: json["status"],
        createdBy: json["created_by"],
        createdDate: DateTime.parse(json["created_date"]),
        updatedBy: json["updated_by"],
        updatedDate: json["updated_date"] == null ? null : DateTime.parse(json["updated_date"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "status": status,
        "created_by": createdBy,
        "created_date": createdDate.toIso8601String(),
        "updated_by": updatedBy,
        "updated_date": updatedDate?.toIso8601String(),
    };
}
