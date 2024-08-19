import 'package:flutter/material.dart';
import 'package:grades/utils/theme/theme.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: GradesTheme.lightTheme,
      darkTheme: GradesTheme.darkTheme,
    );
  }
}