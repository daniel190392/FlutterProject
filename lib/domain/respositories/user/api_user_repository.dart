import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../resources/contanst.dart';
import '../../models/models.dart';
import '../url_mixin.dart';
import 'user_repository.dart';

class APIUserProfileRepository with UriMixin implements UserRepository {
  final http.Client client;
  final headers = {
    'Content-Type': 'application/json',
  };

  APIUserProfileRepository(this.client);

  @override
  Future<UserModel> getUser(String userId) async {
    try {
      final url = getUri('user/$userId');
      var response = await client.get(url);
      final dynamic result = json.decode(response.body);
      return UserModel.fromMap(result);
    } catch (exception) {
      throw ErrorServiceModel(ErrorCode.genericError.message);
    }
  }

  @override
  Future<bool> updateUser(String userId, Map<String, dynamic> body) async {
    try {
      final url = getUri('user/$userId');
      var response = await client.patch(
        url,
        headers: headers,
        body: json.encode(body),
      );
      return response.statusCode == 200;
    } catch (exception) {
      throw ErrorServiceModel(ErrorCode.genericError.message);
    }
  }
}
