import 'package:push_notification/api/user_api.dart';
import 'package:push_notification/models/user_response.dart';

class UserService {

  static Future<UserResponseDto?> getSelfUser(String jwt) async{
    return await UserApi.getSelfUser(jwt);
  }


}