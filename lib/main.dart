import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keynes/pages/main_container.dart';

import 'controllers/base_controller.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  BaseController baseCtrl = Get.put(BaseController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainContainer(),
    );
  }
}