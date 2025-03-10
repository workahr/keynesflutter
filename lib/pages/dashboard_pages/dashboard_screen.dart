import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:keynes/pages/dashboard_pages/enquiry_list_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/app_assets.dart';
import '../../constants/app_colors.dart';
import '../../services/comFuncService.dart';
import '../../services/keynes_api_service.dart';
import '../enquire/enquiry_details_model.dart';
import '../enquire/enquiry_list_model.dart';
import '../enquire/pdf_page.dart';
import '../main_container.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
    getenquirylistbyadmin_app();
  }

  List<DasEnquiryListData>? dasenquiryList = [];
  List<DasEnquiryListData>? dasenquiryListAll = [];
  bool isLoading = false;


  Future<void> _handleLogout() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Logged out successfully')),
  );


  // Navigate to MainContainer and remove all previous routes
  Navigator.pushAndRemoveUntil(

    context,
    MaterialPageRoute(builder: (context) => MainContainer()),
    (Route<dynamic> route) => false, // Removes all previous routes
  );
}


  Future getAllEnquirys() async {
    await apiService.getBearerToken();
    setState(() {
      isLoading = true;
    });
    var result = await apiService.getAllEnquirys();
    print('hi $result');
    EnquiryListModel response = enquiryListModelFromJson(result);
    if (response.status.toString() == 'SUCCESS') {
      setState(() {
        dasenquiryList = response.list;
        dasenquiryListAll = dasenquiryList;
        print('hello $dasenquiryList');
        isLoading = false;
      });
    } else {
      setState(() {
        dasenquiryList = [];
        dasenquiryListAll = [];
        isLoading = false;
      });
      //  showInSnackBar(context, response.status);
    }
    setState(() {});
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

   EnquiryDetail? enquirydetailslistpage;


  Future<void> getenquirybyadmin_app(enquiryid) async {
    setState(() {
      isLoading = true;
    });

    try {
      var result = await apiService.getenquirybyadmin_app(enquiryid);
      var response = enquirydetailsListmodelFromJson(result);

      if (response.status.toString().toUpperCase() == 'SUCCESS') {
        print("print");
        setState(() {
          enquirydetailslistpage = response.record;
 showenquiry();
          isLoading = false;
        });
      } else {
        setState(() {
          //  enquirydetailslistpage = [];
          //  enquirydetailslistpageAll = [];
          isLoading = false;
        });
        // showInSnackBar(context, response.message.toString());
        print(response.message.toString());
      }
    } catch (e) {
      setState(() {
        // enquirydetailslistpage = [];
        // enquirydetailslistpageAll = [];
        isLoading = false;
      });
      // showInSnackBar(context, 'Error occurred: $e');
      print(e);
    }
  }

  Widget _buildShimmerPlaceholder() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(13), // Add border radius
              child: Container(
                width: double.infinity,
                height: 183,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showenquiry() {
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
                    Container(width: MediaQuery.of(context).size.width /2.5,
                      child:   Text(
                        enquirydetailslistpage!.clientName.toString(),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                     maxLines: 3,
                                            ) ),
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
                        enquirydetailslistpage!.mobile.toString() == "null"
                            ? "-"
                            : enquirydetailslistpage!.mobile.toString(),
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
                        enquirydetailslistpage!.email.toString() == "null"
                            ? "-"
                            : enquirydetailslistpage!.email.toString(),
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
                    enquirydetailslistpage!.address.toString() == "null"
                        ? "-"
                        : enquirydetailslistpage!.address.toString(),
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
                enquirydetailslistpage!.serviceType.toString(),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              Text(
                'Description',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
              ),
              Text(
                enquirydetailslistpage!.notes.toString(),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              Text(
                'Project Status',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
              ),
              Text(
                enquirydetailslistpage!.projectStatus.toString(),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            Center(
                child: ElevatedButton.icon(
              onPressed: () {
                _makePhoneCall("tel:" + enquirydetailslistpage!.mobile.toString());
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
            icon: Icon(Icons.logout),
            color: Colors.white,
            onPressed: () {
            _handleLogout();
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
 isLoading
    ? ListView.builder(
        itemCount: 8,
        itemBuilder: (context, index) {
          return _buildShimmerPlaceholder();
        },
      )
    : (enquiryesList == null || enquiryesList!.isEmpty)
        ? Center(child: Text("No data available")) 
        : ListView.builder(
           shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
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
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
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
                                                    color: AppColors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13),
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
                                       getenquirybyadmin_app(enquiry.id);
  //   Navigator.push(
  //   context,
  //   MaterialPageRoute(builder: (context) => PdfInvoicePage()),
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
                     
                      },
                   
             
            ),

            ],
          ),
        ),
      ),
    );
  }
}
















// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:keynes/pages/dashboard_pages/enquiry_list_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:url_launcher/url_launcher.dart';

// import '../../constants/app_assets.dart';
// import '../../constants/app_colors.dart';
// import '../../services/comFuncService.dart';
// import '../../services/keynes_api_service.dart';
// import '../enquire/enquiry_details_model.dart';
// import '../enquire/enquiry_list_model.dart';

// class DashboardScreen extends StatefulWidget {
//   @override
//   _DashboardScreenState createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen> {
//   final KeynesApiService apiService = KeynesApiService();
//   String? formattedDate;

//   void _makePhoneCall(String mobile) async {
//     if (await canLaunch(
//       mobile,
//     )) {
//       await launch(mobile);
//     } else {
//       throw 'Could not launch $mobile';
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     getAllEnquirys();
//     getenquirylistbyadmin_app();
//   }

//   List<DasEnquiryListData>? dasenquiryList = [];
//   List<DasEnquiryListData>? dasenquiryListAll = [];
//   bool isLoading = false;


//     Future<void> _handleLogout() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.clear();

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Logged out successfully')),
//     );

//     Navigator.pushNamedAndRemoveUntil(
//         context, '/login', ModalRoute.withName('/login'));
//   }

//   Future getAllEnquirys() async {
//     await apiService.getBearerToken();
//     setState(() {
//       isLoading = true;
//     });
//     var result = await apiService.getAllEnquirys();
//     print('hi $result');
//     EnquiryListModel response = enquiryListModelFromJson(result);
//     if (response.status.toString() == 'SUCCESS') {
//       setState(() {
//         dasenquiryList = response.list;
//         dasenquiryListAll = dasenquiryList;
//         print('hello $dasenquiryList');
//         isLoading = false;
//       });
//     } else {
//       setState(() {
//         dasenquiryList = [];
//         dasenquiryListAll = [];
//         isLoading = false;
//       });
//       //  showInSnackBar(context, response.status);
//     }
//     setState(() {});
//   }

//   List<Record>? enquiryesList = [];
//   List<Record>? enquiryesListAll = [];

//     Future getenquirylistbyadmin_app() async {
//     await apiService.getBearerToken();
//     var result = await apiService.getenquirylistbyadmin_app();
//     print('hi $result');
//     EnquiryListmodel response = enquiryListmodelFromJson(result);
//     if (response.status.toString() == 'SUCCESS') {
//       setState(() {
//         enquiryesList = response.record;
//         enquiryesListAll = enquiryesList;
//         print('hello $enquiryesList');
//       });
//     } else {
//       setState(() {
//         enquiryesList = [];
//         enquiryesListAll = [];
//       });
//       showInSnackBar(context, response.status);
//     }
//     setState(() {});
//   }

//    EnquiryDetail? enquirydetailslistpage;


//   Future<void> getenquirybyadmin_app(enquiryid) async {
//     setState(() {
//       isLoading = true;
//     });

//     try {
//       var result = await apiService.getenquirybyadmin_app(enquiryid);
//       var response = enquirydetailsListmodelFromJson(result);

//       if (response.status.toString().toUpperCase() == 'SUCCESS') {
//         print("print");
//         setState(() {
//           enquirydetailslistpage = response.record;
//  showenquiry();
//           isLoading = false;
//         });
//       } else {
//         setState(() {
//           //  enquirydetailslistpage = [];
//           //  enquirydetailslistpageAll = [];
//           isLoading = false;
//         });
//         // showInSnackBar(context, response.message.toString());
//         print(response.message.toString());
//       }
//     } catch (e) {
//       setState(() {
//         // enquirydetailslistpage = [];
//         // enquirydetailslistpageAll = [];
//         isLoading = false;
//       });
//       // showInSnackBar(context, 'Error occurred: $e');
//       print(e);
//     }
//   }

