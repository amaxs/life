import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import '../services/quest_service.dart';
import '../services/user_service.dart';
import '../models/user_profile.dart';
import '../models/quest.dart';
import '../notifications/notification_service.dart';
import 'add_quest_screen.dart';
import 'shop_screen.dart';
import 'inventory_screen.dart';
import '../theme.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<UserProfile> userProfile;
  late Future<List<Quest>> quests;

  @override
  void initState() {
    super.initState();
    final userService = Provider.of<UserService>(context, listen: false);
    userService.initUser();
    userProfile = userService.getUserProfile();
    _refreshQuests();
  }

  void _refreshQuests() {
    setState(() {
      quests = Provider.of<QuestService>(context, listen: false).getAllActiveQuests();
    });
  }

  Future<void> _removeQuest(Quest quest) async {
    final questService = Provider.of<QuestService>(context, listen: false);
    final userService = Provider.of<UserService>(context, listen: false);

    await questService.deleteQuest(quest.id!);

    final updatedUser = await userService.getUserProfile();
    updatedUser.xp -= quest.xp; // Lose XP when removing a quest
    await userService.updateUserProfile(updatedUser);

    setState(() {
      userProfile = userService.getUserProfile();
      _refreshQuests();
    });
  }

  Future<void> _validateQuest(Quest quest) async {
    final questService = Provider.of<QuestService>(context, listen: false);
    final userService = Provider.of<UserService>(context, listen: false);

    quest.isCompleted = true;
    await questService.updateQuest(quest);

    NotificationService().showNotification(
      quest.id!,
      'Quest Completed!',
      'You have completed the quest: ${quest.title}',
    );

    await userService.addXp(quest.xp);

    final updatedUser = await userService.getUserProfile();
    updatedUser.coins += quest.coins;
    await userService.updateUserProfile(updatedUser);

    setState(() {
      userProfile = userService.getUserProfile();
      _refreshQuests();
    });
  }

  void _showQuestDetails(BuildContext context, Quest quest) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: GameTheme.secondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          title: Text(quest.title, style: GameTheme.titleStyle),
          content: Container(
            decoration: GameTheme.dialogDecoration,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(quest.description, style: GameTheme.subtitleStyle),
                SizedBox(height: 10),
                Text('XP: ${quest.xp}', style: GameTheme.subtitleStyle),
                Text('Coins: ${quest.coins}', style: GameTheme.subtitleStyle),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close', style: TextStyle(color: GameTheme.highlightColor)),
            ),
            TextButton(
              onPressed: () {
                _validateQuest(quest);
                Navigator.of(context).pop();
              },
              child: Text('Complete', style: TextStyle(color: Colors.green)),
            ),
            TextButton(
              onPressed: () {
                _removeQuest(quest);
                Navigator.of(context).pop();
              },
              child: Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final questService = Provider.of<QuestService>(context);
    final userService = Provider.of<UserService>(context);

    return Scaffold(
      backgroundColor: GameTheme.backgroundColor,
      appBar: AppBar(
        title: Text('LiFE RPG', style: GameTheme.titleStyle),
        backgroundColor: GameTheme.primaryColor,
      ),
      body: FutureBuilder<UserProfile>(
        future: userProfile,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}', style: GameTheme.subtitleStyle));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No user profile data', style: GameTheme.subtitleStyle));
          }

          final user = snapshot.data!;
          print('User profile loaded: ${user.level}, ${user.xp}, ${user.coins}');  // Debug print

          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Container(
                        decoration: GameTheme.containerDecoration,
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text('STATUS', style: GameTheme.titleStyle),
                            SizedBox(height: 10),
                            Text('Level: ${user.level}', style: GameTheme.subtitleStyle),
                            Text('XP: ${user.xp}', style: GameTheme.subtitleStyle),
                            Text('Coins: ${user.coins}', style: GameTheme.subtitleStyle),
                            Text('XP for next level: ${user.xpForNextLevel()}', style: GameTheme.subtitleStyle),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('Quests in Progress', style: GameTheme.titleStyle),
                ),
                FutureBuilder<List<Quest>>(
                  future: quests,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}', style: GameTheme.subtitleStyle));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No quests available', style: GameTheme.subtitleStyle));
                    }

                    final quests = snapshot.data!;
                    final inProgressQuests = quests.where((quest) => !quest.isCompleted).toList();
                    print('In progress quests: ${inProgressQuests.length}');  // Debug print

                    return ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: inProgressQuests.length,
                      itemBuilder: (context, index) {
                        final quest = inProgressQuests[index];
                        return GestureDetector(
                          onTap: () => _showQuestDetails(context, quest),
                          child: Container(
                            decoration: GameTheme.containerDecoration,
                            padding: const EdgeInsets.all(16.0),
                            margin: const EdgeInsets.only(bottom: 16.0),
                            child: Text(quest.title, style: GameTheme.subtitleStyle),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: GameTheme.accentColor,
        children: [
          SpeedDialChild(
            child: Icon(Icons.list, color: Colors.white),
            label: 'Quests',
            backgroundColor: GameTheme.highlightColor,
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddQuestScreen()),
              );
              if (result == true) {
                _refreshQuests();  // Refresh quests when a new quest is added
              }
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.shop, color: Colors.white),
            label: 'Shop',
            backgroundColor: GameTheme.highlightColor,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ShopScreen()),
              );
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.inventory, color: Colors.white),
            label: 'Inventory',
            backgroundColor: GameTheme.highlightColor,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InventoryScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
