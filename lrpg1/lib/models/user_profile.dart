class UserProfile {
  int level;
  int xp;
  int coins;

  UserProfile({
    required this.level,
    required this.xp,
    required this.coins,
  });

  int xpForNextLevel() {
    return level * 100; // Example: 100 XP needed per level
  }

  Map<String, dynamic> toMap() {
    return {
      'level': level,
      'xp': xp,
      'coins': coins,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      level: map['level'],
      xp: map['xp'],
      coins: map['coins'],
    );
  }
}
