import 'package:flutter/material.dart';
import '../theme.dart';

class InventoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GameTheme.backgroundColor,
      appBar: AppBar(
        title: Text('Inventory', style: GameTheme.titleStyle),
        backgroundColor: GameTheme.primaryColor,
        iconTheme: const IconThemeData(
          color: Colors.white, // Set the color of the back arrow to white
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Example inventory item
            Container(
              decoration: GameTheme.containerDecoration,
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.only(bottom: 16.0),
              child: Text('Not available for newbies.', style: GameTheme.subtitleStyle),
            ),
            // Add more inventory items as needed
          ],
        ),
      ),
    );
  }
}
