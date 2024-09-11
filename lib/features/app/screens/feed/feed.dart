import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grades/common/widgets/appbar/appbar.dart';
import 'package:grades/common/widgets/card_grid.dart';
import 'package:grades/common/widgets/containers/circular_container.dart';
import 'package:grades/features/app/screens/feed/widgets/feed_appbar.dart';
import 'package:grades/features/app/screens/feed/widgets/feed_filterbar.dart';
import 'package:grades/features/app/screens/feed/widgets/feed_assignmentcard.dart';
import 'package:grades/utils/constants/colors.dart';
import 'package:grades/utils/constants/sizes.dart';
import 'package:grades/utils/constants/text_strings.dart';
import 'package:grades/utils/helpers/grade_calculations.dart';
import 'package:iconsax/iconsax.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../authentication/controllers/user/user_controller.dart';

class Feed extends StatelessWidget {
  const Feed({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Get.find<GenesisUserController>();
    final assignments = user.userdata["assignments"] as List<dynamic>;

    // Create a list of GradeCard widgets based on the courses data
    final assignmentCards = assignments.map((assignment) {
      return AssignmentCard(
          date: assignment['date'],
          className: assignment['course'],
          gradePercent: GenesisGradeCalculations.percentify(
                  assignment['earnedPoints'], assignment['possiblePoints'])
              .toStringAsFixed(2),
          points: assignment['earnedPoints'],
          totalPoints: assignment['possiblePoints'],
          impact: 24,
          name: assignment['name']);
    }).toList();
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
                padding: const EdgeInsets.symmetric(horizontal: GenesisSizes.md),
                child: GenesisCardGrid(
                    cardPadding: const EdgeInsets.all(0),
                    columns: 2,
                    rows: (assignmentCards.length / 2).ceil(),
                    childAspectRatio: 0.8,
                    children: assignmentCards)),
          ],
        ),
      ),
    );
  }
}
