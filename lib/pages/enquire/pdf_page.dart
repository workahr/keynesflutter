// import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter/foundation.dart'; // For kIsWeb
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:pdf/pdf.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:open_file/open_file.dart';
// import 'dart:html' as html;

// import '../../constants/constants.dart'; // Only for Web

// class PdfInvoicePage extends StatefulWidget {
//   @override
//   _PdfInvoicePageState createState() => _PdfInvoicePageState();
// }

// class _PdfInvoicePageState extends State<PdfInvoicePage> {
//  Future<void> _createAndDownloadPDF() async {
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
//                             alignment: row.indexOf(cell) > 1
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

//         pw.SizedBox(height: 10),

//         // Terms and Conditions (Reduced Size)
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

//   //  final pdf = pw.Document();

//   // final tableHeaders = ['S.No', 'Description', 'Qty', 'Rate', 'Amount AED'];
//   // final tableData = [
//   //   ['1', 'added service', '1', '3,000.00', '3,000.00'],
//   //   ['2', 'sampl3', '1', '2,000.00', '2,000.00'],
//   //   ['3', 'another added service', '1', '1,000.00', '1,000.00'],
//   //   ['4', 'added revision', '1', '1,000.00', '1,000.00'],
//   //   ['5', 'added revision 2', '1', '3,000.00', '3,000.00'],
//   // ];

