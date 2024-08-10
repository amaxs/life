import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/quest.dart';
import '../models/user_profile.dart';
import '../services/quest_service.dart';
import '../services/user_service.dart';
import '../theme.dart';

class AddQuestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final questService = Provider.of<QuestService>(context);
    final userService = Provider.of<UserService>(context);
    return FutureBuilder<UserProfile>(
      future: userService.getUserProfile(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}', style: GameTheme.subtitleStyle));
        } else if (!snapshot.hasData) {
          return Center(child: Text('No user profile data', style: GameTheme.subtitleStyle));
        }

        final user = snapshot.data!;
        return Scaffold(
          backgroundColor: GameTheme.backgroundColor,
          appBar: AppBar(
            title: Text('Add New Quest', style: GameTheme.titleStyle),
            backgroundColor: GameTheme.primaryColor,
          ),
          body: FutureBuilder<List<Quest>>(
            future: questService.getAllAvailableQuests(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}', style: GameTheme.subtitleStyle));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No quests available', style: GameTheme.subtitleStyle));
              }

              final availableQuests = snapshot.data!.where((quest) => quest.minLevel <= user.level).toList();
              print('Available quests for user level ${user.level}: ${availableQuests.length}');  // Debug print

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: availableQuests.length,
                      itemBuilder: (context, index) {
                        final quest = availableQuests[index];
                        return ListTile(
                          title: Text(quest.title, style: GameTheme.subtitleStyle),
                          subtitle: Text(quest.description, style: GameTheme.subtitleStyle),
                          trailing: ElevatedButton(
                            onPressed: () async {
                              final newQuest = Quest(
                                title: quest.title,
                                description: quest.description,
                                xp: quest.xp,
                                coins: quest.coins,
                                isDaily: quest.isDaily,
                                isCompleted: quest.isCompleted,
                                isAvailable: false, // Mark it as unavailable after adding
                                minLevel: quest.minLevel,
                              );
                              int id = await questService.addQuest(newQuest);
                              print('New quest added with id: $id');  // Debug print
                              Navigator.pop(context, true); // Return true to indicate a new quest was added
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: GameTheme.highlightColor,
                              foregroundColor: Colors.white,
                            ),
                            child: Text('Add', style: TextStyle(color: Colors.white)),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: GameTheme.highlightColor,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                      ),
                      child: Text('Return', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
