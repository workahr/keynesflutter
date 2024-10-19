// import 'package:flutter/material.dart';
// import 'package:onesignal_flutter/onesignal_flutter.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // Initialize OneSignal
//   await OneSignal.shared.setAppId(
//       "35b93f01-9c8e-4713-a836-b3a921c2fb36"); // Replace with your App ID

//   // Optional: prompt for push notifications permission
//   OneSignal.shared.promptUserForPushNotificationPermission();

//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text("OneSignal Demo"),
//         ),
//         body: Center(
//           child: Text("Welcome to OneSignal in Flutter!"),
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:keynes/pages/main_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controllers/base_controller.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:flutter/material.dart';
import 'constants/app_localizations.dart';
import 'constants/constants.dart';
import 'services/firebase_services/firebase_api_services.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize OneSignal
  await OneSignal.shared.setAppId(
      "35b93f01-9c8e-4713-a836-b3a921c2fb36"); // Replace with your App ID

  // Optional: prompt for push notifications permission
  OneSignal.shared.promptUserForPushNotificationPermission();

  runApp(MyApp());
}

// Future<void> main() async {
//    WidgetsFlutterBinding.ensureInitialized();

// if(!kIsWeb){
//   await Firebase.initializeApp();
//   await FirebaseAPIServices().initNotifications();
// }

//   BaseController baseCtrl = Get.put(BaseController());

//   String? token = baseCtrl.fbUserId;

//   print("token $token");

//   runApp(MyApp());
// }

class MyApp extends StatefulWidget with WidgetsBindingObserver {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  BaseController baseCtrl = Get.put(BaseController());

  _MyAppState() {
    print('baseCtrl ${baseCtrl.isDarkModeEnabled.value}');
    // baseCtrl.isDarkModeEnabled.listen((value) {
    //   refresh();
    // });
  }

  refresh() {
    setState(() {
      isDarkModeEnabled = baseCtrl.isDarkModeEnabled.value;
      AppColors();
    });
  }

  bool isDarkModeEnabled = false;
  var position;

  toggleDarkMode() {
    setState(() {
      isDarkModeEnabled = !isDarkModeEnabled;
      AppColors();
      print('color ${AppColors.dark}');
      print('isDarkModeEnabled ${AppColors.dark}');
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  bool isDebugMode() {
    bool isDebug = false;
    if (!kReleaseMode && (kDebugMode || kProfileMode)) {
      isDebug = true;
    }
    return isDebug;
  }

  @override
  void dispose() async {
    super.dispose();
  }

  @override
  void deactivate() async {
    print('page deactivate');
    super.deactivate();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setState(() {});
    } else if (state == AppLifecycleState.inactive) {
      // checkuserlog("-close");
    } else if (state == AppLifecycleState.paused) {
      // checkuserlog("-pause");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
      child: MaterialApp(
        title: AppConstants.appTitle,
        debugShowCheckedModeBanner: false,
        theme: isDarkModeEnabled ? AppTheme.darkTheme : AppTheme.lightTheme,
        home: MainContainer(),
      ),
    );
  }
}
