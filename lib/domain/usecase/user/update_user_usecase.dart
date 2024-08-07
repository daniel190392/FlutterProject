import '../../models/models.dart';
import '../../respositories/respositories.dart';

abstract class UpdateUserUseCase {
  Future<bool> execute(String userId, UserModel user);
}

class DefaultUpdateUserUseCase implements UpdateUserUseCase {
  final UserRepository _repository;

  DefaultUpdateUserUseCase(repository) : _repository = repository;

  @override
  Future<bool> execute(String userId, UserModel user) async {
    return _repository.updateUser(userId, user.toMap());
  }
}
