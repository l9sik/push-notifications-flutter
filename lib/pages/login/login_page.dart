import 'package:flutter/material.dart';
import 'package:push_notification/services/subscription_service.dart';
import 'package:push_notification/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/authentication_service.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final AuthenticationService authenticationService;

  LoginPage(this.authenticationService);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Авторизация")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _userEmailController,
              decoration: InputDecoration(labelText: 'User/Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Пароль'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Login button logic
                onLoginButton(context);
              },
              child: Text("Войти"),
            ),
            TextButton(
              onPressed: () {
                // switch to registration page
                Navigator.pushNamed(context, Constants.appState.STATE_REGISTRATION_PAGE);
              },
              child: Text("Создать аккаунт"),
            ),
          ],
        ),
      ),
    );
  }

  void onLoginButton(BuildContext context) async{
    String userOrEmail = _userEmailController.text;
    String password = _passwordController.text;

    bool isAuthenticated = await authenticationService.authenticate(userOrEmail, password);

    if (isAuthenticated){
      subscribeDevice();
      Navigator.pushNamed(context, Constants.appState.STATE_USER_PAGE);
    }else {
      Navigator.pushNamed(context, Constants.appState.STATE_LOGIN_PAGE);
    }
  }

  void subscribeDevice() async {

    var preferences = await SharedPreferences.getInstance();
    String? jwt = preferences.getString(Constants.localStorage.TOKEN);
    String? fcm = preferences.getString(Constants.localStorage.FCM_TOKEN);

    if (jwt != null && fcm != null) {
      SubscriptionService.subscribe(jwt, fcm);
    }
  }
}
