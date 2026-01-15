class Course {
  final String id;
  final String userId;
  final String courseName;
  final String colorCode;

  Course({
    required this.id,
    required this.userId,
    required this.courseName,
    required this.colorCode,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'course_name': courseName,
      'color_code': colorCode,
    };
  }

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      courseName: map['course_name'] as String,
      colorCode: map['color_code'] as String,
    );
  }

  Course copyWith({
    String? id,
    String? userId,
    String? courseName,
    String? colorCode,
  }) {
    return Course(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      courseName: courseName ?? this.courseName,
      colorCode: colorCode ?? this.colorCode,
    );
  }
}
