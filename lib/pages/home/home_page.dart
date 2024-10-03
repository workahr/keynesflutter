import 'package:flutter/material.dart';
import 'package:keynes/widgets/heading_widget.dart';
import 'package:keynes/widgets/sub_heading_widget.dart';

import '../../constants/app_assets.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 90,
        title: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Row(
              children: [
                Image.asset(
                  AppAssets.keynesLogo,
                  height: 70.0,
                ),
                Column(
                  children: [
                    HeadingWidget(
                        title: ' KEYNES GROUP ',
                        // fontWeight: FontWeight.bold,
                        color: Colors.white),
                    SubHeadingWidget(
                      title: '    Doing more, for you!',
                      color: Colors.black,
                      // fontWeight: FontWeight.bold,
                    ),
                  ],
                )
              ],
            )),
        centerTitle: true,
        backgroundColor: Color(0xFF01519D),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  'About Us',
                  style: TextStyle(
                    fontSize: 15,
                    // fontWeight: FontWeight.bold,
                    color: Color(0xFF01519D),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'We Are Leading Company In Dubai, UAE',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF01519D)),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'KEYNES GROUP is growing rapidly into UAE’s leading company in delivering exceptional service. As the industry moves forward, so does our company. Our journey from a construction company to a conglomerate comprising of contracting and service industries has been filled with its fair share of trials. However, we can honestly say that today, our employees are richer in experience than their counterparts.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            Container(
                //height: 100,
                color: Color(0xFF01519D),
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "725+",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  SizedBox(height: 5),
                                  Text('Revenue in 2017',
                                      style: TextStyle(color: Colors.white),
                                      textAlign: TextAlign.center),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    '1520+',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  SizedBox(height: 5),
                                  Text('Colleagues & Counting',
                                      style: TextStyle(color: Colors.white),
                                      textAlign: TextAlign.center),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      '5012+',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    SizedBox(height: 5),
                                    Text('Successfully Projects',
                                        style: TextStyle(color: Colors.white),
                                        textAlign: TextAlign.center),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      '15+',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    SizedBox(height: 5),
                                    Text('Years of Experience',
                                        style: TextStyle(color: Colors.white),
                                        textAlign: TextAlign.center),
                                  ],
                                ),
                              ]))
                    ]))),
            SizedBox(height: 20),
            SubHeadingWidget(
                title: 'Trust and Worth',
                fontSize: 15,
                textAlign: TextAlign.center,
                color: Color(0xFF01519D)),
            HeadingWidget(
              title: "Our Clients",
              fontSize: 20,
              color: Color(0xFF01519D),
            ),
            SizedBox(height: 20),
            Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      AppAssets.kfcImg,
                      height: 90.0,
                    ),
                    Image.asset(
                      AppAssets.londonImg,
                      height: 90.0,
                    ),
                    Image.asset(
                      AppAssets.uaeImg,
                      height: 90.0,
                    ),
                  ],
                )),
            Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      AppAssets.lifeImg,
                      height: 90.0,
                    ),
                    Image.asset(
                      AppAssets.medicalcenterImg,
                      height: 90.0,
                    ),
                    Image.asset(
                      AppAssets.jaleelImg,
                      height: 90.0,
                    ),
                  ],
                )),
            SizedBox(height: 20),
            HeadingWidget(
              title: 'Our Founder',
              color: Color(0xFF01519D),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'We KEYNES steadfast focus is on providing an outstanding service to our customers. We value the mix of strengths, insights this approach brings, and we are proud to have built a team with a diversity of perspectives and background. Our priorities, commitments will always remain the same: to deliver a high quality service, to manage all aspects of the development process and to ensure that all of our clients receive the right product on time and to expectations.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 20),
            Column(
              children: [
                Image.asset(
                  AppAssets.profileImg,
                  height: 90.0,
                ),
                // CircleAvatar(
                //   radius: 50,
                //   backgroundImage: AssetImage(
                //       'assets/ceo_image.png'), // Replace with actual image path
                // ),
                SizedBox(height: 10),
                HeadingWidget(
                  title: 'Thanveerjan Alikkal',
                  color: Color(0xFF01519D),
                ),
                Text('Founder & CEO'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
