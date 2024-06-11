import 'constants.dart';

class HttpUtils {

  static Map<String, String> bearerTokenHeaders(String jwt){
    String bearerToken = "Bearer " + jwt;
    var headers = Map.of(Constants.HTTP_HEADERS);
    headers.addAll({
      "Authorization": bearerToken,
    });
    return headers;
  }

}