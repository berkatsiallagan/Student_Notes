class Note {
  final String id;
  final String userId;
  final String title;
  final String course;
  final String content;
  final DateTime dateCreated;
  final DateTime dateUpdated;
  final bool isFavorite;

  Note({
    required this.id,
    required this.userId,
    required this.title,
    required this.course,
    required this.content,
    required this.dateCreated,
    required this.dateUpdated,
    this.isFavorite = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'course': course,
      'content': content,
      'date_created': dateCreated.toIso8601String(),
      'date_updated': dateUpdated.toIso8601String(),
      'is_favorite': isFavorite ? 1 : 0,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      title: map['title'] as String,
      course: map['course'] as String,
      content: map['content'] as String,
      dateCreated: DateTime.parse(map['date_created'] as String),
      dateUpdated: DateTime.parse(map['date_updated'] as String),
      isFavorite: (map['is_favorite'] as int) == 1,
    );
  }

  Note copyWith({
    String? id,
    String? userId,
    String? title,
    String? course,
    String? content,
    DateTime? dateCreated,
    DateTime? dateUpdated,
    bool? isFavorite,
  }) {
    return Note(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      course: course ?? this.course,
      content: content ?? this.content,
      dateCreated: dateCreated ?? this.dateCreated,
      dateUpdated: dateUpdated ?? this.dateUpdated,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
