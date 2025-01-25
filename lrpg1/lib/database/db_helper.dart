import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/quest.dart';
import '../data/available_quests.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  static Database? _database;

  DBHelper._internal();

  factory DBHelper() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'life_rpg.db');
    return await openDatabase(
      path,
      version: 2, // Adjust version number if needed
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE quests (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        theme TEXT,
        xp REAL,
        strengthXP REAL,
        intelligenceXP REAL,
        dexterityXP REAL,
        creativityXP REAL,
        staminaXP REAL,
        charismaXP REAL,
        coins INTEGER,
        isDaily INTEGER,
        isCompleted INTEGER,
        isAvailable INTEGER DEFAULT 1,
        minLevel INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE user_profile (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        level INTEGER,
        xp REAL,
        strengthXP REAL,
        intelligenceXP REAL,
        dexterityXP REAL,
        creativityXP REAL,
        staminaXP REAL,
        charismaXP REAL,
        coins INTEGER
      )
    ''');

    // Insert predefined quests
    await _insertQuests(db);
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('ALTER TABLE quests ADD COLUMN isAvailable INTEGER DEFAULT 1');
    }
  }

  Future<void> _insertQuests(Database db) async {
    List<Quest> quests = getAvailableQuests();
    for (var quest in quests) {
      await db.insert('quests', quest.toMap());
    }
  }
}
