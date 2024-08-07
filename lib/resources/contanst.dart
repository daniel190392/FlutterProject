import 'package:uuid/uuid.dart';

const _uuidV4 = Uuid();

class GeneratorUuid {
  final String _uuid;

  GeneratorUuid({String? identifier}) : _uuid = identifier ?? _uuidV4.v4();

  String get uuid => _uuid;
}

GeneratorUuid uuidGenerated = GeneratorUuid();

const String kIsFirstInstall = 'isFirstInstall';
const String kUserId = 'userIdentifier';

enum ErrorCode {
  parseError,
  genericError,
}

extension ErrorCodeExtension on ErrorCode {
  String get message {
    switch (this) {
      case ErrorCode.parseError:
        return 'Error parsing json';
      case ErrorCode.genericError:
        return 'Something bad happend, try again';
    }
  }
}

enum StorageKeys {
  isUserLogin,
  userId,
}
