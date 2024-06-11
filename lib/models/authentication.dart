import 'dart:convert';

class Authentication {

  final String status;
  final bool isAuthenticated;
  final String methodType;
  final String email;
  final List<String> authorities;
  final String token;

    Authentication({required this.status, required this.isAuthenticated,
      required this.methodType, required this.email, required this.authorities,
      required this.token});



    factory Authentication.fromJson(dynamic json){
      var authoritiesJson = json['authorities'] as List?;
      return Authentication(
          status: json['status'] as String,
          isAuthenticated: json['authenticated'] as bool,
          methodType: json['methodType'] as String,
          email: json['email'] as String,
          authorities: authoritiesJson != null ? List<String>.from(authoritiesJson) : List.empty(),
          token: json['token'] as String
      );
    }

    @override
  String toString() {
    // TODO: implement toString
    return "Email: $email, Authorities: $authorities, Token: $token";
  }
}