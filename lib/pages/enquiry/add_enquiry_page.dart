import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:keynes/pages/dashboard_pages/dashboard_container.dart';
import 'package:keynes/pages/main_container.dart';
import 'package:keynes/widgets/heading_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
import 'assignperson_list_model.dart';
import 'authority_list_model.dart';
import 'enquiry_add_model.dart';
import 'servicetype_list_model.dart';

class AddEnquiryPage extends StatefulWidget {
  String? serviceName;
  AddEnquiryPage({super.key, this.serviceName});

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
  TextEditingController mobileNoCtrl = TextEditingController();
  TextEditingController notesCtrl = TextEditingController();
  TextEditingController addressCtrl = TextEditingController();
  TextEditingController projectTitleCtrl = TextEditingController();
  TextEditingController projectDescCtrl = TextEditingController();




  @override
  void initState() {
    print(widget.serviceName);
    getAllServices();
    getAllUsers();
    getLoginScreen();
    super.initState();
  }

  String? loginuser;

  Future getLoginScreen() async {
    final prefs = await SharedPreferences.getInstance();
    loginuser = prefs.getString('role_name' ?? '');
    print("login user :$loginuser");

    if (loginuser == "Sales Executive") {
      selectedReferId = 2;
      selectedUserId = prefs.getInt('user_id' ?? '');
    }

    if (loginuser == "Super Admin") {

      getAllAuthority();
      getAllServiceType();
      getAllUsers1();

    }
  }

