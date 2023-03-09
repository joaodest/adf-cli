import 'dart:convert';

import 'package:dio/dio.dart';

import '../models/courses.dart';
import 'package:http/http.dart' as http;

class ProductRepository {
  Future<Courses> findByName(String name) async {
    try {
      final response =
          await Dio().get('http://localhost:8080/products', queryParameters: {
        'name': name,
      });

      if (response.data.isEmpty) {
        throw Exception('Produto não encontrado');
      }

      return Courses.fromMap(response.data.first);
    } on DioError {
      throw Exception();
    }
  }
}
