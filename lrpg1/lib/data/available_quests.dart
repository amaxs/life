import '../models/quest.dart';
import 'dart:math';
import 'dart:async';

List<Quest> getAvailableQuests() {
  return [
    // Health and Wellness Quests
    Quest(
      title: 'Walk 2000 steps',
      description: 'Walk 2000 steps today.',
      theme: 'Health and Wellness',
      strengthXP: 0.5,
      staminaXP: 0.5,
      creativityXP: 0.0,
      charismaXP: 0.0,
      coins: 1,
      isDaily: true,
      isCompleted: false,
      minLevel: 1,
    ),
    Quest(
      title: 'Drink 4 glasses of water',
      description: 'Stay hydrated by drinking at least 4 glasses of water today.',
      theme: 'Health and Wellness',
      strengthXP: 0.2,
      staminaXP: 0.3,
      creativityXP: 0.0,
      charismaXP: 0.0,
      coins: 1,
      isDaily: true,
      isCompleted: false,
      minLevel: 1,
    ),
    Quest(
      title: 'Meditate for 5 minutes',
      description: 'Spend 5 minutes meditating to relax your mind.',
      theme: 'Health and Wellness',
      strengthXP: 0.0,
      staminaXP: 0.2,
      creativityXP: 0.2,
      charismaXP: 0.2,
      coins: 1,
      isDaily: true,
      isCompleted: false,
      minLevel: 2,
    ),
    Quest(
      title: 'Do 10 push-ups',
      description: 'Complete 10 push-ups today.',
      theme: 'Health and Wellness',
      strengthXP: 0.6,
      staminaXP: 0.5,
      creativityXP: 0.0,
      charismaXP: 0.0,
      coins: 2,
      isDaily: true,
      isCompleted: false,
      minLevel: 3,
    ),
    Quest(
      title: 'Sleep for 8 hours',
      description: 'Get at least 8 hours of sleep tonight to recharge your body and mind.',
      theme: 'Health and Wellness',
      strengthXP: 0.0,
      staminaXP: 0.6,
      creativityXP: 0.0,
      charismaXP: 0.0,
      coins: 1,
      isDaily: true,
      isCompleted: false,
      minLevel: 4,
    ),
    Quest(
      title: 'Walk 5000 steps',
      description: 'Walk 5000 steps today.',
      theme: 'Health and Wellness',
      strengthXP: 0.7,
      staminaXP: 0.6,
      creativityXP: 0.0,
      charismaXP: 0.0,
      coins: 2,
      isDaily: true,
      isCompleted: false,
      minLevel: 5,
    ),
    Quest(
      title: 'Drink 8 glasses of water',
      description: 'Drink at least 8 glasses of water today to stay fully hydrated.',
      theme: 'Health and Wellness',
      strengthXP: 0.3,
      staminaXP: 0.3,
      creativityXP: 0.0,
      charismaXP: 0.0,
      coins: 1,
      isDaily: true,
      isCompleted: false,
      minLevel: 5,
    ),
    Quest(
      title: 'Walk 8000 steps',
      description: 'Walk 8000 steps today.',
      theme: 'Health and Wellness',
      strengthXP: 1.0,
      staminaXP: 0.8,
      creativityXP: 0.0,
      charismaXP: 0.0,
      coins: 3,
      isDaily: true,
      isCompleted: false,
      minLevel: 10,
    ),
    Quest(
      title: 'Practice Gratitude',
      description: 'Write down three things you are grateful for today.',
      theme: 'Health and Wellness',
      strengthXP: 0.0,
      staminaXP: 0.0,
      creativityXP: 0.3,
      charismaXP: 0.5,
      coins: 2,
      isDaily: true,
      isCompleted: false,
      minLevel: 3,
    ),
    Quest(
      title: 'Stretch for 10 minutes',
      description: 'Spend 10 minutes stretching to improve your flexibility.',
      theme: 'Health and Wellness',
      strengthXP: 0.1,
      staminaXP: 0.3,
      creativityXP: 0.0,
      charismaXP: 0.1,
      coins: 1,
      isDaily: true,
      isCompleted: false,
      minLevel: 4,
    ),

    // Nutrition Quests
    Quest(
      title: 'Eat a fruit',
      description: 'Eat at least one fruit today.',
      theme: 'Nutrition',
      strengthXP: 0.2,
      staminaXP: 0.1,
      creativityXP: 0.0,
      charismaXP: 0.0,
      coins: 1,
      isDaily: true,
      isCompleted: false,
      minLevel: 1,
    ),
    Quest(
      title: 'Have a salad',
      description: 'Include a salad in one of your meals today.',
      theme: 'Nutrition',
      strengthXP: 0.2,
      staminaXP: 0.2,
      creativityXP: 0.0,
      charismaXP: 0.0,
      coins: 1,
      isDaily: true,
      isCompleted: false,
      minLevel: 2,
    ),
    Quest(
      title: 'No sugar today',
      description: 'Avoid all sugary foods and drinks today.',
      theme: 'Nutrition',
      strengthXP: 0.3,
      staminaXP: 0.4,
      creativityXP: 0.0,
      charismaXP: 0.0,
      coins: 2,
      isDaily: false,
      isCompleted: false,
      minLevel: 4,
    ),

    // Skill Development Quests
    Quest(
      title: 'Read for 15 minutes',
      description: 'Read a book or an article for 15 minutes.',
      theme: 'Skill Development',
      strengthXP: 0.0,
      staminaXP: 0.1,
      creativityXP: 0.2,
      charismaXP: 0.3,
      coins: 1,
      isDaily: true,
      isCompleted: false,
      minLevel: 2,
    ),
    Quest(
      title: 'Learn a new word',
      description: 'Learn and use a new word today.',
      theme: 'Skill Development',
      strengthXP: 0.0,
      staminaXP: 0.1,
      creativityXP: 0.2,
      charismaXP: 0.2,
      coins: 1,
      isDaily: true,
      isCompleted: false,
      minLevel: 1,
    ),
    Quest(
      title: 'Practice a hobby',
      description: 'Spend 30 minutes practicing a hobby like drawing or playing an instrument.',
      theme: 'Skill Development',
      strengthXP: 0.0,
      staminaXP: 0.0,
      creativityXP: 0.5,
      charismaXP: 0.3,
      coins: 2,
      isDaily: false,
      isCompleted: false,
      minLevel: 3,
    ),

    // Productivity Quests
    Quest(
      title: 'Plan your day',
      description: 'Spend 10 minutes planning your tasks for the day.',
      theme: 'Productivity',
      strengthXP: 0.0,
      staminaXP: 0.0,
      creativityXP: 0.2,
      charismaXP: 0.3,
      coins: 1,
      isDaily: true,
      isCompleted: false,
      minLevel: 1,
    ),
    Quest(
      title: 'Complete 3 tasks',
      description: 'Finish 3 tasks from your to-do list today.',
      theme: 'Productivity',
      strengthXP: 0.0,
      staminaXP: 0.0,
      creativityXP: 0.3,
      charismaXP: 0.2,
      coins: 2,
      isDaily: false,
      isCompleted: false,
      minLevel: 2,
    ),
    Quest(
      title: 'Declutter your workspace',
      description: 'Clean and organize your workspace.',
      theme: 'Productivity',
      strengthXP: 0.0,
      staminaXP: 0.0,
      creativityXP: 0.2,
      charismaXP: 0.2,
      coins: 2,
      isDaily: false,
      isCompleted: false,
      minLevel: 3,
    ),

    // Learning Quests
    Quest(
      title: 'Watch an educational video',
      description: 'Watch a video that teaches you something new.',
      theme: 'Learning',
      strengthXP: 0.0,
      staminaXP: 0.0,
      creativityXP: 0.3,
      charismaXP: 0.2,
      coins: 1,
      isDaily: false,
      isCompleted: false,
      minLevel: 1,
    ),
    Quest(
      title: 'Take a quiz',
      description: 'Test your knowledge by taking a short quiz.',
      theme: 'Learning',
      strengthXP: 0.0,
      staminaXP: 0.0,
      creativityXP: 0.4,
      charismaXP: 0.2,
      coins: 2,
      isDaily: false,
      isCompleted: false,
      minLevel: 2,
    ),

    // Creativity Quests
    Quest(
      title: 'Draw something',
      description: 'Spend 10 minutes drawing or doodling.',
      theme: 'Creativity',
      strengthXP: 0.0,
      staminaXP: 0.0,
      creativityXP: 0.3,
      charismaXP: 0.2,
      coins: 2,
      isDaily: false,
      isCompleted: false,
      minLevel: 1,
    ),
    Quest(
      title: 'Write a journal entry',
      description: 'Write about your day or your thoughts in a journal.',
      theme: 'Creativity',
      strengthXP: 0.0,
      staminaXP: 0.0,
      creativityXP: 0.4,
      charismaXP: 0.3,
      coins: 2,
      isDaily: true,
      isCompleted: false,
      minLevel: 2,
    ),

    // Family Quests
    Quest(
      title: 'Call a family member',
      description: 'Call or visit a family member you haven’t spoken to in a while.',
      theme: 'Family',
      strengthXP: 0.0,
      staminaXP: 0.0,
      creativityXP: 0.2,
      charismaXP: 0.5,
      coins: 2,
      isDaily: false,
      isCompleted: false,
      minLevel: 1,
    ),
    Quest(
      title: 'Spend time with family',
      description: 'Spend at least 30 minutes with your family.',
      theme: 'Family',
      strengthXP: 0.0,
      staminaXP: 0.0,
      creativityXP: 0.3,
      charismaXP: 0.4,
      coins: 2,
      isDaily: false,
      isCompleted: false,
      minLevel: 2,
    ),

    // Community Quests
    Quest(
      title: 'Help a neighbor',
      description: 'Offer help to a neighbor or someone in need.',
      theme: 'Community',
      strengthXP: 0.2,
      staminaXP: 0.2,
      creativityXP: 0.2,
      charismaXP: 0.4,
      coins: 3,
      isDaily: false,
      isCompleted: false,
      minLevel: 2,
    ),
    Quest(
      title: 'Volunteer',
      description: 'Spend time volunteering for a cause you care about.',
      theme: 'Community',
      strengthXP: 0.3,
      staminaXP: 0.3,
      creativityXP: 0.3,
      charismaXP: 0.5,
      coins: 5,
      isDaily: false,
      isCompleted: false,
      minLevel: 5,
    ),

    // Savings Quests
    Quest(
      title: 'Save \$5',
      description: 'Set aside \$5 in your savings today.',
      theme: 'Savings',
      strengthXP: 0.0,
      staminaXP: 0.0,
      creativityXP: 0.1,
      charismaXP: 0.2,
      coins: 1,
      isDaily: false,
      isCompleted: false,
      minLevel: 1,
    ),
    Quest(
      title: 'Avoid unnecessary spending',
      description: 'Go through the day without spending on anything unnecessary.',
      theme: 'Savings',
      strengthXP: 0.1,
      staminaXP: 0.1,
      creativityXP: 0.2,
      charismaXP: 0.3,
      coins: 2,
      isDaily: false,
      isCompleted: false,
      minLevel: 2,
    ),

    // Debugging Quests (for testing and leveling up)
    Quest(
      title: 'Debug test XP',
      description: 'Level up test.',
      theme: 'Other',
      strengthXP: 8.0,
      staminaXP: 7.0,
      creativityXP: 8.0,
      charismaXP: 9.0,
      coins: 2,
      isDaily: false,
      isCompleted: false,
      minLevel: 0,
    ),
    Quest(
      title: 'Debug test XP 100',
      description: 'Level up test.',
      theme: 'Other',
      strengthXP: 0.0,
      staminaXP: 0.0,
      creativityXP: 0.0,
      charismaXP: 600.0,
      coins: 2,
      isDaily: false,
      isCompleted: false,
      minLevel: 0,
    ),
  ];
}


