// student_db.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class StudentDB {
  static final StudentDB instance = StudentDB._init();
  static Database? _database;
  StudentDB._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('students.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE students(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        roll TEXT,
        dept TEXT
      )
    ''');
  }

  Future<int> insertStudent(Map<String, dynamic> data) async {
    final db = await instance.database;
    return await db.insert('students', data);
  }

  Future<List<Map<String, dynamic>>> getStudents() async {
    final db = await instance.database;
    return await db.query('students', orderBy: 'id DESC');
  }
}
