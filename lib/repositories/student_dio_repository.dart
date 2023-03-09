import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '../models/students.dart';

class StudentDioRepository {
  Future<List<Students>> findAll() async {
    try {
      final studentsResult = await Dio().get('http://localhost:8080/students');

      return studentsResult.data
          .map<Students>((student) => Students.fromMap(student))
          .toList();
    } on DioError catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<Students> findById(int id) async {
    try {
      final studentsResult =
          await Dio().get('http://localhost:8080/students/$id');
      if (studentsResult.data == null) {
        throw Exception();
      }

      return Students.fromMap(studentsResult.data);
    } on DioError catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<void> insert(Students student) async {
    try {
      await Dio().post(
        'http://localhost:8080/students',
        data: student.toMap(),
      );
    } on DioError catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<void> update(Students student) async {
    try {
      await Dio().put(
        'http://localhost:8080/students/${student.id}',
        data: student.toMap(),
      );
    } on DioError catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<void> deleteById(int id) async {
    try {
      await Dio().delete('https://localhost:8080/students/$id');
    } on DioError catch (e) {
      print(e);
      throw Exception();
    }
  }
}
