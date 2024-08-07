import 'package:continental_app/domain/respositories/respositories.dart';

import '../../../resources/contanst.dart';
import '../../models/models.dart';
import '../continental_data_base.dart';

class DBUserProfileRepository implements UserRepository {
  final ContinentalDataBase dataBaseProvider;

  DBUserProfileRepository({ContinentalDataBase? dataBaseProvider})
      : dataBaseProvider =
            dataBaseProvider ?? ContinentalDataBase.dataBaseProvider;

  Future<bool> insertUser(Map<String, dynamic> body) async {
    try {
      final database = await dataBaseProvider.database;
      await database.insert(ContinentalDataBase.userTable, body);
      return true;
    } catch (exception) {
      throw ErrorServiceModel(ErrorCode.genericError.message);
    }
  }

  @override
  Future<UserModel> getUser(String userId) async {
    try {
      final database = await dataBaseProvider.database;
      final jsonList = await database.query(
        ContinentalDataBase.userTable,
        where: 'id = ?',
        whereArgs: [userId],
      );
      final user = jsonList.first;
      return UserModel.fromMap(user);
    } on ArgumentError {
      throw ErrorServiceModel(ErrorCode.parseError.message);
    } catch (exception) {
      throw ErrorServiceModel(ErrorCode.genericError.message);
    }
  }

  @override
  Future<bool> updateUser(String userId, Map<String, dynamic> body) async {
    try {
      final database = await dataBaseProvider.database;
      await database.update(
        ContinentalDataBase.userTable,
        body,
        where: 'id = ?',
        whereArgs: [userId],
      );
      return true;
    } catch (exception) {
      throw ErrorServiceModel(ErrorCode.genericError.message);
    }
  }
}
