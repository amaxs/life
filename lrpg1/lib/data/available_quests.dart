import '../models/quest.dart';

List<Quest> getAvailableQuests() {
  return [
    Quest(
      title: 'Walk 2000 steps',
      description: 'Walk 2000 steps today',
      xp: 1,
      coins: 1,
      isDaily: true,
      isCompleted: false,
      minLevel: 1,
    ),
    Quest(
      title: 'Drink 4 glasses of water',
      description: 'Drink at least 4 glasses of water today',
      xp: 1,
      coins: 1,
      isDaily: true,
      isCompleted: false,
      minLevel: 1,
    ),
    // Add more quests as needed
  ];
}
