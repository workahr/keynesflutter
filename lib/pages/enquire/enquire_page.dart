import 'package:flutter/material.dart';
import 'package:keynes/constants/app_colors.dart';
import 'package:shimmer/shimmer.dart';
import 'enquire_view_more.dart';
import 'enquiry_list_model.dart';
import '../../services/keynes_api_service.dart';
import '../../constants/app_assets.dart';
import 'package:intl/intl.dart';
import '../../services/comFuncService.dart';
import 'from_to_date_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_file/open_file.dart';
// import 'dart:html' as html;
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart'; // For kIsWeb

class EnquirePage extends StatefulWidget {
  const EnquirePage({super.key});

  @override
  State<EnquirePage> createState() => _EnquirePageState();
}

class _EnquirePageState extends State<EnquirePage> {
  final KeynesApiService apiService = KeynesApiService();
  bool isLoading = false;
  DateTime? fromDate;
  DateTime? toDate;
  @override
  void initState() {
    getenquirylistbyadmin_app();
    super.initState();
  }

  List<Record>? enquiryesList = [];
  List<Record>? enquiryesListAll = [];

  void filterEnquiriesByDate() {
    if (fromDate != null && toDate != null) {
      setState(() {
        enquiryesList = enquiryesListAll!.where((record) {
          DateTime? createdDate = parseApiDate(record.createdDate);

          if (createdDate != null) {
            return createdDate
                    .isAfter(fromDate!.subtract(const Duration(days: 1))) &&
                createdDate.isBefore(toDate!.add(const Duration(days: 1)));
          }
          return false;
        }).toList();
      });
    } else {
      setState(() {
        enquiryesList = enquiryesListAll;
      });
    }
  }

  DateTime? parseApiDate(String apiDate) {
    try {
      return DateFormat("dd-MMM-yyyy").parse(apiDate);
    } catch (e) {
      print("Error parsing date: $e");
      return null;
    }
  }

  Future getenquirylistbyadmin_app() async {
    await apiService.getBearerToken();
    var result = await apiService.getenquirylistbyadmin_app();
    print('hi $result');
    EnquiryListmodel response = enquiryListmodelFromJson(result);
    if (response.status.toString() == 'SUCCESS') {
      setState(() {
        enquiryesList = response.record;
        enquiryesListAll = enquiryesList;
        print('hello $enquiryesList');
      });
    } else {
      setState(() {
        enquiryesList = [];
        enquiryesListAll = [];
      });
      showInSnackBar(context, response.status);
    }
    setState(() {});
  }

