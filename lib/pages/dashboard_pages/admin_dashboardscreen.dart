//import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../../constants/app_assets.dart';
import '../../models/dashboardrecord_model.dart';
import '../../services/comFuncService.dart';
import '../../services/keynes_api_service.dart';
import '../auth/login_page.dart';
import '../home/home_page.dart';
import '../main_container.dart';

class Admin_Dashboardscreen extends StatefulWidget {
  @override
  _Admin_DashboardscreenState createState() => _Admin_DashboardscreenState();
}

class _Admin_DashboardscreenState extends State<Admin_Dashboardscreen> {
  final KeynesApiService apiService = KeynesApiService();

  @override
  void initState() {
    super.initState();
    getdashboardrecord();
  }

//getdashboardrecord

  // List<ServiceList>? recordList = [];
  // List<ServiceList>? recordListAll = [];

  Record? recordList;

  Future getdashboardrecord() async {
    await apiService.getBearerToken();
    setState(() {
      isLoading = true;
    });
    var result = await apiService.getdashboardrecord();

    print('hi $result');
    DashboardRecordModel response = dashboardRecordModelFromJson(result);
    print('Raw JSON: $response');
    print('record : ${response.record}');

    if (response.status == 'SUCCESS' && response.record != null) {
      setState(() {
        recordList = response.record;

        print('Raw');
        isLoading = false;
      });
    } else {
      showInSnackBar(context, "Data not found");
      isLoading = false;
    }
    setState(() {});
  }