//   Widget _buildShimmerPlaceholder() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//       child: Shimmer.fromColors(
//         baseColor: Colors.grey.shade300,
//         highlightColor: Colors.grey.shade100,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(13), // Add border radius
//               child: Container(
//                 width: double.infinity,
//                 height: 183,
//                 color: Colors.white,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void showenquiry() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15),
//           ),
//           contentPadding: EdgeInsets.all(20),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Name',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, color: Colors.grey),
//                       ),
//                     Container(width: MediaQuery.of(context).size.width /2.5,
//                       child:   Text(
//                         enquirydetailslistpage!.clientName.toString(),
//                         style: TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.bold),
//                      maxLines: 3,
//                                             ) ),
//                     ],
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Text(
//                         'Phone No',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, color: Colors.grey),
//                       ),
//                       Text(
//                         enquirydetailslistpage!.mobile.toString() == "null"
//                             ? "-"
//                             : enquirydetailslistpage!.mobile.toString(),
//                         style: TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox(height: 15),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Email id',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, color: Colors.grey),
//                       ),
//                       Text(
//                         enquirydetailslistpage!.email.toString() == "null"
//                             ? "-"
//                             : enquirydetailslistpage!.email.toString(),
//                         style: TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Emirates',
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold, color: Colors.grey),
//                   ),
//                   Text(
//                     enquirydetailslistpage!.address.toString() == "null"
//                         ? "-"
//                         : enquirydetailslistpage!.address.toString(),
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                     softWrap: true,
//                   ),
//                 ],
//               ),
//               SizedBox(height: 15),
//               Text(
//                 'Service Type',
//                 style:
//                     TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
//               ),
//               Text(
//                 enquirydetailslistpage!.serviceType.toString(),
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 15),
//               Text(
//                 'Description',
//                 style:
//                     TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
//               ),
//               Text(
//                 enquirydetailslistpage!.notes.toString(),
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 15),
//               Text(
//                 'Project Status',
//                 style:
//                     TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
//               ),
//               Text(
//                 enquirydetailslistpage!.projectStatus.toString(),
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//           actions: [
//             Center(
//                 child: ElevatedButton.icon(
//               onPressed: () {
//                 _makePhoneCall("tel:" + enquirydetailslistpage!.mobile.toString());
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               icon: Icon(Icons.phone),
//               label: Text('Enquiry now'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.blue,
//                 padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//               ),
//             )),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text(
//           'Dashboard',
//           style: TextStyle(color: Colors.white),
//         ),
//         iconTheme: IconThemeData(
//           color: Colors.white,
//         ),
//         backgroundColor: Color(0xFF01519D),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.notifications_none),
//             color: Colors.white,
//             onPressed: () {
//               // Notification button action
//             },
//           ),
//         ],
//         automaticallyImplyLeading: false,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Container(
//               //   decoration: BoxDecoration(
//               //     color: Colors.white,
//               //     borderRadius: BorderRadius.circular(10.0),
//               //     boxShadow: [
//               //       BoxShadow(
//               //         color: Colors.grey.withOpacity(0.2),
//               //         spreadRadius: 2,
//               //         blurRadius: 5,
//               //         offset: Offset(0, 3),
//               //       ),
//               //     ],
//               //   ),
//               //   margin: const EdgeInsets.all(16.0),
//               //   padding: const EdgeInsets.all(16.0),
//               //   child: Column(
//               //     crossAxisAlignment: CrossAxisAlignment.start,
//               //     children: [
//               //       // Title and Menu Icon Row
//               //       Row(
//               //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //         children: [
//               //           Text(
//               //             'Overview',
//               //             style: TextStyle(
//               //               fontSize: 20,
//               //               fontWeight: FontWeight.bold,
//               //               color: Color(0xFF01519D),
//               //             ),
//               //           ),
//               //           Icon(Icons.more_vert),
//               //         ],
//               //       ),

//               //       SizedBox(height: 10),

//               //       Divider(thickness: 1, color: Colors.grey[300]),

