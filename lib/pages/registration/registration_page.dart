import 'package:flutter/material.dart';
import 'package:push_notification/services/registration_service.dart';
import 'package:push_notification/utils/constants.dart';

class RegistrationPage extends StatelessWidget {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Регистрация")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _userController,
              decoration: InputDecoration(labelText: 'User'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Пароль'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Registration logic
                onRegistrationButton(context);
              },
              child: Text("Зарегистрироваться"),
            ),
            TextButton(
              onPressed: () {
                // Switch to login page
                Navigator.pushNamed(context, Constants.appState.STATE_LOGIN_PAGE);
              },
              child: Text("Войти"),
            ),
          ],
        ),
      ),
    );
  }

  void onRegistrationButton(BuildContext context) async {
    String username = _userController.text;
    String email = _emailController.text;
    String password = _passwordController.text;


    bool isRegistered = await RegistrationService.register(username, email, password);
    if (isRegistered){
      Navigator.pushNamed(context, Constants.appState.STATE_LOGIN_PAGE);
    }else {
      Navigator.pushNamed(context, Constants.appState.STATE_REGISTRATION_PAGE);
    }

  }
}
