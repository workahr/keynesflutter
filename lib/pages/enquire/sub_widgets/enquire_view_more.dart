import 'package:flutter/material.dart';
import 'package:keynes/pages/enquire/sub_widgets/view_enquire_table.dart';

class EnquireViewMore extends StatelessWidget {
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
                  child: PaymentTableScreen(),
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
