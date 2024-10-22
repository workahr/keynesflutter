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
  await Firebase.initializeApp();

  // Initialize OneSignal
  await OneSignal.shared.setAppId("35b93f01-9c8e-4713-a836-b3a921c2fb36");
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  // Prompt user for notification permission
  bool permissionGranted =
      await OneSignal.shared.promptUserForPushNotificationPermission();
  print("Permission accepted: $permissionGranted");

  OneSignal.shared.setNotificationWillShowInForegroundHandler(
    (OSNotificationReceivedEvent event) {
      print('Notification received: ${event.notification.title}');
      event.complete(event.notification);
    },
  );

  OneSignal.shared.setNotificationOpenedHandler(
    (OSNotificationOpenedResult result) {
      print('Opened notification: ${result.notification.title}');
    },
  );

  // Initialize the BaseController
  BaseController baseCtrl = Get.put(BaseController());

  // Function to fetch the player ID with retry logic
  Future<void> fetchPlayerId() async {
    var deviceState = await OneSignal.shared.getDeviceState();
    var playerId = deviceState?.userId;

    if (playerId != null) {
      baseCtrl.fbUserId = playerId;
      print("Player ID retrieved: $playerId");
    } else {
      print("Player ID not retrieved, retrying in 2 seconds...");
      await Future.delayed(Duration(seconds: 2));
      fetchPlayerId(); // Retry fetching player ID
    }
  }

  // Start fetching the player ID
  fetchPlayerId();

  runApp(MyApp());
}

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   if (!kIsWeb) {
//     await Firebase.initializeApp();
//     await FirebaseAPIServices().initNotifications();
//   }

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

  usermobileid() {
    setState(() {
      main();
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
    usermobileid();
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
