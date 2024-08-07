import '../../models/models.dart';
import 'course_repository.dart';
import '../url_mixin.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../resources/resources.dart';

class APICourseRepository with UriMixin implements CourseRepository {
  final http.Client _client;
  final headers = {
    'Content-Type': 'application/json',
  };

  APICourseRepository(this._client);

  @override
  Future<bool> addCourse(Map<String, dynamic> body) async {
    try {
      final url = getUri('course');
      var response = await _client.post(
        url,
        headers: headers,
        body: json.encode(body),
      );
      return response.statusCode == 200;
    } catch (exception) {
      throw ErrorServiceModel(ErrorCode.genericError.message);
    }
  }

  @override
  Future<List<Object>> getCourses(Map<String, dynamic>? queries) async {
    try {
      final url = getUri('course');
      var response = await _client.get(url);
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((item) => CourseModel.fromMap(item)).toList();
    } on ArgumentError {
      throw ErrorServiceModel(ErrorCode.parseError.message);
    } catch (exception) {
      throw ErrorServiceModel(ErrorCode.genericError.message);
    }
  }

  @override
  Future<bool> updateCourse(String id, Map<String, dynamic> body) async {
    try {
      final url = getUri('course/$id');
      var response = await _client.patch(
        url,
        headers: headers,
        body: json.encode(body),
      );
      return response.statusCode == 200;
    } catch (exception) {
      throw ErrorServiceModel(ErrorCode.genericError.message);
    }
  }

  @override
  Future<bool> deleteCourse(String id) async {
    try {
      final url = getUri('course/$id');
      var response = await _client.delete(url);
      return response.statusCode == 200;
    } catch (exception) {
      throw ErrorServiceModel(ErrorCode.genericError.message);
    }
  }
}
