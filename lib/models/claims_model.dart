import 'package:equatable/equatable.dart';

class Claim extends Equatable {
  final int userId;
  final int id;
  final String title;
  final String body;

  const Claim({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  // Factory constructor to create a Claim object from a JSON map.
  factory Claim.fromJson(Map<String, dynamic> json) {
    return Claim(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }

  @override
  List<Object> get props => [userId, id, title, body];
}
