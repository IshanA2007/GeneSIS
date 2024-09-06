import 'package:flutter/material.dart';
import 'package:grades/common/widgets/genesis_card.dart';
import 'package:grades/features/app/screens/gradebook/widgets/gradebook_gradesview_infocard.dart';
import 'package:grades/features/app/screens/gradebook/widgets/gradebook_gradesviewappbar.dart';
import 'package:grades/utils/constants/colors.dart';
import 'package:grades/utils/constants/sizes.dart';
import 'package:grades/utils/device/device_utilities.dart';

import 'gradebook_gradesview_gradebars.dart';
import 'gradebook_gradeview_assignment.dart';

class GradesView extends StatelessWidget {
  const GradesView({super.key, required this.className, required this.monthlyChange, required this.missingAssignments, required this.letterGrade, required this.gradePercent});
  final String className;
  final int monthlyChange;
  final int missingAssignments;
  final String letterGrade;
  final double gradePercent;
  @override
  Widget build(BuildContext context) {
    var weeklyChange = 0; // HARDCODED VALUE
    var semesterChange = -100;  // HARDCODED VALUE
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            GradesViewAppBar(
              className: className,
              gpaBoost: "1.0", // HARDCODED VALUE
            ),
            const SizedBox(
              height: GenesisSizes.spaceBtwSections,
            ),
            const GradesViewGradeBars(),
            GradesViewInfoCard(
                letterGrade: letterGrade,
                missingAssignments: missingAssignments,
                gradePercent: gradePercent,
                weeklyChange: weeklyChange,
                monthlyChange: monthlyChange,
                semesterChange: semesterChange),
            const SizedBox(height: GenesisSizes.lg),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: GenesisSizes.md),
              child: GenesisCard(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Text("Assignments",
                          style: Theme.of(context).textTheme.titleLarge!),
                      const SizedBox(height: GenesisSizes.sm),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: GenesisSizes.cardPaddingLg),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Text(
                                "NAME",
                                textAlign: TextAlign.start,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .apply(color: GenesisColors.darkerGrey),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text("POINTS",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .apply(color: GenesisColors.darkerGrey)),
                            ),
                            Expanded(
                              flex: 4,
                              child: Text("GRADE",
                                  textAlign: TextAlign.end,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .apply(color: GenesisColors.darkerGrey)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: GenesisSizes.xs),
                      for (int i = 0; i < 15; i++) ...[
                        GradesViewAssignment(),
                        const SizedBox(height: GenesisSizes.sm), // Add SizedBox after each item
                      ],

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
