import 'package:flutter/material.dart';
import 'package:grades/features/authentication/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:grades/features/authentication/screens/onboarding/widgets/onboarding_next.dart';
import 'package:grades/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:grades/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';
import 'package:grades/utils/constants/image_strings.dart';
import 'package:grades/utils/constants/text_strings.dart';
import 'package:get/get.dart';
import '../../controllers/onboarding/onboarding_controller.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());

    return Scaffold(
      body: Stack(children: [
        PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                  image: GenesisImages.onboarding1,
                  title: GenesisTexts.onBoardingTitle1,
                  subTitle: GenesisTexts.onBoardingSubtitle1),
              OnBoardingPage(
                  image: GenesisImages.onboarding1,
                  title: GenesisTexts.onBoardingTitle2,
                  subTitle: GenesisTexts.onBoardingSubtitle2),
              OnBoardingPage(
                  image: GenesisImages.onboarding1,
                  title: GenesisTexts.onBoardingTitle3,
                  subTitle: GenesisTexts.onBoardingSubtitle3),
            ]),
        const OnBoardingSkip(),
        const OnBoardingDotNavigation(),
        const OnBoardingNext(),
      ]),
    );
  }
}
