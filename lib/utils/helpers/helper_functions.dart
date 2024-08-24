import 'package:flutter/material.dart';

class GenesisHelpers {
  static double getWidth() {
    return 0.9;
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
}
