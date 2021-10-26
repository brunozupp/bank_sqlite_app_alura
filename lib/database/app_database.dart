import 'package:bank_sqlite_app_alura/database/dao/contact_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> createDatabase() async {

  final databasePath = await getDatabasesPath();

  final path = join(databasePath, 'bankapp.db');

  return await openDatabase(path, onCreate: (db, version) async {
    await db.execute(ContactDao.tableSql);
  }, version: 1,
    //onDowngrade: onDatabaseDowngradeDelete,
  );
}