//               //       Row(
//               //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //           children: [
//               //             Expanded(
//               //                 child: Column(
//               //               crossAxisAlignment: CrossAxisAlignment.start,
//               //               children: [
//               //                 SizedBox(height: 8),
//               //                 Text(
//               //                   'Total Projects',
//               //                   style: TextStyle(
//               //                     color: Colors.black,
//               //                     fontSize: 14,
//               //                     fontWeight: FontWeight.bold,
//               //                   ),
//               //                 ),
//               //                 SizedBox(height: 4),
//               //                 Row(
//               //                   children: [
//               //                     Image.asset(
//               //                       AppAssets.projecticon,
//               //                       // height: 90.0,
//               //                     ),
//               //                     SizedBox(
//               //                       width: 5,
//               //                     ),
//               //                     Text(
//               //                       '50',
//               //                       style: TextStyle(
//               //                         color: Color(0xFF0B90D3),
//               //                         fontSize: 20,
//               //                         fontWeight: FontWeight.bold,
//               //                       ),
//               //                     ),
//               //                   ],
//               //                 )
//               //               ],
//               //             )),
//               //             Expanded(
//               //                 child: Column(
//               //               crossAxisAlignment: CrossAxisAlignment.start,
//               //               children: [
//               //                 SizedBox(height: 8),
//               //                 Text(
//               //                   'Project Achieved',
//               //                   style: TextStyle(
//               //                     color: Colors.black,
//               //                     fontSize: 14,
//               //                     fontWeight: FontWeight.bold,
//               //                   ),
//               //                 ),
//               //                 SizedBox(height: 4),
//               //                 Row(
//               //                   children: [
//               //                     Image.asset(
//               //                       AppAssets.increaseicon,
//               //                       // height: 90.0,
//               //                     ),
//               //                     SizedBox(
//               //                       width: 5,
//               //                     ),
//               //                     Text(
//               //                       '20',
//               //                       style: TextStyle(
//               //                         color: Color(0xFF0CC172),
//               //                         fontSize: 20,
//               //                         fontWeight: FontWeight.bold,
//               //                       ),
//               //                     ),
//               //                   ],
//               //                 )
//               //               ],
//               //             ))
//               //           ]),
//               //       Row(
//               //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //         children: [
//               //           Expanded(
//               //               child: Column(
//               //             crossAxisAlignment: CrossAxisAlignment.start,
//               //             children: [
//               //               SizedBox(height: 8),
//               //               Text(
//               //                 'Pending Projects',
//               //                 style: TextStyle(
//               //                   color: Colors.black,
//               //                   fontSize: 14,
//               //                   fontWeight: FontWeight.bold,
//               //                 ),
//               //               ),
//               //               SizedBox(height: 4),
//               //               Row(
//               //                 children: [
//               //                   Image.asset(
//               //                     AppAssets.fileicon,
//               //                     // height: 90.0,
//               //                   ),
//               //                   SizedBox(
//               //                     width: 5,
//               //                   ),
//               //                   Text(
//               //                     '05',
//               //                     style: TextStyle(
//               //                       color: Color(0xFFF68F34),
//               //                       fontSize: 20,
//               //                       fontWeight: FontWeight.bold,
//               //                     ),
//               //                   ),
//               //                 ],
//               //               )
//               //             ],
//               //           )),
//               //           Expanded(
//               //               child: Column(
//               //             crossAxisAlignment: CrossAxisAlignment.start,
//               //             children: [
//               //               SizedBox(height: 8),
//               //               Text(
//               //                 'Total Workers',
//               //                 style: TextStyle(
//               //                   color: Colors.black,
//               //                   fontSize: 14,
//               //                   fontWeight: FontWeight.bold,
//               //                 ),
//               //               ),
//               //               SizedBox(height: 4),
//               //               Row(
//               //                 children: [
//               //                   Image.asset(
//               //                     AppAssets.personsicon,
//               //                     // height: 90.0,
//               //                   ),
//               //                   SizedBox(
//               //                     width: 5,
//               //                   ),
//               //                   Text(
//               //                     '62',
//               //                     style: TextStyle(
//               //                       color: Color(0xFFD22D3F),
//               //                       fontSize: 20,
//               //                       fontWeight: FontWeight.bold,
//               //                     ),
//               //                   ),
//               //                 ],
//               //               )
//               //             ],
//               //           )),
//               //         ],
//               //       ),
//               //     ],
//               //   ),
//               // ),

