import 'package:flutter/material.dart';

class DatabaseColors {
  DatabaseColors._();
  static const List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
  ];

  static Color fromString(String colorString) {
    switch (colorString) {
      case 'red':
        return Colors.red;
      case 'green':
        return Colors.green;
      case 'blue':
        return Colors.blue;
      case 'yellow':
        return Colors.yellow;
      case 'orange':
        return Colors.orange;
      case 'purple':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  static String colorToString(Color color) {
    if (color == Colors.red) return 'red';
    if (color == Colors.green) return 'green';
    if (color == Colors.blue) return 'blue';
    if (color == Colors.yellow) return 'yellow';
    if (color == Colors.orange) return 'orange';
    if (color == Colors.purple) return 'purple';
    return 'grey';
  }
}
