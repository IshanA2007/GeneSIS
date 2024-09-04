import 'package:flutter/material.dart';
import 'package:grades/features/app/screens/gradebook/widgets/gradebook_gradesviewappbar.dart';

class GradesView extends StatelessWidget {
  const GradesView({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            GradesViewAppBar(
              className: "Mobile/Web Research",
              gpaBoost: "1.0",
            ),
            // grades graph,
            // grades/trends boxes,
            // GradesViewAssignments(assignments: [{title: "assignment1", points: "30", outof: "30"}])
          ],
        ),
      ),
    );
  }
}
