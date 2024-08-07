import '../../../resources/resources.dart';
import '../../respositories/respositories.dart';

abstract class IsAuthenticatedUseCase {
  Future<bool> execute();
}

class DefaultIsAuthenticatedUseCase implements IsAuthenticatedUseCase {
  final AuthenticationRepository _repository;

  DefaultIsAuthenticatedUseCase(repository) : _repository = repository;

  @override
  Future<bool> execute() async {
    try {
      return await _repository.getBoolWith(StorageKeys.isUserLogin.name);
    } catch (_) {
      return false;
    }
  }
}