//               // SizedBox(
//               //   height: 10,
//               // ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: Card(
//                       color: Color(0xFFFFFE2E5),
//                       child: Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Image.asset(
//                               AppAssets.towericon1,
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Text(
//                               '20',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 25,
//                               ),
//                             ),
//                             SizedBox(height: 8),
//                             Text(
//                               'Today Meetings',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 12,
//                               ),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Row(
//                               children: [
//                                 Text(
//                                   '8% ',
//                                   style: TextStyle(
//                                     color: Colors.blue,
//                                     fontSize: 12,
//                                   ),
//                                 ),
//                                 Icon(Icons.trending_up, color: Colors.blue),
//                                 Text(
//                                   ' from Yesterday',
//                                   style: TextStyle(
//                                     color: Colors.blue,
//                                     fontSize: 10,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 10), // Add space between the cards
//                   Expanded(
//                     child: Card(
//                       color: Color(0xFFFFF4DE),
//                       child: Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Image.asset(
//                               AppAssets.towericon2,
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Text(
//                               '20',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 25,
//                               ),
//                             ),
//                             SizedBox(height: 8),
//                             Text(
//                               'Total Enquiries',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 12,
//                               ),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Text(
//                               ' 0% from Today',
//                               style: TextStyle(
//                                 color: Colors.blue,
//                                 fontSize: 12,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: Card(
//                       color: Color(0xFFDCFCE7),
//                       child: Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Image.asset(
//                               AppAssets.increaseicon2,
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Text(
//                               '0',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 25,
//                               ),
//                             ),
//                             SizedBox(height: 8),
//                             Text(
//                               'Today Enquiries',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 12,
//                               ),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Row(
//                               children: [
//                                 Text(
//                                   '2.5%',
//                                   style: TextStyle(
//                                     color: Colors.blue,
//                                     fontSize: 12,
//                                   ),
//                                 ),
//                                 Icon(Icons.trending_up, color: Colors.blue),
//                                 Text(
//                                   'from Yesterday',
//                                   style: TextStyle(
//                                     color: Colors.blue,
//                                     fontSize: 10,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 10), // Add space between the cards
//                   Expanded(
//                     child: Card(
//                       color: Color(0xFFF3E8FF),
//                       child: Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             CircleAvatar(
//                               backgroundColor: Color(0xFFBF83FF),
//                               child: Image.asset(
//                                 AppAssets.containericon,
//                               ),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Text(
//                               '9',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 25,
//                               ),
//                             ),
//                             SizedBox(height: 8),
//                             Text(
//                               'Pending Enquiries',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 12,
//                               ),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Row(
//                               children: [
//                                 Text(
//                                   '7%',
//                                   style: TextStyle(
//                                     color: Colors.blue,
//                                     fontSize: 12,
//                                   ),
//                                 ),
//                                 Text(
//                                   ' from LastMonth',
//                                   style: TextStyle(
//                                     color: Colors.blue,
//                                     fontSize: 12,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),

//               //  _buildOverviewCards(),

//               SizedBox(height: 20),

//               // Enquiry List section
//               Text(
//                 'Enquiry List',
//                 style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF01519D)),
//               ),
//               SizedBox(height: 10),
// //               isLoading
// //                   ? ListView.builder(
// //                       itemCount: 5,
// //                       itemBuilder: (context, index) {
// //                         return _buildShimmerPlaceholder();
// //                       },
// //                     )
// //                   : Padding(
// //                       padding: const EdgeInsets.all(12.0),
// //                       child: Column(
// //                         children: enquiryesList!.map((service) {
// //                           return Container(
// //                             margin: EdgeInsets.symmetric(vertical: 8.0),
// //                             decoration: BoxDecoration(
// //                               border: Border.all(
// //                                   color: Colors.grey,
// //                                   width: 0.50), // Border color and width
// //                               borderRadius: BorderRadius.circular(
// //                                   10.0), // Matching the border radius of the card
// //                             ),
// //                             child:
                               

// //                                 Padding(
// //                               padding: const EdgeInsets.all(16.0),
// //                               child: Row(
// //                                 children: [
// //                                   Expanded(
// //                                     child: Column(
// //                                       crossAxisAlignment:
// //                                           CrossAxisAlignment.start,
// //                                       children: [
// //                                         Row(
// //                                           mainAxisAlignment:
// //                                               MainAxisAlignment.spaceBetween,
// //                                           children: [
// //                                             Container(
// //                                               padding: EdgeInsets.symmetric(
// //                                                   vertical: 4, horizontal: 10),
// //                                               decoration: BoxDecoration(
// //                                                 color: Color(0xFFFFF8DB),
// //                                                 borderRadius:
// //                                                     BorderRadius.circular(20),
// //                                               ),
// //                                               child: Row(
// //                                                 children: [
// //                                                   Icon(Icons.circle,
// //                                                       color: Color(0xFFBC9600),
// //                                                       size: 10),
// //                                                   SizedBox(width: 5),
// //                                                   Text('Pending',
// //                                                       style: TextStyle(
// //                                                           color: Colors.amber)),
// //                                                 ],
// //                                               ),
// //                                             ),
// //                                             GestureDetector(
// //                                               onTap: () {
// //                                                 getenquirybyadmin_app(service.id);
// //                                                 // showenquiry(service);
// //                                               },
// //                                               child: Text(
// //                                                 'View more',
// //                                                 style: TextStyle(
// //                                                   color: Colors.blue,
// //                                                 ),
// //                                               ),
// //                                             ),
// //                                           ],
// //                                         ),
// //                                         SizedBox(height: 10),

// //                                         // Name and Date
// //                                         Row(
// //                                           mainAxisAlignment:
// //                                               MainAxisAlignment.spaceBetween,
// //                                           children: [
// //                                             Text(
// //                                               'Name',
// //                                               style:
// //                                                   TextStyle(color: Colors.grey)),
// //                                             Text(
// //                                               'Date',
// //                                               style:
// //                                                   TextStyle(color: Colors.grey),
// //                                             ),
// //                                           ],
// //                                         ),
// //                                         Row(
// //                                           mainAxisAlignment:
// //                                               MainAxisAlignment.spaceBetween,
// //                                           children: [
// //                                           Container(
// //                                                           width: MediaQuery.of(context).size.width /2,
// //                                                           child:    Text(
// //                                               service.clientName.toString(),
// //                                               // 'Tom Cruise',
// //                                               style: TextStyle(
// //                                                   fontWeight: FontWeight.bold),
// //                                             maxLines: 3,
// //                                             )),
// //                                          Text(service.createdDate,
// //   style: TextStyle(fontWeight: FontWeight.bold),
// // )
// //                                           ],
// //                                         ),
// //                                         SizedBox(height: 10),

// //                                         Row(
// //                                             mainAxisAlignment:
// //                                                 MainAxisAlignment.spaceBetween,
// //                                             children: [
// //                                               // Service Type
// //                                               Column(
// //                                                   mainAxisAlignment:
// //                                                       MainAxisAlignment.start,
// //                                                   crossAxisAlignment:
// //                                                       CrossAxisAlignment.start,
// //                                                   children: [
// //                                                     Text(
// //                                                       'Service Type',
// //                                                       style: TextStyle(
// //                                                           color: Colors.grey),
// //                                                     ),
// //                                                     Text(
// //                                                       service.department
// //                                                           .toString(),
// //                                                       //'Approval, Construction, Interior',
// //                                                       style: TextStyle(
// //                                                           fontWeight:
// //                                                               FontWeight.bold),
// //                                                     ),
// //                                                   ]),
// //                                               Column(
// //                                                   mainAxisAlignment:
// //                                                       MainAxisAlignment.end,
// //                                                   crossAxisAlignment:
// //                                                       CrossAxisAlignment.end,
// //                                                   children: [
// //                                                     Container(
// //                                                       padding:
// //                                                           EdgeInsets.symmetric(
// //                                                               vertical: 4,
// //                                                               horizontal: 10),
// //                                                       decoration: BoxDecoration(
// //                                                         color:
// //                                                             Colors.blue.shade50,
// //                                                         borderRadius:
// //                                                             BorderRadius
// //                                                                 .circular(20),
// //                                                       ),
// //                                                       child: Column(
// //                                                         crossAxisAlignment:
// //                                                             CrossAxisAlignment
// //                                                                 .start,
// //                                                         children: [
// //                                                           Text(
// //                                                             'Project Status',
// //                                                             style: TextStyle(
// //                                                                 color: Colors
// //                                                                     .black),
// //                                                           ),
// //                                                           Row(
// //                                                             children: [
// //                                                         Container(
// //                                                           width: MediaQuery.of(context).size.width /2.5,
// //                                                           child: Text(
// //                                                                   service
// //                                                                       .projectStatus
// //                                                                       .toString(),
// //                                                                   style: TextStyle(
// //                                                                       color: Colors
// //                                                                           .blue,),
// //                                                                           maxLines: 3,) ,)     
// //                                                             ],
// //                                                           ),
// //                                                         ],
// //                                                       ),
// //                                                     ),
// //                                                     // Text(
// //                                                     //   'Project Status',
// //                                                     //   style: TextStyle(
// //                                                     //       color: Colors.grey),
// //                                                     // ),
// //                                                     // Text(
// //                                                     //   service.project_status
// //                                                     //       .toString(),
// //                                                     //   //'Approval, Construction, Interior',
// //                                                     //   style: TextStyle(
// //                                                     //       fontWeight:
// //                                                     //           FontWeight.bold),
// //                                                     // ),
// //                                                   ])
// //                                             ])
// //                                       ],
// //                                     ),
// //                                   ),
// //                                 ],
//                           //     ),
//                           //   ),
//                           // );
//                         // }).toList(),
//                     //   ),
//                     // ),

//  isLoading
//           ? ListView.builder(
//               itemCount: 8,
//               itemBuilder: (context, index) {
//                 return _buildShimmerPlaceholder();
//               },
//             )
//           : ListView.builder(
//                       itemCount: enquiryesList!.length,
//                       itemBuilder: (context, index) {
//                         final enquiry = enquiryesList![index];
//                         return Card(
//                             elevation: 2,
//                             margin: EdgeInsets.all(10),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(16),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(20.0),
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
//                                             "Customer Name",
//                                             style: TextStyle(
//                                               fontSize: 14,
//                                               color: Colors.grey,
//                                             ),
//                                           ),
//                                           SizedBox(height: 4),
//                                           Container(
//                                               width: MediaQuery.of(context)
//                                                       .size
//                                                       .width /
//                                                   2,
//                                               child: Text(
//                                                 enquiry!.clientName ?? '',
//                                                 style: TextStyle(
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.bold,
//                                                 ),
//                                                 overflow: TextOverflow
//                                                     .ellipsis, // Adds "..." if the text overflows
//                                                 maxLines:
//                                                     2, // Limits the text to one line
//                                               )),
//                                         ],
//                                       ),
//                                       Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.end,
//                                         children: [
//                                           Text(
//                                             "Date",
//                                             style: TextStyle(
//                                               fontSize: 14,
//                                               color: Colors.grey,
//                                             ),
//                                           ),
//                                           SizedBox(height: 4),
//                                           Text(
//                                             enquiry!.createdDate,
//                                             style: TextStyle(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(height: 16),
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             "Department",
//                                             style: TextStyle(
//                                               fontSize: 14,
//                                               color: Colors.grey,
//                                             ),
//                                           ),
//                                           SizedBox(height: 4),
//                                           Text(
//                                             //"",
//                                             enquiry!.department ?? '',
//                                             style: TextStyle(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.end,
//                                         children: [
//                                           Text(
//                                             "Enquiry Source",
//                                             style: TextStyle(
//                                               fontSize: 14,
//                                               color: Colors.grey,
//                                             ),
//                                           ),
//                                           SizedBox(height: 4),
//                                           Text(
//                                             //"",
//                                             enquiry!.refer ?? '',
//                                             style: TextStyle(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(height: 16),
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "Status",
//                                         style: TextStyle(
//                                           fontSize: 14,
//                                           color: Colors.grey,
//                                         ),
//                                       ),
//                                       SizedBox(height: 8),
//                                       Container(
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 12, vertical: 8),
//                                         decoration: BoxDecoration(
//                                           color: Colors.yellow[100],
//                                           borderRadius:
//                                               BorderRadius.circular(20),
//                                         ),
//                                         child: Row(
//                                           children: [
//                                             Icon(
//                                               Icons.circle,
//                                               size: 12,
//                                               color: Colors.amber,
//                                             ),
//                                             SizedBox(width: 8),
//                                             Expanded(
//                                               child: Text(
//                                                 enquiry!.projectStatus ?? '',
//                                                 style: TextStyle(
//                                                     color: AppColors.black,
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 13),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(height: 16),
//                                   Divider(color: Colors.grey[500]),
//                                   Center(
//                                     child: TextButton(
//                                       onPressed: () {
//                                        getenquirybyadmin_app(enquiry.id);

                                      
//                                       },
//                                       child: Text(
//                                         "View more",
//                                         style: TextStyle(
//                                           color: Color(0xFF01519D),
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ));
                     
//                       },
                   
             
//             ),

//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
