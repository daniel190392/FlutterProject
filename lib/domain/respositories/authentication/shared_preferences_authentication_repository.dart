import 'package:continental_app/domain/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'authentication_repository.dart';

class SharedPreferenceAuthenticationRepository
    implements AuthenticationRepository {
  static final SharedPreferenceAuthenticationRepository _instance =
      SharedPreferenceAuthenticationRepository._privateConstructor();

  factory SharedPreferenceAuthenticationRepository() => _instance;

  SharedPreferenceAuthenticationRepository._privateConstructor();

  @override
  Future<bool> getBoolWith(String key) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final result = sharedPreferences.getBool(key);
    if (result == null) {
      throw ErrorServiceModel('key not founded');
    } else {
      return result;
    }
  }

  @override
  Future<String> getStringWith(String key) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final result = sharedPreferences.getString(key);
    if (result == null) {
      throw ErrorServiceModel('key not founded');
    } else {
      return result;
    }
  }

  @override
  Future<void> setValueWith(String key, Object value) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    if (value is String) {
      sharedPreferences.setString(key, value);
    } else if (value is bool) {
      sharedPreferences.setBool(key, value);
    } else {
      throw ErrorServiceModel('value type not supported');
    }
    return;
  }

  @override
  Future<void> clear() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    return;
  }
}
