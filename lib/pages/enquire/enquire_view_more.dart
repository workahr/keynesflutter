import 'package:flutter/material.dart';
import 'package:keynes/widgets/heading_widget.dart';
import '../../services/keynes_api_service.dart';
import '../../constants/app_assets.dart';
import '../../constants/app_colors.dart';
import '../../services/comFuncService.dart';
import 'enquiry_details_model.dart';
import 'package:shimmer/shimmer.dart';

class EnquireViewMore extends StatefulWidget {
  int enquiryid;

  EnquireViewMore({
    Key? key,
    required this.enquiryid,
  }) : super(key: key);
  @override
  _EnquireViewMoreState createState() => _EnquireViewMoreState();
}

class _EnquireViewMoreState extends State<EnquireViewMore> {
  final KeynesApiService apiService = KeynesApiService();

  @override
  void initState() {
    getenquirybyadmin_app();
    super.initState();
  }

  Record? enquirydetailslistpage;
  bool isLoading = false;

  Future<void> getenquirybyadmin_app() async {
    setState(() {
      isLoading = true;
    });

    try {
      var result = await apiService.getenquirybyadmin_app(widget.enquiryid);
      var response = enquirydetailsListmodelFromJson(result);

      if (response.status.toString().toUpperCase() == 'SUCCESS') {
        print("print");
        setState(() {
          enquirydetailslistpage = response.record;

          isLoading = false;
        });
      } else {
        setState(() {
          //  enquirydetailslistpage = [];
          //  enquirydetailslistpageAll = [];
          isLoading = false;
        });
        // showInSnackBar(context, response.message.toString());
        print(response.message.toString());
      }
    } catch (e) {
      setState(() {
        // enquirydetailslistpage = [];
        // enquirydetailslistpageAll = [];
        isLoading = false;
      });
      // showInSnackBar(context, 'Error occurred: $e');
      print(e);
    }
  }

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
              borderRadius: BorderRadius.circular(13), // Add border radius
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
        backgroundColor: const Color(0xFF01519D),
        title: const Text(
          "Back",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: DetailSection(
                            label: "Date of enquiry",
                            value: enquirydetailslistpage!.createdDate ?? '',
                          ),
                        ),
                        Expanded(
                          child: DetailSection(
                            label: "Sale Executive",
                            value: enquirydetailslistpage!.salesExeName ?? '',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: DetailSection(
                            label: "Confirm Date",
                            value: enquirydetailslistpage!.confirmedDate ??
                                '', // confirmDate,
                          ),
                        ),
                        Expanded(
                          child: DetailSection(
                            label: "Duration",
                            value: enquirydetailslistpage!.duration ??
                                '', // duration,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: DetailSection(
                            label: "Amount",
                            value: enquirydetailslistpage!.totalAmount
                                .toString(), // amount,
                          ),
                        ),
                        Expanded(
                          child: DetailSection(
                            label: "Closing Date",
                            value: enquirydetailslistpage!.closedDate ??
                                '', // closingDate,
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment:
                          Alignment.centerLeft, // Aligns the text to the left
                      child: Text(
                        "Team Involved",
                        style: TextStyle(
                          color: Color(0xFF01519D),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: DetailSection(
                            label: "Project Engineer",
                            value: enquirydetailslistpage!.projEngName ??
                                '', // projectEngineer,
                          ),
                        ),
                        Expanded(
                          child: DetailSection(
                            label: "Engineer Admin",
                            value: enquirydetailslistpage!.engAdminName ??
                                '', // engineerAdmin,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: DetailSection(
                            label: "Department Engineer",
                            value: enquirydetailslistpage!.deptEngName ??
                                '', // departmentEngineer,
                          ),
                        ),
                        Expanded(
                          child: DetailSection(
                            label: "Engineer",
                            value: enquirydetailslistpage!.enginnersName ??
                                '', // engineer,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: DetailSection(
                            label: "Project Safety Coordinator",
                            value: enquirydetailslistpage!.safetyEngName ??
                                '', // projectSafetyCoordinator,
                          ),
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: DetailSection(
                            label: "Project Status",
                            value: enquirydetailslistpage!.enquiryStatus ??
                                '', // projectSafetyCoordinator,
                          ),
                        ),
                      ],
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Expanded(
                    //       child: DetailSection(
                    //         label: "Total Amount",
                    //         value: enquirydetailslistpage!.totalAmount
                    //             .toString(), // totalService,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(
                      height: 20.0,
                    ),
                    if (enquirydetailslistpage?.paymentHistory != null)
                      if (enquirydetailslistpage?.paymentHistory.length != 0)
                        Align(
                            alignment:
                                Alignment.centerLeft, // Align to the start
                            child: HeadingWidget(
                              title: "  Payment Status",
                            )),
                    if (enquirydetailslistpage?.paymentHistory != null)
                      if (enquirydetailslistpage?.paymentHistory.length != 0)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 400,
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey.shade200, width: 1.0),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Column(
                                    children: [
                                      // Table Header
                                      Container(
                                        color: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12.0, horizontal: 8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: const [
                                            Expanded(
                                                child: Text("Date",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold))),
                                            Expanded(
                                                child: Text("Mode",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold))),
                                            Expanded(
                                                child: Text("Amount",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold))),
                                          ],
                                        ),
                                      ),
                                      // Table Rows
                                      Expanded(
                                        child: ListView.builder(
                                          itemCount: enquirydetailslistpage
                                                  ?.paymentHistory.length ??
                                              0,
                                          itemBuilder: (context, index) {
                                            final payment =
                                                enquirydetailslistpage
                                                    ?.paymentHistory[index];

                                            return Container(
                                              color: index % 2 == 0
                                                  ? Colors.blue[50]
                                                  : Colors.white,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12.0,
                                                      horizontal: 8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                      child: Text(payment!
                                                              .createdDate ??
                                                          "")), // Date
                                                  Expanded(
                                                      child: Text(
                                                          payment.paymentMode ??
                                                              "")), // Mode
                                                  Expanded(
                                                      child: Text(
                                                          payment.amount ??
                                                              "")), // Amount
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            // PaymentTableScreen(),
                          ),
                        ),
                  ],
                ),
              ),
            ),
    );
  }
}

