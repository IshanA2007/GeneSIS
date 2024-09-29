import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grades/features/app/screens/gradebook/widgets/gradebook_appbar.dart';
import 'package:grades/common/widgets/genesis_card.dart';
import 'package:grades/common/widgets/card_grid.dart';
import 'package:grades/features/authentication/controllers/user/user_controller.dart';
import 'package:grades/utils/constants/sizes.dart';
import 'package:grades/features/app/screens/gradebook/widgets/gradebook_gradecard.dart';

import '../../../../common/data/ClassData.dart';
import '../../../../common/data/Period.dart';
import '../../../../utils/helpers/grade_calculations.dart';

class Gradebook extends StatelessWidget {
  const Gradebook({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Get.find<GenesisUserController>();


    final List<Period> periods = user.getPeriods();
    List<GradeCard> grCards = [];
    for (Period period in periods) {
      ClassData curClass = period.classData[period.classData.length - 1];
      grCards.add(
        GradeCard(
            className: curClass.courseName,
            monthlyChange: 0,
            classData: curClass,
            missingAssignments: user.getMissing(curClass),
            letterGrade: GenesisGradeCalculations.percentToLetter(curClass.percent),
            gradePercent: curClass.percent),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const GradebookAppBar(),
            GenesisCardGrid(
              rows: grCards.length,
              // Adjust rows based on the number of courses
              columns: 1,
              padding: const EdgeInsets.only(
                  left: GenesisSizes.md,
                  right: GenesisSizes.md,
                  top: GenesisSizes.spaceBtwItems),
              childAspectRatio: 2.8,
              children: grCards,
            ),
          ],
        ),
      ),
    );
  }
}
