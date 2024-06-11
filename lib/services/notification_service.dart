import 'package:push_notification/api/notification_api.dart';
import 'package:push_notification/models/notification_request.dart';
import 'package:push_notification/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {

  static Future<void> sendNotification(int userId,String title,
    String body, String imageUrl, Map<String, String> data) async {
    NotificationRequest request = NotificationRequest(userId: userId, title: title, body: body, imageUrl: imageUrl, data: data);

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? jwt = preferences.getString(Constants.localStorage.TOKEN);

    if (jwt == null){
      return;
    }

    print(request);
    NotificationApi.sendNotification(request, jwt);
  }
}