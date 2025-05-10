// import 'package:flutter/material.dart';
// import 'package:flutter_appauth/flutter_appauth.dart';

// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final FlutterAppAuth _appAuth = FlutterAppAuth();

//   @override
//   void initState() {
//     super.initState();
//     //_login();
//   }

//   Future<void> _login() async {
//     try {
//       final AuthorizationTokenResponse? result = await _appAuth
//           .authorizeAndExchangeCode(
//             AuthorizationTokenRequest(
//               'dolapp_45c078c9',
//               'com.dolapp.flutterapp:/oauthredirect', // Redirect URI
//               serviceConfiguration: AuthorizationServiceConfiguration(
//                 authorizationEndpoint:
//                     'https://demo-auth.infinextsoft.com/connect/authorize',
//                 tokenEndpoint:
//                     'https://demo-auth.infinextsoft.com/connect/token',
//               ),
//               scopes: ['openid', 'profile', 'roles', 'offline_access'],

//               //preferEphemeralSession: true,
//             ),
//           );

//       if (result != null) {
//         print('Access Token: ${result.accessToken}');
//         print('ID Token: ${result.idToken}');

//         // Navigator.pushReplacementNamed(context, '/home');
//       }
//     } catch (e) {
//       print('Login Hatası: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(body: Center(child: CircularProgressIndicator()));
//   }
// }
