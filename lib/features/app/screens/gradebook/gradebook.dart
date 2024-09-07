import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grades/features/app/screens/gradebook/widgets/gradebook_appbar.dart';
import 'package:grades/common/widgets/genesis_card.dart';
import 'package:grades/common/widgets/card_grid.dart';
import 'package:grades/features/authentication/controllers/user/user_controller.dart';
import 'package:grades/utils/constants/sizes.dart';
import 'package:grades/features/app/screens/gradebook/widgets/gradebook_gradecard.dart';

class Gradebook extends StatelessWidget {
  const Gradebook({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Get.find<GenesisUserController>();
    final courses = user.userdata["courses"] as Map<dynamic, dynamic>;

    // Create a list of GradeCard widgets based on the courses data
    final gradeCards = courses.entries.map((entry) {
      final courseName = entry.key;
      final courseData = entry.value;

      return GradeCard(
        className: courseName,
        monthlyChange: 0,
        // Placeholder, adjust based on your logic
        missingAssignments: int.parse(courseData["missing"]),
        letterGrade: courseData["letter"],
        gradePercent: double.parse(courseData["percent"]),
      );
    }).toList();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            GradebookAppBar(),
            GenesisCardGrid(
              rows: (courses.length / 1).ceil(),
              // Adjust rows based on the number of courses
              columns: 1,
              padding: EdgeInsets.only(
                  left: GenesisSizes.md,
                  right: GenesisSizes.md,
                  top: GenesisSizes.spaceBtwItems),
              childAspectRatio: 2.8,
              children: gradeCards,
            ),
          ],
        ),
      ),
    );
  }
}
