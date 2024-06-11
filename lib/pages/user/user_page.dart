import 'package:flutter/material.dart';
import 'package:push_notification/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants.dart';

class UserPage extends StatefulWidget {
  const UserPage ({super.key});

  @override
  State<UserPage> createState() => _UserPage();

}

class _UserPage extends State<UserPage> {
  late String _username = "null";
  late String _email = "null";
  late bool _isModerator = false;

  @override
  void initState(){
    super.initState();
    getUserInfo();
  }

  Future<void> getUserInfo() async {

    var preferences = await SharedPreferences.getInstance();
    
    String? token = preferences.getString(Constants.localStorage.TOKEN);
    List<String>? authorities = preferences.getStringList(Constants.localStorage.AUTHORITIES);

    //if no authentication data then go to login page
    if (token == null || authorities == null){
      Navigator.pushNamed(context, Constants.appState.STATE_LOGIN_PAGE);
      return;
    }
    //get self user data
    var user = await UserService.getSelfUser(token);

    setState(() {
      // if something goes wrong go to login page
      if (user == null){
        Navigator.pushNamed(context, Constants.appState.STATE_LOGIN_PAGE);
        return;
      }
      _username = user.username;
      _email = user.email;
      _isModerator = authorities.contains(Constants.ROLE_ADMIN);
    } );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Пользователь")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Информация о пользователе", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Логин: $_username"),
            Text("Почта: $_email"),
            if (_isModerator)
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Constants.appState.STATE_ADMIN_PAGE);
                },
                child: Text("Перейти в админ-панель"),
              ),
          ],
        ),
      ),
    );
  }
}
