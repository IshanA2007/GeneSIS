import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grades/utils/constants/colors.dart';
import 'package:grades/utils/constants/sizes.dart';
import 'package:grades/utils/theme/custom_themes/text_theme.dart';

class AssignmentCard extends StatelessWidget {
  final String name;
  final String gradePercent;
  final double points;
  final double totalPoints;
  final int impact; // positive, negative, or neutral impact
  final String className;
  final String date;

  const AssignmentCard(
      {super.key,
      required this.name,
      required this.gradePercent,
      required this.points,
      required this.totalPoints,
      required this.impact,
      required this.className,
      required this.date});

  @override
  Widget build(BuildContext context) {
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

    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(GenesisSizes.md),
          width: double.infinity,
          decoration: BoxDecoration(
            color: GenesisColors.differentGrey, // background color for top part
            borderRadius: BorderRadius.circular(GenesisSizes.cardRadiusMd),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: Theme.of(context).textTheme.labelMedium!,
              ),
              Text(date, style: Theme.of(context).textTheme.labelSmall!),
              const SizedBox(height: GenesisSizes.sm),
              Text(
                "$gradePercent%",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .apply(color: GenesisColors.feedAssignmentPercentColor),
              ),
              Text(
                "$points/$totalPoints",
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
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            color: impactColor,
                          ),
                    ),
                    TextSpan(
                      text: "impact",
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
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
                  offset: Offset(0, 3),
                  // Shift the shadow downward
                  blurRadius: 1.0,
                  // How much the shadow is blurred
                  spreadRadius: 0, // How far the shadow spreads
                ),
              ],
              borderRadius: BorderRadius.only(
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
              child: Text(className,
                  style: Theme.of(context).textTheme.titleLarge!),
            ),
          ),
        ),
      ],
    );
  }
}
