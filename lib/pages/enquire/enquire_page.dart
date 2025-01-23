import 'package:flutter/material.dart';
import 'package:keynes/pages/enquire/date_picker.dart';
import 'enquire_view_more.dart';
import 'enquiry_list_model.dart';
import '../../services/keynes_api_service.dart';
import '../../constants/app_assets.dart';
import '../../constants/app_colors.dart';
import '../../services/comFuncService.dart';

class EnquirePage extends StatefulWidget {
  const EnquirePage({super.key});

  @override
  State<EnquirePage> createState() => _EnquirePageState();
}

class _EnquirePageState extends State<EnquirePage> {


   final KeynesApiService apiService = KeynesApiService();

  @override
  void initState() {
    getenquirylistbyadmin_app();
    super.initState();
  }

  List<Record>? enquiryesList = [];
  List<Record>? enquiryesListAll = [];

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



  DateTime? _fromDate;
  DateTime? _toDate;

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

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> enquiryData = [
      {
        "customerName": "Tom Cruise",
        "department": "Construction",
        "date": "28-Oct-2024",
        "status": "Waiting for the quote from the account admin",
        "enquirySource": "App",
        "saleExecutive": "Michael",
        "confirmDate": "30-Oct-2024",
        "duration": "2 days",
        "amount": "AED 1,000.00",
        "closingDate": "01-Nov-2024",
        "projectEngineer": "John",
        "engineerAdmin": "David",
        "departmentEngineer": "Rachel",
        "engineer": "Ethan",
        "projectSafetyCoordinator": "Paul",
        "totalService": "4",
      },
      {
        "customerName": "Emily Blunt",
        "department": "Marketing",
        "date": "12-Nov-2024",
        "status": "Pending approval from manager",
        "enquirySource": "Website",
        "saleExecutive": "Emily",
        "confirmDate": "14-Nov-2024",
        "duration": "3 days",
        "amount": "AED 2,500.00",
        "closingDate": "15-Nov-2024",
        "projectEngineer": "Sophie",
        "engineerAdmin": "Lucas",
        "departmentEngineer": "Nora",
        "engineer": "Liam",
        "projectSafetyCoordinator": "Grace",
        "totalService": "3",
      },
      {
        "customerName": "Robert Downey",
        "department": "IT",
        "date": "5-Dec-2024",
        "status": "Quote sent to customer",
        "enquirySource": "App",
        "saleExecutive": "Robert",
        "confirmDate": "10-Dec-2024",
        "duration": "5 days",
        "amount": "AED 5,000.00",
        "closingDate": "15-Dec-2024",
        "projectEngineer": "Anna",
        "engineerAdmin": "James",
        "departmentEngineer": "Sophia",
        "engineer": "Noah",
        "projectSafetyCoordinator": "Olivia",
        "totalService": "5",
      },
    ];

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
      body: Container(
        color: Colors.grey[100],
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: DatePickerField(
                      label: "From",
                      onDateSelected: (date) {
                        setState(() {
                          _fromDate = date;
                          _toDate = null;
                        });
                        print("From Date: $_fromDate");
                      },
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: DatePickerField(
                      label: "To",
                      onDateSelected: (date) {
                        setState(() {
                          _toDate = date;
                        });

                        print("To Date: $_toDate");
                      },
                      datePickerConfig: DatePickerConfig(
                          firstDate: _fromDate?.add(const Duration(days: 1))),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: enquiryesList!.length,
                itemBuilder: (context, index) {
                  final enquiry = enquiryesList![index];
                  return 
                   Card(
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                    width:
                                        MediaQuery.of(context).size.width / 1.7,
                                    child:   Text(
  enquiry!.clientName,
  style: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
  overflow: TextOverflow.ellipsis, // Adds "..." if the text overflows
  maxLines: 2, // Limits the text to one line
)),

                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      enquiry!.department,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
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
                     enquiry!.refer,
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.yellow[100],
                    borderRadius: BorderRadius.circular(20),
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
                        enquiry!.projectStatus,
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
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => EnquireViewMore(
                      //     //  enquiryid: enquiry["enquiryid"]
                      //       dateOfEnquiry: enquiry["date"]!,
                      //       saleExecutive: enquiry["saleExecutive"]!,
                      //       confirmDate: enquiry["confirmDate"]!,
                      //       duration: enquiry["duration"]!,
                      //       amount: enquiry["amount"]!,
                      //       closingDate: enquiry["closingDate"]!,
                      //       projectEngineer: enquiry["projectEngineer"]!,
                      //       engineerAdmin: enquiry["engineerAdmin"]!,
                      //       departmentEngineer: enquiry["departmentEngineer"]!,
                      //       engineer: enquiry["engineer"]!,
                      //       projectSafetyCoordinator:
                      //           enquiry["projectSafetyCoordinator"]!,
                      //       totalService: enquiry["totalService"]!,
                      //     ),
                      //   ),
                      // );
                    },
        // onViewMore,
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
