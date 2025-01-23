// To parse this JSON data, do
//
//     final enquiryListmodel = enquiryListmodelFromJson(jsonString);

import 'dart:convert';

EnquiryListmodel enquiryListmodelFromJson(String str) => EnquiryListmodel.fromJson(json.decode(str));

String enquiryListmodelToJson(EnquiryListmodel data) => json.encode(data.toJson());

class EnquiryListmodel {
    String status;
    String code;
    List<Record> record;
    String message;

    EnquiryListmodel({
        required this.status,
        required this.code,
        required this.record,
        required this.message,
    });

    factory EnquiryListmodel.fromJson(Map<String, dynamic> json) => EnquiryListmodel(
        status: json["status"],
        code: json["code"],
        record: List<Record>.from(json["record"].map((x) => Record.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "record": List<dynamic>.from(record.map((x) => x.toJson())),
        "message": message,
    };
}

class Record {
    String? projectStatus;
    String? clientName;
    String? projectTitle;
    String? refer;
    String? department;
    String createdDate;
    int id;

    Record({
         this.projectStatus,
         this.clientName,
         this.projectTitle,
         this.refer,
         this.department,
        required this.createdDate,
        required this.id,
    });

    factory Record.fromJson(Map<String, dynamic> json) => Record(
        projectStatus: json["project_status"],
        clientName: json["client_name"],
        projectTitle: json["project_title"],
        refer: json["refer"],
        department: json["department"],
        createdDate: json["created_date"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "project_status": projectStatus,
        "client_name": clientName,
        "project_title": projectTitle,
        "refer": refer,
        "department": department,
        "created_date": createdDate,
        "id": id,
    };
}

enum Department {
    KEYNES_APPROVAL
}

final departmentValues = EnumValues({
    "Keynes Approval": Department.KEYNES_APPROVAL
});

enum Refer {
    SALES_EXECUTIVE
}

final referValues = EnumValues({
    "Sales Executive": Refer.SALES_EXECUTIVE
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
