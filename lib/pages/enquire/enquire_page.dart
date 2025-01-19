import 'package:flutter/material.dart';
import 'package:keynes/pages/enquire/date_picker.dart';
import 'package:keynes/pages/enquire/enquire_card.dart';
import 'package:keynes/pages/enquire/sub_widgets/enquire_view_more.dart';

class EnquirePage extends StatefulWidget {
  const EnquirePage({super.key});

  @override
  State<EnquirePage> createState() => _EnquirePageState();
}

class _EnquirePageState extends State<EnquirePage> {
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
                itemCount: enquiryData.length,
                itemBuilder: (context, index) {
                  final enquiry = enquiryData[index];
                  return EnquireCard(
                    customerName: enquiry["customerName"]!,
                    department: enquiry["department"]!,
                    date: enquiry["date"]!,
                    status: enquiry["status"]!,
                    enquirySource: enquiry["enquirySource"]!,
                    onViewMore: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EnquireViewMore(
                            dateOfEnquiry: enquiry["date"]!,
                            saleExecutive: enquiry["saleExecutive"]!,
                            confirmDate: enquiry["confirmDate"]!,
                            duration: enquiry["duration"]!,
                            amount: enquiry["amount"]!,
                            closingDate: enquiry["closingDate"]!,
                            projectEngineer: enquiry["projectEngineer"]!,
                            engineerAdmin: enquiry["engineerAdmin"]!,
                            departmentEngineer: enquiry["departmentEngineer"]!,
                            engineer: enquiry["engineer"]!,
                            projectSafetyCoordinator:
                                enquiry["projectSafetyCoordinator"]!,
                            totalService: enquiry["totalService"]!,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
