import 'package:continental_app/domain/models/models.dart';
import 'package:flutter_keychain/flutter_keychain.dart';

import 'authentication_repository.dart';

class KeychainAuthenticationRepository implements AuthenticationRepository {
  static final KeychainAuthenticationRepository _instance =
      KeychainAuthenticationRepository._privateConstructor();

  factory KeychainAuthenticationRepository() => _instance;

  KeychainAuthenticationRepository._privateConstructor();

  @override
  Future<bool> getBoolWith(String key) async {
    final result = await FlutterKeychain.get(key: key);
    if (result == null) {
      throw ErrorServiceModel('key not founded');
    } else {
      return result == 'true' ? true : false;
    }
  }

  @override
  Future<String> getStringWith(String key) async {
    final result = await FlutterKeychain.get(key: key);
    if (result == null) {
      throw ErrorServiceModel('key not founded');
    } else {
      return result;
    }
  }

  @override
  Future<void> setValueWith(String key, Object value) async {
    String valueToSafe = '';
    if (value is String) {
      valueToSafe = value;
    } else if (value is bool) {
      valueToSafe = value ? 'true' : 'false';
    } else {
      throw ErrorServiceModel('value type not supported');
    }
    await FlutterKeychain.put(key: key, value: valueToSafe);
    return;
  }

  @override
  Future<void> clear() async {
    await FlutterKeychain.clear();
    return;
  }
}
