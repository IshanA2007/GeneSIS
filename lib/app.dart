import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grades/features/authentication/screens/onboarding/onboarding.dart';
import 'package:grades/utils/constants/colors.dart';
import 'package:grades/utils/theme/theme.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      builder: (context, child) {
        return GetMaterialApp(
          themeMode: ThemeMode.system,
          theme: GenesisTheme.lightTheme,
          darkTheme: GenesisTheme.darkTheme,
          home: const Scaffold(
            backgroundColor: GenesisColors.primaryColor,
            body: Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
