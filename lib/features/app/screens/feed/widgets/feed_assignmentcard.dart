import 'package:flutter/material.dart';
import 'package:grades/features/app/screens/gradebook/widgets/gradebook_gradesview.dart';
import 'package:grades/utils/constants/colors.dart';
import 'package:grades/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:studentvueclient/studentvueclient.dart';

import '../../../../../common/data/ClassData.dart';

class AssignmentCard extends StatelessWidget {
  final Assignment assignment;
  final ClassData course;

  const AssignmentCard({super.key, required this.assignment, required this.course});

  @override
  Widget build(BuildContext context) {
    int impact = 24; //TODO: make an assignment impact
    Color impactColor = impact > 0
        ? GenesisColors.success
        : impact < 0
            ? GenesisColors.error
            : GenesisColors.grey;

    Color shadowColor = impact > 0
        ? GenesisColors.feedGreen
        : impact < 0
            ? GenesisColors.error
            : GenesisColors.grey;

    String impactText = impact > 0 ? "+$impact%" : "$impact%";

    return InkWell(
      onTap: () {
        Get.to(() => GradesView(classData: course));
      },
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(GenesisSizes.md),
            width: double.infinity,
            decoration: BoxDecoration(
              color:
                  GenesisColors.differentGrey, // background color for top part
              borderRadius: BorderRadius.circular(GenesisSizes.cardRadiusMd),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  assignment.assignmentName,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.labelMedium!,
                ),
                Text(assignment.date, style: Theme.of(context).textTheme.labelSmall!),
                const SizedBox(height: GenesisSizes.sm),
                Text(
                  "${(assignment.earnedPoints*100/assignment.possiblePoints).toStringAsFixed(1)}%",
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .apply(color: GenesisColors.feedAssignmentPercentColor),
                ),
                Text(
                  "${assignment.earnedPoints}/${assignment.possiblePoints}",
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .apply(color: GenesisColors.grey),
                ),
                const SizedBox(height: GenesisSizes.sm),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "$impactText ",
                        style:
                            Theme.of(context).textTheme.labelMedium!.copyWith(
                                  color: impactColor,
                                ),
                      ),
                      TextSpan(
                        text: "impact",
                        style:
                            Theme.of(context).textTheme.labelMedium!.copyWith(
                                  color: GenesisColors.darkGrey,
                                ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: shadowColor.withOpacity(0.6),
                    // Shadow color based on impact
                    offset: const Offset(0, 3),
                    // Shift the shadow downward
                    blurRadius: 1.0,
                    // How much the shadow is blurred
                    spreadRadius: 0, // How far the shadow spreads
                  ),
                ],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(GenesisSizes.cardRadiusMd),
                  bottomRight: Radius.circular(GenesisSizes.cardRadiusMd),
                ),
                color: GenesisColors.black, // background color for bottom part
              ),
              padding: const EdgeInsets.symmetric(
                  vertical: GenesisSizes.lg, horizontal: GenesisSizes.md),
              alignment: Alignment.center,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(course.courseName,
                    style: Theme.of(context).textTheme.titleLarge!),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
