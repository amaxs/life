class Quest {
  int? id;
  String title;
  String description;
  String theme;
  double xp;
  double strengthXP;
  double intelligenceXP;
  double dexterityXP;
  double creativityXP;
  double staminaXP;
  double charismaXP;
  int coins;
  bool isDaily;
  bool isCompleted;
  bool isAvailable;
  int minLevel;
  DateTime? startTime;
  Duration? duration;

  Quest({
    this.id,
    required this.title,
    required this.description,
    this.theme = "UNKNOWN",
    this.xp = 0.0,
    this.strengthXP = 0.0,
    this.intelligenceXP = 0.0,
    this.dexterityXP = 0.0,
    this.creativityXP = 0.0,
    this.staminaXP = 0.0,
    this.charismaXP = 0.0,
    required this.coins,
    required this.isDaily,
    required this.isCompleted,
    this.isAvailable = true,
    required this.minLevel,
    this.startTime,
    this.duration,
  });


  bool isOngoing() {
    if (startTime != null && duration != null) {
      return DateTime.now().isAfter(startTime!) &&
          DateTime.now().isBefore(startTime!.add(duration!));
    }
    return true;
  }

  bool isExpired() {
    if (startTime != null && duration != null) {
      return DateTime.now().isAfter(startTime!.add(duration!));
    }
    return false;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'theme': theme,
      'xp': xp,
      'strengthXP': strengthXP,
      'intelligenceXP': intelligenceXP,
      'dexterityXP': dexterityXP,
      'creativityXP': creativityXP,
      'staminaXP': staminaXP,
      'charismaXP': charismaXP,
      'coins': coins,
      'isDaily': isDaily ? 1 : 0,
      'isCompleted': isCompleted ? 1 : 0,
      'isAvailable': isAvailable ? 1 : 0,
      'minLevel': minLevel,
    };
  }

  factory Quest.fromMap(Map<String, dynamic> map) {
    return Quest(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      theme: map['theme'],
      xp: map['xp'],
      strengthXP: map['strengthXP'],
      intelligenceXP: map['intelligenceXP'],
      dexterityXP: map['dexterityXP'],
      creativityXP: map['creativityXP'],
      staminaXP: map['staminaXP'],
      charismaXP: map['charismaXP'],
      coins: map['coins'],
      isDaily: map['isDaily'] == 1,
      isCompleted: map['isCompleted'] == 1,
      isAvailable: map['isAvailable'] == 1,
      minLevel: map['minLevel'],
    );
  }
}
