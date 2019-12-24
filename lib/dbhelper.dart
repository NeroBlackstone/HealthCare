import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'User.dart';

class DBHelper {
  static Database _db;
  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    var path = join(documentDirectory.path, 'database.db');
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE User(id INTEGER PRIMARY KEY,username TEXT,password TEXT)');
    await db.execute(
    'CREATE TABLE Time(id INTEGER PRIMARY KEY,hour INTEGER,minute INTEGER,'
        'medicine TEXT)');
  }

  void saveUser(User user) async {
    var dbClient = await db;
    await dbClient.transaction((txn) async => await txn.rawInsert(
        "INSERT INTO User(username,password) VALUES('${user.username}',"
        "'${user.password}')"));
  }

  void saveMedicineNotification(int hour,int minute,String medicine) async{
    var dbClient = await db;
    await dbClient.transaction((txn) async => await txn.rawInsert(
      "INSERT INTO Time(hour,minute,medicine) VALUES('$hour','$minute',"
          "'$medicine')"
    ));
  }

  Future<bool> isUserExist(User user) async {
    var dbClient = await db;
    var list = await dbClient.rawQuery(
        "SELECT * FROM User WHERE username='${user.username}' and password='${user.password}'");
    if (list.isEmpty)
      return false;
    else
      return true;
  }

  Future<List> allMedicineNotification() async {
    var dbClient=await db;
    return await dbClient.rawQuery('SELECT * FROM Time');
  }
}