  Future<DateTime?> _selectDate({
    required BuildContext context,
    required DateTime initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    return await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate ?? DateTime(2000),
      lastDate: lastDate ?? DateTime(2100),
    );
  }




//    Future<void> _createAndDownloadPDF() async {
//     if (!kIsWeb && !await _requestStoragePermission()) return;
// final arabicFont = pw.Font.ttf(await rootBundle.load("assets/fonts/NotoNaskhArabic-Regular.ttf"));
// final pdf = pw.Document();
// final ByteData bytes = await rootBundle.load(AppAssets.keynesLogo);
// final Uint8List imageBytes = bytes.buffer.asUint8List();

//   final tableHeaders = ['S.No', 'Description', 'Qty', 'Rate', 'Amount AED'];
//   final tableData = [
//     ['1', 'added service', '1', '3,000.00', '3,000.00'],
//     ['2', 'sampl3', '1', '2,000.00', '2,000.00'],
//     ['3', 'another added service', '1', '1,000.00', '1,000.00'],
//     ['4', 'added revision', '1', '1,000.00', '1,000.00'],
//     ['5', 'added revision 2', '1', '3,000.00', '3,000.00'],
//   ];

// pdf.addPage(
//   pw.Page(
//     pageFormat: PdfPageFormat.a4,
//     build: (context) => pw.Column(
//       crossAxisAlignment: pw.CrossAxisAlignment.start,
//       children: [
//         // Header
//         pw.Row(
//          // mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//           children: [
//             pw.Container(
//               height: 70,
//               width: 120,
//               child: pw.Image(pw.MemoryImage(imageBytes), height: 50.0),
//             ),
//             pw.SizedBox(width: 10),
//             pw.Column(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               children: [
//              pw.Text(
//           "كينيس للإنشاءات و التصميم ش ذم م",
//           style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold,color: PdfColor.fromInt(0xFF095FA8), font: arabicFont),
//           textDirection: pw.TextDirection.rtl, // Right-to-left (RTL) support
//         ),
//                 pw.Text("KEYNES CONSTRUCTIONS & INTERIORS L.L.C",
//                     style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold, color: PdfColor.fromInt(0xFF095FA8))),
//               ],
//             ),
//           ],
//         ),
//         pw.SizedBox(height: 5),
//         pw.Center(
//           child: pw.Text("TAX INVOICE", style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
//         ),
//         pw.Center(
//           child: pw.SizedBox(width: 100,child: pw.Divider(thickness: 1, color: PdfColors.black))),
//  pw.SizedBox(height: 5),
//         // Invoice Details
//         pw.Row(
//           mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//           children: [
//             pw.Column(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               children: [
//                 pw.Text("Bill To:",style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10)),
//                  pw.Text("Client Name: prasathh",style: pw.TextStyle( fontSize: 10)),
//                   pw.Text("Address:",style: pw.TextStyle(fontSize: 10)),
//                    pw.Text("Mail:",style: pw.TextStyle( fontSize: 10)),
//                 pw.Text("TRN: XXXX",style: pw.TextStyle( fontSize: 10)),
//                pw.Text( "PROJECT: enquiry_check",style: pw.TextStyle(fontSize: 10)),
//               ],
//             ),
//             pw.Column(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               children: [
//                 pw.Text("Receipt No: KCI/2025-057",style: pw.TextStyle( fontSize: 10)),
//                 pw.Text("Date: 30-01-2025",style: pw.TextStyle( fontSize: 10)),
//                 pw.Text("Quote Reference: KCI/CW/2501-98/R1/15/01",style: pw.TextStyle( fontSize: 10)),
//                 pw.Text("LPO: XXXX",style: pw.TextStyle( fontSize: 10)),
//                 pw.Text("TRN: 100318432000003",style: pw.TextStyle( fontSize: 10)),
//                 pw.Text("PaymentTerms: ADVANCE/PART/BALANCE",style: pw.TextStyle( fontSize: 10)),
//               ],
//             ),
//           ],
//         ),
//         pw.SizedBox(height: 10),

//         // Table
//         pw.Table(
//               border: pw.TableBorder.all(color: PdfColors.black, width: 0.5),
//               columnWidths: {
//                 0: pw.FixedColumnWidth(40), // S.No
//                 1: pw.FlexColumnWidth(), // Description
//                 2: pw.FixedColumnWidth(40), // Qty
//                 3: pw.FixedColumnWidth(70), // Rate
//                 4: pw.FixedColumnWidth(70), // Amount AED
//               },
//               children: [
//                 // Header Row
//                 pw.TableRow(
//                   decoration: pw.BoxDecoration(color: PdfColor.fromInt(0xFFB8CEE5),),
//                   children: tableHeaders
//                       .map(
//                         (header) => pw.Container(
//                           padding: pw.EdgeInsets.all(8),
//                           alignment: pw.Alignment.center,
//                           child: pw.Text(
//                             header,
//                             style: pw.TextStyle(
//                               //fontWeight: pw.FontWeight.bold,
//                               color: PdfColors.black,
//                             ),
//                           ),
//                         ),
//                       )
//                       .toList(),
//                 ),
//                 // Table Data Rows
//                 ...tableData.map(
//                   (row) => pw.TableRow(
//                     decoration: pw.BoxDecoration(
//                       border: pw.Border(
//                         bottom: pw.BorderSide(color: PdfColors.grey, width: 0.5),
//                       ),
//                     ),
//                     children: row
//                         .map(
//                           (cell) => pw.Container(
//                             padding: pw.EdgeInsets.all(6),
//                             alignment: row.indexOf(cell) > 0
//                                 ? pw.Alignment.centerRight
//                                 : pw.Alignment.centerLeft,
//                             child: pw.Text(cell),
//                           ),
//                         )
//                         .toList(),
//                   ),
//                 ),
//                 // Total Project Value in Second Column
//                 pw.TableRow(
//                   decoration: pw.BoxDecoration(
//                     border: pw.Border(
//                       top: pw.BorderSide(color: PdfColors.black, width: 0.5),
//                     ),
//                   ),
//                   children: [
//                     pw.Container(), // Empty for S.No
//                     pw.Container(
//                       padding: pw.EdgeInsets.all(8),
//                       child: pw.Text("Total Project value : 10000 + Vat 5%"),
//                     ),
//                     pw.Container(), // Empty for Qty
//                     pw.Container(), // Empty for Rate
//                     pw.Container(), // Empty for Amount
//                   ],
//                 ),
//                 // Sub Total Inside Table
//                 pw.TableRow(children: [
//                   pw.Container(),
//                   pw.Container(),
//                   pw.Container(),
//                   pw.Container(
//                     padding: pw.EdgeInsets.all(8),
//                     alignment: pw.Alignment.centerRight,
//                     child: pw.Text("Sub Total"),
//                   ),
//                   pw.Container(
//                     padding: pw.EdgeInsets.all(8),
//                     alignment: pw.Alignment.centerRight,
//                     child: pw.Text("10,000.00"),
//                   ),
//                 ]),
//                 pw.TableRow(children: [
//                   pw.Container(),
//                   pw.Container(),
//                   pw.Container(),
//                   pw.Container(
//                     padding: pw.EdgeInsets.all(8),
//                     alignment: pw.Alignment.centerRight,
//                     child: pw.Text("VAT 5%"),
//                   ),
//                   pw.Container(
//                     padding: pw.EdgeInsets.all(8),
//                     alignment: pw.Alignment.centerRight,
//                     child: pw.Text("500.00"),
//                   ),
//                 ]),
//                 pw.TableRow(children: [
//                   pw.Container(),
//                   pw.Container(),
//                   pw.Container(),
//                   pw.Container(
//                     padding: pw.EdgeInsets.all(8),
//                     alignment: pw.Alignment.centerRight,
//                     child: pw.Text("Extra Payment"),
//                   ),
//                   pw.Container(
//                     padding: pw.EdgeInsets.all(8),
//                     alignment: pw.Alignment.centerRight,
//                     child: pw.Text("5,000.00"),
//                   ),
//                 ]),
//                 // Grand Total Row (Bold)
//                 pw.TableRow(
//                   decoration: pw.BoxDecoration(
//                     border: pw.Border(
//                       top: pw.BorderSide(color: PdfColors.black, width: 0.5),
//                     ),
//                   ),
//                   children: [
//                     pw.Container(),
//                     pw.Container( padding: pw.EdgeInsets.all(8),
//                       child: pw.Text("Dirhams Fifteen Thousand Five Hundred Only"),),
//                     pw.Container(),
//                     pw.Container(
//                       padding: pw.EdgeInsets.all(8),
//                       alignment: pw.Alignment.centerRight,
//                       child: pw.Text(
//                         "Grand Total",
//                         style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//                       ),
//                     ),
//                     pw.Container(
//                       padding: pw.EdgeInsets.all(8),
//                       alignment: pw.Alignment.centerRight,
//                       child: pw.Text(
//                         "15,500.00",
//                         style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),

//         pw.Text("Terms & Conditions:", style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10)),
//          pw.SizedBox(height: 10),
//         pw.Text("1.50% Kindly remit the payments by Cheque/Bank Transfer as per the detail mentioned below.", style: pw.TextStyle(fontSize: 9)),
//         pw.Text("2.50% Any discrepancy found in this invoice should be notified to us within 7 days of the receipt of the invoice; otherwise, the invoice will be "
//        " considered to becorrect and charged accordingly.", style: pw.TextStyle(fontSize: 9)),

//         pw.SizedBox(height: 5),

//         // Bank Details (Reduced Spacing)
//         pw.Container(
//           padding: pw.EdgeInsets.all(5),
//           decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColors.grey)),
//           child: pw.Column(
//             crossAxisAlignment: pw.CrossAxisAlignment.start,
//             children: [
//               pw.Text("Bank Details:", style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10)),
//               pw.Text("Account Title:Keynes Constructions & Interiors LLC", style: pw.TextStyle(fontSize: 9)),
//               pw.Text("Bank: ADCB, Branch: Dragon Mart", style: pw.TextStyle(fontSize: 9)),
//               pw.Text("Acc No: 10195403920004", style: pw.TextStyle(fontSize: 9)),
//               pw.Text(" IBAN: AE890030010195403920004", style: pw.TextStyle(fontSize: 9)),
//               pw.Text("SWIFT Code: ADCBAEAAFIN", style: pw.TextStyle(fontSize: 9)),
//             ],
//           ),
//         ),

//         pw.SizedBox(height: 10),

//         // Signature Section
//         pw.Row(
//           mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//           children: [
//             pw.Column(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               children: [
//                 pw.Text("For Keynes Constructions & Interiors LLC", style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10)),
//               ],
//             ),
//             pw.Column(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               children: [
//                 pw.Text("Received by", style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10)),
//                 pw.SizedBox(height: 5),
//                 pw.Text("Signature", style: pw.TextStyle(fontSize: 9)),
//                 pw.Text("Name", style: pw.TextStyle(fontSize: 9)),
//                 pw.Text("Date", style: pw.TextStyle(fontSize: 9)),
//               ],
//             ),
//           ],
//         ),

//         pw.SizedBox(height:10),

//         // Footer
//         pw.Text("Office No.305, 3rd floor | Oxford Tower, Business Bay | P.O. Box 299560 | Dubai, United Arab Emirates. Tel: +971 4 4534945 | Fax: +971 4 453 4947 | Email:"
// "info@keynesgroupuae.com | www.keynesgroupuae.com", style: pw.TextStyle(fontSize: 9, color: PdfColor.fromInt(0xFF095FA8))),
     
//       ],
//     ),
//   ),
// );


//     final pdfBytes = await pdf.save();

//     if (kIsWeb) {
//    //   _downloadPdfWeb(pdfBytes);
//     } else {
//       await _downloadPdfAndroid(pdfBytes);
//     }
//   }


// Future<void> generateQuotationPDF() async {
//   final pdf = pw.Document();
// final ByteData bytes = await rootBundle.load(AppAssets.keynesLogo);
// final Uint8List imageBytes = bytes.buffer.asUint8List();
//   pdf.addPage(
//     pw.MultiPage(
//       pageFormat: PdfPageFormat.a4,
//       margin: pw.EdgeInsets.all(32),
//       build: (pw.Context context) {
//         return [
//           // Header Section
//           pw.Row(
//             mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//             children: [
//              pw.Container(
//               height: 70,
//               width: 120,
//               child: pw.Image(pw.MemoryImage(imageBytes), height: 50.0),
//             ),
//               pw.Column(
//                 crossAxisAlignment: pw.CrossAxisAlignment.end,
//                 children: [
//                   pw.Text("KEYNES CONSTRUCTIONS & INTERIORS L.L.C", style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
//                   pw.Text("Date: 07.03.2025"),
//                   pw.Text("Ref No: KCIAQ/2503-80/R0/DSLN"),
//                 ],
//               ),
//             ],
//           ),
          
//           pw.SizedBox(height: 20),
          
//           // Client Details
//           pw.Text("M/s: PEROrient building contracting llc", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//           pw.Text("Mr. Dinesh"),
//           pw.Text("Mob: +971 0507036781"),
//           pw.Text("Email: dinesh@perobc.ae"),
//           pw.Text("Subject: Quotation For DEWA Approval"),
//           pw.Text("Project: B+G+1 VILLA - Temporary DEWA Connection @ Al Manara"),
          
//           pw.SizedBox(height: 20),
          
//           // Table with Scope of Services
//           pw.Table.fromTextArray(
//             border: pw.TableBorder.all(width: 1),
//             cellAlignment: pw.Alignment.centerLeft,
//             headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//             headers: ["ITEM", "SCOPE OF SERVICES", "AED"],
//             data: [
//               ["1", "Pre-approval Services: Complete set of documentations and drawings as per authority requirements.", "8000.00"],
//               ["2", "Post approval Services: Arrange & attend necessary inspections with authorities for completion.", "0.00"],
//               ["", "ALL THE GOVT FEES TO BE PROVIDED BY THE CLIENT", ""],
//               ["", "VAT Additional To All Invoice", "400.00"],
//               ["", "Total Value (Including VAT)", "8,400.00"],
//             ],
//           ),
          
//           pw.SizedBox(height: 20),
          
//           // Payment Terms
//           pw.Text("PAYMENT TERMS", style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
//           pw.Text("1. 50% ADVANCE REQUIRED UPON CONFIRMATION OF PROJECT"),
//           pw.Text("2. 50% REMAINING DUE BEFORE PERMIT RELEASE"),
          
//           pw.SizedBox(height: 10),
          
//           pw.Text("MODE OF PAYMENT", style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
//           pw.Text("1. Payment should be made by Cash, Bank transfer or Cheque in the name of KEYNES CONSTRUCTIONS & INTERIORS LLC"),
//    pw.SizedBox(height: 10),
          
//           // Payment Terms
//           pw.Text("SERVICE DURATION", style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
//           pw.Text("1. This service is limited to 40 days - upon obtaining the building permit, Sub-contractor should complete the work within this period and obtain the completion certificate."),
//           pw.Text("2. After 40 days of using the service, additional charges will be applicable.",  style: pw.TextStyle(color: PdfColors.red)),

//    pw.SizedBox(height: 10),
//             pw.Text("QUOTATION VALIDITY", style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
//           pw.Text("1. 10 WORKING DAYS"),
// pw.SizedBox(height: 10),
//             pw.Text("EXCLUSIONS", style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
//           pw.Text("1. For any revision submission and drawings required, additional charges will be applicable."),
//            pw.Text("2. In case of bounced cheque or any governmental fee pending that blocks our system, penalty of AED 1000 / Refundable deposit will not be  refunded."),
//         pw.Text("3. Excludes all authority fees. All authorities fee in actual to paid by client. This can either pay through 'KEYNES' or client can pay directly."),
//           pw.Text("4. Any laboratory testing fees, Survey demarcation fees either authority or by third-party agency to be paid by client if required"),
//           pw.Text("5. This Service fee limited to our services as described above only. In case submission to carried out through Third Party Consultant as per   authority requirements, consultant service fee will be additional."),
//           pw.SizedBox(height: 40),
//  pw.SizedBox(height: 10),
//             pw.Text("AGREED & SIGNED BY BOTH PARTIES", style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
          
          
//           pw.Row(
//             mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//             children: [
//               pw.Column(
//                 children: [
//                   pw.Text("THANVEER JAN"),
//                   pw.Text("KEYNES CONSTRUCTIONS & INTERIORS LLC"),
//                 ],
//               ),
//               pw.Column(
//                 children: [
//                   pw.Text("Mr. Dinesh"),
//                   pw.Text("PEROrient building contracting llc"),
//                 ],
//               ),
//             ],
//           ),
//   pw.Text("Office No.305, 3rd floor, Oxford Tower, Business Bay, P.O. Box 299560, Dubai, UAE. Tel. 04-4534945, Fax 04-4534947,Email: info@keynesgroupuae.com, www.keynesgroupuae.com"),
         
 

//         ];
//       },
//     ),
//   );

//   // Save and Open PDF
//   final output = await getExternalStorageDirectory();
//   final file = File("${output!.path}/quotation.pdf");
//   await file.writeAsBytes(await pdf.save());
//   OpenFile.open(file.path);
// }


Future<void> generateQuotationPDF() async {
  final pdf = pw.Document();
  final ByteData bytes = await rootBundle.load(AppAssets.keynesLogo);
  final Uint8List imageBytes = bytes.buffer.asUint8List();

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.all(32),
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Header Section
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Container(
                  height: 70,
                  width: 120,
                  child: pw.Image(pw.MemoryImage(imageBytes), height: 50.0),
                ),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text("KEYNES CONSTRUCTIONS & INTERIORS L.L.C", style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
                    pw.Text("Date: 07.03.2025"),
                    pw.Text("Ref No: KCIAQ/2503-80/R0/DSLN"),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 10),

            // Client Details
            pw.Text("M/s: PEROrient building contracting llc", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.Text("Mr. Dinesh"),
            pw.Text("Mob: +971 0507036781"),
            pw.Text("Email: dinesh@perobc.ae"),
            pw.Text("Subject: Quotation For DEWA Approval"),
            pw.Text("Project: B+G+1 VILLA - Temporary DEWA Connection @ Al Manara"),
            pw.SizedBox(height: 10),

            // Table with Scope of Services
            pw.Table.fromTextArray(
              border: pw.TableBorder.all(width: 1),
              cellAlignment: pw.Alignment.centerLeft,
              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              headers: ["ITEM", "SCOPE OF SERVICES", "AED"],
              data: [
                ["1", "Pre-approval Services: Complete set of documentations and drawings as per authority requirements.", "8000.00"],
                ["2", "Post approval Services: Arrange & attend necessary inspections with authorities for completion.", "0.00"],
                ["", "ALL THE GOVT FEES TO BE PROVIDED BY THE CLIENT", ""],
                ["", "VAT Additional To All Invoice", "400.00"],
                ["", "Total Value (Including VAT)", "8,400.00"],
              ],
            ),
          
            sectionTitle("PAYMENT TERMS"),
            pw.Text("1. 50% ADVANCE REQUIRED UPON CONFIRMATION OF PROJECT"),
            pw.Text("2. 50% REMAINING DUE BEFORE PERMIT RELEASE"),
            pw.SizedBox(height: 10),
        
          
          pw.Text("MODE OF PAYMENT", style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
          pw.Text("1. Payment should be made by Cash, Bank transfer or Cheque in the name of KEYNES CONSTRUCTIONS & INTERIORS LLC"),
   pw.SizedBox(height: 10),
          
          // Payment Terms
          pw.Text("SERVICE DURATION", style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
          pw.Text("1. This service is limited to 40 days - upon obtaining the building permit, Sub-contractor should complete the work within this period and obtain the completion certificate."),
          pw.Text("2. After 40 days of using the service, additional charges will be applicable.",  style: pw.TextStyle(color: PdfColors.red)),

   pw.SizedBox(height: 10),
            pw.Text("QUOTATION VALIDITY", style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
          pw.Text("1. 10 WORKING DAYS"),
pw.SizedBox(height: 10),
            pw.Text("EXCLUSIONS", style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
          pw.Text("1. For any revision submission and drawings required, additional charges will be applicable."),
           pw.Text("2. In case of bounced cheque or any governmental fee pending that blocks our system, penalty of AED 1000 / Refundable deposit will not be  refunded."),
        pw.Text("3. Excludes all authority fees. All authorities fee in actual to paid by client. This can either pay through 'KEYNES' or client can pay directly."),
          pw.Text("4. Any laboratory testing fees, Survey demarcation fees either authority or by third-party agency to be paid by client if required"),
          pw.Text("5. This Service fee limited to our services as described above only. In case submission to carried out through Third Party Consultant as per   authority requirements, consultant service fee will be additional."),
          pw.SizedBox(height: 5),
pw.Center(child: sectionTitle("AGREED & SIGNED BY BOTH PARTIES"),),
              pw.SizedBox(height: 10),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                signatureColumn("THANVEER JAN", "KEYNES CONSTRUCTIONS & INTERIORS LLC"),
                signatureColumn("Mr. Dinesh", "PEROrient building contracting llc"),
              ],
            ),
            pw.SizedBox(height: 10),
            pw.Text("Office No.305, 3rd floor, Oxford Tower, Business Bay, P.O. Box 299560, Dubai, UAE. Tel. 04-4534945, Fax 04-4534947, Email: info@keynesgroupuae.com, www.keynesgroupuae.com"),
          ],
        );
      },
    ),
  );

  final output = await getExternalStorageDirectory();
  final file = File("${output!.path}/quotation.pdf");
  await file.writeAsBytes(await pdf.save());
  OpenFile.open(file.path);
}