  bool isLoading = false;
  Widget _buildShimmerPlaceholder() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: Container(
                width: double.infinity,
                height: 150,
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
                height: 100,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 60,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: Container(
                width: double.infinity,
                height: 300,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: Container(
                width: double.infinity,
                height: 100,
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

  Future<void> _handleLogout() async {
    // Clear SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    // Navigate to Login Page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainContainer()),
    );
  }

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
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () {
                _handleLogout();
              },
            ),
          ],
        ),
        body: isLoading || recordList == null
            ? ListView.builder(
                itemCount: 8,
                itemBuilder: (context, index) {
                  return _buildShimmerPlaceholder();
                },
              )
            : SingleChildScrollView(
                child: Column(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 18),
                    const Text(
                      'Overall Payment',
                      style: TextStyle(
                        color: Color(0xFF01519D),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (recordList!.totalpayment.toString() != null)
                      Text(
                        (recordList?.totalpayment ?? 0).toStringAsFixed(2),
                        style: TextStyle(
                          color: Color(0xFF01519D),
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    const SizedBox(height: 8),
                    // Container(
                    //   padding: const EdgeInsets.symmetric(
                    //       horizontal: 12, vertical: 4),
                    //   decoration: BoxDecoration(
                    //     color: Color(0xFFD8FFEE),
                    //     borderRadius: BorderRadius.circular(12),
                    //   ),
                    //   child: const Text(
                    //     '8% ↑ Last month',
                    //     style: TextStyle(
                    //       color: Color(0xFF0CC172),
                    //       fontSize: 14,
                    //     ),
                    //   ),
                    // ),
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
                                  if (recordList!.paidpayment.toString() !=
                                      null)
                                    Text(
                                      recordList!.paidpayment
                                          .toStringAsFixed(2),
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
                                  if (recordList!.balancepayment.toString() !=
                                      null)
                                    Text(
                                      recordList!.balancepayment
                                          .toStringAsFixed(2),
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
                              if (recordList!.closeEnquiry.toString() != null)
                                Text(
                                  recordList!.closeEnquiry.toString(),
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
                        color:
                            Colors.white, // Background color of the container
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
                              if (recordList!.totalEnquiry.toString() != null)
                                Text(
                                  recordList!.totalEnquiry.toString(),
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
                        color:
                            Colors.white, // Background color of the container
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
                              if (recordList!.activeEnquiry.toString() != null)
                                Text(
                                  recordList!.activeEnquiry.toString(),
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
                        color:
                            Colors.white, // Background color of the container
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
                              if (recordList!.confirmEnquiry.toString() != null)
                                Text(
                                  recordList!.confirmEnquiry.toString(),
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
                if (recordList != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: PieChart(
                          dataMap: {
                            for (var service in recordList!.serviceList)
                              service.name: service.count.toDouble(),
                          },
                          colorList: [
                            Colors.green,
                            Colors.red,
                            Colors.orange,
                            Colors.purple,
                            Colors.pink,
                            Colors.blue,
                            Colors.blueAccent,
                            Colors.teal,
                            Colors.indigo,
                          ], // Custom colors for the chart
                          chartType: ChartType.ring,
                          chartRadius: MediaQuery.of(context).size.width / 1.8,
                          centerText: "Total Invoice \nValue",
                          centerTextStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValues: false,
                            showChartValuesOutside: false,
                            showChartValuesInPercentage: false,
                            showChartValueBackground: false,
                          ),
                          ringStrokeWidth: 32,
                          legendOptions: const LegendOptions(
                            showLegends: false, // Hide default legends
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var service in recordList!.serviceList)
                              _buildValueText(
                                _getColorForIndex(
                                    recordList!.serviceList.indexOf(service)),
                                service.count,
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),

// GridView for Legends
                const SizedBox(height: 20),
                if (recordList != null)
                  GridView.count(
                    crossAxisCount: 2, // 2 items per row
                    shrinkWrap: true, // Shrinks to fit content
                    physics:
                        const NeverScrollableScrollPhysics(), // Disable scrolling
                    padding: const EdgeInsets.all(10.0),
                    mainAxisSpacing: 5.0, // Vertical space between items
                    crossAxisSpacing: 5.0, // Horizontal space between items
                    childAspectRatio: 4.5, // Aspect ratio of the grid items
                    children: [
                      for (var service in recordList!.serviceList)
                        _buildLegend(
                          _getColorForIndex(
                              recordList!.serviceList.indexOf(service)),
                          service.name,
                        ),
                    ],
                  ),
              ])));
  }

  Widget _buildValueText(Color color, double value) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          "$value",
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
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
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

  Color _getColorForIndex(int index) {
    const colorList = [
      Colors.green,
      Colors.red,
      Colors.orange,
      Colors.purple,
      Colors.pink,
      Colors.blue,
      Colors.blueAccent,
      Colors.teal,
      Colors.indigo,
    ];
    return colorList[index % colorList.length];
  }
}








// //import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:pie_chart/pie_chart.dart';
// import 'package:shimmer/shimmer.dart';
// import '../../constants/app_assets.dart';
// import '../../models/dashboardrecord_model.dart';
// import '../../services/comFuncService.dart';
// import '../../services/keynes_api_service.dart';

// class Admin_Dashboardscreen extends StatefulWidget {
//   @override
//   _Admin_DashboardscreenState createState() => _Admin_DashboardscreenState();
// }

// class _Admin_DashboardscreenState extends State<Admin_Dashboardscreen> {
//   final KeynesApiService apiService = KeynesApiService();

//   @override
//   void initState() {
//     super.initState();
//     getdashboardrecord();
//   }

// //getdashboardrecord

//   // List<ServiceList>? recordList = [];
//   // List<ServiceList>? recordListAll = [];

//   Record? recordList;

//   Future getdashboardrecord() async {
//     await apiService.getBearerToken();
//     setState(() {
//       isLoading = true;
//     });
//     var result = await apiService.getdashboardrecord();

//     print('hi $result');
//     DashboardRecordModel response = dashboardRecordModelFromJson(result);
//     print('Raw JSON: $response');
//     print('record : ${response.record}');

//     if (response.status == 'SUCCESS' && response.record != null) {
//       setState(() {
//         recordList = response.record;

//         print('Raw');
//         isLoading = false;
//       });
//     } else {
//       showInSnackBar(context, "Data not found");
//       isLoading = false;
//     }
//     setState(() {});
//   }

//   bool isLoading = false;
//   Widget _buildShimmerPlaceholder() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//       child: Shimmer.fromColors(
//         baseColor: Colors.grey.shade300,
//         highlightColor: Colors.grey.shade100,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(13),
//               child: Container(
//                 width: double.infinity,
//                 height: 150,
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
//                 height: 100,
//                 color: Colors.white,
//               ),
//             ),
//             SizedBox(
//               height: 60,
//             ),
//             ClipRRect(
//               borderRadius: BorderRadius.circular(13),
//               child: Container(
//                 width: double.infinity,
//                 height: 300,
//                 color: Colors.white,
//               ),
//             ),
//             SizedBox(
//               height: 30,
//             ),
//             ClipRRect(
//               borderRadius: BorderRadius.circular(13),
//               child: Container(
//                 width: double.infinity,
//                 height: 100,
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
//         appBar: AppBar(
//           backgroundColor: Color(0xFF01519D),
//           elevation: 0,
//           title: const Text('Dashboard',
//               style: TextStyle(fontSize: 20, color: Colors.white)),
//           leading: IconButton(
//             icon: const Icon(Icons.menu, color: Colors.white),
//             onPressed: () {},
//           ),
//           actions: [
//             IconButton(
//               icon: Image.asset(
//                 AppAssets.Bell_icon,
//                 height: 25.0,
//                 width: 25.0,
//               ),
//               onPressed: () {},
//             ),
//           ],
//         ),
//         body: isLoading || recordList == null
//             ? ListView.builder(
//                 itemCount: 8,
//                 itemBuilder: (context, index) {
//                   return _buildShimmerPlaceholder();
//                 },
//               )
//             : SingleChildScrollView(
//                 child: Column(children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     SizedBox(height: 18),
//                     const Text(
//                       'Overall Payment',
//                       style: TextStyle(
//                         color: Color(0xFF01519D),
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     if (recordList!.totalpayment.toString() != null)
//                       Text(
//                         (recordList?.totalpayment ?? 0).toStringAsFixed(2),
//                         style: TextStyle(
//                           color: Color(0xFF01519D),
//                           fontSize: 28,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     const SizedBox(height: 8),
//                     // Container(
//                     //   padding: const EdgeInsets.symmetric(
//                     //       horizontal: 12, vertical: 4),
//                     //   decoration: BoxDecoration(
//                     //     color: Color(0xFFD8FFEE),
//                     //     borderRadius: BorderRadius.circular(12),
//                     //   ),
//                     //   child: const Text(
//                     //     '8% ↑ Last month',
//                     //     style: TextStyle(
//                     //       color: Color(0xFF0CC172),
//                     //       fontSize: 14,
//                     //     ),
//                     //   ),
//                     // ),
//                   ],
//                 ),

//                 Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: Divider(
//                       color: Color.fromARGB(255, 244, 243, 243),
//                     )),

//                 Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         height: 80, // Ensure a fixed height for the Row
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             // First Column
//                             Expanded(
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
//                                             'Total Payments',
//                                             style: const TextStyle(
//                                                 fontSize: 16,
//                                                 color: Colors.black),
//                                             overflow: TextOverflow.ellipsis,
//                                             maxLines: 2,
//                                           ),
//                                           Text(
//                                             'Received',
//                                             style: const TextStyle(
//                                                 fontSize: 16,
//                                                 color: Colors.black),
//                                             overflow: TextOverflow.ellipsis,
//                                             maxLines: 2,
//                                           ),
//                                         ],
//                                       ),
//                                       Icon(Icons.account_balance_wallet,
//                                           size: 28, color: Colors.blue),
//                                     ],
//                                   ),
//                                   if (recordList!.paidpayment.toString() !=
//                                       null)
//                                     Text(
//                                       recordList!.paidpayment
//                                           .toStringAsFixed(2),
//                                       style: const TextStyle(
//                                         fontSize: 21,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                 ],
//                               ),
//                             ),

//                             // Vertical Divider
//                             VerticalDivider(
//                               color: Color.fromARGB(255, 244, 243, 243),
//                               thickness: 1, // Width of the line
//                               width: 25, // Total space taken by the divider
//                               indent: 5, // Top padding
//                               endIndent: 5, // Bottom padding
//                             ),

//                             // Second Column
//                             Expanded(
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
//                                             'Total',
//                                             style: const TextStyle(
//                                                 fontSize: 16,
//                                                 color: Colors.black),
//                                           ),
//                                           Text(
//                                             'Balance Due',
//                                             style: const TextStyle(
//                                                 fontSize: 16,
//                                                 color: Colors.black),
//                                           ),
//                                         ],
//                                       ),
//                                       Icon(Icons.account_balance_wallet,
//                                           size: 28, color: Colors.blue),
//                                     ],
//                                   ),
//                                   if (recordList!.balancepayment.toString() !=
//                                       null)
//                                     Text(
//                                       recordList!.balancepayment
//                                           .toStringAsFixed(2),
//                                       style: const TextStyle(
//                                         fontSize: 21,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 Divider(
//                   color: Color.fromARGB(255, 244, 243, 243),
//                 ),
//                 Align(
//                   alignment: Alignment
//                       .centerLeft, // Aligns to the start of the container
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: const Text(
//                       'Enquiry',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//                 GridView.count(
//                   crossAxisCount: 2,
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   padding: const EdgeInsets.all(13.0),
//                   mainAxisSpacing: 16.0,
//                   crossAxisSpacing: 16.0,
//                   childAspectRatio: 1.2,
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 10.0, horizontal: 12.0),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(12),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.2),
//                             spreadRadius: 2,
//                             blurRadius: 5,
//                             offset: Offset(0, 3),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text(
//                             'Total Enquiry’s Closed',
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.black,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Image.asset(
//                                 AppAssets.edittext_pink_icon,
//                                 height: 40.0,
//                                 width: 40.0,
//                               ),
//                               if (recordList!.closeEnquiry.toString() != null)
//                                 Text(
//                                   recordList!.closeEnquiry.toString(),
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold,
//                                     color: Color(0xFF1C1C3B),
//                                   ),
//                                 ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       padding: const EdgeInsets.all(16.0),
//                       decoration: BoxDecoration(
//                         color:
//                             Colors.white, // Background color of the container
//                         borderRadius:
//                             BorderRadius.circular(12), // Rounded corners
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.2), // Shadow color
//                             spreadRadius: 2, // Spread radius
//                             blurRadius: 5, // Blur radius
//                             offset: Offset(0, 3), // Shadow position
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Total Enquiries',
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.black,
//                             ),
//                           ),
//                           const SizedBox(height: 16),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Image.asset(
//                                 AppAssets.edittext_icon2,
//                                 height: 40.0,
//                                 width: 40.0,
//                               ),
//                               if (recordList!.totalEnquiry.toString() != null)
//                                 Text(
//                                   recordList!.totalEnquiry.toString(),
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold,
//                                     color: Color(0xFF1C1C3B), // Text color
//                                   ),
//                                 ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       padding: const EdgeInsets.all(16.0),
//                       decoration: BoxDecoration(
//                         color:
//                             Colors.white, // Background color of the container
//                         borderRadius:
//                             BorderRadius.circular(12), // Rounded corners
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.2), // Shadow color
//                             spreadRadius: 2, // Spread radius
//                             blurRadius: 5, // Blur radius
//                             offset: Offset(0, 3), // Shadow position
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Total Active Enquiry’s',
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.black,
//                             ),
//                           ),
//                           const SizedBox(height: 16),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Image.asset(
//                                 AppAssets.edittext_icon3,
//                                 height: 40.0,
//                                 width: 40.0,
//                               ),
//                               if (recordList!.activeEnquiry.toString() != null)
//                                 Text(
//                                   recordList!.activeEnquiry.toString(),
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold,
//                                     color: Color(0xFF1C1C3B), // Text color
//                                   ),
//                                 ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       padding: const EdgeInsets.all(16.0),
//                       decoration: BoxDecoration(
//                         color:
//                             Colors.white, // Background color of the container
//                         borderRadius:
//                             BorderRadius.circular(12), // Rounded corners
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.2), // Shadow color
//                             spreadRadius: 2, // Spread radius
//                             blurRadius: 5, // Blur radius
//                             offset: Offset(0, 3), // Shadow position
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Total Confirm Enquiry’s',
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.black,
//                             ),
//                           ),
//                           const SizedBox(height: 16),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Image.asset(
//                                 AppAssets.edittext_icon4,
//                                 height: 40.0,
//                                 width: 40.0,
//                               ),
//                               if (recordList!.confirmEnquiry.toString() != null)
//                                 Text(
//                                   recordList!.confirmEnquiry.toString(),
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold,
//                                     color: Color(0xFF1C1C3B), // Text color
//                                   ),
//                                 ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),

//                 // Services Section
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: const Text(
//                     'Services',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 if (recordList != null)
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: PieChart(
//                           dataMap: {
//                             for (var service in recordList!.serviceList)
//                               service.name: service.count.toDouble(),
//                           },
//                           colorList: [
//                             Colors.green,
//                             Colors.red,
//                             Colors.orange,
//                             Colors.purple,
//                             Colors.pink,
//                             Colors.blue,
//                             Colors.blueAccent,
//                             Colors.teal,
//                             Colors.indigo,
//                           ], // Custom colors for the chart
//                           chartType: ChartType.ring,
//                           chartRadius: MediaQuery.of(context).size.width / 1.8,
//                           centerText: "Total Invoice \nValue",
//                           centerTextStyle: const TextStyle(
//                             color: Colors.black,
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                           chartValuesOptions: const ChartValuesOptions(
//                             showChartValues: false,
//                             showChartValuesOutside: false,
//                             showChartValuesInPercentage: false,
//                             showChartValueBackground: false,
//                           ),
//                           ringStrokeWidth: 32,
//                           legendOptions: const LegendOptions(
//                             showLegends: false, // Hide default legends
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 20),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             for (var service in recordList!.serviceList)
//                               _buildValueText(
//                                 _getColorForIndex(
//                                     recordList!.serviceList.indexOf(service)),
//                                 service.count,
//                               ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),

// // GridView for Legends
//                 const SizedBox(height: 20),
//                 if (recordList != null)
//                   GridView.count(
//                     crossAxisCount: 2, // 2 items per row
//                     shrinkWrap: true, // Shrinks to fit content
//                     physics:
//                         const NeverScrollableScrollPhysics(), // Disable scrolling
//                     padding: const EdgeInsets.all(10.0),
//                     mainAxisSpacing: 5.0, // Vertical space between items
//                     crossAxisSpacing: 5.0, // Horizontal space between items
//                     childAspectRatio: 4.5, // Aspect ratio of the grid items
//                     children: [
//                       for (var service in recordList!.serviceList)
//                         _buildLegend(
//                           _getColorForIndex(
//                               recordList!.serviceList.indexOf(service)),
//                           service.name,
//                         ),
//                     ],
//                   ),
//               ])));
//   }

//   Widget _buildValueText(Color color, double value) {
//     return Row(
//       children: [
//         Container(
//           width: 10,
//           height: 10,
//           decoration: BoxDecoration(
//             color: color,
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//         const SizedBox(width: 8),
//         Text(
//           "$value",
//           style: const TextStyle(fontSize: 16),
//         ),
//       ],
//     );
//   }

//   Widget _buildLegend(Color color, String label) {
//     return Row(
//       children: [
//         Container(
//           width: 10,
//           height: 10,
//           decoration: BoxDecoration(
//             color: color,
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//         const SizedBox(width: 8),
//         Expanded(
//           child: Text(
//             label,
//             style: const TextStyle(fontSize: 14),
//             overflow: TextOverflow.ellipsis,
//             maxLines: 2,
//           ),
//         ),
//       ],
//     );
//   }

//   Color _getColorForIndex(int index) {
//     const colorList = [
//       Colors.green,
//       Colors.red,
//       Colors.orange,
//       Colors.purple,
//       Colors.pink,
//       Colors.blue,
//       Colors.blueAccent,
//       Colors.teal,
//       Colors.indigo,
//     ];
//     return colorList[index % colorList.length];
//   }
// }
