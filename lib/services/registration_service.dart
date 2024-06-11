import 'package:push_notification/api/authentication_api.dart';
import 'package:push_notification/models/registration_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationService {

    final SharedPreferences preferences;

    RegistrationService({required this.preferences});

    static Future<bool> register(String username, String email, String password) async {
        return await AuthenticationApi.register(RegistrationRequest(
            username: username,
            userEmail: email,
            userPassword: password)
        );
    }
}