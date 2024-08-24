import 'package:flutter/material.dart';
import 'package:grades/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:grades/utils/constants/colors.dart';
import 'package:grades/utils/constants/sizes.dart';
import 'package:grades/utils/device/device_utilities.dart';
import 'package:grades/utils/helpers/helper_functions.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = GenesisHelpers.isDarkMode(context);
    final controller = OnBoardingController.instance;
    return Positioned(
        bottom: GenesisDeviceUtils.getBottomNavigationBarHeight() + 25,
        left: GenesisSizes.defaultSpacing,
        child: SmoothPageIndicator(
          controller: controller.pageController,
          onDotClicked: controller.dotNavigationClick,
          effect: ExpandingDotsEffect(
              activeDotColor: dark
                  ? GenesisColors.lightBackground
                  : GenesisColors.darkBackground,
              dotHeight: 6),
          count: 3,
        ));
  }
}
