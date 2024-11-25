import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grades/common/widgets/card_grid.dart';
import 'package:grades/features/app/screens/feed/widgets/feed_appbar.dart';
import 'package:grades/features/app/screens/feed/widgets/feed_filterbar.dart';
import 'package:grades/features/app/screens/feed/widgets/feed_assignmentcard.dart';
import 'package:grades/utils/constants/sizes.dart';
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

  @override
  Widget build(BuildContext context) {
    final user = Get.find<GenesisUserController>();

    List<AssignmentCard> assignmentCards = [];
    List<Assignment> assignments = user.getAllAssignments();
    for (Assignment assignment in assignments) {
      print("hee");
      print(assignment);
      ClassData containingClass = user.findClassWithAssignment(assignment)!;
      print("ha");
      assignmentCards.add(AssignmentCard(
        assignment: assignment,
        course: containingClass,
      ));
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const FeedAppBar(),
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: GenesisSizes.md),
                child: FeedFilterBar()),
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
