class Mood {
  final String id;
  final DateTime day;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String notes;
  final String score;
  final String? photoUrl;

  Mood({
    required this.id,
    required this.day,
    required this.createdAt,
    required this.updatedAt,
    required this.notes,
    required this.score,
    this.photoUrl,
  });

  factory Mood.fromJson(Map<String, dynamic> data) {
    return Mood(
      id: data['id'] as String,
      day: DateTime.parse(data['day'] as String),
      createdAt: DateTime.parse(data['created_at'] as String),
      updatedAt: DateTime.parse(data['updated_at'] as String),
      notes: data['notes'] as String? ?? '',
      score: data['score'] as String,
      photoUrl: data['photo_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'day': '${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}',
      'notes': notes,
      'score': score,
      'photo_url': photoUrl,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
