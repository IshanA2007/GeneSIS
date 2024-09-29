import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grades/features/authentication/controllers/user/user_controller.dart';
import 'package:grades/utils/constants/colors.dart';
import 'package:grades/utils/constants/sizes.dart';
import 'package:grades/utils/constants/text_strings.dart';
import 'package:grades/utils/device/device_utilities.dart';
import 'package:grades/utils/helpers/helper_functions.dart';

class GenesisGPACardContent extends StatelessWidget {
  const GenesisGPACardContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final user = Get.find<GenesisUserController>();
    final dark = GenesisHelpers.isDarkMode(context);
    final amntFromGoal = double.parse(user.amntFromGoal() ?? "0");
    final isOverGoal = amntFromGoal >= 0;
    final isOverGoalColor =
        isOverGoal ? GenesisColors.success : GenesisColors.error;
    final isOverGoalText = isOverGoal ? GenesisTexts.overGoalText : GenesisTexts.underGoalText;
    return SizedBox(
      width: double.infinity,
      height: GenesisDeviceUtils.getScreenHeight() * .115,
      child: FittedBox(
        child: Row(
          children: [
            Column(
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
                        text: user.amntFromGoal(),
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .apply(color: isOverGoalColor),
                      ),
                      TextSpan(text: " $isOverGoalText ${user.getGPAGoal()}")
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
            const SizedBox(width: GenesisSizes.spaceBtwSections),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                // Vertically center the whole column
                children: [
                  Text(
                    user.getGPA(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .apply(fontSizeFactor: 5), // Adjust style as needed
                  ),

                  // Space between the texts
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
