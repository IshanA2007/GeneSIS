import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grades/common/widgets/card_grid.dart';
import 'package:grades/features/app/screens/feed/widgets/feed_appbar.dart';
import 'package:grades/features/app/screens/feed/widgets/feed_filterbar.dart';
import 'package:grades/features/app/screens/feed/widgets/feed_assignmentcard.dart';
import 'package:grades/utils/constants/sizes.dart';
import 'package:grades/utils/helpers/grade_calculations.dart';
import 'package:intl/intl.dart';
import 'package:studentvueclient/studentvueclient.dart';

import '../../../authentication/controllers/user/user_controller.dart';
import '../../../../common/data/ClassData.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<Offset>> _slideAnimations;
  String filter = "All";

  @override
  void initState() {
    super.initState();

    final user = Get.find<GenesisUserController>();
    List<Assignment> assignments = user.getAllAssignments();

    // Initialize the AnimationController
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500), // Total animation time
    );

    // Create slide animations for each assignment card
    _slideAnimations = List.generate(assignments.length, (index) {
      // Determine slide direction: even index (left column) from left, odd index (right column) from right
      final isLeftColumn = index % 2 == 0;
      final startOffset =
          isLeftColumn ? const Offset(-1, 0) : const Offset(1, 0);

      return Tween<Offset>(
        begin: startOffset,
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve:
            Interval((index * 0.1).clamp(0.0, 1.0), 1.0, curve: Curves.easeOut),
      ));
    });

    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose(); // Clean up the controller
    super.dispose();
  }

  void updateFilter(String filt) {
    setState(() {
      filter = filt;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Get.find<GenesisUserController>();

    List<AssignmentCard> assignmentCards = [];
    List<Assignment> assignments = user.getAllAssignments();
    Set<Assignment> uniqueAssignments = {}; 

    for (Assignment assignment in assignments) {
      // DUPLICATE CHECKING
      if(uniqueAssignments.contains(assignment)){
        continue;
      }
      uniqueAssignments.add(assignment);
      ClassData? containingClass = user.findClassWithAssignment(assignment);
      if (containingClass == null) {
        continue; // Skip assignment if class doesn't have it - was either deleted or modified
      }
      AssignmentCategory assignmentCat = containingClass.categories[0];
      for(AssignmentCategory cat in containingClass.categories){
        if(cat.name == assignment.category){
          assignmentCat = cat;
        }
      }
      // Get percentage of grade impact (poss points of this assignment / poss category points * category weight %)
      double percentageOfGrade = assignmentCat.weight * assignment.possiblePoints / assignmentCat.possiblePoints;
      // print("$percentageOfGrade percent");
      // print(DateTime.now().difference(DateFormat("MM/dd/yyyy").parse(assignment.date)).inDays);
      if (filter == "New") {
        if(DateTime.now().difference(DateFormat("MM/dd/yyyy").parse(assignment.date)).inDays > 6){
          continue;
        }
      }
      else if (filter == "Major"){
        // Major: at least 10% of total grade
        if(percentageOfGrade < 10){
          continue;
        }
        // if(!assignment.assignmentName.contains("Essay") || !containingClass.courseName.contains("ment")){
        //   continue;
        // }
        // print("Assignment: ${assignment.assignmentName}");
        // print("Containing class: ${containingClass}");
        // print("Category: ${assignmentCat}");
        // print("Possible assignment points: ${assignment.possiblePoints}");
        // print("Possible points in category: ${assignmentCat.possiblePoints}");
        // print("Dividing them: ${assignment.possiblePoints/assignmentCat.possiblePoints}");
        // print("Multiplying by category: ${assignmentCat.weight * assignment.possiblePoints/assignmentCat.possiblePoints}");
        // print("Grade impact: ${percentageOfGrade}");
      }
      var (pointsafter, totalafter) =
          GenesisGradeCalculations.calculateCategoryPointsTotalOn(
              date: DateFormat("MM/dd/yyyy").parse(assignment.date),
              course: containingClass,
              category: assignment.category);
      double pointsbefore = pointsafter - assignment.earnedPoints;
      double totalbefore = totalafter - assignment.possiblePoints;
      double gradebefore = pointsbefore / totalbefore;
      double gradeafter = pointsafter / totalafter;
      double difference = gradeafter - gradebefore;
      if (difference.isNaN) {
        // this is the first grade in category (or tied for first)
        difference = 0;
      }
      // multiply difference by category weight
      difference *= GenesisGradeCalculations.calculateCategoryWeight(
              course: containingClass, category: assignment.category) /
          100;
      assignmentCards.add(AssignmentCard(
        assignment: assignment,
        course: containingClass,
        impact: difference * 100,
        percentageOfGrade: percentageOfGrade,
      ));
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const FeedAppBar(),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: GenesisSizes.md),
                child: FeedFilterBar(
                    filter: filter, onFilterChanged: updateFilter)),
            const SizedBox(
              height: GenesisSizes.spaceBtwItems,
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: GenesisSizes.md),
                child: GenesisCardGrid(
                  cardPadding: const EdgeInsets.all(0),
                  columns: 2,
                  rows: (assignmentCards.length / 2).ceil(),
                  childAspectRatio: 0.8,
                  children: List.generate(assignmentCards.length, (index) {
                    return SlideTransition(
                      position: _slideAnimations[index],
                      child: assignmentCards[index],
                    );
                  }),
                )),
          ],
        ),
      ),
    );
  }
}
