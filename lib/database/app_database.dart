import 'package:bank_sqlite_app_alura/models/contact.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> createDatabase() async {

  final databasePath = await getDatabasesPath();

  final path = join(databasePath, 'bankapp.db');

  return await openDatabase(path, onCreate: (db, version) async {

    await db.execute('''
      CREATE TABLE contacts(
        id INTEGER PRIMARY KEY,
        name TEXT,
        account_number INTEGER
      )
    ''');
  }, version: 1);
}

Future<int> save(Contact contact) async {

  final db = await createDatabase();

  return await db.insert('contacts', contact.toMap());
}

Future<List<Contact>> findAll() async {

  final db = await createDatabase();

  final queryResult = await db.query('contacts');

  final list = queryResult.map((e) => Contact.fromMap(e)).toList();

  return list;
}