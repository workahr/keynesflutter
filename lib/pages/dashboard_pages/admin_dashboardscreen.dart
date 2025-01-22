//import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../constants/app_assets.dart';

class Admin_Dashboardscreen extends StatefulWidget {
  @override
  _Admin_DashboardscreenState createState() => _Admin_DashboardscreenState();
}

class _Admin_DashboardscreenState extends State<Admin_Dashboardscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF01519D),
          elevation: 0,
          title: const Text('Dashboard',
              style: TextStyle(fontSize: 20, color: Colors.white)),
          leading: IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {},
          ),
          actions: [
            IconButton(
              icon: Image.asset(
                AppAssets.Bell_icon,
                height: 25.0,
                width: 25.0,
              ),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            //  crossAxisAlignment: CrossAxisAlignment.c,
            children: [
              // Overall Payment Section
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Overall Payment',
                    style: TextStyle(
                      color: Color(0xFF01519D),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'AED15,000.00',
                    style: TextStyle(
                      color: Color(0xFF01519D),
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Color(0xFFD8FFEE),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      '8% ↑ Last month',
                      style: TextStyle(
                        color: Color(0xFF0CC172),
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Divider(
                    color: Color.fromARGB(255, 244, 243, 243),
                  )),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 80, // Ensure a fixed height for the Row
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // First Column
                          Expanded(
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
                                          'Total Payments',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                        Text(
                                          'Received',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ],
                                    ),
                                    Icon(Icons.account_balance_wallet,
                                        size: 28, color: Colors.blue),
                                  ],
                                ),
                                Text(
                                  'AED9,000.00',
                                  style: const TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Vertical Divider
                          VerticalDivider(
                            color: Color.fromARGB(255, 244, 243, 243),
                            thickness: 1, // Width of the line
                            width: 25, // Total space taken by the divider
                            indent: 5, // Top padding
                            endIndent: 5, // Bottom padding
                          ),

                          // Second Column
                          Expanded(
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
                                          'Total',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          'Balance Due',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    Icon(Icons.account_balance_wallet,
                                        size: 28, color: Colors.blue),
                                  ],
                                ),
                                Text(
                                  'AED9,000.00',
                                  style: const TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Divider(
                color: Color.fromARGB(255, 244, 243, 243),
              ),
              Align(
                alignment: Alignment
                    .centerLeft, // Aligns to the start of the container
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: const Text(
                    'Enquiry',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(13.0),
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
                childAspectRatio: 1.2,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 12.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Total Enquiry’s Closed',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              AppAssets.edittext_pink_icon,
                              height: 40.0,
                              width: 40.0,
                            ),
                            Text(
                              '5,500',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1C1C3B),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white, // Background color of the container
                      borderRadius:
                          BorderRadius.circular(12), // Rounded corners
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2), // Shadow color
                          spreadRadius: 2, // Spread radius
                          blurRadius: 5, // Blur radius
                          offset: Offset(0, 3), // Shadow position
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Enquiries',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              AppAssets.edittext_icon2,
                              height: 40.0,
                              width: 40.0,
                            ),
                            Text(
                              '2,500',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1C1C3B), // Text color
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white, // Background color of the container
                      borderRadius:
                          BorderRadius.circular(12), // Rounded corners
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2), // Shadow color
                          spreadRadius: 2, // Spread radius
                          blurRadius: 5, // Blur radius
                          offset: Offset(0, 3), // Shadow position
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Active Enquiry’s',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              AppAssets.edittext_icon3,
                              height: 40.0,
                              width: 40.0,
                            ),
                            Text(
                              '1,500',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1C1C3B), // Text color
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white, // Background color of the container
                      borderRadius:
                          BorderRadius.circular(12), // Rounded corners
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2), // Shadow color
                          spreadRadius: 2, // Spread radius
                          blurRadius: 5, // Blur radius
                          offset: Offset(0, 3), // Shadow position
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Confirm Enquiry’s',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              AppAssets.edittext_icon4,
                              height: 40.0,
                              width: 40.0,
                            ),
                            Text(
                              '500',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1C1C3B), // Text color
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Services Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: const Text(
                  'Services',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: PieChart(
                      dataMap: {
                        "Construction": 800,
                        "Authority Approvals": 150,
                        "Interior Design": 850,
                        "Property Management": 560,
                        "General Maintenance": 150,
                        "Pest Control Services": 120,
                        "Business Support Services": 220,
                        "Additional Services": 160,
                        "IT and Security Solutions": 155,
                      },
                      colorList: [
                        Colors.green, // Construction
                        Colors.red, // Authority Approvals
                        Colors.orange, // Interior Design
                        Colors.purple, // Property Management
                        Colors.pink, // General Maintenance
                        Colors.blue, // Pest Control Services
                        Colors.blueAccent, // Business Support Services
                        Colors.teal, // Additional Services
                        Colors.indigo, // IT and Security Solutions
                      ], // Custom colors for the chart
                      chartType: ChartType.ring,
                      chartRadius: MediaQuery.of(context).size.width /
                          1.8, // Adjust width if needed
                      centerText: "Total Invoice \nValue \n 09",
                      centerTextStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      chartValuesOptions: const ChartValuesOptions(
                          showChartValues: false,
                          showChartValuesOutside: false,
                          showChartValuesInPercentage: false,
                          showChartValueBackground: false),
                      ringStrokeWidth: 32,
                      legendOptions: const LegendOptions(
                        showLegends: false, // Hide default legends
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  // Wrap the Column inside an Expanded to prevent overflow
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildValueText(Colors.green, 800),
                        _buildValueText(Colors.red, 150),
                        _buildValueText(Colors.orange, 850),
                        _buildValueText(Colors.purple, 560),
                        _buildValueText(Colors.pink, 150),
                        _buildValueText(Colors.blue, 120),
                        _buildValueText(Colors.blueAccent, 220),
                        _buildValueText(Colors.teal, 160),
                        _buildValueText(Colors.indigo, 155),
                      ],
                    ),
                  ),
                ],
              ),

// Center Text
              const SizedBox(height: 20),
              GridView.count(
                crossAxisCount: 2, // 2 items per row
                shrinkWrap: true, // Shrinks to fit content
                physics:
                    const NeverScrollableScrollPhysics(), // Disables scrolling
                padding: const EdgeInsets.all(10.0),
                mainAxisSpacing: 5.0, // Vertical space between items
                crossAxisSpacing: 5.0, // Horizontal space between items
                childAspectRatio: 4.5, // Aspect ratio of the grid items
                children: [
                  _buildLegend(Colors.green, "Construction"),
                  _buildLegend(Colors.red, "Authority Approvals"),
                  _buildLegend(Colors.orange, "Interior Design"),
                  _buildLegend(Colors.purple, "Property Management"),
                  _buildLegend(Colors.pink, "General Maintenance"),
                  _buildLegend(Colors.blue, "Pest Control Services"),
                  _buildLegend(Colors.blueAccent, "Business Support Services"),
                  _buildLegend(Colors.teal, "Additional Services"),
                  _buildLegend(Colors.indigo, "IT and Security Solutions"),
                ],
              ),
            ],
          ),
        ));
  }

  Widget _buildValueText(Color color, double value) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10), // This makes it round
          ),
        ),
        const SizedBox(width: 8),
        Text(
          "$value", // Show only the value here
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildLegend(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10), // This makes it round
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          // Ensure the text expands properly within the available space
          child: Text(
            label,
            style: const TextStyle(fontSize: 14),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}