pw.Widget sectionTitle(String title) {
  return pw.Text(title, style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold));
}

pw.Widget signatureColumn(String name, String company) {
  return pw.Column(
    children: [
      pw.Text(name),
      pw.Text(company),
    ],
  );
}


  // Function to handle Android file saving
  Future<void> _downloadPdfAndroid(Uint8List pdfBytes) async {
    if (!await _requestStoragePermission()) return;

    final directory = await getExternalStorageDirectory();
    final filePath = "${directory!.path}/invoice.pdf";
    final file = File(filePath);

    await file.writeAsBytes(pdfBytes);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("PDF Downloaded: $filePath")));

    OpenFile.open(filePath);
  }

  // Function to handle Web PDF download
  // void _downloadPdfWeb(Uint8List pdfBytes) {
  //   final blob = html.Blob([pdfBytes], 'application/pdf');
  //   final url = html.Url.createObjectUrlFromBlob(blob);
  //   final anchor = html.AnchorElement(href: url)
  //     ..setAttribute("download", "invoice.pdf")
  //     ..click();
  //   html.Url.revokeObjectUrl(url);

  //   ScaffoldMessenger.of(context)
  //       .showSnackBar(SnackBar(content: Text("PDF Downloaded")));
  // }

  // Request storage permission for Android
  Future<bool> _requestStoragePermission() async => Platform.isAndroid
      ? (await Permission.storage.request().isGranted ||
          await Permission.manageExternalStorage.request().isGranted)
      : true;


