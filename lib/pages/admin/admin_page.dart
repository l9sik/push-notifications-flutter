import 'package:flutter/material.dart';
import 'package:push_notification/api/subscription_api.dart';
import 'package:push_notification/api/user_api.dart';
import 'package:push_notification/models/subscribed_user_response.dart';
import 'package:push_notification/models/user_response.dart';
import 'package:push_notification/services/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/subscription.dart';
import '../../utils/constants.dart';

class AdminPage extends StatefulWidget {
  const AdminPage ({super.key});

  @override
  State<AdminPage> createState() => _AdminPage();

}

class _AdminPage extends State<AdminPage> {
  List<User> _users = List.empty();

  @override
  void initState() {
    super.initState();
    getUsers(context);
  }

  Future<void> getUsers(BuildContext context) async {

    SharedPreferences preferences = await SharedPreferences.getInstance();

    String? token = preferences.getString(Constants.localStorage.TOKEN);

    if (token == null){
      Navigator.pushNamed(context, Constants.appState.STATE_LOGIN_PAGE);
      return;
    }

    List<SubscribedUserResponseDto>? users = await SubscriptionApi.getAllSubscribedUsers(token);

    print(users);
    if (users == null){
      Navigator.pushNamed(context, Constants.appState.STATE_LOGIN_PAGE);
      return;
    }

    setState(() {
      _users = users.map((u) => User(
          id: u.id,
          username:  u.name,
          deviceCount: u.deviceCount,
      )).toList();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Админ-панель")),
      body: usersWidget(_users),
    );
  }

  Widget usersWidget(List<User> users){
    if (users.isEmpty){
      return Text("Пока ничего нет...");
    }
    return ListView.builder(
      itemCount: _users.length,
      itemBuilder: (context, index) {
        final user = _users[index];
        return ListTile(
          title: Text(user.username),
          subtitle: Text("Количество устройств: ${user.deviceCount}"),
          trailing: IconButton(
            icon: Icon(Icons.mail),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => NotificationDialog(user: user),
              );
            },
          ),
        );
      },
    );
  }
}

class NotificationDialog extends StatefulWidget {
  final User user;

  NotificationDialog({required this.user});

  @override
  _NotificationDialogState createState() => _NotificationDialogState();
}

class _NotificationDialogState extends State<NotificationDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  final List<MapEntry<String, String>> _keyValuePairs = [];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Отправить уведомление"),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Название'),
            ),
            TextField(
              controller: _messageController,
              decoration: InputDecoration(labelText: 'Текст'),
            ),
            TextField(
              controller: _urlController,
              decoration: InputDecoration(labelText: 'URL картинки'),
            ),
            ..._keyValuePairs.map((pair) {
              return Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(labelText: 'Ключ'),
                      onChanged: (value) {
                        // Key
                      },
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(labelText: 'Значение'),
                      onChanged: (value) {
                        //Value
                      },
                    ),
                  ),
                ],
              );
            }).toList(),
            TextButton(
              onPressed: () {
                setState(() {
                  _keyValuePairs.add(MapEntry('', ''));
                });
              },
              child: Text("Добавить поле"),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Sending notification logic
            sendNotificationButton(widget.user);
            Navigator.of(context).pop();
          },
          child: Text("Отправить"),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Отмена"),
        ),
      ],
    );
  }

  void sendNotificationButton(User user){
    String title = _titleController.text;
    String message = _messageController.text;
    String image = _urlController.text;
    List<MapEntry<String, String>> entries = _keyValuePairs;
    int userId = user.id;

    var data = Map.fromEntries(entries);

    NotificationService.sendNotification(userId, title, message, image, data);
  }
}

class User {
  int id;
  String username;
  int deviceCount;

  User({required this.id, required this.username, required this.deviceCount});
}
