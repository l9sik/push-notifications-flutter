import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:push_notification/models/authentication.dart';
import 'package:push_notification/models/subscribed_user_response.dart';
import 'package:push_notification/models/subscription_request.dart';
import 'package:push_notification/models/user_response.dart';
import 'package:push_notification/utils/constants.dart';
import 'package:push_notification/models/subscription.dart';
import 'package:push_notification/utils/http_utils.dart';

class SubscriptionApi {

  static Future<List<Subscription>?> getAllSubscriptions() async {
    
    var uri = Uri.http(Constants.BACKEND_DOMAIN, Constants.SUBSCRIPTION_SERVICE_PATH);

    var response = await http.get(
      uri,
    );

    var code = response.statusCode;
    if (code != 200){
      return null;
    }
    List data = jsonDecode(response.body);

    return Subscription.subscriptionsFromSnapshot(data);
  }

  static Future<List<SubscribedUserResponseDto>?> getAllSubscribedUsers(String jwt) async {

    var uri = Uri.http(Constants.BACKEND_DOMAIN, Constants.SUBSCRIPTION_SERVICE_PATH + "/users");

    var headers = HttpUtils.bearerTokenHeaders(jwt);

    print(headers);

    var response = await http.get(
      uri,
      headers: headers,
    );

    var code = response.statusCode;
    if (code != 200){
      return null;
    }
    List data = jsonDecode(response.body);

    return SubscribedUserResponseDto.subscriptionsFromSnapshot(data);
  }

  static Future<bool> createSelfSubscription(String jwt, String recipientToken) async {

    var uri = Uri.http(Constants.BACKEND_DOMAIN, Constants.SUBSCRIPTION_SERVICE_PATH + "/self");

    var headers = HttpUtils.bearerTokenHeaders(jwt);
    SubscriptionRequest request = SubscriptionRequest(recipientToken: recipientToken);

    var response = await http.post(
        uri,
        headers: headers,
        body: json.encode({
          'recipientToken': request.recipientToken,
        }),
    );

    var code = response.statusCode;
    if (code != 201){
      return false;
    }
    return true;
  }




}