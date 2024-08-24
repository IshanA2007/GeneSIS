
import 'package:flutter/material.dart';
import 'package:grades/utils/constants/image_strings.dart';
import 'package:grades/utils/constants/sizes.dart';
import 'package:grades/utils/constants/text_strings.dart';

class GenesisLoginHeader extends StatelessWidget {
  const GenesisLoginHeader({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image(
          height: 150,
          image: AssetImage(dark
              ? GenesisImages.darkAppLogo
              : GenesisImages.darkAppLogo),
        ),
        Text(GenesisTexts.loginTitle,
            style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: GenesisSizes.sm),
        Text(GenesisTexts.loginSubTitle,
            style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
