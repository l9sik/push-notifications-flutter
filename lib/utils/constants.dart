class Constants {

  static final String BACKEND_DOMAIN = "192.168.100.70:8080";

  static final String AUTHENTICATION_SERVICE_PATH = "/auth";
  static final String SUBSCRIPTION_SERVICE_PATH = "/subscriptions";
  static final String USER_SERVICE_PATH = "/users";
  static final String TEST_SERVICE_PATH = "/test";


  static final Map<String, String> HTTP_HEADERS = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  static final String ROLE_ADMIN = "ROLE_ADMIN";

  static AppState appState = AppState();
  static LocalStorage localStorage = LocalStorage();

}

class AppState {
  String get STATE_REGISTRATION_PAGE => "/register";
  String get STATE_LOGIN_PAGE =>        "/login";
  String get STATE_USER_PAGE =>         "/user";
  String get STATE_ADMIN_PAGE =>        "/admin";
}

class LocalStorage{

  String get TOKEN => "token";
  String get EMAIL => "email";
  String get AUTHORITIES => "authorities";
  String get FCM_TOKEN => "fcmToken";
}