Map<String, List<Quest>> categorizeQuests(List<Quest> quests) {
  Map<String, List<Quest>> categorizedQuests = {
    'Health and Wellness': [],
    'Nutrition': [],
    'Skill Development': [],
    'Productivity': [],
    'Learning': [],
    'Creativity': [],
    'Family': [],
    'Community': [],
    'Savings': [],
    'Other': [],
  };

  for (var quest in quests) {
    String lowerTitle = quest.theme.toLowerCase(); // Convert title to lowercase

    if (lowerTitle.contains('health')) {
      categorizedQuests['Health and Wellness']!.add(quest);
    } else if (lowerTitle.contains('nutrition')) {
      categorizedQuests['Nutrition']!.add(quest);
    } else if (lowerTitle.contains('skill')) {
      categorizedQuests['Skill Development']!.add(quest);
    } else if (lowerTitle.contains('productivity')) {
      categorizedQuests['Productivity']!.add(quest);
    } else if (lowerTitle.contains('learning')) {
      categorizedQuests['Learning']!.add(quest);
    } else if (lowerTitle.contains('creativity')) {
      categorizedQuests['Creativity']!.add(quest);
    } else if (lowerTitle.contains('family')) {
      categorizedQuests['Family']!.add(quest);
    } else if (lowerTitle.contains('community')) {
      categorizedQuests['Community']!.add(quest);
    } else if (lowerTitle.contains('saving')) {
      categorizedQuests['Savings']!.add(quest);
    } else {
      categorizedQuests['Other']!.add(quest);
    }
  }
  //
  // // Remove empty arrays
  // categorizedQuests.removeWhere((key, value) => value.isEmpty);
  // // Print the keys after removing empty arrays
  // print("Categories after removing empty lists: ${categorizedQuests.keys.toList()}");



  return categorizedQuests;
}


Quest generateRandomTimedQuest() {
  final random = Random();
  final now = DateTime.now();

  // Define a list of possible timed quests
  List<Quest> possibleQuests = [
    Quest(
      title: 'Quick Jog',
      description: 'Go for a 15-minute jog.',
      theme: 'Health and Wellness',
      strengthXP: 0.5,
      staminaXP: 0.6,
      coins: 2,
      isDaily: false,
      isCompleted: false,
      minLevel: 1,
      startTime: now,
      duration: Duration(minutes: 15), // 15 minutes to complete
    ),
    Quest(
      title: 'Flash Study Session',
      description: 'Study a topic for 10 minutes.',
      theme: 'Health and Wellness',
      intelligenceXP: 0.4,
      coins: 2,
      isDaily: false,
      isCompleted: false,
      minLevel: 1,
      startTime: now,
      duration: Duration(minutes: 10),
    ),
    // Add more timed quests here
  ];

  return possibleQuests[random.nextInt(possibleQuests.length)];
}

void addRandomTimedQuest(List<Quest> questList) {
  Quest newTimedQuest = generateRandomTimedQuest();
  if (!questList.any((quest) => quest.title == newTimedQuest.title)) {
    questList.add(newTimedQuest);
  }
}