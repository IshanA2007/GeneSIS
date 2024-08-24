import 'package:flutter/material.dart';
import 'package:grades/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:grades/utils/constants/sizes.dart';
import 'package:grades/utils/device/device_utilities.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: GenesisDeviceUtils.getAppBarHeight(),
        right: GenesisSizes.defaultSpacing,
        child: TextButton(onPressed: () => OnBoardingController.instance.skipPage(), child: const Text("Skip")));
  }
}
