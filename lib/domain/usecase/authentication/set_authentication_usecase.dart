import '../../../resources/resources.dart';
import '../../respositories/respositories.dart';

abstract class SetAuthenticationUseCase {
  Future<void> execute(bool value);
}

class DefaultSetAuthenticationUseCase implements SetAuthenticationUseCase {
  final AuthenticationRepository _repository;

  DefaultSetAuthenticationUseCase(repository) : _repository = repository;

  @override
  Future<void> execute(bool value) async {
    return await _repository.setValueWith(StorageKeys.isUserLogin.name, value);
  }
}
