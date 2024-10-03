import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/service_list_model.dart';
import '../services/comFuncService.dart';
import '../services/keynes_api_service.dart';
import '../widgets/button_widget.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  final KeynesApiService apiService = KeynesApiService();

  @override
  void initState() {
    getAllServices();
    super.initState();
  }

  List<ServicesListData>? servicesList = [];
  List<ServicesListData>? servicesListAll = [];

  Future getAllServices() async {
    var result = await apiService.getAllServices();
    print('hi $result');
    ServiceListModel response = serviceListModelFromJson(result);
    if (response.status.toString() == 'SUCCESS') {
      setState(() {
        servicesList = response.list;
        servicesListAll = servicesList;
        print('hello $servicesList');
      });
    } else {
      setState(() {
        servicesList = [];
        servicesListAll = [];
      });
      showInSnackBar(context, response.status);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: screenHeight * 0.10,
        title: Text(
          'Services',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0151AF),
          ),
        ),
      ),
      body: servicesList == null || servicesList!.isEmpty
          ? Center(child: CircularProgressIndicator()) // Loading indicator
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: servicesList!.map((service) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      decoration: BoxDecoration(
                        color: Color(0xFF0151AF),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Display service name dynamically
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  service.name.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 18.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ButtonWidget(
                                title: 'Enquiry',
                                width: MediaQuery.of(context).size.width / 2.7,
                                onTap: () {
                                  // Handle enquiry button tap
                                },
                                borderRadius: 12.0,
                                color: AppColors.light,
                                titleColor: AppColors.blue,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
    );
  }
}
