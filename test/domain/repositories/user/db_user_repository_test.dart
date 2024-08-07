import 'package:continental_app/domain/models/models.dart';
import 'package:continental_app/domain/respositories/continental_data_base.dart';
import 'package:continental_app/domain/respositories/respositories.dart';
import 'package:continental_app/resources/resources.dart';
import 'package:test/test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  late DBUserProfileRepository sut;
  late ContinentalDataBase dataBaseProvider;
  late Database dataBase;

  setUp(() {
    return Future(() async {
      sqfliteFfiInit();
      dataBase = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
      dataBaseProvider = ContinentalDataBase.withDatabase(dataBase);
      await dataBaseProvider.onCreate(dataBase, 1);
      sut = DBUserProfileRepository(dataBaseProvider: dataBaseProvider);
    });
  });

  tearDown(() {
    dataBase.close();
  });

  const userDummy = UserModel(
    userId: 'userId',
    name: 'name',
    latitude: 0,
    longitude: 0,
    address: 'address',
  );

  group('User Table', () {
    test('Insert user', () async {
      try {
        // WHEN
        final result = await sut.insertUser(userDummy.toMap());
        // THEN
        expect(result, true);
      } catch (error) {
        fail('Not expected error');
      }
    });

    test('Insert user with database closed', () async {
      // WHEN
      try {
        await dataBase.close();
        await sut.insertUser(userDummy.toMap());
        fail('Expected error');
      } catch (error) {
        // THEN
        expect(error is ErrorServiceModel, true);
        final message = (error as ErrorServiceModel).message;
        expect(message, ErrorCode.genericError.message);
      }
    });

    test('Get User', () async {
      // GIVEN
      await sut.insertUser(userDummy.toMap());
      // WHEN
      final dataFromBD = await sut.getUser(userDummy.userId);
      // THEN
      expect(dataFromBD, userDummy);
    });

    test('Get User with database closed', () async {
      // GIVEN
      await sut.insertUser(userDummy.toMap());
      // WHEN
      try {
        await dataBase.close();
        await sut.getUser(userDummy.userId);
        fail('Expected error');
      } catch (error) {
        // THEN
        expect(error is ErrorServiceModel, true);
        final message = (error as ErrorServiceModel).message;
        expect(message, ErrorCode.genericError.message);
      }
    });

    test('Update user', () async {
      // GIVEN
      await sut.insertUser(userDummy.toMap());
      // WHEN
      final newUser = userDummy.copyWith(name: 'name2');
      await sut.updateUser(userDummy.userId, newUser.toMap());
      final dataFromBD = await sut.getUser(userDummy.userId);
      // THEN
      expect(dataFromBD, newUser);
    });

    test('Update Course with database closed', () async {
      // GIVEN
      await sut.insertUser(userDummy.toMap());
      // WHEN
      try {
        await dataBase.close();
        final newUser = userDummy.copyWith(name: 'name2');
        await sut.updateUser(userDummy.userId, newUser.toMap());
        fail('Expected error');
      } catch (error) {
        // THEN
        expect(error is ErrorServiceModel, true);
        final message = (error as ErrorServiceModel).message;
        expect(message, ErrorCode.genericError.message);
      }
    });
  });
}
