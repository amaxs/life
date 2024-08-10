import 'package:flutter/material.dart';

class GameTheme {
  static final Color primaryColor = Color(0xFF0B1E3B); // Darker blue
  static final Color secondaryColor = Color(0xFF1B2C47); // Darker secondary blue
  static final Color accentColor = Color(0xFF274B77); // Darker accent blue
  static final Color highlightColor = Color(0xFF3E72A8); // Highlight blue
  static final Color backgroundColor = Color(0xFF0B1E3B); // Darker background

  static final TextStyle titleStyle = TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    shadows: [
      Shadow(
        blurRadius: 10.0,
        color: Colors.blueAccent,
        offset: Offset(0, 0),
      ),
    ],
  );

  static final TextStyle subtitleStyle = TextStyle(
    color: Colors.white70,
    fontSize: 18,
  );

  static final BoxDecoration containerDecoration = BoxDecoration(
    gradient: LinearGradient(
      colors: [Color(0xFF0B1E3B), Color(0xFF1B2C47)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(10),
    boxShadow: [
      BoxShadow(
        color: Colors.blueAccent.withOpacity(0.5),
        spreadRadius: 1,
        blurRadius: 10,
        offset: Offset(0, 3),
      ),
    ],
  );

  static final BoxDecoration dialogDecoration = BoxDecoration(
    gradient: LinearGradient(
      colors: [Color(0xFF0B1E3B), Color(0xFF1B2C47)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(10),
    boxShadow: [
      BoxShadow(
        color: Colors.blueAccent.withOpacity(0.5),
        spreadRadius: 1,
        blurRadius: 10,
        offset: Offset(0, 3),
      ),
    ],
  );
}
