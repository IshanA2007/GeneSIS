import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grades/common/widgets/genesis_card.dart';
import 'package:grades/features/app/screens/gradebook/widgets/gradebook_gradesview_infocard.dart';
import 'package:grades/features/app/screens/gradebook/widgets/gradebook_gradesviewappbar.dart';
import 'package:grades/features/authentication/controllers/user/user_controller.dart';
import 'package:grades/utils/constants/colors.dart';
import 'package:grades/utils/constants/sizes.dart';
import 'package:grades/utils/device/device_utilities.dart';
import 'package:grades/utils/helpers/grade_calculations.dart';
import 'package:studentvueclient/studentvueclient.dart';

import '../../../../../common/data/ClassData.dart';
import 'gradebook_gradesview_gradebars.dart';
import 'gradebook_gradeview_assignment.dart';

class GradesView extends StatelessWidget {
  const GradesView({super.key, required this.classData});

  final ClassData classData;

  @override
  Widget build(BuildContext context) {
    final user = Get.find<GenesisUserController>();



    const weeklyChange = 0; // HARDCODED VALUE
    const monthlyChange = 0; // HARDCODED VALUE
    const semesterChange = -100; // HARDCODED VALUE

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            GradesViewAppBar(
              className: classData.courseName,
              gpaBoost: GenesisGradeCalculations.gpaBoostFromCourse(
                  classData.courseName),
            ),
            const SizedBox(
              height: GenesisSizes.spaceBtwSections,
            ),
            GradesViewGradeBars(
              categories: classData.categories,
            ),
            GradesViewInfoCard(
                letterGrade: GenesisGradeCalculations.percentToLetter(classData.percent),
                missingAssignments: user.getMissing(classData),
                gradePercent: classData.percent,
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: GenesisSizes.cardPaddingLg),
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
                      for (Assignment assignment in classData.assignments) ...[
                        GradesViewAssignment(
                          assignmentName: assignment.assignmentName,
                          earnedPoints: assignment.earnedPoints,
                          possiblePoints: assignment.possiblePoints,
                        ),
                        const SizedBox(height: GenesisSizes.sm),
                        // Add SizedBox after each item
                      ],
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: GenesisSizes.defaultSpacing),
          ],
        ),
      ),
    );
  }
}
