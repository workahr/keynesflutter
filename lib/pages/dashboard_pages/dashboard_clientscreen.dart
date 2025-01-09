import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:keynes/pages/dashboard_pages/enquiry_list_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/app_assets.dart';
import '../../constants/app_colors.dart';
import '../../services/comFuncService.dart';
import '../../services/keynes_api_service.dart';

class DashboardClientScreen extends StatefulWidget {
  @override
  _DashboardClientScreenState createState() => _DashboardClientScreenState();
}

class _DashboardClientScreenState extends State<DashboardClientScreen> {
  final KeynesApiService apiService = KeynesApiService();
  String? formattedDate;

  void _makePhoneCall(String mobile) async {
    if (await canLaunch(
      mobile,
    )) {
      await launch(mobile);
    } else {
      throw 'Could not launch $mobile';
    }
  }

  @override
  void initState() {
    super.initState();
    getAllEnquirys();
  }

  List<DasEnquiryListData>? dasenquiryList = [];
  List<DasEnquiryListData>? dasenquiryListAll = [];

  Future getAllEnquirys() async {
    await apiService.getBearerToken();

    var result = await apiService.getAllEnquirys();
    print('hi $result');
    EnquiryListModel response = enquiryListModelFromJson(result);
    if (response.status.toString() == 'SUCCESS') {
      setState(() {
        dasenquiryList = response.list;
        dasenquiryListAll = dasenquiryList;
        print('hello $dasenquiryList');
      });
    } else {
      setState(() {
        dasenquiryList = [];
        dasenquiryListAll = [];
      });
      //  showInSnackBar(context, response.status);
    }
    setState(() {});
  }

  void showenquiry(DasEnquiryListData service) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          contentPadding: EdgeInsets.all(20),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                      Text(
                        service.clientName.toString(),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Phone No',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                      Text(
                        service.mobile.toString(),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email id',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                      Text(
                        service.email.toString(),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Emirates',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                  Text(
                    service.address.toString(),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    softWrap: true,
                  ),
                ],
              ),
              SizedBox(height: 15),
              Text(
                'Service Type',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
              ),
              Text(
                service.serviceName.toString(),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              Text(
                'Description',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
              ),
              Text(
                service.notes.toString(),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            Center(
                child: ElevatedButton.icon(
              onPressed: () {
                _makePhoneCall("tel:" + service.mobile.toString());
                Navigator.of(context).pop(); // Close the dialog
              },
              icon: Icon(Icons.phone),
              label: Text('Enquiry now'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
            )),
          ],
        );
      },
    );
  }

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
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                  SizedBox(width: 10), // Add space between the cards
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
                              '20',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Total Enquiries',
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
                              'Today Enquiries',
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
                  SizedBox(width: 10), // Add space between the cards
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
                              '9',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Pending Enquiries',
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
                                Text(
                                  ' from LastMonth',
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

              //  _buildOverviewCards(),

              SizedBox(height: 20),

              // Enquiry List section
              Text(
                'Enquiry List',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF01519D)),
              ),
              SizedBox(height: 10),
              dasenquiryList == null || dasenquiryList!.isEmpty
                  ? Center(
                      child: CircularProgressIndicator()) // Loading indicator
                  : Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: dasenquiryList!.map((service) {
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 8.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey,
                                  width: 0.50), // Border color and width
                              borderRadius: BorderRadius.circular(
                                  10.0), // Matching the border radius of the card
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 4, horizontal: 10),
                                              decoration: BoxDecoration(
                                                color: Color(0xFFFFF8DB),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.circle,
                                                      color: Color(0xFFBC9600),
                                                      size: 10),
                                                  SizedBox(width: 5),
                                                  Text('Pending',
                                                      style: TextStyle(
                                                          color: Colors.amber)),
                                                ],
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                showenquiry(service);
                                              },
                                              child: Text(
                                                'View more',
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),

                                        // Name and Date
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Name',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                            Text(
                                              'Date',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              service.clientName.toString(),
                                              // 'Tom Cruise',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              formattedDate = DateFormat(
                                                      'dd-MM-yyyy')
                                                  .format(service.createdDate),
                                              // '28-Oct-2024',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),

                                        // Service Type
                                        Text(
                                          'Service Type',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        Text(
                                          service.serviceName.toString(),
                                          //'Approval, Construction, Interior',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
