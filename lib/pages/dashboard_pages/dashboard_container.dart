import 'package:flutter/material.dart';
import 'package:keynes/pages/auth/login_page.dart';
import 'package:keynes/pages/dashboard_pages/admin_dashboardscreen.dart';
import 'package:keynes/pages/home/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/app_assets.dart';
import '../chat/chat_page.dart';
import '../enquire/enquire_page.dart';
import '../main_container.dart';
import '../service_page.dart';
import 'dashboard_adminscreen_old.dart';
import 'dashboard_screen.dart';

class DashboardContainer extends StatefulWidget {
  DashboardContainer({super.key, this.childWidget});

  final Widget? childWidget;

  @override
  State<DashboardContainer> createState() => _DashboardContainerState();
}

class _DashboardContainerState extends State<DashboardContainer>
    with WidgetsBindingObserver {
  int _selectedIndex = 0;
  bool navBack = false;

  @override
  initState() {
    super.initState();
    getLoginScreen();
  }

  String loginuser = "";
  List<Widget> pageOptions = [];

  // Future getLoginScreen() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   loginuser = prefs.getString('role_name' ?? '')!;
  //   print("login user : $loginuser");

  // }
  Future<void> getLoginScreen() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      loginuser = prefs.getString('role_name') ?? '';

      pageOptions = [
        (loginuser == "Super Admin")
            ? Admin_Dashboardscreen()
            : DashboardScreen(),
        ServicePage(),
        const EnquirePage(),
        // ChatPage(),
      ];
    });
    print("login user : $loginuser");
  }

  final List pageId = [1, 5, 8, 12, 15];
  // static List<Widget> pageOptions = <Widget>[
  //  (loginuser == "Super Admin") ? Dashboard_adminscreen():DashboardScreen(),
  //   ServicePage(),
  //   ChatPage(),
  // ];

  void _onItemTapped(int index) async {
    if (index == 3) {
      // Handle logout
      await _handleLogout();
    } else {
      // Handle other navigation
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  Future<void> _handleLogout() async {
    // Clear SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    // Navigate to Login Page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MainContainer(childWidget: const LoginPage()),
      ),
    );
  }

  @protected
  void didUpdateWidget(oldWidget) {
    print('oldWidget');
    print(oldWidget);
    super.didUpdateWidget(oldWidget);
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   setState(() {
  //     // print('state l $state');

  //     if (AppLifecycleState.detached == state && navBack == false) {
  //       baseCtrl.player.stop();
  //       // print(
  //       //     ' audioplayer state ${baseCtrl.audioHandler.playbackState.value} ');
  //       // print(' playerState  ${baseCtrl.player.playerState} ');
  //     }
  //   });
  // }

  Future<void> _onPop() async {
    // Handle back button press, you can add custom logic here.
    // For example, you could show a dialog or exit the app.
    // Exit the app or return to the home page:
    if (_selectedIndex == 0) {
      // Exit the app if already on the home page.
      return;
    } else {
      // Otherwise, navigate back to the first tab (home page).
      setState(() {
        _selectedIndex = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (popDisposition) async {
        await _onPop();
      },
      child: Scaffold(
        // appBar: CustomAppBar(title: '', leading: SizedBox(), showSearch: true,showCart: false, backgroundColor: [0,2].contains(_selectedIndex) ? AppColors.light: null ,),
        // onPressed: widget.onThemeToggle),
        // drawer: SideMenu(),
        body: pageOptions[_selectedIndex],

        bottomNavigationBar: BottomNavigationBar(
          // onTap: onTabTapped,
          // currentIndex: currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                AppAssets.serviceImg,
                height: 20.0,
              ),
              //icon: Icon(Icons.book),
              label: 'Service',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.call),
              // icon: Image.asset(
              //   AppAssets.serviceImg,
              //   height: 20.0,
              // ),
              //icon: Icon(Icons.book),
              label: 'Enquire',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.chat),
            //   label: 'Chat',
            // ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.logout), // Correct logout icon
            //   label: 'Log Out',
            // ),
          ],
          currentIndex: _selectedIndex,

          showUnselectedLabels: true,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}










// import 'package:flutter/material.dart';
// import 'package:keynes/pages/auth/login_page.dart';
// import 'package:keynes/pages/dashboard_pages/admin_dashboardscreen.dart';
// import 'package:keynes/pages/home/home_page.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../constants/app_assets.dart';
// import '../chat/chat_page.dart';
// import '../enquire/enquire_page.dart';
// import '../main_container.dart';
// import '../service_page.dart';
// import 'dashboard_adminscreen_old.dart';
// import 'dashboard_screen.dart';

// class DashboardContainer extends StatefulWidget {
//   DashboardContainer({super.key, this.childWidget});

//   final Widget? childWidget;

//   @override
//   State<DashboardContainer> createState() => _DashboardContainerState();
// }

// class _DashboardContainerState extends State<DashboardContainer>
//     with WidgetsBindingObserver {
//   int _selectedIndex = 0;
//   bool navBack = false;

//   @override
//   initState() {
//     super.initState();
//     getLoginScreen();
//   }

//   String loginuser = "";
//   List<Widget> pageOptions = [];

//   // Future getLoginScreen() async {
//   //   final prefs = await SharedPreferences.getInstance();
//   //   loginuser = prefs.getString('role_name' ?? '')!;
//   //   print("login user : $loginuser");

//   // }
//   Future<void> getLoginScreen() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       loginuser = prefs.getString('role_name') ?? '';

//       pageOptions = [
//         (loginuser == "Super Admin")
//             ? Admin_Dashboardscreen()
//             : DashboardScreen(),
//         ServicePage(),
//         const EnquirePage(),
//         // ChatPage(),
//       ];
//     });
//     print("login user : $loginuser");
//   }

//   final List pageId = [1, 5, 8, 12, 15];
//   // static List<Widget> pageOptions = <Widget>[
//   //  (loginuser == "Super Admin") ? Dashboard_adminscreen():DashboardScreen(),
//   //   ServicePage(),
//   //   ChatPage(),
//   // ];

//   void _onItemTapped(int index) async {
//     if (index == 3) {
//       // Handle logout
//       await _handleLogout();
//     } else {
//       // Handle other navigation
//       setState(() {
//         _selectedIndex = index;
//       });
//     }
//   }

//   Future<void> _handleLogout() async {
//     // Clear SharedPreferences
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.clear();

//     // Navigate to Login Page
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => MainContainer(childWidget: const LoginPage()),
//       ),
//     );
//   }

//   @protected
//   void didUpdateWidget(oldWidget) {
//     print('oldWidget');
//     print(oldWidget);
//     super.didUpdateWidget(oldWidget);
//   }

//   // @override
//   // void didChangeAppLifecycleState(AppLifecycleState state) {
//   //   setState(() {
//   //     // print('state l $state');

//   //     if (AppLifecycleState.detached == state && navBack == false) {
//   //       baseCtrl.player.stop();
//   //       // print(
//   //       //     ' audioplayer state ${baseCtrl.audioHandler.playbackState.value} ');
//   //       // print(' playerState  ${baseCtrl.player.playerState} ');
//   //     }
//   //   });
//   // }

//   Future<void> _onPop() async {
//     // Handle back button press, you can add custom logic here.
//     // For example, you could show a dialog or exit the app.
//     // Exit the app or return to the home page:
//     if (_selectedIndex == 0) {
//       // Exit the app if already on the home page.
//       return;
//     } else {
//       // Otherwise, navigate back to the first tab (home page).
//       setState(() {
//         _selectedIndex = 0;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       onPopInvoked: (popDisposition) async {
//         await _onPop();
//       },
//       child: Scaffold(
//         // appBar: CustomAppBar(title: '', leading: SizedBox(), showSearch: true,showCart: false, backgroundColor: [0,2].contains(_selectedIndex) ? AppColors.light: null ,),
//         // onPressed: widget.onThemeToggle),
//         // drawer: SideMenu(),
//         body: pageOptions[_selectedIndex],

//         bottomNavigationBar: BottomNavigationBar(
//           // onTap: onTabTapped,
//           // currentIndex: currentIndex,
//           items: [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               label: 'Home',
//             ),
//             BottomNavigationBarItem(
//               icon: Image.asset(
//                 AppAssets.serviceImg,
//                 height: 20.0,
//               ),
//               //icon: Icon(Icons.book),
//               label: 'Service',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.call),
//               // icon: Image.asset(
//               //   AppAssets.serviceImg,
//               //   height: 20.0,
//               // ),
//               //icon: Icon(Icons.book),
//               label: 'Enquire',
//             ),
//             // BottomNavigationBarItem(
//             //   icon: Icon(Icons.chat),
//             //   label: 'Chat',
//             // ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.logout), // Correct logout icon
//               label: 'Log Out',
//             ),
//           ],
//           currentIndex: _selectedIndex,

//           showUnselectedLabels: true,
//           onTap: _onItemTapped,
//           type: BottomNavigationBarType.fixed,
//         ),
//       ),
//     );
//   }
// }
