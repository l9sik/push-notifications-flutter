import 'package:push_notification/models/authentication.dart';
import 'package:push_notification/models/authentication_request.dart';
import 'package:push_notification/services/subscription_service.dart';
import 'package:push_notification/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:push_notification/api/authentication_api.dart';
import 'package:email_validator/email_validator.dart';

class AuthenticationService {

  final SharedPreferences preferences;

  AuthenticationService({required this.preferences});


  Future<String> getInitialState() async{

    //check if current device has token
    final token = preferences.getString('token');

    if (token == null){
      //if no then go to registration state

      return Constants.appState.STATE_REGISTRATION_PAGE;

    }
    //if yes check if it is valid
    var isValid = await this.isValid(token);

    if (!isValid){
      return Constants.appState.STATE_LOGIN_PAGE;
    }

    return Constants.appState.STATE_USER_PAGE;
  }

  Future<bool> isValid(String token) async{
    Authentication? authentication = await AuthenticationApi.validToken(token);
    if (authentication == null){
      return false;
    }
    //store authentication data;
    storeUserInfo(
        authentication.email,
        authentication.token,
        authentication.authorities
    );

    return true;
  }

  Future<bool> authenticate(String emailOrName, String password) async{
    bool isEmail = EmailValidator.validate(emailOrName);
    Authentication authentication;
    try {
      if (isEmail) {
        authentication =
        await AuthenticationApi.authenticate(AuthenticationRequest(
            null, emailOrName, password)
        );
      } else {
        authentication =
        await AuthenticationApi.authenticate(AuthenticationRequest(
            emailOrName, null, password)
        );
      }
    }on Exception catch (_){
      return false;
    }
    print(authentication);
    //store user data
    storeUserInfo(
        authentication.email,
        authentication.token,
        authentication.authorities
    );

    return true;
  }

  void storeUserInfo(String email, String token, List<String> authorities){

    preferences.setString(Constants.localStorage.EMAIL, email);
    preferences.setString(Constants.localStorage.TOKEN, token);
    preferences.setStringList(Constants.localStorage.AUTHORITIES, authorities);
    print("User data stored");
  }

}