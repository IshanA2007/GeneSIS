import 'package:flutter/material.dart';
import 'package:grades/utils/constants/sizes.dart';
import 'package:grades/utils/device/device_utilities.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage(
      {super.key,
      required this.image,
      required this.title,
      required this.subTitle});

  final String image, title, subTitle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(GenesisSizes.defaultSpacing),
      child: Column(children: [
        Image(
            width: GenesisDeviceUtils.getScreenWidth() * 0.8,
            height: GenesisDeviceUtils.getScreenHeight() * 0.6,
            image: AssetImage(image)),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: GenesisSizes.spaceBtwItems),
        Text(
          subTitle,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ]),
    );
  }
}
