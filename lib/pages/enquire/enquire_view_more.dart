import 'package:flutter/material.dart';
import '../../services/keynes_api_service.dart';
import '../../constants/app_assets.dart';
import '../../constants/app_colors.dart';
import '../../services/comFuncService.dart';

class EnquireViewMore extends StatelessWidget {
 // final String enquiryid;
  final String dateOfEnquiry;
  final String saleExecutive;
  final String confirmDate;
  final String duration;
  final String amount;
  final String closingDate;
  final String projectEngineer;
  final String engineerAdmin;
  final String departmentEngineer;
  final String engineer;
  final String projectSafetyCoordinator;
  final String totalService;

  const EnquireViewMore({
    Key? key,
  //  required this.enquiryid,
    required this.dateOfEnquiry,
    required this.saleExecutive,
    required this.confirmDate,
    required this.duration,
    required this.amount,
    required this.closingDate,
    required this.projectEngineer,
    required this.engineerAdmin,
    required this.departmentEngineer,
    required this.engineer,
    required this.projectSafetyCoordinator,
    required this.totalService,
  }) : super(key: key);



   final List<Map<String, String>> paymentData =const [
    {"date": "14-12-2024", "mode": "Cash", "amount": "AED352.00"},
    {"date": "14-12-2024", "mode": "Cash", "amount": "AED352.00"},
    {"date": "14-12-2024", "mode": "Cash", "amount": "AED352.00"},
    {"date": "14-12-2024", "mode": "Cash", "amount": "AED352.00"},
    {"date": "14-12-2024", "mode": "Cash", "amount": "AED352.00"},
    {"date": "14-12-2024", "mode": "Cash", "amount": "AED352.00"},
    {"date": "14-12-2024", "mode": "Cash", "amount": "AED352.00"},
    {"date": "14-12-2024", "mode": "Cash", "amount": "AED352.00"},
  ];

  //  List<CategoryProductList> enquirydetailslistpage = [];
  //  List<CategoryProductList> enquirydetailslistpageAll = [];



  //  Future<void> getenquirybyadmin_app() async {
  //   setState(() {
  //     isLoading = true;
  //   });

  //   try {
  //     var result = await apiService.getenquirybyadmin_app(widget.enquiryid);
  //     var response = storedetailmenulistmodelFromJson(result);

  //     if (response.status.toString().toUpperCase() == 'SUCCESS') {
  //       print("print");
  //       setState(() {
  //         enquirydetailslistpage = response.categoryProductList;
  //         enquirydetailslistpageAll = enquirydetailslistpage;
  //         print(enquirydetailslistpage);
  //         print(enquirydetailslistpage);
  //         isLoading = false;
  //       });
  //     } else {
  //       setState(() {
  //         enquirydetailslistpage = [];
  //         enquirydetailslistpageAll = [];
  //         isLoading = false;
  //       });
  //       // showInSnackBar(context, response.message.toString());
  //       print(response.message.toString());
  //     }
  //   } catch (e) {
  //     setState(() {
  //       enquirydetailslistpage = [];
  //       enquirydetailslistpageAll = [];
  //       isLoading = false;
  //     });
  //     // showInSnackBar(context, 'Error occurred: $e');
  //     print(e);
  //   }
  // }

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
      body: Container(
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
                      value: dateOfEnquiry,
                    ),
                  ),
                  Expanded(
                    child: DetailSection(
                      label: "Sale Executive",
                      value: saleExecutive,
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
                      value: confirmDate,
                    ),
                  ),
                  Expanded(
                    child: DetailSection(
                      label: "Duration",
                      value: duration,
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
                      value: amount,
                    ),
                  ),
                  Expanded(
                    child: DetailSection(
                      label: "Closing Date",
                      value: closingDate,
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerLeft, // Aligns the text to the left
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
                      value: projectEngineer,
                    ),
                  ),
                  Expanded(
                    child: DetailSection(
                      label: "Engineer Admin",
                      value: engineerAdmin,
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
                      value: departmentEngineer,
                    ),
                  ),
                  Expanded(
                    child: DetailSection(
                      label: "Engineer",
                      value: engineer,
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
                      value: projectSafetyCoordinator,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: DetailSection(
                      label: "Total Service",
                      value: totalService,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 400,
                  child:   Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade200, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Column(
            children: [
              // Table Header
              Container(
                color: Colors.white,
                padding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Expanded(
                        child: Text("Payment Date",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Expanded(
                        child: Text("Payment Mode",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Expanded(
                        child: Text("Payment Amount",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                ),
              ),
              // Table Rows
              Expanded(
                child: ListView.builder(
                  itemCount: paymentData.length,
                  itemBuilder: (context, index) {
                    final row = paymentData[index];
                    return Container(
                      color: index % 2 == 0 ? Colors.blue[50] : Colors.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text(row["date"]!)),
                          Expanded(child: Text(row["mode"]!)),
                          Expanded(child: Text(row["amount"]!)),
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
