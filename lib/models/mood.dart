import 'package:cloud_firestore/cloud_firestore.dart';

class Mood {
  final String id;
  final String userId;
  final Timestamp day;
  final Timestamp createdAt;
  final String notes;
  final String score;

  Mood({
    required this.id,
    required this.userId,
    required this.day,
    required this.createdAt,
    required this.notes,
    required this.score,
  });

  factory Mood.fromMap(String id, Map<String, dynamic> data) {
    return Mood(
      id: id,
      userId: data['userId'] as String? ?? '',
      day: data['day'] as Timestamp,
      createdAt: data['createdAt'] as Timestamp,
      notes: data['notes'] as String? ?? '',
      score: data['score'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'day': day,
      'createdAt': createdAt,
      'notes': notes,
      'score': score,
    };
  }
}
