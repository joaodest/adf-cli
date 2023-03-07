// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Courses {
  final int id;
  final String nameCourse;
  final bool isStudent;

  Courses({
    required this.id,
    required this.nameCourse,
    required this.isStudent,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "nameCourse": nameCourse,
      "isStudent": isStudent,
    };
  }

  String toJson() => jsonEncode(toMap());

  factory Courses.fromMap(Map<String, dynamic> map) {
    return Courses(
        id: map['id'] ?? 0,
        nameCourse: map['name'] ?? '',
        isStudent: map['isStudent'] ?? false);
  }

  factory Courses.fromJson(String json) => Courses.fromJson(jsonDecode(json));
}
