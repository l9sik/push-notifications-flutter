import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:push_notification/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseApi{

  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {

    await _firebaseMessaging.requestPermission();

    final fCMToken = await _firebaseMessaging.getToken();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(Constants.localStorage.FCM_TOKEN, fCMToken!);
    print("Token: {" + fCMToken! + "}");
  }
}