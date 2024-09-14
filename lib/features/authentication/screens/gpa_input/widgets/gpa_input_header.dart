import 'package:flutter/material.dart';
import 'package:grades/utils/constants/colors.dart';
import 'package:grades/utils/constants/image_strings.dart';
import 'package:grades/utils/constants/sizes.dart';
import 'package:grades/utils/constants/text_strings.dart';

class GenesisGPAInputHeader extends StatelessWidget {
  const GenesisGPAInputHeader({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                height: 150,
                image: AssetImage(dark
                    ? GenesisImages.darkAppLogo
                    : GenesisImages.darkAppLogo),
              ),
              Text(GenesisTexts.gpaInputTitle,
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: GenesisSizes.sm),
              Text(GenesisTexts.gpaInputSubtitle,
                  style: Theme.of(context).textTheme.bodyMedium!.apply(color: dark ? GenesisColors.grey : GenesisColors.darkerGrey),
                  
                  textAlign: TextAlign.center,),
            ],
          ),
        ),
      ],
    );
  }
}
