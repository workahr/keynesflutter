import 'dart:convert';

// To parse this JSON data, you can use:
// final enquiryListModel = enquiryListModelFromJson(jsonString);

EnquiryListModel enquiryListModelFromJson(String str) =>
    EnquiryListModel.fromJson(json.decode(str));

String enquiryListModelToJson(EnquiryListModel data) =>
    json.encode(data.toJson());

class EnquiryListModel {
  String status;
  List<DasEnquiryListData> list;
  String code;
  String message;

  EnquiryListModel({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  // Factory constructor to create an instance from JSON data
  factory EnquiryListModel.fromJson(Map<String, dynamic> json) {
    try {
      return EnquiryListModel(
        status: json["status"] ?? 'UNKNOWN',
        list: json["list"] != null
            ? List<DasEnquiryListData>.from(
                json["list"].map((x) => DasEnquiryListData.fromJson(x)))
            : [],
        code: json["code"] ?? 'N/A',
        message: json["message"] ?? 'No message',
      );
    } catch (e) {
      print('Error parsing EnquiryListModel: $e');
      return EnquiryListModel(
        status: 'ERROR',
        list: [],
        code: 'N/A',
        message: 'Parsing error',
      );
    }
  }

  // Method to convert the instance back to JSON
  Map<String, dynamic> toJson() => {
        "status": status,
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
        "code": code,
        "message": message,
      };
}

class DasEnquiryListData {
  int id;
  int serviceId;
  String? clientName;
  String? mobile;
  String? email;
  String? address;
  String? notes;
  String? referType;
  String? referPerson;
  String? enquiryStatus;
  String? serviceName;
  int status;
  int createdBy;
  DateTime createdDate;
  int? updatedBy;
  DateTime? updatedDate;

  DasEnquiryListData({
    required this.id,
    required this.serviceId,
    this.clientName,
    this.mobile,
    this.email,
    this.address = '', // Default to an empty string
    this.notes,
    this.referType,
    this.referPerson = '', // Default to an empty string
    this.enquiryStatus,
    this.serviceName,
    required this.status,
    required this.createdBy,
    required this.createdDate,
    this.updatedBy,
    this.updatedDate,
  });

  // Factory constructor to create an instance from JSON data
  factory DasEnquiryListData.fromJson(Map<String, dynamic> json) {
    try {
      return DasEnquiryListData(
        id: json["id"],
        serviceId: json["service_id"],
        clientName: json["client_name"],
        mobile: json["mobile"],
        email: json["email"],
        address: json["address"],
        notes: json["notes"],
        referType: json["refer_type"],
        referPerson: json["refer_person"],
        enquiryStatus: json["enquiry_status"],
        serviceName: json["service_name"],
        status: json["status"],
        createdBy: json["created_by"],
        createdDate: DateTime.parse(json["created_date"]),
        updatedBy: json["updated_by"],
        updatedDate: json["updated_date"] != null
            ? DateTime.parse(json["updated_date"])
            : null,
      );
    } catch (e) {
      print('Error parsing DasEnquiryListData: $e');
      // Return a default object with minimum required fields in case of error
      return DasEnquiryListData(
        id: 0,
        serviceId: 0,
        clientName: 'Unknown',
        mobile: 'Unknown',
        email: 'Unknown',
        notes: 'No notes',
        referType: 'Unknown',
        enquiryStatus: 'Unknown',
        serviceName: 'Unknown',
        status: 0,
        createdBy: 0,
        createdDate: DateTime.now(),
      );
    }
  }

  // Method to convert the instance back to JSON
  Map<String, dynamic> toJson() => {
        "id": id,
        "service_id": serviceId,
        "client_name": clientName,
        "mobile": mobile,
        "email": email,
        "address": address,
        "notes": notes,
        "refer_type": referType,
        "refer_person": referPerson,
        "enquiry_status": enquiryStatus,
        "service_name": serviceName,
        "status": status,
        "created_by": createdBy,
        "created_date": createdDate.toIso8601String(),
        "updated_by": updatedBy,
        "updated_date": updatedDate?.toIso8601String(),
      };
}









// // To parse this JSON data, do
// //
// //     final enquiryListModel = enquiryListModelFromJson(jsonString);

// import 'dart:convert';

// EnquiryListModel enquiryListModelFromJson(String str) =>
//     EnquiryListModel.fromJson(json.decode(str));

// String enquiryListModelToJson(EnquiryListModel data) =>
//     json.encode(data.toJson());

// class EnquiryListModel {
//   String status;
//   List<DasEnquiryListData> list;
//   String code;
//   String message;

//   EnquiryListModel({
//     required this.status,
//     required this.list,
//     required this.code,
//     required this.message,
//   });

//   factory EnquiryListModel.fromJson(Map<String, dynamic> json) =>
//       EnquiryListModel(
//         status: json["status"],
//         list: List<DasEnquiryListData>.from(
//             json["list"].map((x) => DasEnquiryListData.fromJson(x))),
//         code: json["code"],
//         message: json["message"],
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "list": List<dynamic>.from(list.map((x) => x.toJson())),
//         "code": code,
//         "message": message,
//       };
// }

// class DasEnquiryListData {
//   int id;
//   int serviceId;
//   String clientName;
//   String mobile;
//   String email;
//   String? address;
//   String notes;
//   String referType;
//   String? referPerson;
//   String enquiryStatus;
//   int status;
//   int createdBy;
//   DateTime createdDate;
//   int? updatedBy;
//   DateTime? updatedDate;

//   DasEnquiryListData({
//     required this.id,
//     required this.serviceId,
//     required this.clientName,
//     required this.mobile,
//     required this.email,
//     required this.address,
//     required this.notes,
//     required this.referType,
//     required this.referPerson,
//     required this.enquiryStatus,
//     required this.status,
//     required this.createdBy,
//     required this.createdDate,
//     required this.updatedBy,
//     required this.updatedDate,
//   });

//   factory DasEnquiryListData.fromJson(Map<String, dynamic> json) =>
//       DasEnquiryListData(
//         id: json["id"],
//         serviceId: json["service_id"],
//         clientName: json["client_name"],
//         mobile: json["mobile"],
//         email: json["email"],
//         address: json["address"],
//         notes: json["notes"],
//         referType: json["refer_type"],
//         referPerson: json["refer_person"],
//         enquiryStatus: json["enquiry_status"],
//         status: json["status"],
//         createdBy: json["created_by"],
//         createdDate: DateTime.parse(json["created_date"]),
//         updatedBy: json["updated_by"],
//         updatedDate: json["updated_date"] == null
//             ? null
//             : DateTime.parse(json["updated_date"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "service_id": serviceId,
//         "client_name": clientName,
//         "mobile": mobile,
//         "email": email,
//         "address": address,
//         "notes": notes,
//         "refer_type": referType,
//         "refer_person": referPerson,
//         "enquiry_status": enquiryStatus,
//         "status": status,
//         "created_by": createdBy,
//         "created_date": createdDate.toIso8601String(),
//         "updated_by": updatedBy,
//         "updated_date": updatedDate?.toIso8601String(),
//       };
// }
