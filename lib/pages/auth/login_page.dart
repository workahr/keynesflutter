import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/app_assets.dart';
import '../../constants/app_colors.dart';
import '../../controllers/base_controller.dart';
import '../../services/keynes_api_service.dart';
import '../../services/comFuncService.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/heading_widget.dart';
import '../../../widgets/sub_heading_widget.dart';
import '../../widgets/custom_dropdown_login.dart';
import '../../widgets/custom_text_field_login.dart';
import 'package:dropdown_search/dropdown_search.dart';

import '../dashboard/dashboard_page.dart';
import '../dashboard_pages/dashboard_screen.dart';
import 'auth_validations.dart';
import 'login_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final KeynesApiService apiService = KeynesApiService();

  AuthValidation authValidation = AuthValidation();

  BaseController baseCtrl = Get.put(BaseController());

  final GlobalKey<FormState> loginForm = GlobalKey<FormState>();
  TextEditingController usernameCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  List? allBranchList = [];

  bool isChecked = false;

  var obscureText = true;

  @override
  void initState() {
    //usernameCtrl.text ="suntech_dev_team";
    super.initState();
  }

  errValidateUseranme(value) {
    return (value) {
      if (value.isEmpty) {
        return 'Username is required';
      }
      return null;
    };
  }

  errValidatePassword(value) {
    return (value) {
      if (value.isEmpty) {
        return 'Password is required';
      }
      return null;
    };
  }

  String? dropdownValue;
  Future login() async {
    try {
      if (loginForm.currentState!.validate()) {
        Map<String, dynamic> postData = {
          'username': usernameCtrl.text,
          'password': passwordCtrl.text,
          'mobile_push_id': baseCtrl.fbUserId
        };
        var result = await apiService.userLogin(postData);
        LoginModel response = loginModelFromJson(result);
        if (response.status.toString() == 'SUCCESS') {
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool('isLoggedin', true);
          prefs.setString('auth_token', response.authToken ?? '');

          //Navigator.pushNamed(context, '/');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DashboardScreen()),
          );
        } else {
          showInSnackBar(context, response.message.toString());
        }
      } else {
        // showInSnackBar(context, "Please fill all fields");
      }
    } catch (error) {
      showInSnackBar(context, error.toString());
    }
  }

  List<DropdownMenuItem<String>> items = [
    // Dynamic items for dropdown
    DropdownMenuItem(
      value: 'suntech_dev_team',
      child: Text('suntech_dev_team'),
    ),
  ];

  errValidateUserName(String? value) {
    return (value) {
      if (value.isEmpty) {
        return 'User Name is required';
      }
      return null;
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
            child: Center(
                child: Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                padding: const EdgeInsets.all(25),
                // decoration: BoxDecoration(
                //     boxShadow: const [BoxShadow(blurRadius: 10.0)],
                //     color: AppColors.light,
                //     borderRadius: BorderRadius.circular(15)),
                child: Form(
                  key: loginForm,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40.0,
                      ),
                      Center(
                        child: Image.asset(
                          AppAssets.keynesLogo,
                          width: 200.0,
                          // width: MediaQuery.of(context).size.width / 2,
                          // width: MediaQuery.of(context).size.width - 20.0,
                        ),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6.0, vertical: 2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            HeadingWidget(
                              title: 'Login',
                              color: AppColors.dark,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ),
                      CustomeTextField(
                        labelText: 'Username',
                        control: usernameCtrl,
                        validator: errValidateUseranme(usernameCtrl.text),
                        width: MediaQuery.of(context).size.width / 1.1,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      CustomeTextField(
                        obscureText: obscureText,
                        labelText: 'Password',
                        control: passwordCtrl,
                        validator: authValidation
                            .errValidatePasswordForLogin(passwordCtrl.text),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                          icon: obscureText
                              ? Icon(
                                  MdiIcons.eye,
                                )
                              : Icon(
                                  MdiIcons.eyeOff,
                                ),
                        ),
                        width: MediaQuery.of(context).size.width / 1.1,
                      ),
                      const SizedBox(
                        height: 37.0,
                      ),
                      ButtonWidget(
                        title: 'Login',
                        width: MediaQuery.of(context).size.width / 1.3,
                        onTap: () {
                          login();
                        },
                        borderRadius: 12.0,
                        color: AppColors.blue,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              )
            ],
          ),
        ))));
  }
}

Color getColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };
  if (states.any(interactiveStates.contains)) {
    return AppColors.primary;
  }
  return AppColors.background;
}
