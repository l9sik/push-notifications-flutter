import 'package:push_notification/api/subscription_api.dart';
import 'package:push_notification/models/subscribed_user_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants.dart';

class SubscriptionService {

  static Future<List<SubscribedUserResponseDto>?> getAllSubscribedUsers(String jwt) async{

    return await SubscriptionApi.getAllSubscribedUsers(jwt);
  }

  static Future<bool> subscribe(String jwt, String recipientToken) async{
    return await SubscriptionApi.createSelfSubscription(jwt, recipientToken);
  }


}