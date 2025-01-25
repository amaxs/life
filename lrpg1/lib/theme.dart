import 'package:flutter/material.dart';
import 'dart:math';

class GameTheme {
  static final Color primaryColor = Color(0xFF0B1E3B); // Darker blue
  static final Color secondaryColor = Color(0xFF1B2C47); // Darker secondary blue
  static final Color accentColor = Color(0xFF274B77); // Darker accent blue
  static const Color highlightColor = Color(0xFF3E72A8); // Highlight blue
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

  // Update tab bar label style
  static const TextStyle tabBarLabelStyle = TextStyle(
    color: Colors.white,  // White color for active label
    fontSize: 16.0,       // Match the title font size
    fontWeight: FontWeight.bold,
  );

  static const TextStyle tabBarUnselectedLabelStyle = TextStyle(
    color: Colors.white60, // Slightly transparent white for inactive labels
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
  );

  static const TabBarTheme tabBarTheme = TabBarTheme(
    labelStyle: tabBarLabelStyle,
    unselectedLabelStyle: tabBarUnselectedLabelStyle,
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(color: highlightColor, width: 2.0),
    ),
    labelColor: Colors.white,  // White for selected tab
    unselectedLabelColor: Colors.white60, // Lighter white for unselected tabs
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

class SquareHaloPainter extends CustomPainter {
  final Animation<double> animation;
  SquareHaloPainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0 // Thicker stroke for more impact
      ..shader = LinearGradient(
        colors: [
          Colors.blueAccent.withOpacity(0.0),
          Colors.blueAccent.withOpacity(0.7),
          Colors.cyanAccent.withOpacity(0.9),
          Colors.white.withOpacity(1.0), // Bright white head
        ],
        stops: [0.0, 0.5, 0.8, 1.0],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 5); // Soft glow effect

    // Create a square path with rounded corners
    final rect = Rect.fromLTWH(10, 10, size.width - 20, size.height - 20);
    final path = Path()..addRRect(RRect.fromRectAndRadius(rect, Radius.circular(20)));

    // Calculate the total length of the square path
    final totalLength = path.computeMetrics().fold(0.0, (sum, m) => sum + m.length);

    // Animate the halo effect
    for (double i = 0; i < totalLength; i += 5) {
      final progress = (i / totalLength + animation.value) % 1;
      final opacity = (1 - progress).clamp(0.0, 1.0); // Smooth fading effect

      paint.color = paint.color.withOpacity(opacity.toDouble());

      final metric = path.computeMetrics().first;
      final extractPath = metric.extractPath(
        i,
        i + 40, // Length of the bright segment
      );

      canvas.drawPath(extractPath, paint);
    }
  }

  @override
  bool shouldRepaint(SquareHaloPainter oldDelegate) {
    return true;
  }
}
