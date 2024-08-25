import 'package:flutter/material.dart';
import 'package:grades/features/app/screens/gradebook/widgets/gradebook_appbar.dart';
import 'package:grades/features/app/screens/home/widgets/genesis_card.dart';
import 'package:grades/features/app/screens/home/widgets/card_grid.dart';
import 'package:grades/features/app/screens/gradebook/widgets/gradebook_appbar.dart';
import 'package:grades/utils/constants/sizes.dart';
import 'package:grades/features/app/screens/gradebook/widgets/gradecard.dart';

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
              children: [
              GradeCard(className: "Math 4", monthlyChange: 10, missingAssignments: 2, letterGrade: "A", gradePercent: 94.8),
              GradeCard(className: "Mobile/Web Res", monthlyChange: -14, missingAssignments: 12, letterGrade: "F", gradePercent: 14.2),
              
              Text("pd 3"), Text("pd 4"), Text("pd 5"), Text("pd 6"), Text("pd 7")]
            ),
          ],
        ),
      ),
    );
  }
}