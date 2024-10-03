import 'package:flutter/material.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.15,
        title: Text(
          'Services',
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0151AF)),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
            top: screenHeight * 0.02,
            left: screenWidth * 0.03,
            right: screenWidth * 0.03),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Color(0xFF0151AF),
                  borderRadius: BorderRadius.circular(18)),
              height: screenHeight * 0.2,
              child: Padding(
                padding: EdgeInsets.only(
                    left: screenWidth * 0.03,
                    right: screenWidth * 0.03,
                    top: screenHeight * 0.03,
                    bottom: screenHeight * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0xFFFFFFFF),
                              borderRadius: BorderRadius.circular(18)),
                          height: screenHeight * 0.13,
                          width: screenWidth * 0.2,
                        ),
                        SizedBox(
                          width: screenWidth * 0.03,
                        ),
                        Text(
                          'Keynes Approval',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                            style: ButtonStyle(
                              minimumSize: WidgetStatePropertyAll(
                                  Size(screenWidth * 0.1, screenHeight * 0.07)),
                              shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8))),
                              foregroundColor:
                                  WidgetStatePropertyAll(Colors.white),
                            ),
                            onPressed: () {},
                            child: Text(
                              'Enquiry',
                              style: TextStyle(
                                  color: Color(0xFF0151AF),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            )),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