//   // pdf.addPage(
//   //   pw.Page(
//   //     pageFormat: PdfPageFormat.a4,
//   //     margin: pw.EdgeInsets.all(20),
//   //     build: (pw.Context context) {
//   //       return pw.Column(
//   //         crossAxisAlignment: pw.CrossAxisAlignment.start,
//   //         children: [
//   //           // Table with exact borders
//   //           pw.Table(
//   //             border: pw.TableBorder.all(color: PdfColors.black, width: 0.5),
//   //             columnWidths: {
//   //               0: pw.FixedColumnWidth(40), // S.No
//   //               1: pw.FlexColumnWidth(), // Description
//   //               2: pw.FixedColumnWidth(40), // Qty
//   //               3: pw.FixedColumnWidth(70), // Rate
//   //               4: pw.FixedColumnWidth(70), // Amount AED
//   //             },
//   //             children: [
//   //               // Header Row
//   //               pw.TableRow(
//   //                 decoration: pw.BoxDecoration(color: PdfColors.blue),
//   //                 children: tableHeaders
//   //                     .map(
//   //                       (header) => pw.Container(
//   //                         padding: pw.EdgeInsets.all(8),
//   //                         alignment: pw.Alignment.center,
//   //                         child: pw.Text(
//   //                           header,
//   //                           style: pw.TextStyle(
//   //                             fontWeight: pw.FontWeight.bold,
//   //                             color: PdfColors.white,
//   //                           ),
//   //                         ),
//   //                       ),
//   //                     )
//   //                     .toList(),
//   //               ),
//   //               // Table Data Rows
//   //               ...tableData.map(
//   //                 (row) => pw.TableRow(
//   //                   decoration: pw.BoxDecoration(
//   //                     border: pw.Border(
//   //                       bottom: pw.BorderSide(color: PdfColors.grey, width: 0.5),
//   //                     ),
//   //                   ),
//   //                   children: row
//   //                       .map(
//   //                         (cell) => pw.Container(
//   //                           padding: pw.EdgeInsets.all(6),
//   //                           alignment: row.indexOf(cell) > 1
//   //                               ? pw.Alignment.centerRight
//   //                               : pw.Alignment.centerLeft,
//   //                           child: pw.Text(cell),
//   //                         ),
//   //                       )
//   //                       .toList(),
//   //                 ),
//   //               ),
//   //               // Total Project Value in Second Column
//   //               pw.TableRow(
//   //                 decoration: pw.BoxDecoration(
//   //                   border: pw.Border(
//   //                     top: pw.BorderSide(color: PdfColors.black, width: 0.5),
//   //                   ),
//   //                 ),
//   //                 children: [
//   //                   pw.Container(), // Empty for S.No
//   //                   pw.Container(
//   //                     padding: pw.EdgeInsets.all(8),
//   //                     child: pw.Text("Total Project value : 10000 + Vat 5%"),
//   //                   ),
//   //                   pw.Container(), // Empty for Qty
//   //                   pw.Container(), // Empty for Rate
//   //                   pw.Container(), // Empty for Amount
//   //                 ],
//   //               ),
//   //               // Sub Total Inside Table
//   //               pw.TableRow(children: [
//   //                 pw.Container(),
//   //                 pw.Container(),
//   //                 pw.Container(),
//   //                 pw.Container(
//   //                   padding: pw.EdgeInsets.all(8),
//   //                   alignment: pw.Alignment.centerRight,
//   //                   child: pw.Text("Sub Total"),
//   //                 ),
//   //                 pw.Container(
//   //                   padding: pw.EdgeInsets.all(8),
//   //                   alignment: pw.Alignment.centerRight,
//   //                   child: pw.Text("10,000.00"),
//   //                 ),
//   //               ]),
//   //               pw.TableRow(children: [
//   //                 pw.Container(),
//   //                 pw.Container(),
//   //                 pw.Container(),
//   //                 pw.Container(
//   //                   padding: pw.EdgeInsets.all(8),
//   //                   alignment: pw.Alignment.centerRight,
//   //                   child: pw.Text("VAT 5%"),
//   //                 ),
//   //                 pw.Container(
//   //                   padding: pw.EdgeInsets.all(8),
//   //                   alignment: pw.Alignment.centerRight,
//   //                   child: pw.Text("500.00"),
//   //                 ),
//   //               ]),
//   //               pw.TableRow(children: [
//   //                 pw.Container(),
//   //                 pw.Container(),
//   //                 pw.Container(),
//   //                 pw.Container(
//   //                   padding: pw.EdgeInsets.all(8),
//   //                   alignment: pw.Alignment.centerRight,
//   //                   child: pw.Text("Extra Payment"),
//   //                 ),
//   //                 pw.Container(
//   //                   padding: pw.EdgeInsets.all(8),
//   //                   alignment: pw.Alignment.centerRight,
//   //                   child: pw.Text("5,000.00"),
//   //                 ),
//   //               ]),
//   //               // Grand Total Row (Bold)
//   //               pw.TableRow(
//   //                 decoration: pw.BoxDecoration(
//   //                   border: pw.Border(
//   //                     top: pw.BorderSide(color: PdfColors.black, width: 0.5),
//   //                   ),
//   //                 ),
//   //                 children: [
//   //                   pw.Container(),
//   //                   pw.Container(),
//   //                   pw.Container(),
//   //                   pw.Container(
//   //                     padding: pw.EdgeInsets.all(8),
//   //                     alignment: pw.Alignment.centerRight,
//   //                     child: pw.Text(
//   //                       "Grand Total",
//   //                       style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//   //                     ),
//   //                   ),
//   //                   pw.Container(
//   //                     padding: pw.EdgeInsets.all(8),
//   //                     alignment: pw.Alignment.centerRight,
//   //                     child: pw.Text(
//   //                       "15,500.00",
//   //                       style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//   //                     ),
//   //                   ),
//   //                 ],
//   //               ),
//   //             ],
//   //           ),
//   //           pw.SizedBox(height: 10),
//   //           // Amount in words
//   //           pw.Text(
//   //             "Dirhams Fifteen Thousand Five Hundred Only",
//   //             style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//   //           ),
//   //         ],
//   //       );
//   //     },
//   //   ),
//   // );

//     final pdfBytes = await pdf.save();

//     if (kIsWeb) {
//       _downloadPdfWeb(pdfBytes);
//     } else {
//       await _downloadPdfAndroid(pdfBytes);
//     }
//   }

//   // Function to handle Android file saving
//   Future<void> _downloadPdfAndroid(Uint8List pdfBytes) async {
//     if (!await _requestStoragePermission()) return;

//     final directory = await getExternalStorageDirectory();
//     final filePath = "${directory!.path}/invoice.pdf";
//     final file = File(filePath);

//     await file.writeAsBytes(pdfBytes);

//     ScaffoldMessenger.of(context)
//         .showSnackBar(SnackBar(content: Text("PDF Downloaded: $filePath")));

//     OpenFile.open(filePath);
//   }

//   // Function to handle Web PDF download
//   void _downloadPdfWeb(Uint8List pdfBytes) {
//     final blob = html.Blob([pdfBytes], 'application/pdf');
//     final url = html.Url.createObjectUrlFromBlob(blob);
//     final anchor = html.AnchorElement(href: url)
//       ..setAttribute("download", "invoice.pdf")
//       ..click();
//     html.Url.revokeObjectUrl(url);

