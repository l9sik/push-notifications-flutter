import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:push_notification/api/authentication_api.dart';
import 'package:push_notification/firebase_api.dart';
import 'package:push_notification/pages/admin/admin_page.dart';
import 'package:push_notification/pages/login/login_page.dart';
import 'package:push_notification/pages/registration/registration_page.dart';
import 'package:push_notification/pages/user/user_page.dart';
import 'package:push_notification/services/authentication_service.dart';
import 'package:push_notification/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: FirebaseOptions(
    apiKey: 'AIzaSyCCorMu6OHVAGHQDhzHq-AFKHiox3reQsE',
    appId: '1:149820708059:android:0aacf38703192019b7e8fe',
    messagingSenderId: '149820708059',
    projectId: 'push-notification-96faa',
    storageBucket: 'myapp-b9yt18.appspot.com',
  ));
  await FirebaseApi().initNotifications();

  //initialising

  SharedPreferences preferences = await SharedPreferences.getInstance();

  AuthenticationService authenticationService = AuthenticationService(
      preferences: preferences,
  );
  String initialState = await authenticationService.getInitialState();

  runApp(MyApp(
    initialState: initialState,
    authenticationService: authenticationService,
  ));
}

class MyApp extends StatefulWidget{
  final String initialState;
  final AuthenticationService authenticationService;
  const MyApp ({super.key, required this.initialState, required this.authenticationService});


  @override
  State<StatefulWidget> createState() => _MyApp();

}

class _MyApp extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: widget.initialState,
      routes: {
        '/': (context) => RegistrationPage(),
        Constants.appState.STATE_REGISTRATION_PAGE: (context) => RegistrationPage(),
        Constants.appState.STATE_LOGIN_PAGE: (context) => LoginPage(widget.authenticationService),
        Constants.appState.STATE_USER_PAGE: (context) => UserPage(),
        Constants.appState.STATE_ADMIN_PAGE: (context) => AdminPage(),
      },
    );
  }
}
