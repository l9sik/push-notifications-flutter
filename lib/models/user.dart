class User {

  final int userId;
  final String username;
  final String email;

  User({required this.userId, required this.username, required this.email});

  factory User.fromJson(dynamic json){
    return User(
      userId: json['userId'] as int,
      username: json['username'] as String,
      email: json['email'] as String,
    );
  }

  static List<User> subscriptionsFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return User.fromJson(data);
    }).toList();
  }

}