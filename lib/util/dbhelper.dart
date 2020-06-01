import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:time_zone/models/timzone.dart';

class DbHelper {
  static final DbHelper _dbHelper = new DbHelper._internal();

  String tblTimeZone = 'timezoneTable';
  String id = "id";
  String region = "region";
  String city = "city";
  String timezone = "timezone";
  String abbrevation = "abbrevation";

  DbHelper._internal();

  factory DbHelper() {
    return _dbHelper;
  }
  static Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  Future<Database> initializeDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'timezoneTable.db';
    var dbTimeZone = await openDatabase(path, version: 1, onCreate: _createDb);
    return dbTimeZone;
  }

  // FutureOr<void> _createDb(Database db, int version) async {
  //   await db.execute("CREATE TABLE $tblTimeZone($id INTEGER PRIMARY KEY," +
  //       "$region TEXT, $city TEXT, $timezone TEXT,$abbrevation TEXT)");
  // }
  FutureOr<void> _createDb(Database db, int version) async {
    await db.execute("CREATE TABLE $tblTimeZone($id INTEGER PRIMARY KEY," +
        "$timezone TEXT)");
  }

  Future<int> insertTimeZone(TimeZone timeZone) async {
    Database db = await this.db;
    var result = await db.insert(tblTimeZone, timeZone.toMap());
    return result;
  }

  Future<List> getTimeZone() async {
    Database db = await this.db;
    var result =
        await db.rawQuery("SELECT * FROM $tblTimeZone ORDER BY $timezone ASC");
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.db;
    var result = Sqflite.firstIntValue(
        await db.rawQuery("SELECT count (*) FROM $tblTimeZone"));
    return result;
  }

  Future<int> deleteTimeZone(String zone) async {
    Database db = await this.db;
    var result = await db
        .rawDelete("DELETE FROM $tblTimeZone WHERE $timezone like '$zone'");
    return result;
  }
}