//     ScaffoldMessenger.of(context)
//         .showSnackBar(SnackBar(content: Text("PDF Downloaded")));
//   }

//   // Request storage permission for Android
//   Future<bool> _requestStoragePermission() async => Platform.isAndroid
//       ? (await Permission.storage.request().isGranted ||
//           await Permission.manageExternalStorage.request().isGranted)
//       : true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("PDF Invoice Generator")),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: _createAndDownloadPDF,
//           child: Text("Download Invoice PDF",
//               style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)),
//         ),
//       ),
//     );
//   }
// }














// // import 'dart:io';
// // import 'package:flutter/material.dart';
// // import 'package:pdf/widgets.dart' as pw;
// // import 'package:pdf/pdf.dart';
// // import 'package:path_provider/path_provider.dart';
// // import 'package:permission_handler/permission_handler.dart';
// // import 'package:open_file/open_file.dart';
// // import 'dart:html' as html; 


// // class PdfInvoicePage extends StatefulWidget {
// //   @override
// //   _PdfInvoicePageState createState() => _PdfInvoicePageState();
// // }

// // class _PdfInvoicePageState extends State<PdfInvoicePage> {
// //   Future<void> _createAndDownloadPDF() async {
// //     if (!await _requestStoragePermission()) return;

// //     final pdf = pw.Document();

