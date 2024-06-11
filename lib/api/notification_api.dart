import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:push_notification/models/notification_request.dart';
import 'package:push_notification/utils/http_utils.dart';

import '../utils/constants.dart';

class NotificationApi {

  static Future<bool> sendNotification(NotificationRequest request, String jwt) async{

    var uri = Uri.http(Constants.BACKEND_DOMAIN, Constants.TEST_SERVICE_PATH);

    var headers = HttpUtils.bearerTokenHeaders(jwt);

    final response = await http.post(
        uri,
        headers: headers,
        body: json.encode({
          'userId': request.userId,
          'title': request.title,
          'body': request.body,
          'imageUrl': request.imageUrl,
          'data': request.data,
        })
    );

    var code = response.statusCode;

    return code == 200;
  }

}