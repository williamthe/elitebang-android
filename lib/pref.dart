import 'package:prototype_litbang/mysettings.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class PrefService {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();

    return openDatabase(
      join(path, 'litbang.db'),
      onCreate: (database, version) async {
        await database.execute(
            "CREATE TABLE prefs(id INTEGER PRIMARY KEY AUTOINCREMENT,"
                "nama TEXT NOT NULL, font VARCHAR(200))"
        );
      },
      version: 1,
    );
  }

  // Future<int> createItem(MySettings set) async {
  //   int result = 0;
  //   final Database db = await initializeDB();
  //   final id = await db.insert(
  //       'Notes', set.toMap(),
  //       conflictAlgorithm: ConflictAlgorithm.replace);
  //   return 0;
  // }

  // Future<List<MySettings>> getItems() async {
  // final db = await PrefService.initizateDb();
  // final List<Map<String, Object?>> queryResult =
  // await db.query('Notes', orderBy: NoteColumn.createdAt);
  // return queryResult.map((e) => Note.fromMap(e)).toList();
  // }

}