// //     pdf.addPage(
// //       pw.Page(
// //         pageFormat: PdfPageFormat.a4,
// //         build: (context) => pw.Column(
// //           crossAxisAlignment: pw.CrossAxisAlignment.start,
// //           children: [
// //             // Header with logo and company details
// //             pw.Row(
// //               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
// //               children: [
// //                 pw.Column(
// //                   crossAxisAlignment: pw.CrossAxisAlignment.start,
// //                   children: [
// //                     pw.Text("KEYNES CONSTRUCTIONS & INTERIORS L.L.C",
// //                         style: pw.TextStyle(
// //                             fontSize: 16, fontWeight: pw.FontWeight.bold)),
// //                     pw.SizedBox(height: 5),
// //                     pw.Text(
// //                         "Office No. 305, 3rd Floor, Oxford Tower, Business Bay, Dubai, UAE"),
// //                     pw.Text(
// //                         "Tel: +971 4 453 4041 | Email: info@keynesgroupuae.com"),
// //                   ],
// //                 ),
// //                 pw.Container(
// //                   height: 50,
// //                   width: 50,
// //                   child: pw.PdfLogo(), // Placeholder for actual company logo
// //                 )
// //               ],
// //             ),
// //             pw.SizedBox(height: 10),
// //             pw.Center(
// //               child: pw.Text("TAX INVOICE",
// //                   style: pw.TextStyle(
// //                       fontSize: 18, fontWeight: pw.FontWeight.bold)),
// //             ),
// //             pw.SizedBox(height: 10),
// //             // Invoice details
// //             pw.Row(
// //               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
// //               children: [
// //                 pw.Column(
// //                   crossAxisAlignment: pw.CrossAxisAlignment.start,
// //                   children: [
// //                     pw.Text("Bill To: "),
// //                     pw.Text("Client Name: Prasanth"),
// //                     pw.Text("Project: enquiry_check"),
// //                   ],
// //                 ),
// //                 pw.Column(
// //                   crossAxisAlignment: pw.CrossAxisAlignment.start,
// //                   children: [
// //                     pw.Text("Receipt No: KCI/2025-057"),
// //                     pw.Text("Date: 20-10-2025"),
// //                     pw.Text("Quote Reference: KCI/Q/1520-98/H/51"),
// //                   ],
// //                 )
// //               ],
// //             ),
// //             pw.SizedBox(height: 15),
// //             // Table Header
// //             pw.Table(
// //               border: pw.TableBorder.all(),
// //               columnWidths: {
// //                 0: pw.FixedColumnWidth(40),
// //                 1: pw.FixedColumnWidth(200),
// //                 2: pw.FixedColumnWidth(50),
// //                 3: pw.FixedColumnWidth(80),
// //                 4: pw.FixedColumnWidth(80),
// //               },
// //               children: [
// //                 pw.TableRow(
// //                   decoration: pw.BoxDecoration(color: PdfColors.grey300),
// //                   children: [
// //                     pw.Padding(
// //                         padding: pw.EdgeInsets.all(5),
// //                         child: pw.Text("S.No",
// //                             style:
// //                                 pw.TextStyle(fontWeight: pw.FontWeight.bold))),
// //                     pw.Padding(
// //                         padding: pw.EdgeInsets.all(5),
// //                         child: pw.Text("Description",
// //                             style:
// //                                 pw.TextStyle(fontWeight: pw.FontWeight.bold))),
// //                     pw.Padding(
// //                         padding: pw.EdgeInsets.all(5),
// //                         child: pw.Text("Qty",
// //                             style:
// //                                 pw.TextStyle(fontWeight: pw.FontWeight.bold))),
// //                     pw.Padding(
// //                         padding: pw.EdgeInsets.all(5),
// //                         child: pw.Text("Rate",
// //                             style:
// //                                 pw.TextStyle(fontWeight: pw.FontWeight.bold))),
// //                     pw.Padding(
// //                         padding: pw.EdgeInsets.all(5),
// //                         child: pw.Text("Amount",
// //                             style:
// //                                 pw.TextStyle(fontWeight: pw.FontWeight.bold))),
// //                   ],
// //                 ),
// //                 ...[
// //                   ["1", "Added Service", "1", "3000.00", "3000.00"],
// //                   ["2", "Sample 3", "1", "2000.00", "2000.00"],
// //                   ["3", "Another Added Service", "1", "1000.00", "1000.00"],
// //                   ["4", "Added Revision", "1", "1000.00", "1000.00"],
// //                   ["5", "Added Revision 2", "1", "3000.00", "3000.00"],
// //                 ].map((row) => pw.TableRow(
// //                       children: row
// //                           .map((cell) => pw.Padding(
// //                               padding: pw.EdgeInsets.all(5),
// //                               child: pw.Text(cell)))
// //                           .toList(),
// //                     )),
// //               ],
// //             ),
// //             pw.SizedBox(height: 10),
// //             // Total Section
// //             pw.Row(
// //               mainAxisAlignment: pw.MainAxisAlignment.end,
// //               children: [
// //                 pw.Column(
// //                   crossAxisAlignment: pw.CrossAxisAlignment.end,
// //                   children: [
// //                     pw.Text("Sub Total: 10,000.00 AED"),
// //                     pw.Text("VAT 5%: 500.00 AED"),
// //                     pw.Text("Extra Payment: 5,000.00 AED"),
// //                     pw.Text("Grand Total: 15,500.00 AED",
// //                         style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
// //                   ],
// //                 ),
// //               ],
// //             ),
// //             pw.SizedBox(height: 20),
// //             // Terms and Conditions
// //             pw.Text("Terms and Conditions:",
// //                 style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
// //             pw.Text("1. 50% payment via bank transfer."),
// //             pw.Text("2. Notify discrepancies within 7 days."),
// //             pw.SizedBox(height: 10),
// //             // Bank Details
// //             pw.Text("Bank Details:",
// //                 style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
// //             pw.Text("Account Name: Keynes Constructions & Interiors LLC"),
// //             pw.Text("Bank: ADCB, Branch: Dragon Mart"),
// //             pw.Text("Account No: 195-403329004"),
// //             pw.Text("IBAN: AE88003001095403329004"),
// //           ],
// //         ),
// //       ),
// //     );

// //     final output = await getExternalStorageDirectory();
// //     final file = File("${output!.path}/invoice.pdf");
// //     await file.writeAsBytes(await pdf.save());
// //     ScaffoldMessenger.of(context)
// //         .showSnackBar(SnackBar(content: Text("PDF Downloaded: ${file.path}")));
// //     OpenFile.open(file.path);
// //   }

// //   Future<bool> _requestStoragePermission() async => Platform.isAndroid
// //       ? (await Permission.storage.request().isGranted ||
// //           await Permission.manageExternalStorage.request().isGranted)
// //       : true;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //         appBar: AppBar(title: Text("PDF Invoice Generator")),
// //         body: Center(
// //             child: ElevatedButton(
              
// //                 onPressed: _createAndDownloadPDF,
// //                 child: Text("Download Invoice PDF", style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)))));
// //   }
// // }
