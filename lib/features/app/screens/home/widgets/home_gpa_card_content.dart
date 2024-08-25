import 'package:flutter/material.dart';
import 'package:grades/utils/constants/colors.dart';
import 'package:grades/utils/constants/sizes.dart';
import 'package:grades/utils/device/device_utilities.dart';
import 'package:grades/utils/helpers/helper_functions.dart';

class GenesisGPACardContent extends StatelessWidget {
  const GenesisGPACardContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = GenesisHelpers.isDarkMode(context);
    return SizedBox(
      width: double.infinity,
      height: GenesisDeviceUtils.getScreenHeight() * .115,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your GPA",
                  style: Theme.of(context).textTheme.titleLarge!,
                ),
                const SizedBox(
                  height: GenesisSizes.spaceBtwItems,
                ),
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.labelMedium!.apply(
                        color: dark
                            ? GenesisColors.darkerGrey
                            : GenesisColors.grey),
                    children: <TextSpan>[
                      TextSpan(
                        text: '0.15',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .apply(color: GenesisColors.success),
                      ),
                      const TextSpan(text: ' over your goal of 4.40')
                    ],
                  ),
                ),
                Text(
                  "Keep it up!",
                  style: Theme.of(context).textTheme.labelMedium!.apply(
                      color: dark
                          ? GenesisColors.darkGrey
                          : GenesisColors.darkestGrey),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                // Vertically center the whole column
                children: [
                  Text(
                    '4.55',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .apply(fontSizeFactor: 5), // Adjust style as needed
                  ),

                  // Space between the texts
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
