import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:keynes/widgets/heading_widget.dart';

import '../../constants/app_colors.dart';
import '../../models/service_list_model.dart';
import '../../models/user_list_model.dart';
import '../../services/comFuncService.dart';
import '../../services/keynes_api_service.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/custom_autocomplete_widget.dart';
import '../../widgets/custom_text_field.dart';
import '../auth/auth_validations.dart';
import '../service_page.dart';
import 'enquiry_add_model.dart';

class AddEnquiryPage extends StatefulWidget {
   String? serviceName;
   AddEnquiryPage({super.key,this.serviceName});

  @override
  State<AddEnquiryPage> createState() => _AddEnquiryPageState();
}

class _AddEnquiryPageState extends State<AddEnquiryPage> {

  final _formKey = GlobalKey<FormState>();
   final KeynesApiService apiService = KeynesApiService();

  final GlobalKey<FormState> enquiryForm = GlobalKey<FormState>();

  AuthValidation authValidation = AuthValidation();


  TextEditingController userIdController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailAddressCtrl = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController vehicleIdController = TextEditingController();
  TextEditingController licenseNumberController = TextEditingController();
  TextEditingController licenseExpiryDateController = TextEditingController();
  TextEditingController mobileNoCtrl = TextEditingController();
  TextEditingController notesCtrl = TextEditingController();
  TextEditingController addressCtrl = TextEditingController();

   @override
  void initState() {
    print(widget.serviceName);
    getAllServices();
     getAllUsers();
    super.initState();
  }


selectedServicesArray() {

   
    List result;
  
        if(servicesList!.isNotEmpty){

      result = servicesList!
          .where((element) => element.name == widget.serviceName)
          .toList();
     
      if (result.isNotEmpty) {
        setState(() {
          selectedServicesArr = result[0];
          selectedServiceId = result[0].id;
          print('selectedServiceId $selectedServiceId');
        });
      } else {
        setState(() {
          selectedServicesArr = null;
        });
      }
    } else {
      setState(() {
        print('selectedServicesArr empty');

        selectedServicesArr = null;
      });
    }
  
    }
   List<ServicesListData>? servicesList = [];
  List<ServicesListData>? servicesListAll = [];

  var selectedServicesArr;
  String? selectedService;
  int? selectedServiceId;


    var selectedReferArr;
  String? selectedRefer;
  int? selectedReferId;

bool referPerson = false;
  List referList =[
    {
      "name": "App",
      "value": 1
    },
     {
      "name": "Sales Executive",
      "value": 2
    },
     {
      "name": "Call",
      "value": 3
    },
     {
      "name": "Reference",
      "value": 4
    },
     {
      "name": "None",
      "value": 5
    },
  ];

