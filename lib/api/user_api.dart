import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:push_notification/utils/constants.dart';
import 'package:push_notification/utils/http_utils.dart';
import '../models/user_response.dart';

class UserApi {


  // Получить одного пользователя по ID
  static Future<UserResponseDto?> getUserById(int id) async {

    var uri = Uri.http(Constants.BACKEND_DOMAIN, Constants.USER_SERVICE_PATH + "/$id");

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return UserResponseDto.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  static Future<UserResponseDto?> getSelfUser(String jwt) async {

    var uri = Uri.http(Constants.BACKEND_DOMAIN, Constants.USER_SERVICE_PATH + "/self");

    var headers = HttpUtils.bearerTokenHeaders(jwt);

    print(headers);

    final response = await http.get(
      uri,
      headers: headers,
    );

    var code = response.statusCode;

    if (code != 200) {
      print("Error while getting self user: $code");
      return null;
    }
    Map data = jsonDecode(response.body);

    return UserResponseDto.fromJson(data);
  }

}