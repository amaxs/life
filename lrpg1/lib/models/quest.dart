class Quest {
  int? id;
  String title;
  String description;
  int xp;
  int coins;
  bool isDaily;
  bool isCompleted;
  bool isAvailable;  // New field to track if the quest is still available
  int minLevel;

  Quest({
    this.id,
    required this.title,
    required this.description,
    required this.xp,
    required this.coins,
    required this.isDaily,
    required this.isCompleted,
    this.isAvailable = true,  // Default to true when a quest is created
    required this.minLevel,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'xp': xp,
      'coins': coins,
      'isDaily': isDaily ? 1 : 0,
      'isCompleted': isCompleted ? 1 : 0,
      'isAvailable': isAvailable ? 1 : 0,  // Convert boolean to integer for database storage
      'minLevel': minLevel,
    };
  }

  factory Quest.fromMap(Map<String, dynamic> map) {
    return Quest(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      xp: map['xp'],
      coins: map['coins'],
      isDaily: map['isDaily'] == 1,
      isCompleted: map['isCompleted'] == 1,
      isAvailable: map['isAvailable'] == 1,  // Convert integer back to boolean
      minLevel: map['minLevel'],
    );
  }
}
