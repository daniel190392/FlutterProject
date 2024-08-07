import 'package:continental_app/domain/models/user_model.dart';
import 'package:continental_app/domain/respositories/respositories.dart';

class UserRepositoryMock implements UserRepository {
  bool getUserWasCalled = false;
  UserModel? getUserResult;
  bool updateUserWasCalled = false;
  bool updateUserResult = false;

  @override
  Future<UserModel> getUser(String userId) async {
    getUserWasCalled = true;
    if (getUserResult != null) {
      return getUserResult!;
    } else {
      throw Error();
    }
  }

  @override
  Future<bool> updateUser(String userId, Map<String, dynamic> body) async {
    updateUserWasCalled = true;
    return updateUserResult ? updateUserResult : throw Error();
  }
}