  selectedServicesArray() {
    List result;

    if (servicesList!.isNotEmpty) {
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
  List referList = [
    {"name": "App", "value": 1},
    {"name": "Sales Executive", "value": 2},
    {"name": "Call", "value": 3},
    {"name": "Reference", "value": 4},
    {"name": "None", "value": 5},
  ];

  var selectedassignedpersonArr;
  String? selectedassignedperson;
  int? selectedassignedpersonId;

  bool assignedPerson = false;
  List assignedList = [
    {"name": "Sales Executive", "value": 1},
    {"name": "Engineer", "value": 2},
    {"name": "Accountant", "value": 3},
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

 List<AuthorityListData>? authorityList = [];
  List<AuthorityListData>? authorityListAll = [];

    var selectedAuthorityArr;
  String? selectedAuthority;
  int? selectedAuthorityId;

   Future getAllAuthority() async {
     await apiService.getBearerToken();
    var result = await apiService.getAllAuthority();
    print('hi $result');
    AuthorityListModel response = authorityListModelFromJson(result);
    if (response.status.toString() == 'SUCCESS') {
      setState(() {
        authorityList = response.list;
        authorityListAll = authorityList;
        selectedServicesArray();
        print('hello $authorityList');
      });
    } else {
      setState(() {
        authorityList = [];
        authorityListAll = [];
      });
      showInSnackBar(context, response.status);
    }
    setState(() {});
  }



   List<ServiceTypeList>? serviceTypeList = [];
  List<ServiceTypeList>? serviceTypeListAll = [];

  var selectedServiceTypeArr;
  String? selectedServiceType;
  int? selectedServiceTypeId;

   Future getAllServiceType() async {
     await apiService.getBearerToken();
    var result = await apiService.getAllServiceType();
    print('hi $result');
    ServicetypeListModel response = servicetypeListModelFromJson(result);
    if (response.status.toString() == 'SUCCESS') {
      setState(() {
        serviceTypeList = response.list;
        serviceTypeListAll = serviceTypeList;
        selectedServicesArray();
        print('hello $serviceTypeList');
      });
    } else {
      setState(() {
        serviceTypeList = [];
        serviceTypeListAll = [];
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

  List<UserListData>? clientList = [];
  List<UserListData>? clientListAll = [];

    var selectedClientArr;
  String? selectedClient;
  int? selectedClientId;

  Future getAllUsers1() async {
    var result = await apiService.getAllUsers();
    print('hi $result');
    UsersListModel response = usersListModelFromJson(result);
    if (response.status.toString() == 'SUCCESS') {
      setState(() {
        clientList = response.list;
        clientListAll = clientList;
        print('hello $clientList');

         clientList = clientListAll!.where((entry) {
           
            return entry.role == 1;
       
        }).toList();
      });
    } else {
      setState(() {
        clientList = [];
        clientListAll = [];
      });
      showInSnackBar(context, response.status);
    }
    setState(() {});
  }

  List<AssignPerson>? assignedperList = [];
  List<AssignPerson>? assignedListAll = [];

  var selectedAssignedArr;
  String? selectedAssigned;
  int? selectedAssignedId;

  Future getassignedperson() async {
    var result = await apiService.getassignedperson(selectedassignedpersonId);
    print('hi $result');
    AssignpersonListModel response = assignpersonListModelFromJson(result);
    if (response.status.toString() == 'SUCCESS') {
      setState(() {
        assignedperList = response.list;
        assignedListAll = assignedperList;
        print('hello $assignedperList');
      });
    } else {
      setState(() {
        assignedperList = [];
        assignedListAll = [];
      });
      showInSnackBar(context, response.status);
    }
    setState(() {});
  }

  errValidateusername(String? value) {
    return (value) {
      if (value.isEmpty) {
        return 'Name is required';
      }
      return null;
    };
  }

    errValidateProjectTitle(String? value) {
    return (value) {
      if (value.isEmpty) {
        return 'Project Title is required';
      }
      return null;
    };
  }

  errValidateProjectDesc(String? value) {
    return (value) {
      if (value.isEmpty) {
        return 'Project Description is required';
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
  errValidateMobile(String? value) {
    return (value) {
      if (value.isEmpty) {
        return 'Mobile Number is required';
      }
      return null;
    };
  }

  String authToken = "";


  Future saveEnquiry() async {
    if (enquiryForm.currentState!.validate()) {
      // DateTime parsedDate =
      //     DateFormat('dd-MM-yyyy').parse(licenseExpiryDateController.text);

      // // Format the date to yyyy-MM-dd
      // String formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
      Map<String, dynamic> postData = {
        "client_name": selectedClient != null || selectedClient != "" ? selectedClient.toString() : userNameController.text,
        "mobile": mobileNoCtrl.text,
        "email": emailAddressCtrl.text,
        "address": addressCtrl.text,
        "notes": notesCtrl.text,
        "refer_type": selectedReferId,
        "refer_person": selectedUserId,
        "assigned_for": selectedassignedpersonId,
        "assigned_person": selectedAssignedId,
        "service_id": selectedServiceId,
        "enquiry_status": "New",
        "authority": selectedAuthorityId,
        "service_type": selectedServiceTypeId,
        "project_title": projectTitleCtrl.text,
        "project_description": projectDescCtrl.text
      };
      print('postData $postData');
      final prefs = await SharedPreferences.getInstance();
      authToken = prefs.getString('auth_token') ?? "";
      String apiUrl ="";
      if(authToken == ""){
        apiUrl = 'enquiries/create-enquirieswithouttoken';
      }
      else{
        apiUrl = 'enquiries/create-enquiries';
      }
       

      var result = await apiService.saveEnquiry(apiUrl,postData);
      print('result $result');
      EnquiryAddModel response = enquiryAddModelFromJson(result);

      if (response.status.toString() == 'SUCCESS') {
        showInSnackBar(context, response.message.toString());
        // Navigator.pop(context, {'type': 1});
        print("login user :  $loginuser");
        if (loginuser == '' || loginuser == null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  MainContainer(childWidget: const ServicePage()),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  DashboardContainer(childWidget: const ServicePage()),
            ),
          );
        }
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
              title: "Enquiry",
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
                    child: Column(children: [

                      if (loginuser == null)
                      CustomeTextField(
                        control: userNameController,
                        validator: errValidateusername(userNameController.text),
                        labelText: 'Name',
                        width: MediaQuery.of(context).size.width - 10,
                      ),

                       if (clientList != null && loginuser == "Super Admin" && loginuser != '')
                        CustomAutoCompleteWidget(
                          width: MediaQuery.of(context).size.width / 1.1,
                          selectedItem: selectedClientArr,
                          labelText: 'Client',
                          labelField: (item) => item.fullname,
                          onChanged: (value) {
                            setState(() {
                             selectedClientId =  value.id;
                             selectedClient = value.fullname;
                            });
                          },
                          valArr: clientList,
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
                        validator: errValidateMobile(mobileNoCtrl.text),
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

                        if (loginuser == "Super Admin" && loginuser != '')
                        CustomeTextField(
                        control: projectTitleCtrl,
                        validator: errValidateProjectTitle(projectTitleCtrl.text),
                        labelText: 'Project Title',
                        width: MediaQuery.of(context).size.width - 10,
                      ),

                     if (loginuser == "Super Admin" && loginuser != '')
                       CustomeTextField(
                        control: projectDescCtrl,
                        validator: errValidateProjectDesc(projectDescCtrl.text),
                        labelText: 'Project Description',
                        width: MediaQuery.of(context).size.width - 10,
                        lines: 3,
                      ),


                         if (authorityList != null && loginuser == "Super Admin" && loginuser != '')
                        CustomAutoCompleteWidget(
                          width: MediaQuery.of(context).size.width / 1.1,
                          selectedItem: selectedAuthorityArr,
                          labelText: 'Authority',
                          labelField: (item) => item.authorityName,
                          onChanged: (value) {
                            selectedAuthority = value.authorityName;
                            selectedAuthorityId = value.id;
                            print(selectedAuthorityId);
                          },
                          valArr: authorityList,
                        ),


                      if (servicesList != null)
                        CustomAutoCompleteWidget(
                          width: MediaQuery.of(context).size.width / 1.1,
                          selectedItem: selectedServicesArr,
                          labelText: 'Department',
                          labelField: (item) => item.name,
                          onChanged: (value) {
                            selectedService = value.name;
                            selectedServiceId = value.id;
                            print(selectedServiceId);
                          },
                          valArr: servicesList,
                        ),

                        if (serviceTypeList != null && loginuser == "Super Admin" && loginuser != '' && [1, 2, 3, 4].contains(selectedServiceId)) 
                        CustomAutoCompleteWidget(
                          width: MediaQuery.of(context).size.width / 1.1,
                          selectedItem: selectedServiceTypeArr,
                          labelText: 'Service Type',
                          labelField: (item) => item.serviceName,
                          onChanged: (value) {
                            selectedServiceType = value.serviceName;
                            selectedServiceTypeId = value.id;
                            print(selectedServiceTypeId);
                          },
                          valArr: serviceTypeList,
                        ),

                      if (loginuser != "Sales Executive")
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
                              if (value["value"] == 4) {
                                referPerson = true;
                              } else {
                                referPerson = false;
                                selectedUser = "";
                                selectedUserId = null;
                              }
                            });
                          },
                          valArr: referList,
                        ),

                      if (userList != null && referPerson == true)
                        CustomAutoCompleteWidget(
                          width: MediaQuery.of(context).size.width / 1.1,
                          selectedItem: selectedUserArr,
                          labelText: 'Refer Person',
                          labelField: (item) => item.fullname,
                          onChanged: (value) {
                            selectedUser = value.fullname;
                            selectedUserId = value.id;
                            print(selectedUserId);
                          },
                          valArr: userList,
                        ),

                      if (loginuser == "Super Admin" && loginuser != '')
                        CustomAutoCompleteWidget(
                          width: MediaQuery.of(context).size.width / 1.1,
                          selectedItem: selectedassignedpersonArr,
                          labelText: 'Assigned For',
                          labelField: (item) => item["name"],
                          onChanged: (value) {
                            setState(() {
                              selectedassignedperson = value["name"];
                              selectedassignedpersonId = value["value"];
                              print(selectedassignedperson);
                              print(selectedassignedpersonId);
                              getassignedperson();
                              assignedPerson = true;
                            });
                          },
                          valArr: assignedList,
                        ),

                      if (assignedperList != null && assignedPerson == true)
                        CustomAutoCompleteWidget(
                          width: MediaQuery.of(context).size.width / 1.1,
                          selectedItem: selectedAssignedArr,
                          labelText: 'Assigned Person',
                          labelField: (item) => item.fullname,
                          onChanged: (value) {
                            selectedAssigned = value.fullname;
                            selectedAssignedId = value.id;
                            print(selectedAssignedId);
                          },
                          valArr: assignedperList,
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
                        onTap: () {
                          saveEnquiry();
                        },
                        borderRadius: 12.0,
                        color: AppColors.blue,
                      ),
                    ])))));
  }
}
