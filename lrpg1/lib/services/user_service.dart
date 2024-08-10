import 'package:sqflite/sqflite.dart';
import '../database/db_helper.dart';
import '../models/user_profile.dart';

class UserService {
  Future<UserProfile> getUserProfile() async {
    final db = await DBHelper().database;
    final List<Map<String, dynamic>> maps = await db.query('user_profile');
    if (maps.isEmpty) {
      UserProfile defaultProfile = UserProfile(
        level: 1,
        xp: 0,
        coins: 0,
      );
      await db.insert('user_profile', defaultProfile.toMap());
      return defaultProfile;
    } else {
      return UserProfile.fromMap(maps.first);
    }
  }

  Future<void> initUser() async {
    final db = await DBHelper().database;
    final List<Map<String, dynamic>> maps = await db.query('user_profile');
    if (maps.isEmpty) {
      UserProfile defaultProfile = UserProfile(
        level: 1,
        xp: 0,
        coins: 0,
      );
      await db.insert('user_profile', defaultProfile.toMap());
    }
  }

  Future<int> updateUserProfile(UserProfile profile) async {
    final db = await DBHelper().database;
    return await db.update('user_profile', profile.toMap());
  }

  Future<void> addXp(int xp) async {
    final profile = await getUserProfile();
    profile.xp += xp;
    await updateUserProfile(profile);
  }
}
