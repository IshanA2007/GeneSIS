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
import 'package:studentvueclient/studentvueclient.dart';

import '../../../../common/data/ClassData.dart';
import '../../../authentication/controllers/user/user_controller.dart';

class Feed extends StatelessWidget {
  const Feed({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Get.find<GenesisUserController>();

    List<AssignmentCard> assignmentCards = [];
    List<Assignment> assignments = user.getAllAssignments();
    for (Assignment assignment in assignments) {
      ClassData containingClass = user.findClassWithAssignment(assignment)!;
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
                    children: assignmentCards)),
          ],
        ),
      ),
    );
  }
}
