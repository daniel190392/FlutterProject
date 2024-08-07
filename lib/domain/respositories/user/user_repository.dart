import '../../models/models.dart';

abstract class UserRepository {
  Future<UserModel> getUser(String userId);

  Future<bool> updateUser(String userId, Map<String, dynamic> body);
}
