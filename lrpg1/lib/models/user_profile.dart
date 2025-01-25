class UserProfile {
  int level;
  double xp;
  double strengthXP;
  double intelligenceXP;
  double dexterityXP;
  double creativityXP;
  double staminaXP;
  double charismaXP;
  int coins;

  UserProfile({
    required this.level,
    this.xp = 0,
    this.strengthXP = 0,
    this.intelligenceXP = 0,
    this.dexterityXP = 0,
    this.creativityXP = 0,
    this.staminaXP = 0,
    this.charismaXP = 0,
    required this.coins,
  });

  // Method to add XP in various categories
  void addXP({
    required double strength,
    required double intelligence,
    required double dexterity,
    required double creativity,
    required double stamina,
    required double charisma,
  }) {
    strengthXP += strength;
    intelligenceXP += intelligence;
    dexterityXP += dexterity;
    creativityXP += creativity;
    staminaXP += stamina;
    charismaXP += charisma;

    // Update the general XP
    xp = keyXP;
  }

  // Method to calculate key XP
  double get keyXP {
    return (strengthXP + intelligenceXP + dexterityXP + creativityXP + staminaXP + charismaXP)/ 6.0;
  }

  // XP required to reach the next level
  int xpForNextLevel() {
    return level * 100; // Example: 100 XP per level
  }

  // Method to level up if XP exceeds the threshold
  void checkLevelUp() {
    while (xp >= xpForNextLevel()) {
      xp -= xpForNextLevel();
      level += 1;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'level': level,
      'xp': xp,
      'strengthXP': strengthXP,
      'intelligenceXP': intelligenceXP,
      'dexterityXP': dexterityXP,
      'creativityXP': creativityXP,
      'staminaXP': staminaXP,
      'charismaXP': charismaXP,
      'coins': coins,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      level: map['level'],
      xp: map['xp'],
      strengthXP: map['strengthXP'],
      intelligenceXP: map['intelligenceXP'],
      dexterityXP: map['dexterityXP'],
      creativityXP: map['creativityXP'],
      staminaXP: map['staminaXP'],
      charismaXP: map['charismaXP'],
      coins: map['coins'],
    );
  }
}
