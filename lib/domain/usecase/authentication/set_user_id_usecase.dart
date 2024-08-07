import '../../../resources/resources.dart';
import '../../respositories/respositories.dart';

abstract class SetUserIdUseCase {
  Future<void> execute(String userId);
}

class DefaultSetUserIdUseCase implements SetUserIdUseCase {
  final AuthenticationRepository _repository;

  DefaultSetUserIdUseCase(repository) : _repository = repository;

  @override
  Future<void> execute(String userId) async {
    return await _repository.setValueWith(StorageKeys.userId.name, userId);
  }
}
