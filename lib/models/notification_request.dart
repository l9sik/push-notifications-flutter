class NotificationRequest {

  final int userId;
  final String title;
  final String body;
  final String imageUrl;
  final Map<String, String> data;

  NotificationRequest({required this.userId, required this.title,
    required this.body, required this.imageUrl, required this.data});

  @override
  String toString() {
    // TODO: implement toString
    return "UserId: $userId, title: $title, body: $body, data: $data";
  }
}