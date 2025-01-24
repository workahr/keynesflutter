// To parse this JSON data, do
//
//     final dashboardRecordModel = dashboardRecordModelFromJson(jsonString);

import 'dart:convert';

DashboardRecordModel dashboardRecordModelFromJson(String str) =>
    DashboardRecordModel.fromJson(json.decode(str));

String dashboardRecordModelToJson(DashboardRecordModel data) =>
    json.encode(data.toJson());

class DashboardRecordModel {
  String status;
  String code;
  Record? record;
  String message;

  DashboardRecordModel({
    required this.status,
    required this.code,
    this.record,
    required this.message,
  });

  factory DashboardRecordModel.fromJson(Map<String, dynamic> json) =>
      DashboardRecordModel(
        status: json["status"] ?? '',
        code: json["code"] ?? '',
        record: json["record"] != null && json["record"] is Map<String, dynamic>
            ? Record.fromJson(json["record"])
            : null,
        message: json["message"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "record": record?.toJson(),
        "message": message,
      };
}

class Record {
  int totalpayment;
  double paidpayment;
  double balancepayment;
  int closeEnquiry;
  int totalEnquiry;
  int confirmEnquiry;
  int activeEnquiry;
  List<ServiceList> serviceList;

  Record({
    required this.totalpayment,
    required this.paidpayment,
    required this.balancepayment,
    required this.closeEnquiry,
    required this.totalEnquiry,
    required this.confirmEnquiry,
    required this.activeEnquiry,
    required this.serviceList,
  });

  factory Record.fromJson(Map<String, dynamic> json) => Record(
        totalpayment: json["totalpayment"],
        paidpayment: json["paidpayment"],
        balancepayment: json["balancepayment"],
        closeEnquiry: json["close_enquiry"],
        totalEnquiry: json["total_enquiry"],
        confirmEnquiry: json["confirm_enquiry"],
        activeEnquiry: json["active_enquiry"],
        serviceList: List<ServiceList>.from(
            json["service_list"].map((x) => ServiceList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalpayment": totalpayment,
        "paidpayment": paidpayment,
        "balancepayment": balancepayment,
        "close_enquiry": closeEnquiry,
        "total_enquiry": totalEnquiry,
        "confirm_enquiry": confirmEnquiry,
        "active_enquiry": activeEnquiry,
        "service_list": List<dynamic>.from(serviceList.map((x) => x.toJson())),
      };
}

class ServiceList {
  double count;
  String name;

  ServiceList({
    required this.count,
    required this.name,
  });

  factory ServiceList.fromJson(Map<String, dynamic> json) => ServiceList(
        count: (json["count"] is int ? (json["count"] as int).toDouble() : json["count"]) ?? 0.0,
        name: json["name"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "name": name,
      };
}
