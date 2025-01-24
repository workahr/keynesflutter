// To parse this JSON data, do
//
//     final enquirydetailsListmodel = enquirydetailsListmodelFromJson(jsonString);

import 'dart:convert';

EnquirydetailsListmodel enquirydetailsListmodelFromJson(String str) =>
    EnquirydetailsListmodel.fromJson(json.decode(str));

String enquirydetailsListmodelToJson(EnquirydetailsListmodel data) =>
    json.encode(data.toJson());

class EnquirydetailsListmodel {
  String status;
  String code;
  Record record;
  String message;

  EnquirydetailsListmodel({
    required this.status,
    required this.code,
    required this.record,
    required this.message,
  });

  factory EnquirydetailsListmodel.fromJson(Map<String, dynamic> json) =>
      EnquirydetailsListmodel(
        status: json["status"],
        code: json["code"],
        record: Record.fromJson(json["record"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "record": record.toJson(),
        "message": message,
      };
}

class Record {
  int id;
  int? serviceId;
  String? clientName;
  String? mobile;
  String? email;
  String? address;
  String? notes;
  int? assignedFor;
  int? assignedPerson;
  String? referType;
  String? referPerson;
  String? enquiryStatus;
  String? serviceType;
  String? projectTitle;
  String? projectDescription;
  String? authority;
  int? status;
  int? createdBy;
  String? createdDate;
  int? updatedBy;
  DateTime updatedDate;
  int? quote;
  String? referenceNo;
  int? managerApproval;
  String? ownerName;
  String? ownerNumber;
  String? ownerEmail;
  int? revisionBtn;
  String? revisionStatus;
  int? updatedRole;
  String? duration;
  int? quoteSent;
  int? revisionNeeded;
  int? confrimed;
  int? paymentReceived;
  int? rejected;
  String? confirmImageUrl;
  String? invoiceEnquiryStatus;
  String? rejectReason;
  int? rejectReasonId;
  String? paidAmount;
  int? engManager;
  int? engAdmin;
  int? projEng;
  int? engDepartment;
  String? engineerDraftman;
  String? uploadPaymentDocument;
  int? proformaInvoice;
  String? document;
  String? documentSubmitted;
  String? documentStatus;
  String? uploadDoucumentStatus;
  String? documentStatusReason;
  String? documentSubmittedTo;
  String? safetyEng;
  String? remarks;
  String? projectLocation;
  String? plotNo;
  String? inspection;
  String? managerNotes;
  String? managerStatus;
  String? paymentTerms;
  String? confirmedDate;
  String? projectStatus;
  String? layoutDoc;
  String? extraPayment;
  String? projectDt;
  String? salesExeName;
  String? projEngName;
  String? engAdminName;
  String? deptEngName;
  String? engDraftFullname;
  String? safetyEngName;
  String? totalServices;
  List<PaymentHistory> paymentHistory;
  String? receivedAmount;
  String? closedDate;
  String? nClosedDate;
  String? enginnersName;
  String? totalAmount;

  Record({
    required this.id,
    this.serviceId,
    this.clientName,
    this.mobile,
    this.email,
    this.address,
    this.notes,
    this.assignedFor,
    this.assignedPerson,
    this.referType,
    this.referPerson,
    this.enquiryStatus,
    this.serviceType,
    this.projectTitle,
    this.projectDescription,
    this.authority,
    this.status,
    this.createdBy,
    this.createdDate,
    this.updatedBy,
    required this.updatedDate,
    this.quote,
    this.referenceNo,
    this.managerApproval,
    this.ownerName,
    this.ownerNumber,
    this.ownerEmail,
    this.revisionBtn,
    this.revisionStatus,
    this.updatedRole,
    this.duration,
    this.quoteSent,
    this.revisionNeeded,
    this.confrimed,
    this.paymentReceived,
    this.rejected,
    this.confirmImageUrl,
    this.invoiceEnquiryStatus,
    this.rejectReason,
    this.rejectReasonId,
    this.paidAmount,
    this.engManager,
    this.engAdmin,
    this.projEng,
    this.engDepartment,
    this.engineerDraftman,
    this.uploadPaymentDocument,
    this.proformaInvoice,
    this.document,
    this.documentSubmitted,
    this.documentStatus,
    this.uploadDoucumentStatus,
    this.documentStatusReason,
    this.documentSubmittedTo,
    this.safetyEng,
    this.remarks,
    this.projectLocation,
    this.plotNo,
    this.inspection,
    this.managerNotes,
    this.managerStatus,
    this.paymentTerms,
    this.confirmedDate,
    this.projectStatus,
    this.layoutDoc,
    this.extraPayment,
    this.projectDt,
    this.salesExeName,
    this.projEngName,
    this.engAdminName,
    this.deptEngName,
    this.engDraftFullname,
    this.safetyEngName,
    this.totalServices,
    required this.paymentHistory,
    this.receivedAmount,
    this.closedDate,
    this.nClosedDate,
    this.enginnersName,
    this.totalAmount,
  });

  factory Record.fromJson(Map<String, dynamic> json) => Record(
        id: json["id"],
        serviceId: json["service_id"],
        clientName: json["client_name"],
        mobile: json["mobile"],
        email: json["email"],
        address: json["address"],
        notes: json["notes"],
        assignedFor: json["assigned_for"],
        assignedPerson: json["assigned_person"],
        referType: json["refer_type"],
        referPerson: json["refer_person"],
        enquiryStatus: json["enquiry_status"],
        serviceType: json["service_type"],
        projectTitle: json["project_title"],
        projectDescription: json["project_description"],
        authority: json["authority"],
        status: json["status"],
        createdBy: json["created_by"],
        createdDate: json["created_date"],
        updatedBy: json["updated_by"],
        updatedDate: DateTime.parse(json["updated_date"]),
        quote: json["quote"],
        referenceNo: json["reference_no"],
        managerApproval: json["manager_approval"],
        ownerName: json["owner_name"],
        ownerNumber: json["owner_number"],
        ownerEmail: json["owner_email"],
        revisionBtn: json["revision_btn"],
        revisionStatus: json["revision_status"],
        updatedRole: json["updated_role"],
        duration: json["duration"],
        quoteSent: json["quote_sent"],
        revisionNeeded: json["revision_needed"],
        confrimed: json["confrimed"],
        paymentReceived: json["payment_received"],
        rejected: json["rejected"],
        confirmImageUrl: json["confirm_image_url"],
        invoiceEnquiryStatus: json["invoice_enquiry_status"],
        rejectReason: json["reject_reason"],
        rejectReasonId: json["reject_reason_id"],
        paidAmount: json["paid_amount"],
        engManager: json["eng_manager"],
        engAdmin: json["eng_admin"],
        projEng: json["proj_eng"],
        engDepartment: json["eng_department"],
        engineerDraftman: json["engineer_draftman"],
        uploadPaymentDocument: json["upload_payment_document"],
        proformaInvoice: json["proforma_invoice"],
        document: json["document"],
        documentSubmitted: json["document_submitted"],
        documentStatus: json["document_status"],
        uploadDoucumentStatus: json["upload_doucument_status"],
        documentStatusReason: json["document_status_reason"],
        documentSubmittedTo: json["document_submitted_to"],
        safetyEng: json["safety_eng"],
        remarks: json["remarks"],
        projectLocation: json["project_location"],
        plotNo: json["plot_no"],
        inspection: json["inspection"],
        managerNotes: json["manager_notes"],
        managerStatus: json["manager_status"],
        paymentTerms: json["payment_terms"],
        confirmedDate: json["confirmed_date"],
        projectStatus: json["project_status"],
        layoutDoc: json["layout_doc"],
        extraPayment: json["extra_payment"],
        projectDt: json["project_dt"],
        salesExeName: json["sales_exe_name"],
        projEngName: json["proj_eng_name"],
        engAdminName: json["eng_admin_name"],
        deptEngName: json["dept_eng_name"],
        engDraftFullname: json["eng_draft_fullname"],
        safetyEngName: json["safety_eng_name"],
        totalServices: json["total_services"],
        paymentHistory: json["payment_history"] == null
            ? []
            : List<PaymentHistory>.from(
                json["payment_history"].map((x) => PaymentHistory.fromJson(x))),
        receivedAmount: json["received_amount"],
        closedDate: json["closed_date"],
        nClosedDate: json["n_closed_date"],
        enginnersName: json["enginners_name"],
        totalAmount: json["total_amount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service_id": serviceId,
        "client_name": clientName,
        "mobile": mobile,
        "email": email,
        "address": address,
        "notes": notes,
        "assigned_for": assignedFor,
        "assigned_person": assignedPerson,
        "refer_type": referType,
        "refer_person": referPerson,
        "enquiry_status": enquiryStatus,
        "service_type": serviceType,
        "project_title": projectTitle,
        "project_description": projectDescription,
        "authority": authority,
        "status": status,
        "created_by": createdBy,
        "created_date": createdDate,
        "updated_by": updatedBy,
        "updated_date": updatedDate.toIso8601String(),
        "quote": quote,
        "reference_no": referenceNo,
        "manager_approval": managerApproval,
        "owner_name": ownerName,
        "owner_number": ownerNumber,
        "owner_email": ownerEmail,
        "revision_btn": revisionBtn,
        "revision_status": revisionStatus,
        "updated_role": updatedRole,
        "duration": duration,
        "quote_sent": quoteSent,
        "revision_needed": revisionNeeded,
        "confrimed": confrimed,
        "payment_received": paymentReceived,
        "rejected": rejected,
        "confirm_image_url": confirmImageUrl,
        "invoice_enquiry_status": invoiceEnquiryStatus,
        "reject_reason": rejectReason,
        "reject_reason_id": rejectReasonId,
        "paid_amount": paidAmount,
        "eng_manager": engManager,
        "eng_admin": engAdmin,
        "proj_eng": projEng,
        "eng_department": engDepartment,
        "engineer_draftman": engineerDraftman,
        "upload_payment_document": uploadPaymentDocument,
        "proforma_invoice": proformaInvoice,
        "document": document,
        "document_submitted": documentSubmitted,
        "document_status": documentStatus,
        "upload_doucument_status": uploadDoucumentStatus,
        "document_status_reason": documentStatusReason,
        "document_submitted_to": documentSubmittedTo,
        "safety_eng": safetyEng,
        "remarks": remarks,
        "project_location": projectLocation,
        "plot_no": plotNo,
        "inspection": inspection,
        "manager_notes": managerNotes,
        "manager_status": managerStatus,
        "payment_terms": paymentTerms,
        "confirmed_date": confirmedDate,
        "project_status": projectStatus,
        "layout_doc": layoutDoc,
        "extra_payment": extraPayment,
        "project_dt": projectDt,
        "sales_exe_name": salesExeName,
        "proj_eng_name": projEngName,
        "eng_admin_name": engAdminName,
        "dept_eng_name": deptEngName,
        "eng_draft_fullname": engDraftFullname,
        "safety_eng_name": safetyEngName,
        "total_services": totalServices,
        "payment_history":
            List<dynamic>.from(paymentHistory.map((x) => x.toJson())),
        "received_amount": receivedAmount,
        "closed_date": closedDate,
        "n_closed_date": nClosedDate,
        "enginners_name": enginnersName,
        "total_amount": totalAmount,
      };
}

class PaymentHistory {
  String? amount;
  String? paymentMode;
  String? createdDate;

  PaymentHistory({
    this.amount,
    this.paymentMode,
    this.createdDate,
  });

  factory PaymentHistory.fromJson(Map<String, dynamic> json) => PaymentHistory(
        amount: json["amount"],
        paymentMode: json["payment_mode"],
        createdDate: json["created_date"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "payment_mode": paymentMode,
        "created_date": createdDate,
      };
}
