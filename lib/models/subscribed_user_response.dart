class SubscribedUserResponseDto {
  final int id;
  final String name;
  final String email;
  final int deviceCount;

  SubscribedUserResponseDto({
    required this.id,
    required this.name,
    required this.email,
    required this.deviceCount,
  });

  factory SubscribedUserResponseDto.fromJson(Map<String, dynamic> json) {
    return SubscribedUserResponseDto(
        id: json['id'],
        name: json['username'],
        email: json['email'],
        deviceCount: json['subscriptionsCount'],
    );
  }

  static List<SubscribedUserResponseDto> subscriptionsFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return SubscribedUserResponseDto.fromJson(data);
    }).toList();
  }
}