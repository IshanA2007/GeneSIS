import 'package:flutter/material.dart';
import 'package:grades/utils/constants/colors.dart';
import 'package:grades/utils/device/device_utilities.dart';
import 'package:grades/utils/helpers/helper_functions.dart';

class GradesViewGradeBars extends StatelessWidget {
  final Map<dynamic, dynamic> categories;

  const GradesViewGradeBars({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    final dark = GenesisHelpers.isDarkMode(context);
    return Center(
      child: SizedBox(
        width: GenesisDeviceUtils.getScreenWidth(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: categories.entries.map((category) {
            double weight = category.value['weight'];
            double earnedPoints = category.value['earnedPoints'];
            double possiblePoints = category.value['possiblePoints'];
            double percentage = (possiblePoints > 0) ? (earnedPoints / possiblePoints) * 100 : 0;

            return Column(
              children: [
                Text(category.key,
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .apply(color: GenesisColors.darkGrey)),
                Text("${earnedPoints.toStringAsFixed(2)}/${possiblePoints.toStringAsFixed(2)} pts",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .apply(color: GenesisColors.darkerGrey)),
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    // Background taller container
                    Container(
                      height: GenesisDeviceUtils.getScreenHeight() * 0.3 * (weight / 100),
                      width: GenesisDeviceUtils.getScreenWidth() * 0.27,
                      decoration: BoxDecoration(
                        color: dark ? GenesisColors.gradeBarSecondary : GenesisColors.lightBackground,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                    ),
                    // Foreground main container with animation
                    TweenAnimationBuilder<double>(
                      tween: Tween(
                          begin: 0.0,
                          end: GenesisDeviceUtils.getScreenHeight() * 0.3 * (weight / 100) * (percentage / 100)),
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeOut, // Smooth transition
                      builder: (context, height, child) {
                        return Container(
                          height: height,
                          width: GenesisDeviceUtils.getScreenWidth() * 0.27,
                          decoration: const BoxDecoration(
                            color: GenesisColors.primaryColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(35),
                              topRight: Radius.circular(35),
                            ),
                          ),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${percentage.toStringAsFixed(2)}%',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .apply(color: GenesisColors.white),
                                ),
                                // Add more widgets as needed
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}