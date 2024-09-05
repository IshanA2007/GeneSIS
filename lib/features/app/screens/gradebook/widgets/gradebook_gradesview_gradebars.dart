
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
                      height: (GenesisDeviceUtils.getScreenHeight() *
                          0.3 *
                          0.30), // Slightly taller
                      width: GenesisDeviceUtils.getScreenWidth() * 0.27,
                      decoration: BoxDecoration(
                        color: GenesisColors.gradeBarSecondary,
                        // Change to differentiate
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                    ),
                    // Foreground main container
                    Container(
                      height: (GenesisDeviceUtils.getScreenHeight() *
                          0.3 *
                          0.30) *
                          .67,
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
                      height: (GenesisDeviceUtils.getScreenHeight() *
                          0.3 *
                          0.70), // Slightly taller
                      width: GenesisDeviceUtils.getScreenWidth() * 0.27,
                      decoration: BoxDecoration(
                        color: GenesisColors.gradeBarSecondary,
                        // Change to differentiate
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                    ),
                    // Foreground main container
                    Container(
                      height: (GenesisDeviceUtils.getScreenHeight() *
                          0.3 *
                          0.70) *
                          .67,
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
