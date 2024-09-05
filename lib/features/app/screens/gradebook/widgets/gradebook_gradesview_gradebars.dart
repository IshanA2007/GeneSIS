import 'package:flutter/material.dart';
import 'package:grades/utils/constants/colors.dart';
import 'package:grades/utils/device/device_utilities.dart';

class GradesViewGradeBars extends StatelessWidget {
  const GradesViewGradeBars({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: GenesisDeviceUtils.getScreenWidth(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // First Column
            Column(
              children: [
                Text("Formative",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .apply(color: GenesisColors.darkGrey)),
                Text("20.13/30.00%",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .apply(color: GenesisColors.darkerGrey)),
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    // Background taller container
                    Container(
                      height: GenesisDeviceUtils.getScreenHeight() * 0.3 * 0.30,
                      width: GenesisDeviceUtils.getScreenWidth() * 0.27,
                      decoration: BoxDecoration(
                        color: GenesisColors.gradeBarSecondary,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                    ),
                    // Foreground main container with animation
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 1.0, end: GenesisDeviceUtils.getScreenHeight() * 0.3 * 0.30 * 0.67),
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeOut,  // Smooth transition
                      builder: (context, height, child) {
                        return Container(
                          height: height,
                          width: GenesisDeviceUtils.getScreenWidth() * 0.27,
                          decoration: BoxDecoration(
                            color: GenesisColors.primaryColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(35),
                              topRight: Radius.circular(35),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '68.33%',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .apply(color: GenesisColors.white),
                              ),
                              // Add more widgets as needed
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            // Second Column
            Column(
              children: [
                Text("Summative",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .apply(color: GenesisColors.darkGrey)),
                Text("60.13/70.00%",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .apply(color: GenesisColors.darkerGrey)),
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    // Background taller container
                    Container(
                      height: GenesisDeviceUtils.getScreenHeight() * 0.3 * 0.70,
                      width: GenesisDeviceUtils.getScreenWidth() * 0.27,
                      decoration: BoxDecoration(
                        color: GenesisColors.gradeBarSecondary,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                    ),
                    // Foreground main container with animation
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 1.0, end: GenesisDeviceUtils.getScreenHeight() * 0.3 * 0.70 * 0.67),
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeOut,
                      builder: (context, height, child) {
                        return Container(
                          height: height,
                          width: GenesisDeviceUtils.getScreenWidth() * 0.27,
                          decoration: BoxDecoration(
                            color: GenesisColors.primaryColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(35),
                              topRight: Radius.circular(35),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '62.40%',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .apply(color: GenesisColors.white),
                              ),
                              // Add more widgets as needed
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
