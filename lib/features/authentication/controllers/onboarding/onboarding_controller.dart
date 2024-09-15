import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grades/features/authentication/screens/login/login.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  //vars
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  //methods

  void updatePageIndicator(index) => currentPageIndex.value = index;

  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  void nextPage() {
    if (currentPageIndex.value == 2) {
      final storage = GetStorage();
      storage.write('isFirstTime', false);
      Get.offAll(const LoginScreen());
    } else {
      int page = currentPageIndex.value + 1;
      pageController.animateToPage(page,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void skipPage() {
    final storage = GetStorage();
    storage.write('isFirstTime', false);
    Get.offAll(const LoginScreen());
  }
}
