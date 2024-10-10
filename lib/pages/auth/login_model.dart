// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String status;
  String authToken;
  int userId;
  int role;
  String roleName;
  String redirect;
  String code;
  String message;

  LoginModel({
    required this.status,
    required this.authToken,
    required this.userId,
    required this.role,
    required this.roleName,
    required this.redirect,
    required this.code,
    required this.message,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        authToken: json["auth_token"],
        userId: json["user_id"],
        role: json["role"],
        roleName: json["role_name"],
        redirect: json["redirect"],
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "auth_token": authToken,
        "user_id": userId,
        "role": role,
        "role_name": roleName,
        "redirect": redirect,
        "code": code,
        "message": message,
      };
}






// // To parse this JSON data, do
// //
// //     final loginModel = loginModelFromJson(jsonString);

// import 'dart:convert';

// LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

// String loginModelToJson(LoginModel data) => json.encode(data.toJson());

// class LoginModel {
//     String status;
//     String authToken;
//     String redirect;
//     String code;
//     String message;

//     LoginModel({
//         required this.status,
//         required this.authToken,
//         required this.redirect,
//         required this.code,
//         required this.message,
//     });

//     factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
//         status: json["status"],
//         authToken: json["auth_token"],
//         redirect: json["redirect"],
//         code: json["code"],
//         message: json["message"],
//     );

//     Map<String, dynamic> toJson() => {
//         "status": status,
//         "auth_token": authToken,
//         "redirect": redirect,
//         "code": code,
//         "message": message,
//     };
// }
