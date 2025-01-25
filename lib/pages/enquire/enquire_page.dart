import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'enquire_view_more.dart';
import 'enquiry_list_model.dart';
import '../../services/keynes_api_service.dart';
import '../../constants/app_assets.dart';
import 'package:intl/intl.dart';
import '../../services/comFuncService.dart';
import 'from_to_date_picker.dart';
import 'package:page_transition/page_transition.dart';

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
                                                  1.7,
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
                                                  color: Colors.amber[800],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 16),
                                  Divider(color: Colors.grey[500]),
                                  Center(
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                duration:
                                                    Duration(milliseconds: 250),
                                                reverseDuration:
                                                    Duration(milliseconds: 250),
                                                child: EnquireViewMore(
                                                  enquiryid: enquiry!.id,
                                                ),
                                                type: PageTransitionType
                                                    .rightToLeft));

                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (context) =>
                                        //         EnquireViewMore(
                                        //       enquiryid: enquiry!.id,
                                        //     ),
                                        //   ),
                                        // );
                                      },
                                      child: Text(
                                        "View more",
                                        style: TextStyle(
                                          color: Color(0xFF01519D),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
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