//Shimmer
  Widget _buildShimmerPlaceholder() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(13),
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(13),
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: Container(
                width: double.infinity,
                height: 500,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: Container(
                width: double.infinity,
                height: 60,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: Container(
                width: double.infinity,
                height: 60,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: Container(
                width: double.infinity,
                height: 500,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        title: const Text(
          'Enquiry',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF01519D),
        leading: const Icon(Icons.menu),
        automaticallyImplyLeading: true,
      ),
      body: isLoading
          ? ListView.builder(
              itemCount: 8,
              itemBuilder: (context, index) {
                return _buildShimmerPlaceholder();
              },
            )
          : Container(
              color: Colors.grey[100],
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: FromAndToDatePickerField(
                      onDatesSelected: (from, to) {
                        setState(() {
                          fromDate = from;
                          toDate = to;

                          filterEnquiriesByDate();
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: enquiryesList!.length,
                      itemBuilder: (context, index) {
                        final enquiry = enquiryesList![index];
                        return Card(
                            elevation: 2,
                            margin: EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Customer Name",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              child: Text(
                                                enquiry!.clientName ?? '',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                overflow: TextOverflow
                                                    .ellipsis, // Adds "..." if the text overflows
                                                maxLines:
                                                    2, // Limits the text to one line
                                              )),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Date",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            enquiry!.createdDate,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Department",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            //"",
                                            enquiry!.department ?? '',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Enquiry Source",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            //"",
                                            enquiry!.refer ?? '',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 16),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Status",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: Colors.yellow[100],
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.circle,
                                              size: 12,
                                              color: Colors.amber,
                                            ),
                                            SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                enquiry!.projectStatus ?? '',
                                                style: TextStyle(
                                                    color: AppColors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 16),
                                  Divider(color: Colors.grey[500]),
                               Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [ TextButton(
                                      onPressed: () {
                                        

                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                duration:
                                                    Duration(milliseconds: 200),
                                                reverseDuration:
                                                    Duration(milliseconds: 200),
                                                child: EnquireViewMore(
                                                  enquiryid: enquiry!.id,
                                                ),
                                                type: PageTransitionType
                                                    .rightToLeft));

                                      
                                      },
                                      child: Text(
                                        "View more",
                                        style: TextStyle(
                                          color: Color(0xFF01519D),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),TextButton(
                                      onPressed: () {
                                        
generateQuotationPDF();

                                      
                                      },
                                      child: Text(
                                        "Invoice PDF",
                                        style: TextStyle(
                                          color: Color(0xFF01519D),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),  ],)
                                  //      Center(
                                  //   child: TextButton(
                                  //     onPressed: () {
                                        

                                  //       Navigator.push(
                                  //           context,
                                  //           PageTransition(
                                  //               duration:
                                  //                   Duration(milliseconds: 200),
                                  //               reverseDuration:
                                  //                   Duration(milliseconds: 200),
                                  //               child: EnquireViewMore(
                                  //                 enquiryid: enquiry!.id,
                                  //               ),
                                  //               type: PageTransitionType
                                  //                   .rightToLeft));

                                      
                                  //     },
                                  //     child: Text(
                                  //       "View more",
                                  //       style: TextStyle(
                                  //         color: Color(0xFF01519D),
                                  //         fontWeight: FontWeight.bold,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ));
                        // EnquireCard(
                        //             customerName: enquiry["customerName"]!,
                        //             department: enquiry["department"]!,
                        //             date: enquiry["date"]!,
                        //             status: enquiry["status"]!,
                        //             enquirySource: enquiry["enquirySource"]!,
                        //             onViewMore: () {
                        //               Navigator.push(
                        //                 context,
                        //                 MaterialPageRoute(
                        //                   builder: (context) => EnquireViewMore(
                        //                     dateOfEnquiry: enquiry["date"]!,
                        //                     saleExecutive: enquiry["saleExecutive"]!,
                        //                     confirmDate: enquiry["confirmDate"]!,
                        //                     duration: enquiry["duration"]!,
                        //                     amount: enquiry["amount"]!,
                        //                     closingDate: enquiry["closingDate"]!,
                        //                     projectEngineer: enquiry["projectEngineer"]!,
                        //                     engineerAdmin: enquiry["engineerAdmin"]!,
                        //                     departmentEngineer: enquiry["departmentEngineer"]!,
                        //                     engineer: enquiry["engineer"]!,
                        //                     projectSafetyCoordinator:
                        //                         enquiry["projectSafetyCoordinator"]!,
                        //                     totalService: enquiry["totalService"]!,
                        //                   ),
                        //                 ),
                        //               );
                        //             },
                        //           );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}










// import 'package:flutter/material.dart';
// import 'package:shimmer/shimmer.dart';
// import 'enquire_view_more.dart';
// import 'enquiry_list_model.dart';
// import '../../services/keynes_api_service.dart';
// import '../../constants/app_assets.dart';
// import 'package:intl/intl.dart';
// import '../../services/comFuncService.dart';
// import 'from_to_date_picker.dart';
// import 'package:page_transition/page_transition.dart';

// class EnquirePage extends StatefulWidget {
//   const EnquirePage({super.key});

//   @override
//   State<EnquirePage> createState() => _EnquirePageState();
// }

// class _EnquirePageState extends State<EnquirePage> {
//   final KeynesApiService apiService = KeynesApiService();
//   bool isLoading = false;
//   DateTime? fromDate;
//   DateTime? toDate;
//   @override
//   void initState() {
//     getenquirylistbyadmin_app();
//     super.initState();
//   }

//   List<Record>? enquiryesList = [];
//   List<Record>? enquiryesListAll = [];

//   void filterEnquiriesByDate() {
//     if (fromDate != null && toDate != null) {
//       setState(() {
//         enquiryesList = enquiryesListAll!.where((record) {
//           DateTime? createdDate = parseApiDate(record.createdDate);

//           if (createdDate != null) {
//             return createdDate
//                     .isAfter(fromDate!.subtract(const Duration(days: 1))) &&
//                 createdDate.isBefore(toDate!.add(const Duration(days: 1)));
//           }
//           return false;
//         }).toList();
//       });
//     } else {
//       setState(() {
//         enquiryesList = enquiryesListAll;
//       });
//     }
//   }

//   DateTime? parseApiDate(String apiDate) {
//     try {
//       return DateFormat("dd-MMM-yyyy").parse(apiDate);
//     } catch (e) {
//       print("Error parsing date: $e");
//       return null;
//     }
//   }

//   Future getenquirylistbyadmin_app() async {
//     await apiService.getBearerToken();
//     var result = await apiService.getenquirylistbyadmin_app();
//     print('hi $result');
//     EnquiryListmodel response = enquiryListmodelFromJson(result);
//     if (response.status.toString() == 'SUCCESS') {
//       setState(() {
//         enquiryesList = response.record;
//         enquiryesListAll = enquiryesList;
//         print('hello $enquiryesList');
//       });
//     } else {
//       setState(() {
//         enquiryesList = [];
//         enquiryesListAll = [];
//       });
//       showInSnackBar(context, response.status);
//     }
//     setState(() {});
//   }

//   Future<DateTime?> _selectDate({
//     required BuildContext context,
//     required DateTime initialDate,
//     DateTime? firstDate,
//     DateTime? lastDate,
//   }) async {
//     return await showDatePicker(
//       context: context,
//       initialDate: initialDate,
//       firstDate: firstDate ?? DateTime(2000),
//       lastDate: lastDate ?? DateTime(2100),
//     );
//   }

// //Shimmer
//   Widget _buildShimmerPlaceholder() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//       child: Shimmer.fromColors(
//         baseColor: Colors.grey.shade300,
//         highlightColor: Colors.grey.shade100,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(13),
//                   child: Container(
//                     width: double.infinity,
//                     height: 60,
//                     color: Colors.white,
//                   ),
//                 ),
//                 SizedBox(
//                   width: 20,
//                 ),
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(13),
//                   child: Container(
//                     width: double.infinity,
//                     height: 60,
//                     color: Colors.white,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             ClipRRect(
//               borderRadius: BorderRadius.circular(13),
//               child: Container(
//                 width: double.infinity,
//                 height: 500,
//                 color: Colors.white,
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             ClipRRect(
//               borderRadius: BorderRadius.circular(13),
//               child: Container(
//                 width: double.infinity,
//                 height: 60,
//                 color: Colors.white,
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             ClipRRect(
//               borderRadius: BorderRadius.circular(13),
//               child: Container(
//                 width: double.infinity,
//                 height: 60,
//                 color: Colors.white,
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             ClipRRect(
//               borderRadius: BorderRadius.circular(13),
//               child: Container(
//                 width: double.infinity,
//                 height: 500,
//                 color: Colors.white,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 90,
//         title: const Text(
//           'Enquiry',
//           style: TextStyle(color: Colors.white),
//         ),
//         iconTheme: const IconThemeData(color: Colors.white),
//         backgroundColor: Color(0xFF01519D),
//         leading: const Icon(Icons.menu),
//         automaticallyImplyLeading: true,
//       ),
//       body: isLoading
//           ? ListView.builder(
//               itemCount: 8,
//               itemBuilder: (context, index) {
//                 return _buildShimmerPlaceholder();
//               },
//             )
//           : Container(
//               color: Colors.grey[100],
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: FromAndToDatePickerField(
//                       onDatesSelected: (from, to) {
//                         setState(() {
//                           fromDate = from;
//                           toDate = to;

//                           filterEnquiriesByDate();
//                         });
//                       },
//                     ),
//                   ),
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: enquiryesList!.length,
//                       itemBuilder: (context, index) {
//                         final enquiry = enquiryesList![index];
//                         return Card(
//                             elevation: 2,
//                             margin: EdgeInsets.all(10),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(16),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(20.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             "Customer Name",
//                                             style: TextStyle(
//                                               fontSize: 14,
//                                               color: Colors.grey,
//                                             ),
//                                           ),
//                                           SizedBox(height: 4),
//                                           Container(
//                                               width: MediaQuery.of(context)
//                                                       .size
//                                                       .width /
//                                                   1.7,
//                                               child: Text(
//                                                 enquiry!.clientName ?? '',
//                                                 style: TextStyle(
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.bold,
//                                                 ),
//                                                 overflow: TextOverflow
//                                                     .ellipsis, // Adds "..." if the text overflows
//                                                 maxLines:
//                                                     2, // Limits the text to one line
//                                               )),
//                                         ],
//                                       ),
//                                       Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.end,
//                                         children: [
//                                           Text(
//                                             "Date",
//                                             style: TextStyle(
//                                               fontSize: 14,
//                                               color: Colors.grey,
//                                             ),
//                                           ),
//                                           SizedBox(height: 4),
//                                           Text(
//                                             enquiry!.createdDate,
//                                             style: TextStyle(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(height: 16),
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             "Department",
//                                             style: TextStyle(
//                                               fontSize: 14,
//                                               color: Colors.grey,
//                                             ),
//                                           ),
//                                           SizedBox(height: 4),
//                                           Text(
//                                             //"",
//                                             enquiry!.department ?? '',
//                                             style: TextStyle(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.end,
//                                         children: [
//                                           Text(
//                                             "Enquiry Source",
//                                             style: TextStyle(
//                                               fontSize: 14,
//                                               color: Colors.grey,
//                                             ),
//                                           ),
//                                           SizedBox(height: 4),
//                                           Text(
//                                             //"",
//                                             enquiry!.refer ?? '',
//                                             style: TextStyle(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(height: 16),
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "Status",
//                                         style: TextStyle(
//                                           fontSize: 14,
//                                           color: Colors.grey,
//                                         ),
//                                       ),
//                                       SizedBox(height: 8),
//                                       Container(
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 12, vertical: 8),
//                                         decoration: BoxDecoration(
//                                           color: Colors.yellow[100],
//                                           borderRadius:
//                                               BorderRadius.circular(20),
//                                         ),
//                                         child: Row(
//                                           children: [
//                                             Icon(
//                                               Icons.circle,
//                                               size: 12,
//                                               color: Colors.amber,
//                                             ),
//                                             SizedBox(width: 8),
//                                             Expanded(
//                                               child: Text(
//                                                 enquiry!.projectStatus ?? '',
//                                                 style: TextStyle(
//                                                   color: Colors.amber[800],
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(height: 16),
//                                   Divider(color: Colors.grey[500]),
//                                   Center(
//                                     child: TextButton(
//                                       onPressed: () {
//                                         Navigator.push(
//                                             context,
//                                             PageTransition(
//                                                 duration:
//                                                     Duration(milliseconds: 250),
//                                                 reverseDuration:
//                                                     Duration(milliseconds: 250),
//                                                 child: EnquireViewMore(
//                                                   enquiryid: enquiry!.id,
//                                                 ),
//                                                 type: PageTransitionType
//                                                     .rightToLeft));

//                                         // Navigator.push(
//                                         //   context,
//                                         //   MaterialPageRoute(
//                                         //     builder: (context) =>
//                                         //         EnquireViewMore(
//                                         //       enquiryid: enquiry!.id,
//                                         //     ),
//                                         //   ),
//                                         // );
//                                       },
//                                       child: Text(
//                                         "View more",
//                                         style: TextStyle(
//                                           color: Color(0xFF01519D),
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ));
//                         // EnquireCard(
//                         //             customerName: enquiry["customerName"]!,
//                         //             department: enquiry["department"]!,
//                         //             date: enquiry["date"]!,
//                         //             status: enquiry["status"]!,
//                         //             enquirySource: enquiry["enquirySource"]!,
//                         //             onViewMore: () {
//                         //               Navigator.push(
//                         //                 context,
//                         //                 MaterialPageRoute(
//                         //                   builder: (context) => EnquireViewMore(
//                         //                     dateOfEnquiry: enquiry["date"]!,
//                         //                     saleExecutive: enquiry["saleExecutive"]!,
//                         //                     confirmDate: enquiry["confirmDate"]!,
//                         //                     duration: enquiry["duration"]!,
//                         //                     amount: enquiry["amount"]!,
//                         //                     closingDate: enquiry["closingDate"]!,
//                         //                     projectEngineer: enquiry["projectEngineer"]!,
//                         //                     engineerAdmin: enquiry["engineerAdmin"]!,
//                         //                     departmentEngineer: enquiry["departmentEngineer"]!,
//                         //                     engineer: enquiry["engineer"]!,
//                         //                     projectSafetyCoordinator:
//                         //                         enquiry["projectSafetyCoordinator"]!,
//                         //                     totalService: enquiry["totalService"]!,
//                         //                   ),
//                         //                 ),
//                         //               );
//                         //             },
//                         //           );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }
// }
