import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/quest.dart';
import '../models/user_profile.dart';
import '../services/quest_service.dart';
import '../services/user_service.dart';
import '../theme.dart';
import '../data/available_quests.dart';

class AddQuestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final questService = Provider.of<QuestService>(context);
    final userService = Provider.of<UserService>(context);
    final allQuests = getAvailableQuests(); // Use the original list of quests
    final categorizedQuests = categorizeQuests(allQuests);

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
        return DefaultTabController(
          length: categorizedQuests.keys.length,
          child: Scaffold(
            backgroundColor: GameTheme.backgroundColor,
            appBar: AppBar(
              title: Text('Add New Quest', style: GameTheme.titleStyle),
              backgroundColor: GameTheme.primaryColor,
              iconTheme: const IconThemeData(
                color: Colors.white, // Set the color of the back arrow to white
              ),
              bottom: TabBar(
                isScrollable: true,
                // indicatorColor: Colors.white,
                // labelColor: Colors.white,
                // unselectedLabelColor: Colors.grey,
                tabs: categorizedQuests.keys
                    .map((category) => Tab(text: category))
                    .toList(),
              ),
            ),
            body: TabBarView(
              children: categorizedQuests.keys.map((category) {
                final quests = categorizedQuests[category]!
                    .where((quest) => quest.minLevel <= user.level)
                    .toList();

                return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: quests.length,
                  itemBuilder: (context, index) {
                    final quest = quests[index];
                    return ListTile(
                      title: Text(quest.title, style: GameTheme.subtitleStyle),
                      subtitle: Text(quest.description, style: GameTheme.subtitleStyle),
                      trailing: ElevatedButton(
                        onPressed: () async {
                          final newQuest = Quest(
                            title: quest.title,
                            description: quest.description,
                            strengthXP: quest.strengthXP,
                            intelligenceXP: quest.intelligenceXP,
                            dexterityXP: quest.dexterityXP,
                            creativityXP: quest.creativityXP,
                            staminaXP: quest.staminaXP,
                            charismaXP: quest.charismaXP,
                            coins: quest.coins,
                            isDaily: quest.isDaily,
                            isCompleted: quest.isCompleted,
                            isAvailable: false, // Mark it as unavailable after adding
                            minLevel: quest.minLevel,
                          );
                          int id = await questService.addQuest(newQuest);
                          print('New quest added with id: $id'); // Debug print

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
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
