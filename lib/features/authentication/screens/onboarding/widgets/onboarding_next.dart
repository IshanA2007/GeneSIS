import 'package:flutter/material.dart';
import 'package:grades/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:grades/utils/constants/sizes.dart';
import 'package:grades/utils/device/device_utilities.dart';
import 'package:iconsax/iconsax.dart';

class OnBoardingNext extends StatelessWidget {
  const OnBoardingNext({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: GenesisSizes.defaultSpacing,
      bottom: GenesisDeviceUtils.getBottomNavigationBarHeight(),
      child: ElevatedButton(
        onPressed: () => OnBoardingController.instance.nextPage(),
        style: ElevatedButton.styleFrom(shape: const CircleBorder()),
        child: const Icon(Iconsax.arrow_right_3),
      ),
    );
  }
}
