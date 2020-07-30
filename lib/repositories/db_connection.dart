import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_migration/sqflite_migration.dart';

final initialScript = [
  '''
create table categories (
  id INTEGER PRIMARY KEY,
  name TEXT,
  description TEXT,
  )
''',
  '''
create table task (
  id INTEGER PRIMARY KEY,
  description TEXT,
  categories_id integer not null,
  CONSTRAINT fk_categories
    FOREIGN KEY (categories_id)
    REFERENCES categories(id)
);
'''
];

final migrations = [
  '''
  alter table task add column data TEXT;
  '''
];

final config = MigrationConfig(
    initializationScript: initialScript, migrationScripts: migrations);

class DatabaseConnection {
  setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db');
    return await openDatabaseWithMigration(path, config);
    // var database = await openDatabase(path,
    //     version: 1, onCreate: _onCreatingDatabase, onUpgrade: _onUpgrade);
    // return database;
  }

  // _onCreatingDatabase(Database db, int version) async {
  //   print(db.getVersion());
  //   return await db.execute(
  //       "CREATE TABLE categories (id INTEGER PRIMARY KEY, name TEXT,description TEXT)");
  // }

  // // To UPGRADE DATABASE TABLES  change the version number
  // void _onUpgrade(Database db, int oldVersion, int newVersion) async {
  //   if (oldVersion < newVersion) {
  //     return await db.execute("ALTER TABLE categories ADD COLUMN data TEXT;");
  //   }
  // }
}
