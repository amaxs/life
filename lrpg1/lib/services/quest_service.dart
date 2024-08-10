import 'package:sqflite/sqflite.dart';
import '../database/db_helper.dart';
import '../models/quest.dart';

class QuestService {
  Future<int> addQuest(Quest quest) async {
    final db = await DBHelper().database;
    final data = quest.toMap();

    // Ensure that `id` is not included if it's null
    data.remove('id');

    int result = await db.insert('quests', data);
    print('New quest added with id: $result');  // Debug print
    return result;
  }

  Future<List<Quest>> getAllAvailableQuests() async {
    final db = await DBHelper().database;
    final List<Map<String, dynamic>> maps = await db.query('quests', where: 'isAvailable = 1');
    return List.generate(maps.length, (i) => Quest.fromMap(maps[i]));
  }

  Future<List<Quest>> getAllActiveQuests() async {
    final db = await DBHelper().database;
    final List<Map<String, dynamic>> maps = await db.query('quests', where: 'isAvailable = 0 AND isCompleted = 0');
    return List.generate(maps.length, (i) => Quest.fromMap(maps[i]));
  }

  Future<int> deleteQuest(int id) async {
    final db = await DBHelper().database;
    return await db.delete(
      'quests',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateQuest(Quest quest) async {
    final db = await DBHelper().database;
    return await db.update(
      'quests',
      quest.toMap(),
      where: 'id = ?',
      whereArgs: [quest.id],
    );
  }
}
