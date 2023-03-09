// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class City {
  final int id;
  final String cityName;
  City({
    required this.id,
    required this.cityName,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": cityName,
    };
  }

  String toJson() => jsonEncode(toMap());

  factory City.fromMap(Map<String, dynamic> map) {
    return City(
      id: map['id'] ?? 0,
      cityName: map['name'] ?? '',
    );
  }

  factory City.fromJson(String json) => City.fromMap(jsonDecode(json));
}
