import 'package:flutter/material.dart';

class PaymentTableScreen extends StatelessWidget {
  final List<Map<String, String>> paymentData = [
    {"date": "14-12-2024", "mode": "Cash", "amount": "AED352.00"},
    {"date": "14-12-2024", "mode": "Cash", "amount": "AED352.00"},
    {"date": "14-12-2024", "mode": "Cash", "amount": "AED352.00"},
    {"date": "14-12-2024", "mode": "Cash", "amount": "AED352.00"},
    {"date": "14-12-2024", "mode": "Cash", "amount": "AED352.00"},
    {"date": "14-12-2024", "mode": "Cash", "amount": "AED352.00"},
    {"date": "14-12-2024", "mode": "Cash", "amount": "AED352.00"},
    {"date": "14-12-2024", "mode": "Cash", "amount": "AED352.00"},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
