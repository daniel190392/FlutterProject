import 'package:continental_app/domain/respositories/respositories.dart';

class AuthenticationRepositoryMock implements AuthenticationRepository {
  bool getBoolWithWasCalled = false;
  bool getBoolWithResult = false;
  bool getStringWithWasCalled = false;
  String? getStringWithResult;
  bool setValueWithWasCalled = false;
  bool setValueWithSuccessResult = false;
  bool clearWasCalled = false;
  bool clearResult = false;

  @override
  Future<bool> getBoolWith(String key) async {
    getBoolWithWasCalled = true;
    return getBoolWithResult ? getBoolWithResult : throw Error();
  }

  @override
  Future<String> getStringWith(String key) async {
    getStringWithWasCalled = true;
    if (getStringWithResult != null) {
      return getStringWithResult!;
    } else {
      throw Error();
    }
  }

  @override
  Future<void> setValueWith(String key, Object value) async {
    setValueWithWasCalled = true;
    if (!setValueWithSuccessResult) {
      throw Error();
    }
    return;
  }

  @override
  Future<void> clear() async {
    clearWasCalled = true;
    if (!clearResult) {
      throw Error();
    }
    return;
  }
}
