import 'package:flutter/material.dart';
import 'package:grades/common/widgets/genesis_card.dart';
import 'package:grades/features/app/screens/gradebook/widgets/gradebook_gradesview_infocard.dart';
import 'package:grades/features/app/screens/gradebook/widgets/gradebook_gradesviewappbar.dart';
import 'package:grades/utils/constants/colors.dart';
import 'package:grades/utils/constants/sizes.dart';
import 'package:grades/utils/device/device_utilities.dart';
import 'package:grades/utils/helpers/grade_calculations.dart';

import 'gradebook_gradesview_gradebars.dart';

class GradesViewAssignment extends StatelessWidget {
  const GradesViewAssignment({super.key, required this.assignmentName, required this.earnedPoints, required this.possiblePoints});

  final String assignmentName;
  final double earnedPoints;
  final double possiblePoints;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: GenesisSizes.cardPaddingLg),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              assignmentName,
              textAlign: TextAlign.start,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .apply(color: GenesisColors.white),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text("$earnedPoints/$possiblePoints",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .apply(color: GenesisColors.white)),
          ),
          Expanded(
            flex: 4,
            child: Text("${GenesisGradeCalculations.percentify(earnedPoints, possiblePoints).toStringAsFixed(2)}%",
                textAlign: TextAlign.end,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .apply(color: GenesisColors.white)),
          ),
        ],
      ),
    );
  }
}
