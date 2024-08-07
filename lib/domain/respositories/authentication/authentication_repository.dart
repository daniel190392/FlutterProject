abstract class AuthenticationRepository {
  Future<String> getStringWith(String key);

  Future<bool> getBoolWith(String key);

  Future<void> setValueWith(String key, Object value);

  Future<void> clear();
}
