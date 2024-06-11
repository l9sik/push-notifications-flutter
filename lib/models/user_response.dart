class UserResponseDto {
  final int id;
  final String username;
  final String email;

  UserResponseDto({
    required this.id,
    required this.username,
    required this.email,
  });

  factory UserResponseDto.fromJson(Map<dynamic, dynamic> json) {
    return UserResponseDto(
        id: json['id'] as int,
        username: json['login'] as String,
        email: json['email'] as String
    );
  }

  static List<UserResponseDto> subscriptionsFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return UserResponseDto.fromJson(data);
    }).toList();
  }
}