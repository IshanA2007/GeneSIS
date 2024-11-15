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

class Gradebook extends StatefulWidget {
  const Gradebook({super.key});

  @override
  _GradebookState createState() => _GradebookState();
}

class _GradebookState extends State<Gradebook> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _fadeAnimations;

  @override
  void initState() {
    super.initState();

    // Get user periods (mocked for now)
    final user = Get.find<GenesisUserController>();
    final List<Period> periods = user.getPeriods();

    // Initialize the AnimationController
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200), // Total animation time
    );

    // Create a list of fade animations, one for each grade card
    _fadeAnimations = List.generate(periods.length, (index) {
      // Each card will fade in after a short delay
      double start = (index * 0.1).clamp(0.0, 1.0);
      double end = start + 0.3; // Each animation lasts for 30% of total duration

      return CurvedAnimation(
        parent: _controller,
        curve: Interval(start, end, curve: Curves.easeIn),
      );
    });

    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose(); // Clean up the controller when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Get.find<GenesisUserController>();
    final List<Period> periods = user.getPeriods();

    List<GradeCard> grCards = [];
    for (Period period in periods) {
      ClassData curClass = period.classData[period.classData.length - 1];
      String letterGrade = GenesisGradeCalculations.percentToLetter(curClass.percent);
      if(curClass.assignments.isEmpty){
        letterGrade = "N/A";
      }
      grCards.add(
        GradeCard(
          className: curClass.courseName,
          monthlyChange: user.getMonthlyChange(curClass),
          classData: curClass,
          missingAssignments: user.getMissing(curClass),
          letterGrade: letterGrade,
          gradePercent: curClass.percent,
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const GradebookAppBar(),
            GenesisCardGrid(
              rows: grCards.length,
              columns: 1,
              padding: const EdgeInsets.only(
                left: GenesisSizes.md,
                right: GenesisSizes.md,
                top: GenesisSizes.spaceBtwItems,
              ),
              childAspectRatio: 2.8,
              children: List.generate(grCards.length, (index) {
                return FadeTransition(
                  opacity: _fadeAnimations[index],
                  child: grCards[index],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
