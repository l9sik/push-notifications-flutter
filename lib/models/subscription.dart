class Subscription {

  final int id;
  final int userId;
  final String recipientToken;

  Subscription({
    required this.id,
    required this.userId,
    required this.recipientToken,
  });

  factory Subscription.fromJson(dynamic json){
    return Subscription(
        id: json['id'] as int,
        userId: json['userId'] as int,
        recipientToken: json['recipientToken'] as String,
    );
  }

  static List<Subscription> subscriptionsFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Subscription.fromJson(data);
    }).toList();
  }
}