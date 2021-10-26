import 'package:bank_sqlite_app_alura/database/app_database.dart';
import 'package:bank_sqlite_app_alura/models/contact.dart';

class ContactDao {

  static const String tableSql = '''
      CREATE TABLE $_tableName(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,
        account_number INTEGER
      )
    ''';

  static const String _tableName = 'contacts';
  
  Future<int> save(Contact contact) async {

    final db = await createDatabase();

    var map = contact.toMap();
    map.remove("id");

    return await db.insert(_tableName, map);
  }

  Future<List<Contact>> findAll() async {

    final db = await createDatabase();

    final queryResult = await db.query(_tableName);

    final list = queryResult.map((e) => Contact.fromMap(e)).toList();

    return list;
  }
}