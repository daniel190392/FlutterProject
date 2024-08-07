import '../../../resources/resources.dart';
import '../../respositories/respositories.dart';

abstract class GetUserIdUseCase {
  Future<String> execute();
}

class DefaultGetUserIdUseCase implements GetUserIdUseCase {
  final AuthenticationRepository _repository;

  DefaultGetUserIdUseCase(repository) : _repository = repository;

  @override
  Future<String> execute() async {
    return await _repository.getStringWith(StorageKeys.userId.name);
  }
}
