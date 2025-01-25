import 'package:sqflite/sqflite.dart';
import '../database/db_helper.dart';
import '../models/user_profile.dart';

class UserService {
  Future<UserProfile> getUserProfile() async {
    final db = await DBHelper().database;
    final List<Map<String, dynamic>> maps = await db.query('user_profile');
    if (maps.isEmpty) {
      // If no user profile exists, create a default one
      UserProfile defaultProfile = UserProfile(
        level: 1,
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

  Future<void> addXP(double strength, double intelligence, double dexterity, double creativity, double stamina, double charisma) async {
    final userProfile = await getUserProfile();
    userProfile.addXP(
      strength: strength,
      intelligence: intelligence,
      dexterity: dexterity,
      creativity: creativity,
      stamina: stamina,
      charisma: charisma,
    );
    userProfile.checkLevelUp();
    await updateUserProfile(userProfile);
  }

  Future<void> _checkForLevelUp(UserProfile userProfile) async {
    // Implement logic to check if the user should level up in any category
  }


}