  Future getAllServices() async {
    var result = await apiService.getAllServices();
    print('hi $result');
    ServiceListModel response = serviceListModelFromJson(result);
    if (response.status.toString() == 'SUCCESS') {
      setState(() {
        servicesList = response.list;
        servicesListAll = servicesList;
        selectedServicesArray();
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


   List<UserListData>? userList = [];
  List<UserListData>? userListAll = [];


    var selectedUserArr;
  String? selectedUser;
  int? selectedUserId;

  Future getAllUsers() async {
    var result = await apiService.getAllUsers();
    print('hi $result');
    UsersListModel response = usersListModelFromJson(result);
    if (response.status.toString() == 'SUCCESS') {
      setState(() {
        userList = response.list;
        userListAll = userList;
        print('hello $userList');
      });
    } else {
      setState(() {
        userList = [];
        userListAll = [];
      });
      showInSnackBar(context, response.status);
    }
    setState(() {});
  }



   errValidateusername(String? value) {
    return (value) {
      if (value.isEmpty) {
        return 'User Name is required';
      }
      return null;
    };
  }

  errValidateNotes(String? value) {
    return (value) {
      if (value.isEmpty) {
        return 'Notes is required';
      }
      return null;
    };
  }

  errValidateAddress(String? value) {
    return (value) {
      if (value.isEmpty) {
        return 'Address is required';
      }
      return null;
    };
  }


  Future saveEnquiry() async {
    if (enquiryForm.currentState!.validate()) {
      // DateTime parsedDate =
      //     DateFormat('dd-MM-yyyy').parse(licenseExpiryDateController.text);

      // // Format the date to yyyy-MM-dd
      // String formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
      Map<String, dynamic> postData = {
        "client_name": userNameController.text,
        "mobile": mobileNoCtrl.text,
        "email": emailAddressCtrl.text,
        "address": addressCtrl.text,
        "notes": notesCtrl.text,
        "refer_type": selectedReferId,
        "refer_person": selectedUserId,
        "service_id":selectedServiceId,
        "enquiry_status": "New",
      };
      print('postData $postData');

      var result = await apiService.saveEnquiry(postData);
      print('result $result');
      EnquiryAddModel response = enquiryAddModelFromJson(result);

      if (response.status.toString() == 'SUCCESS') {
        showInSnackBar(context, response.message.toString());
        // Navigator.pop(context, {'type': 1});
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ServicePage(),
          ),
        );
      } else {
        print(response.message.toString());
        showInSnackBar(context, response.message.toString());
      }
    } else {
      showInSnackBar(context, "Please fill all fields");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.light,
        appBar: AppBar(
            //automaticallyImplyLeading: false,
            title: HeadingWidget(
              title:  "Enquiry",
             color: AppColors.blue,
             fontSize: 18.0,
             fontWeight: FontWeight.bold,
            ),
             
            backgroundColor: AppColors.light),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: enquiryForm,
              child: Column(
                children: [
                  CustomeTextField(
                    control: userNameController,
                    validator: errValidateusername(userNameController.text),
                    labelText: 'Name',
                    width: MediaQuery.of(context).size.width - 10,
                  ),
                  //SizedBox(height: 16),
                  CustomeTextField(
                    control: emailAddressCtrl,
                    validator: authValidation
                                .errValidateEmail(emailAddressCtrl.text),
                    labelText: 'Email',
                    width: MediaQuery.of(context).size.width - 10,
                  ),

                  CustomeTextField(
                          labelText: 'Contact',
                          width: MediaQuery.of(context).size.width / 1.1,
                          control: mobileNoCtrl,
                          validator: authValidation
                              .errValidateMobileNo(mobileNoCtrl.text),
                          type: const TextInputType.numberWithOptions(),
                          inputFormaters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^-?(\d+)?\.?\d{0,11}'))
                          ],
                        ),

                         CustomeTextField(
                    control: addressCtrl,
                    validator: errValidateAddress(addressCtrl.text),
                    labelText: 'Address',
                    width: MediaQuery.of(context).size.width - 10,
                  ),

                   if(servicesList != null)
                    CustomAutoCompleteWidget(
                          width: MediaQuery.of(context).size.width / 1.1,
                          selectedItem: selectedServicesArr,
                          labelText: 'Services',
                          labelField: (item) => item.name,
                          onChanged: (value) {
                            selectedService = value.name;
                            selectedServiceId = value.id;
                            print(selectedService);
                          },
                          valArr: servicesList,
                        ),

                        CustomAutoCompleteWidget(
                          width: MediaQuery.of(context).size.width / 1.1,
                          selectedItem: selectedReferArr,
                          labelText: 'Refer Type',
                          labelField: (item) => item["name"],
                          onChanged: (value) {
                            setState(() {
                                selectedRefer = value["name"];
                            selectedReferId = value["value"];
                            print(selectedRefer);
                              if(value["value"] == 4){
                                referPerson = true;
                              }
                              else{
                                referPerson = false;
                                selectedUser ="";
                                selectedUserId = null;
                              }
                            });
                          
                          },
                          valArr: referList,
                        ),


                        if(userList != null && referPerson == true)
                    CustomAutoCompleteWidget(
                          width: MediaQuery.of(context).size.width / 1.1,
                          selectedItem: selectedUserArr,
                          labelText: 'Refer Person',
                          labelField: (item) => item.fullname,
                          onChanged: (value) {
                            selectedUser = value.fullname;
                            selectedUserId = value.id;
                            print(selectedService);
                          },
                          valArr: userList,
                        ),

                          CustomeTextField(
                    control: notesCtrl,
                    validator: errValidateNotes(notesCtrl.text),
                    labelText: 'Notes',
                    width: MediaQuery.of(context).size.width - 10,
                    lines: 3,
                  ),

                  SizedBox(
                    height: 30.0,
                  ),

                   ButtonWidget(
                        title: 'Submit',
                        width: MediaQuery.of(context).size.width / 1.2,
                        onTap: (){
                          saveEnquiry();
                        },
                        borderRadius: 12.0,
                        color: AppColors.blue,
                      ),
                ]
              )
            )
          )
        )
    );
  }
}