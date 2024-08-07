import '../../models/models.dart';
import '../../respositories/respositories.dart';

abstract class GetUserUseCase {
  Future<UserModel> execute(
    String userId,
    bool availableConnection,
  );
}

class DefaultGetUserUseCase implements GetUserUseCase {
  final UserRepository _apiRepository;
  final UserRepository _dbRepository;

  DefaultGetUserUseCase(apiRepository, dbRepository)
      : _apiRepository = apiRepository,
        _dbRepository = dbRepository;

  @override
  Future<UserModel> execute(
    String userId,
    bool availableConnection,
  ) async {
    if (availableConnection) {
      final user = await _apiRepository.getUser(userId);
      if (_dbRepository is DBUserProfileRepository) {
        return await _insertUser(_dbRepository, user);
      } else {
        return user;
      }
    } else {
      return _dbRepository.getUser(userId);
    }
  }

  Future<UserModel> _insertUser(
    DBUserProfileRepository repository,
    UserModel user,
  ) async {
    try {
      await repository.insertUser(user.toMap());
      return user;
    } catch (_) {
      return user;
    }
  }
}
