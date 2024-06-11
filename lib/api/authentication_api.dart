import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:push_notification/models/authentication.dart';
import 'package:push_notification/models/authentication_request.dart';
import 'package:push_notification/models/registration_request.dart';
import 'package:push_notification/utils/constants.dart';
import 'package:push_notification/utils/http_utils.dart';


class AuthenticationApi {

  static Future<Authentication> authenticate(AuthenticationRequest request) async {

    var uri = Uri.http(Constants.BACKEND_DOMAIN, Constants.AUTHENTICATION_SERVICE_PATH + "/token");


    final response = await http.post(
        uri,
        headers: Constants.HTTP_HEADERS,
        body: json.encode({
          'username': request.username,
          'userEmail': request.email,
          'password': request.password,
        })
    );

    var code = response.statusCode;
    Map data = jsonDecode(response.body);

    if (code != 200){
      String exceptionMessage;
      if (data.containsKey('message')){
        exceptionMessage = data['message'];
      } else {
        exceptionMessage = "Unexpected Error";
      }
      throw Exception(exceptionMessage);
    }

    return Authentication.fromJson(data);
  }

  static Future<bool> register(RegistrationRequest request) async {

    var uri = Uri.http(Constants.BACKEND_DOMAIN, Constants.AUTHENTICATION_SERVICE_PATH + "/register");



    final response = await http.post(
        uri,
        headers: Constants.HTTP_HEADERS,
        body: json.encode({
            'username': request.username,
            'userEmail': request.userEmail,
            'password': request.userPassword,
        })
    );

    var code = response.statusCode;
    return code == 201;
  }

  static Future<Authentication?> validToken(String jwt) async {

    var uri = Uri.http(Constants.BACKEND_DOMAIN, Constants.AUTHENTICATION_SERVICE_PATH + "/valid");

    var headers = HttpUtils.bearerTokenHeaders(jwt);


    final response = await http.get(
      uri,
      headers: headers,
    );

    var code = response.statusCode;

    if (code != 200){

      return null;
    }

    Map data = jsonDecode(response.body);

    return Authentication.fromJson(data);
  }

}