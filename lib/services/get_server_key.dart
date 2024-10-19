// import 'package:googleapis_auth/auth_io.dart';

// class GetServerKey {
//   Future<String> getServerKeyToken() async {
//     final scopes = [
//       'https://www.googleapis.com/auth/userinfo.email',
//       'https://www.googleapis.com/auth/firebase.database',
//       'https://www.googleapis.com/auth/firebase.messaging'
//     ];

//     final client = await clientViaServiceAccount(
//         ServiceAccountCredentials.fromJson(
//           {
//             "type": "service_account",
//             "project_id": "keynesflutter-222b3",
//             "private_key_id": "8af07bfb3a6dbe40ce698a6677ad578c48bb5251",
//             "private_key":
//                 "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQCo3OlZMrZD1LB0\nZ0Tz5NNiQ9VWL0TuYdUd3s8rTSG6CtPeAU7hAhQyZDwFTi3RTyT3E5oWTc2NQjPN\nUZWAL3l5sqTt5J+ohxTng2bXzHsOmGW84Didd0cHXmmtbdlX1sPHg8tZXvBAiofe\nmHDW6BKQCLej4xeyD6QRiZkaRgh50CZpByxPWEy98QywUAQdqXQepYj1P1VyRWbg\nmBDdoEqvfUUZ2LJIQ7wkzgPz0ybDbeJIrlwsYitcGiApin6ErZpQjKVHacNpGaKK\nMxAs9f999ZxQzRgsUZqK5MANmqoU7/vXJlk7XuH82l85JIJX1bfvI61oyuvE0czE\nx5Ra05pJAgMBAAECggEAFGrBfBt5ljH9M9XYrHSaamMxRD5q4zfJANeTzPSCg3AT\nteAKnYIW1xDvgOS2/XvISGeCVfgKRm4evVCD9v/GfERxVKIz+7h5epSUtrrulhEv\nG+swbTmiyO1Ncb66bLh264Sv7ZphCiy1yOA9pH5i4C9tpM8sakch20z7ygV1uOST\nkpmMVKmcRBbJmy7MQqvcMsI65VUos/QAVMaJi1WWsvP9LHB9tJ9zxRcjJSgkkfcW\nnSSSENJWHaPV//Wm4Yh/Htz8PUWBOOf+x3mpczPxvbKvyacv9g8/Dbk4dT6xNiv9\nOfdnW/m0UzcROlSO2KRZcyLJ4e0XYpfnS7lDkUZ90QKBgQDgn3BZfp0FR3SmxHey\nDBMpPIGhDEF3DjYrc5IsckiK4pKDnwBbB4zW55GDT63whLd9K8tyXsjlA8aEP+8r\nHkYUj/xZbWhRz3PCRalrKDOZTUjjGPKJh33Ahq4b/LMTSIAzANNbS8Iif0pDb6wD\nf046lL+CgDI4YXXHIbPqMeFkMwKBgQDAc3zBCizXG+2L+tKF+INVIxA1uCRQE0T7\nTclWua7IcPMFsr8zjMrIqZB+LSZRs83EN4ib1Xf355O3s/0PMbMZeugSJKST5Zgw\nJcRpzev64MxWFu8NYDu29uTmBY9gXaZWiWnSiRmzkmNhp20V38q/7AXtgJnzXbJI\n+gdpNKOrkwKBgQDgfFeTCWex8/TQCj+5kDnCF3dR1WbDrk9S46CtjNWU/9T/d/Oq\nBgSqbinN+t7SJkEe9prPxYyu3DQUzbSf+hR9zlybny0HvfVpracgsb/HsSZr1+3k\npqV1uOPekpEBb4636lZQwojVYzN76+oUYLF0+F3g9W+7SyOjDLq7Dni8YwKBgQCH\nTCm2pOqlR/MW5/09Rls+bWol+hE9Ym6qpiMYH25raEzSAro9CYw+ykbVDfTUl63f\ndpNJyyeOV3YYPid4mR4qmaexqaUyfMUjhEmzgJuYQpYlJ/Zj1vXkSWre86W6v9wD\nFpQY+V3iStYnf0dHi4/EobABKtoQqByBBZZUNjeilQKBgQDF5k0wCp2tHuWkegDf\n5+YOdYdUK5IqIaYnPpHm+GngOYxMKgKjlHycRrYQrBg8zRDTOwTd8uIeBbucXH4o\ngGJLWyRk58RSFnx5gEuxzW94vznwL9rmtm4bZO21Oo0C5Rq9cEEose++w5clQ19a\nDlG+kjio+bP4l0lorI5inWGYXg==\n-----END PRIVATE KEY-----\n",
//             "client_email":
//                 "firebase-adminsdk-r8c3e@keynesflutter-222b3.iam.gserviceaccount.com",
//             "client_id": "111292064215408493801",
//             "auth_uri": "https://accounts.google.com/o/oauth2/auth",
//             "token_uri": "https://oauth2.googleapis.com/token",
//             "auth_provider_x509_cert_url":
//                 "https://www.googleapis.com/oauth2/v1/certs",
//             "client_x509_cert_url":
//                 "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-r8c3e%40keynesflutter-222b3.iam.gserviceaccount.com",
//             "universe_domain": "googleapis.com"
//           },
//         ),
//         scopes);
//     final accessServerKey = client.credentials.accessToken.data;
//     return accessServerKey;
//   }
// }