class DetailSection extends StatelessWidget {
  final String label;
  final String value;

  const DetailSection({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }
}











// import 'package:flutter/material.dart';
// import '../../services/keynes_api_service.dart';
// import '../../constants/app_assets.dart';
// import '../../constants/app_colors.dart';
// import '../../services/comFuncService.dart';
// import 'enquiry_details_model.dart';
// import 'package:shimmer/shimmer.dart';

// class EnquireViewMore extends StatefulWidget {
//   int enquiryid;

//   EnquireViewMore({
//     Key? key,
//     required this.enquiryid,
//   }) : super(key: key);
//   @override
//   _EnquireViewMoreState createState() => _EnquireViewMoreState();
// }

// class _EnquireViewMoreState extends State<EnquireViewMore> {
//   final KeynesApiService apiService = KeynesApiService();

//   @override
//   void initState() {
//     getenquirybyadmin_app();
//     super.initState();
//   }

//   Record? enquirydetailslistpage;
//   bool isLoading = false;

//   Future<void> getenquirybyadmin_app() async {
//     setState(() {
//       isLoading = true;
//     });

//     try {
//       var result = await apiService.getenquirybyadmin_app(widget.enquiryid);
//       var response = enquirydetailsListmodelFromJson(result);

//       if (response.status.toString().toUpperCase() == 'SUCCESS') {
//         print("print");
//         setState(() {
//           enquirydetailslistpage = response.record;

//           isLoading = false;
//         });
//       } else {
//         setState(() {
//           //  enquirydetailslistpage = [];
//           //  enquirydetailslistpageAll = [];
//           isLoading = false;
//         });
//         // showInSnackBar(context, response.message.toString());
//         print(response.message.toString());
//       }
//     } catch (e) {
//       setState(() {
//         // enquirydetailslistpage = [];
//         // enquirydetailslistpageAll = [];
//         isLoading = false;
//       });
//       // showInSnackBar(context, 'Error occurred: $e');
//       print(e);
//     }
//   }

//   //Shimmer
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
//               borderRadius: BorderRadius.circular(13), // Add border radius
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
//         backgroundColor: const Color(0xFF01519D),
//         title: const Text(
//           "Back",
//           style: TextStyle(color: Colors.white),
//         ),
//         leading: IconButton(
//           icon: const Icon(
//             Icons.arrow_back,
//             color: Colors.white,
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
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
//               padding: const EdgeInsets.all(16.0),
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(
//                           child: DetailSection(
//                             label: "Date of enquiry",
//                             value: enquirydetailslistpage!.createdDate ?? '',
//                           ),
//                         ),
//                         Expanded(
//                           child: DetailSection(
//                             label: "Sale Executive",
//                             value: enquirydetailslistpage!.salesExeName ?? '',
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(
//                           child: DetailSection(
//                             label: "Confirm Date",
//                             value: enquirydetailslistpage!.confirmedDate ??
//                                 '', // confirmDate,
//                           ),
//                         ),
//                         Expanded(
//                           child: DetailSection(
//                             label: "Duration",
//                             value: enquirydetailslistpage!.duration ??
//                                 '', // duration,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(
//                           child: DetailSection(
//                             label: "Amount",
//                             value: enquirydetailslistpage!.totalAmount
//                                 .toString(), // amount,
//                           ),
//                         ),
//                         Expanded(
//                           child: DetailSection(
//                             label: "Closing Date",
//                             value: enquirydetailslistpage!.closedDate ??
//                                 '', // closingDate,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Align(
//                       alignment:
//                           Alignment.centerLeft, // Aligns the text to the left
//                       child: Text(
//                         "Team Involved",
//                         style: TextStyle(
//                           color: Color(0xFF01519D),
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18,
//                         ),
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(
//                           child: DetailSection(
//                             label: "Project Engineer",
//                             value: enquirydetailslistpage!.projEngName ??
//                                 '', // projectEngineer,
//                           ),
//                         ),
//                         Expanded(
//                           child: DetailSection(
//                             label: "Engineer Admin",
//                             value: enquirydetailslistpage!.engAdminName ??
//                                 '', // engineerAdmin,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(
//                           child: DetailSection(
//                             label: "Department Engineer",
//                             value: enquirydetailslistpage!.deptEngName ??
//                                 '', // departmentEngineer,
//                           ),
//                         ),
//                         Expanded(
//                           child: DetailSection(
//                             label: "Engineer",
//                             value: enquirydetailslistpage!.enginnersName ??
//                                 '', // engineer,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(
//                           child: DetailSection(
//                             label: "Project Safety Coordinator",
//                             value: enquirydetailslistpage!.safetyEngName ??
//                                 '', // projectSafetyCoordinator,
//                           ),
//                         ),
//                       ],
//                     ),
//                     // Row(
//                     //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     //   children: [
//                     //     Expanded(
//                     //       child: DetailSection(
//                     //         label: "Total Amount",
//                     //         value: enquirydetailslistpage!.totalAmount
//                     //             .toString(), // totalService,
//                     //       ),
//                     //     ),
//                     //   ],
//                     // ),
//                     SizedBox(
//                       height: 10.0,
//                     ),
//                     if (enquirydetailslistpage?.paymentHistory != null)
//                       if (enquirydetailslistpage?.paymentHistory.length != 0)
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: SizedBox(
//                             height: 400,
//                             child: Padding(
//                               padding: const EdgeInsets.all(2.0),
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   border: Border.all(
//                                       color: Colors.grey.shade200, width: 1.0),
//                                   borderRadius: BorderRadius.circular(10.0),
//                                 ),
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(20.0),
//                                   child: Column(
//                                     children: [
//                                       // Table Header
//                                       Container(
//                                         color: Colors.white,
//                                         padding: const EdgeInsets.symmetric(
//                                             vertical: 12.0, horizontal: 8.0),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: const [
//                                             Expanded(
//                                                 child: Text("Payment Date",
//                                                     style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.bold))),
//                                             Expanded(
//                                                 child: Text("Payment Mode",
//                                                     style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.bold))),
//                                             Expanded(
//                                                 child: Text("Payment Amount",
//                                                     style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.bold))),
//                                           ],
//                                         ),
//                                       ),
//                                       // Table Rows
//                                       Expanded(
//                                         child: ListView.builder(
//                                           itemCount: enquirydetailslistpage
//                                                   ?.paymentHistory.length ??
//                                               0,
//                                           itemBuilder: (context, index) {
//                                             final payment =
//                                                 enquirydetailslistpage
//                                                     ?.paymentHistory[index];

//                                             return Container(
//                                               color: index % 2 == 0
//                                                   ? Colors.blue[50]
//                                                   : Colors.white,
//                                               padding:
//                                                   const EdgeInsets.symmetric(
//                                                       vertical: 12.0,
//                                                       horizontal: 8.0),
//                                               child: Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceBetween,
//                                                 children: [
//                                                   Expanded(
//                                                       child: Text(payment!
//                                                               .createdDate ??
//                                                           "")), // Date
//                                                   Expanded(
//                                                       child: Text(
//                                                           payment.paymentMode ??
//                                                               "")), // Mode
//                                                   Expanded(
//                                                       child: Text(
//                                                           payment.amount ??
//                                                               "")), // Amount
//                                                 ],
//                                               ),
//                                             );
//                                           },
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),

//                             // PaymentTableScreen(),
//                           ),
//                         ),
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }
// }

// class DetailSection extends StatelessWidget {
//   final String label;
//   final String value;

//   const DetailSection({
//     super.key,
//     required this.label,
//     required this.value,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             label,
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//               color: Colors.black,
//             ),
//           ),
//           const SizedBox(height: 6),
//           Text(
//             value,
//             style: const TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
//           ),
//         ],
//       ),
//     );
//   }
// }
