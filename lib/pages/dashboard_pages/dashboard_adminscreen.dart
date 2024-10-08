import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../constants/app_assets.dart';
import '../../constants/app_colors.dart';
import '../../services/comFuncService.dart';
import '../../services/keynes_api_service.dart';

class Dashboard_adminscreen extends StatefulWidget {
  @override
  _Dashboard_adminscreenState createState() => _Dashboard_adminscreenState();
}

class _Dashboard_adminscreenState extends State<Dashboard_adminscreen> {
  final KeynesApiService apiService = KeynesApiService();
  int progress = 80;

  // String? formattedDate;

  // @override
  // void initState() {
  //   super.initState();
  //   getAllEnquirys();
  // }

  // List<DasEnquiryListData>? dasenquiryList = [];
  // List<DasEnquiryListData>? dasenquiryListAll = [];

  // Future getAllEnquirys() async {
  //   var result = await apiService.getAllEnquirys();
  //   print('hi $result');
  //   EnquiryListModel response = enquiryListModelFromJson(result);
  //   if (response.status.toString() == 'SUCCESS') {
  //     setState(() {
  //       dasenquiryList = response.list;
  //       dasenquiryListAll = dasenquiryList;
  //       print('hello $dasenquiryList');
  //     });
  //   } else {
  //     setState(() {
  //       dasenquiryList = [];
  //       dasenquiryListAll = [];
  //     });
  //     showInSnackBar(context, response.status);
  //   }
  //   setState(() {});
  // }

// pop up list

  // void showenquiry(DasEnquiryListData service) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(15),
  //         ),
  //         contentPadding: EdgeInsets.all(20),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       'Name',
  //                       style: TextStyle(
  //                           fontWeight: FontWeight.bold, color: Colors.grey),
  //                     ),
  //                     Text(
  //                       service.clientName.toString(),
  //                       style: TextStyle(
  //                           fontSize: 16, fontWeight: FontWeight.bold),
  //                     ),
  //                   ],
  //                 ),
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.end,
  //                   children: [
  //                     Text(
  //                       'Phone No',
  //                       style: TextStyle(
  //                           fontWeight: FontWeight.bold, color: Colors.grey),
  //                     ),
  //                     Text(
  //                       service.mobile.toString(),
  //                       style: TextStyle(
  //                           fontSize: 16, fontWeight: FontWeight.bold),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //             SizedBox(height: 15),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       'Email id',
  //                       style: TextStyle(
  //                           fontWeight: FontWeight.bold, color: Colors.grey),
  //                     ),
  //                     Text(
  //                       service.email.toString(),
  //                       style: TextStyle(
  //                           fontSize: 16, fontWeight: FontWeight.bold),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //             SizedBox(
  //               height: 10,
  //             ),
  //             Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   'Emirates',
  //                   style: TextStyle(
  //                       fontWeight: FontWeight.bold, color: Colors.grey),
  //                 ),
  //                 Text(
  //                   service.address.toString(),
  //                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  //                   softWrap: true,
  //                 ),
  //               ],
  //             ),
  //             SizedBox(height: 15),
  //             Text(
  //               'Service Type',
  //               style:
  //                   TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
  //             ),
  //             Text(
  //               service.serviceName,
  //               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  //             ),
  //             SizedBox(height: 15),
  //             Text(
  //               'Description',
  //               style:
  //                   TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
  //             ),
  //             Text(
  //               service.notes.toString(),
  //               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Color(0xFF01519D),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none),
            color: Colors.white,
            onPressed: () {
              // Notification button action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                margin: const EdgeInsets.all(16.0),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and Menu Icon Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Overview',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF01519D),
                          ),
                        ),
                        Icon(Icons.more_vert),
                      ],
                    ),

                    SizedBox(height: 10),

                    Divider(thickness: 1, color: Colors.grey[300]),

                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 8),
                              Text(
                                'Total Projects',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Image.asset(
                                    AppAssets.projecticon,
                                    // height: 90.0,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '50',
                                    style: TextStyle(
                                      color: Color(0xFF0B90D3),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 8),
                              Text(
                                'Project Achieved',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Image.asset(
                                    AppAssets.increaseicon,
                                    // height: 90.0,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '20',
                                    style: TextStyle(
                                      color: Color(0xFF0CC172),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ))
                        ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8),
                            Text(
                              'Pending Projects',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Image.asset(
                                  AppAssets.fileicon,
                                  // height: 90.0,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '05',
                                  style: TextStyle(
                                    color: Color(0xFFF68F34),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          ],
                        )),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8),
                            Text(
                              'Total Workers',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Image.asset(
                                  AppAssets.personsicon,
                                  // height: 90.0,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '62',
                                  style: TextStyle(
                                    color: Color(0xFFD22D3F),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          ],
                        )),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Card(
                      color: Color(0xFFFFFE2E5),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              AppAssets.towericon1,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '20',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Today Meetings',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  '8% ',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 12,
                                  ),
                                ),
                                Icon(Icons.trending_up, color: Colors.blue),
                                Text(
                                  ' from Yesterday',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Card(
                      color: Color(0xFFFFF4DE),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              AppAssets.towericon2,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '0',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Total Task',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              ' 0% from Today',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Card(
                      color: Color(0xFFDCFCE7),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              AppAssets.increaseicon2,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '0',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Today Revenue',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  '2.5%',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 12,
                                  ),
                                ),
                                Icon(Icons.trending_up, color: Colors.blue),
                                Text(
                                  'from Yesterday',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Card(
                      color: Color(0xFFF3E8FF),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: Color(0xFFBF83FF),
                              child: Image.asset(
                                AppAssets.containericon,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '9582.20AED',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Total Revenue',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  '7%',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 12,
                                  ),
                                ),
                                Icon(Icons.trending_up, color: Colors.blue),
                                Text(
                                  ' LastMonth',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Live Task List',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF01519D)),
                  ),
                  Text(
                    'See More',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF01519D)),
                  ),
                ],
              ),
              SizedBox(height: 10),
              // dasenquiryList == null || dasenquiryList!.isEmpty
              //     ? Center(
              //         child: CircularProgressIndicator()) // Loading indicator
              //     : Padding(
              //         padding: const EdgeInsets.all(12.0),
              //         child: Column(
              //           children: dasenquiryList!.map((service) {
              //             return

              Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                          decoration: BoxDecoration(
                            color: Color(0xFFE9FFF5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.circle,
                                  color: Color(0xFF28C66F), size: 12),
                              SizedBox(width: 8),
                              Text(
                                'Active',
                                style: TextStyle(
                                  color: Color(0xFF28C66F),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'View more',
                          style: TextStyle(
                            color: Color(0xFF01519D),
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Task Name',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Started Date',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                      ],
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Foundation Lying',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '28-Oct-2024',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black),
                          )
                        ]),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Work Progress (%)',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                        Text(
                          'Employee Name',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20,
                                width: 150,
                                child: LinearProgressIndicator(
                                  value: progress / 100,
                                  backgroundColor: Colors.grey,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Color(0xFF01519D)),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    '0%',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                  SizedBox(
                                    width: 100,
                                  ),
                                  Text(
                                    '$progress%',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Text(
                            'Hilary Thomas',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black),
                          ),
                        ]),
                    SizedBox(height: 4),
                  ],
                ),
              )

              //     }).toList(),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
