import 'package:flutter/material.dart';
import 'package:keynes/constants/app_colors.dart';
import 'package:keynes/widgets/heading_widget.dart';
import 'package:keynes/widgets/sub_heading_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/app_assets.dart';
import '../auth/login_page.dart';
import '../dashboard_pages/dashboard_container.dart';

class HomeScreen extends StatefulWidget {
  String? displayTitle;

  HomeScreen({super.key, this.displayTitle});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  initState() {
    super.initState();
    findLoginStatus();
  }

  bool? loginuser;

  Future<void> findLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      loginuser = prefs.getBool('isLoggedin');
      if (loginuser == true) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardContainer()),
        );
      }
    });
    print("login user : $loginuser");
  }

  @protected
  void didUpdateWidget(oldWidget) {
    print('oldWidget');
    print(oldWidget);
    super.didUpdateWidget(oldWidget);
  }

  Future<void> _handleLogout() async {
    // Clear SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    // Navigate to Login Page
    Navigator.pushNamedAndRemoveUntil(
        context, '/login', ModalRoute.withName('/login'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                if (loginuser == true) {
                  _handleLogout();
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            LoginPage()), // Replace with your screen
                  );
                }
              },
              icon: Icon(
                Icons.login,
                color: Colors.white,
              )) // Correct logout icon
        ],
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
                      color: Colors.white,
                      // fontWeight: FontWeight.bold,
                    ),
                  ],
                )
              ],
            )),
        centerTitle: true,
        backgroundColor: const Color(0xFF01519D),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
                padding: EdgeInsets.all(6.0),
                child: Text(
                  'About Us',
                  style: TextStyle(
                    fontSize: 15,
                    // fontWeight: FontWeight.bold,
                    color: Color(0xFF01519D),
                  ),
                )),
            const Padding(
              padding: EdgeInsets.all(16.0),
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
              padding: const EdgeInsets.all(16.0),
              child: SubHeadingWidget(
                title:
                    'KEYNES GROUP is growing rapidly into UAE`s leading company in delivering exceptional service. As the industry moves forward, so does our company. Our journey from a construction company to a conglomerate comprising of contracting and service industries has been filled with its fair share of trials. However, we can honestly say that today, our employees are richer in experience than their counterparts.',
                fontSize: 14.0,
                textAlign: TextAlign.center,
                color: AppColors.dark,
              ),
            ),
            const SizedBox(height: 20),
            Container(
                //height: 100,
                color: const Color(0xFF01519D),
                child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(children: [
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
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
                          padding: EdgeInsets.all(20.0),
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
            const SizedBox(height: 20),
            SubHeadingWidget(
                title: 'Trust and Worth',
                fontSize: 15.0,
                textAlign: TextAlign.center,
                color: const Color(0xFF01519D)),
            HeadingWidget(
              title: "Our Clients",
              fontSize: 20.0,
              color: const Color(0xFF01519D),
            ),
            const SizedBox(height: 20),
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
            const SizedBox(height: 20),
            HeadingWidget(
              title: 'Our Founder',
              color: const Color(0xFF01519D),
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SubHeadingWidget(
                title:
                    'We KEYNES steadfast focus is on providing an outstanding service to our customers. We value the mix of strengths, insights this approach brings, and we are proud to have built a team with a diversity of perspectives and background. Our priorities, commitments will always remain the same: to deliver a high quality service, to manage all aspects of the development process and to ensure that all of our clients receive the right product on time and to expectations.',
                textAlign: TextAlign.center,
                color: AppColors.dark,
                fontSize: 14.0,
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                Image.asset(
                  AppAssets.profileImg,
                  //height: 130.0,
                  fit: BoxFit.fill,
                  //width: 140.0,
                ),
                // CircleAvatar(
                //   radius: 50,
                //   backgroundImage: AssetImage(
                //       'assets/ceo_image.png'), // Replace with actual image path
                // ),
                const SizedBox(height: 10),
                HeadingWidget(
                  title: 'Thanveerjan Alikkal',
                  color: const Color(0xFF01519D),
                ),
                const Text('Founder & CEO'),
                const SizedBox(height: 15.0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}











// import 'package:flutter/material.dart';
// import 'package:keynes/constants/app_colors.dart';
// import 'package:keynes/widgets/heading_widget.dart';
// import 'package:keynes/widgets/sub_heading_widget.dart';

// import '../../constants/app_assets.dart';

// class HomeScreen extends StatefulWidget {
//   String? displayTitle;

//   HomeScreen({super.key, this.displayTitle});
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         toolbarHeight: 90,
//         title: Padding(
//             padding: const EdgeInsets.all(50.0),
//             child: Row(
//               children: [
//                 Image.asset(
//                   AppAssets.keynesLogo,
//                   height: 70.0,
//                 ),
//                 Column(
//                   children: [
//                     HeadingWidget(
//                         title: ' KEYNES GROUP ',
//                         // fontWeight: FontWeight.bold,
//                         color: Colors.white),
//                     SubHeadingWidget(
//                       title: '    Doing more, for you!',
//                       color: Colors.white,
//                       // fontWeight: FontWeight.bold,
//                     ),
//                   ],
//                 )
//               ],
//             )),
//         centerTitle: true,
//         backgroundColor: const Color(0xFF01519D),
//         automaticallyImplyLeading: false,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const Padding(
//                 padding: EdgeInsets.all(6.0),
//                 child: Text(
//                   'About Us',
//                   style: TextStyle(
//                     fontSize: 15,
//                     // fontWeight: FontWeight.bold,
//                     color: Color(0xFF01519D),
//                   ),
//                 )),
//             const Padding(
//               padding: EdgeInsets.all(16.0),
//               child: Text(
//                 'We Are Leading Company In Dubai, UAE',
//                 style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF01519D)),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: SubHeadingWidget(
//                 title:
//                     'KEYNES GROUP is growing rapidly into UAE`s leading company in delivering exceptional service. As the industry moves forward, so does our company. Our journey from a construction company to a conglomerate comprising of contracting and service industries has been filled with its fair share of trials. However, we can honestly say that today, our employees are richer in experience than their counterparts.',
//                 fontSize: 14.0,
//                 textAlign: TextAlign.center,
//                 color: AppColors.dark,
//               ),
//             ),
//             const SizedBox(height: 20),
//             Container(
//                 //height: 100,
//                 color: const Color(0xFF01519D),
//                 child: const Padding(
//                     padding: EdgeInsets.all(16.0),
//                     child: Column(children: [
//                       Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 16.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Column(
//                                 children: [
//                                   Text(
//                                     "725+",
//                                     style: TextStyle(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.white),
//                                   ),
//                                   SizedBox(height: 5),
//                                   Text('Revenue in 2017',
//                                       style: TextStyle(color: Colors.white),
//                                       textAlign: TextAlign.center),
//                                 ],
//                               ),
//                               Column(
//                                 children: [
//                                   Text(
//                                     '1520+',
//                                     style: TextStyle(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.white),
//                                   ),
//                                   SizedBox(height: 5),
//                                   Text('Colleagues & Counting',
//                                       style: TextStyle(color: Colors.white),
//                                       textAlign: TextAlign.center),
//                                 ],
//                               ),
//                             ],
//                           )),
//                       Padding(
//                           padding: EdgeInsets.all(20.0),
//                           child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Column(
//                                   children: [
//                                     Text(
//                                       '5012+',
//                                       style: TextStyle(
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.white),
//                                     ),
//                                     SizedBox(height: 5),
//                                     Text('Successfully Projects',
//                                         style: TextStyle(color: Colors.white),
//                                         textAlign: TextAlign.center),
//                                   ],
//                                 ),
//                                 Column(
//                                   children: [
//                                     Text(
//                                       '15+',
//                                       style: TextStyle(
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.white),
//                                     ),
//                                     SizedBox(height: 5),
//                                     Text('Years of Experience',
//                                         style: TextStyle(color: Colors.white),
//                                         textAlign: TextAlign.center),
//                                   ],
//                                 ),
//                               ]))
//                     ]))),
//             const SizedBox(height: 20),
//             SubHeadingWidget(
//                 title: 'Trust and Worth',
//                 fontSize: 15.0,
//                 textAlign: TextAlign.center,
//                 color: const Color(0xFF01519D)),
//             HeadingWidget(
//               title: "Our Clients",
//               fontSize: 20.0,
//               color: const Color(0xFF01519D),
//             ),
//             const SizedBox(height: 20),
//             Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Image.asset(
//                       AppAssets.kfcImg,
//                       height: 90.0,
//                     ),
//                     Image.asset(
//                       AppAssets.londonImg,
//                       height: 90.0,
//                     ),
//                     Image.asset(
//                       AppAssets.uaeImg,
//                       height: 90.0,
//                     ),
//                   ],
//                 )),
//             Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Image.asset(
//                       AppAssets.lifeImg,
//                       height: 90.0,
//                     ),
//                     Image.asset(
//                       AppAssets.medicalcenterImg,
//                       height: 90.0,
//                     ),
//                     Image.asset(
//                       AppAssets.jaleelImg,
//                       height: 90.0,
//                     ),
//                   ],
//                 )),
//             const SizedBox(height: 20),
//             HeadingWidget(
//               title: 'Our Founder',
//               color: const Color(0xFF01519D),
//               fontWeight: FontWeight.bold,
//               fontSize: 18.0,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: SubHeadingWidget(
//                 title:
//                     'We KEYNES steadfast focus is on providing an outstanding service to our customers. We value the mix of strengths, insights this approach brings, and we are proud to have built a team with a diversity of perspectives and background. Our priorities, commitments will always remain the same: to deliver a high quality service, to manage all aspects of the development process and to ensure that all of our clients receive the right product on time and to expectations.',
//                 textAlign: TextAlign.center,
//                 color: AppColors.dark,
//                 fontSize: 14.0,
//               ),
//             ),
//             const SizedBox(height: 20),
//             Column(
//               children: [
//                 Image.asset(
//                   AppAssets.profileImg,
//                   //height: 130.0,
//                   fit: BoxFit.fill,
//                   //width: 140.0,
//                 ),
//                 // CircleAvatar(
//                 //   radius: 50,
//                 //   backgroundImage: AssetImage(
//                 //       'assets/ceo_image.png'), // Replace with actual image path
//                 // ),
//                 const SizedBox(height: 10),
//                 HeadingWidget(
//                   title: 'Thanveerjan Alikkal',
//                   color: const Color(0xFF01519D),
//                 ),
//                 const Text('Founder & CEO'),
//                 const SizedBox(height: 15.0),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
