import 'package:flutter/material.dart';
import 'package:grades/features/app/screens/gradebook/widgets/gradebook_appbar.dart';
import 'package:grades/common/widgets/genesis_card.dart';
import 'package:grades/common/widgets/card_grid.dart';
import 'package:grades/features/app/screens/gradebook/widgets/gradebook_appbar.dart';
import 'package:grades/utils/constants/sizes.dart';
import 'package:grades/features/app/screens/gradebook/widgets/gradebook_gradecard.dart';

class Gradebook extends StatelessWidget {
  const Gradebook({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            GradebookAppBar(),
            GenesisCardGrid(
              rows: 7,
              columns: 1,
              childAspectRatio: 2.8,
              children: [
                GradeCard(
                    className: "Math 4",
                    monthlyChange: 10,
                    missingAssignments: 2,
                    letterGrade: "A",
                    gradePercent: 94.8),
                GradeCard(
                    className: "Mobile/Web Research",
                    monthlyChange: -14,
                    missingAssignments: 12,
                    letterGrade: "F",
                    gradePercent: 14.2),
                GradeCard(
                    className: "Math 6",
                    monthlyChange: 10,
                    missingAssignments: 9,
                    letterGrade: "D-",
                    gradePercent: 65.8),
                GradeCard(
                    className: "AP Language",
                    monthlyChange: 4,
                    missingAssignments: 8,
                    letterGrade: "C",
                    gradePercent: 4.2),
                GradeCard(
                    className: "AP Government",
                    monthlyChange: 5,
                    missingAssignments: 1,
                    letterGrade: "B+",
                    gradePercent: 88.5),
                GradeCard(
                    className: "Multivariable Calculus",
                    monthlyChange: -50,
                    missingAssignments: 1,
                    letterGrade: "C-",
                    gradePercent: 73.2),
                GradeCard(
                    className: "AP German",
                    monthlyChange: 0,
                    missingAssignments: 0,
                    letterGrade: "A",
                    gradePercent: 100.0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
