import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ContinentalDataBase {
  static final ContinentalDataBase dataBaseProvider = ContinentalDataBase();

  static const dataBaseName = 'continental_database.db';
  static const dataBaseVersion = 1;
  static const courseTable = 'Course';
  static const userTable = 'User';
  static var _dbPath = '';

  ContinentalDataBase();
  ContinentalDataBase.withDatabase(Database newDataBase)
      : _dataBase = newDataBase;

  Database? _dataBase;

  Future<Database> get database async {
    _dataBase ??= await _createDatabase();
    return _dataBase!;
  }

  Future close() async => _dataBase?.close();

  Future<void> deleteDatabase() => databaseFactory.deleteDatabase(_dbPath);

  Future<Database> _createDatabase() async {
    var directory = await getDatabasesPath();
    _dbPath = join(directory, dataBaseName);
    print('HERE ---------- DB PATH $_dbPath');
    return await openDatabase(
      _dbPath,
      version: dataBaseVersion,
      onCreate: onCreate,
    );
  }

  Future onCreate(Database db, int version) async {
    await _createCourseTable(db);
    await _createUserTable(db);
  }

  Future<void> _createCourseTable(Database db) async {
    await db.execute('''
      CREATE TABLE $courseTable (
        id TEXT PRIMARY KEY,
        name TEXT,
        category TEXT
      )
    ''');
  }

  Future<void> _createUserTable(Database db) async {
    await db.execute('''
      CREATE TABLE $userTable (
        id TEXT PRIMARY KEY,
        photo TEXT,
        name TEXT,
        address TEXT,
        latitude TEXT,
        longitude TEXT
      )
    ''');
  }
}
