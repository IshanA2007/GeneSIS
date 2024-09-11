import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:grades/features/app/screens/home/home.dart";
import 'package:grades/features/app/screens/gradebook/gradebook.dart';
import 'package:grades/features/app/screens/settings/settings.dart';
import 'package:grades/features/app/screens/feed/feed.dart';
import "package:grades/utils/constants/colors.dart";
import "package:grades/utils/helpers/helper_functions.dart";
import "package:iconsax/iconsax.dart";

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final dark = GenesisHelpers.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          backgroundColor: dark ? GenesisColors.black : GenesisColors.white,
          indicatorColor: dark
              ? GenesisColors.white.withOpacity(0.1)
              : GenesisColors.black.withOpacity(0.1),
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: "Home"),
            NavigationDestination(icon: Icon(Iconsax.book), label: "Grades"),
            NavigationDestination(
                icon: Icon(Iconsax.notification), label: "Feed"),
            NavigationDestination(
                icon: Icon(Iconsax.setting), label: "Settings"),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const HomeScreen(),
    const Gradebook(),
    const Feed(),
    const Settings(),
  ];
}
