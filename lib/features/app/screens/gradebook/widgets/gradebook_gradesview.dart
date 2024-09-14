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

import 'gradebook_gradesview_gradebars.dart';
import 'gradebook_gradeview_assignment.dart';

class GradesView extends StatelessWidget {
  const GradesView({super.key, required this.className});

  final String className;

  @override
  Widget build(BuildContext context) {
    final user = Get.find<GenesisUserController>();
    final courseData = user.userdata['courses'][className];
    final missingAssignments = int.parse(courseData["missing"]);
    final letterGrade = courseData["letter"];
    final gradePercent = double.parse(courseData["percent"]);
    const weeklyChange = 0; // HARDCODED VALUE
    const monthlyChange = 0; // HARDCODED VALUE
    const semesterChange = -100; // HARDCODED VALUE

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            GradesViewAppBar(
              className: className,
              gpaBoost: GenesisGradeCalculations.gpaBoostFromCourse(
                  className), // HARDCODED VALUE
            ),
            const SizedBox(
              height: GenesisSizes.spaceBtwSections,
            ),
            GradesViewGradeBars(
              categories: user.userdata['courses'][className]['categories'],
            ),
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
                      for (Map<String, dynamic> assignment in user
                          .userdata['courses'][className]["assignments"]) ...[
                        GradesViewAssignment(
                          assignmentName: assignment['name'],
                          earnedPoints: assignment['earnedPoints'],
                          possiblePoints: assignment['possiblePoints'],
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
