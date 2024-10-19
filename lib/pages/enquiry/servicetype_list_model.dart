// To parse this JSON data, do
//
//     final servicetypeListModel = servicetypeListModelFromJson(jsonString);

import 'dart:convert';

ServicetypeListModel servicetypeListModelFromJson(String str) => ServicetypeListModel.fromJson(json.decode(str));

String servicetypeListModelToJson(ServicetypeListModel data) => json.encode(data.toJson());

class ServicetypeListModel {
    String status;
    List<ServiceTypeList> list;
    String code;
    String message;

    ServicetypeListModel({
        required this.status,
        required this.list,
        required this.code,
        required this.message,
    });

    factory ServicetypeListModel.fromJson(Map<String, dynamic> json) => ServicetypeListModel(
        status: json["status"],
        list: List<ServiceTypeList>.from(json["list"].map((x) => ServiceTypeList.fromJson(x))),
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

class ServiceTypeList {
    int id;
    String serviceName;
    int status;
    int createdBy;
    DateTime createdDate;
    int? updatedBy;
    DateTime? updatedDate;

    ServiceTypeList({
        required this.id,
        required this.serviceName,
        required this.status,
        required this.createdBy,
        required this.createdDate,
         this.updatedBy,
         this.updatedDate,
    });

    factory ServiceTypeList.fromJson(Map<String, dynamic> json) => ServiceTypeList(
        id: json["id"],
        serviceName: json["service_name"],
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
        "service_name": serviceName,
        "status": status,
        "created_by": createdBy,
        "created_date": createdDate.toIso8601String(),
        "updated_by": updatedBy,
        "updated_date": updatedDate?.toIso8601String(),
    };
}
