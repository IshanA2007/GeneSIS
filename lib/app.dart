import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grades/features/authentication/screens/onboarding/onboarding.dart';
import 'package:grades/utils/theme/theme.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: GenesisTheme.lightTheme,
      darkTheme: GenesisTheme.darkTheme,
      home: const OnBoardingScreen()
    );
  }
}
