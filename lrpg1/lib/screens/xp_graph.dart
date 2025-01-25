import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:provider/provider.dart';
import '../services/user_service.dart';
import '../models/user_profile.dart';
import '../theme.dart';

import 'dart:math';

import 'dart:math';

String getXPDescription({
  required double intelligenceXP,
  required double dexterityXP,
  required double creativityXP,
  required double staminaXP,
  required double charismaXP,
}) {
  // Calculate the total XP
  double totalXP = intelligenceXP + dexterityXP + creativityXP + staminaXP + charismaXP;

  // Determine the weakest stat and its category
  Map<String, double> stats = {
    "Intelligence": intelligenceXP,
    "Dexterity": dexterityXP,
    "Creativity": creativityXP,
    "Stamina": staminaXP,
    "Charisma": charismaXP,
  };

  String weakestCategory = stats.entries.reduce((a, b) => a.value < b.value ? a : b).key;

  // Determine the base description based on total XP
  String description;
  if (totalXP < 100.0) {
    description = "Are you even trying? A snail could beat you at this.";
  } else if (totalXP < 200.0) {
    description = "You're making progress... at the speed of a sloth!";
  } else if (totalXP < 300.0) {
    description = "At least you're trying, but you've got a long way to go.";
  } else if (totalXP < 400.0) {
    description = "You're getting there, keep going!";
  } else if (totalXP < 500.0) {
    description = "Not bad, but I’ve seen better.";
  } else if (totalXP < 600.0) {
    description = "You’re on the right track, don’t slow down now!";
  } else if (totalXP < 700.0) {
    description = "Good job! You're actually showing some promise.";
  } else if (totalXP < 800.0) {
    description = "You're doing great! Keep it up.";
  } else if (totalXP < 900.0) {
    description = "Impressive! You're getting close to mastery.";
  } else {
    description = "Outstanding! You're a force to be reckoned with!";
  }

  // Critique map for each category with more sarcastic comments
  Map<String, List<String>> critiques = {
    "Intelligence": [
      "Maybe try reading a book or two?",
      "Did you even attend school? No judgment.",
      "You know, Wikipedia is a thing, right?",
      "At this rate, even Google can't save you.",
    ],
    "Dexterity": [
      "Ever thought of joining a yoga class?",
      "Two left feet? I see you’re staying consistent.",
      "Even a turtle moves with more grace.",
      "Have you tried not tripping over air?",
    ],
    "Creativity": [
      "Time to unlock that inner artist!",
      "Stick figures are a good start... for a 3-year-old.",
      "I've seen rocks with more creativity.",
      "Your imagination called; it needs a workout.",
    ],
    "Stamina": [
      "A few more laps around the block wouldn't hurt.",
      "Out of breath already? You barely started!",
      "You could try walking... slowly... maybe.",
      "Stamina level: Couch potato.",
    ],
    "Charisma": [
      "Maybe practice your smile in the mirror?",
      "You’ve got the charm of a wet blanket.",
      "Charisma? Never heard of it, huh?",
      "You might need a personality transplant.",
    ],
  };

  // 25% chance for the P.S. critique to appear
  Random random = Random();
  bool showCritique = random.nextInt(4) == 0; // 1 in 4 chance (25%)

  if (showCritique) {
    List<String> possibleCritiques = critiques[weakestCategory]!;
    String chosenCritique = possibleCritiques[random.nextInt(possibleCritiques.length)];
    description += "\nP.S. $chosenCritique";
  }

  return description;
}




class XPGraphScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'XP Distribution',
            style: GameTheme.titleStyle,
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: GameTheme.primaryColor,
        iconTheme: const IconThemeData(
          color: Colors.white, // Set the color of the back arrow to white
        ),
        automaticallyImplyLeading: true,
      ),
      backgroundColor: GameTheme.backgroundColor,
      body: FutureBuilder<UserProfile>(
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
          final List<XPData> data = [
            XPData('Strength', user.strengthXP, Colors.red),
            XPData('Intelligence', user.intelligenceXP, Colors.blue),
            XPData('Dexterity', user.dexterityXP, Colors.green),
            XPData('Creativity', user.creativityXP, Colors.yellow),
            XPData('Stamina', user.staminaXP, Colors.orange),
            XPData('Charisma', user.charismaXP, Colors.purple),
          ];

          // Get XP description
          final xpDescription = getXPDescription(
            intelligenceXP: user.intelligenceXP,
            dexterityXP: user.dexterityXP,
            creativityXP: user.creativityXP,
            staminaXP: user.staminaXP,
            charismaXP: user.charismaXP,
          );

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Sarcastic Message
                Center(
                  child: Text(
                    xpDescription,
                    style: GameTheme.subtitleStyle.copyWith(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),

                // XP Distribution Chart
                Expanded(
                  child: SfCircularChart(
                    legend: Legend(
                      isVisible: true,
                      position: LegendPosition.bottom,
                      textStyle: GameTheme.subtitleStyle,
                      iconHeight: 15,
                      iconWidth: 15,
                      itemPadding: 15,
                      overflowMode: LegendItemOverflowMode.wrap,
                      iconBorderWidth: 2,
                      iconBorderColor: Colors.white,
                      legendItemBuilder: (legendText, series, point, seriesIndex) {
                        return Row(
                          children: [
                            Container(
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                color: data[seriesIndex].color,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              legendText,
                              style: GameTheme.subtitleStyle,
                            ),
                          ],
                        );
                      },
                    ),
                    series: <CircularSeries>[
                      RadialBarSeries<XPData, String>(
                        dataSource: data,
                        xValueMapper: (XPData xp, _) => xp.category,
                        yValueMapper: (XPData xp, _) => (xp.xp * 10).round() / 10.0, // Round to nearest 0.1
                        radius: '100%',
                        innerRadius: '20%',
                        cornerStyle: CornerStyle.bothCurve,
                        trackColor: GameTheme.secondaryColor,
                        trackOpacity: 0.2,
                        pointColorMapper: (XPData data, _) => data.color,
                        dataLabelSettings: DataLabelSettings(isVisible: true),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class XPData {
  final String category;
  final double xp;
  final Color color;

  XPData(this.category, this.xp, this.color);
}
