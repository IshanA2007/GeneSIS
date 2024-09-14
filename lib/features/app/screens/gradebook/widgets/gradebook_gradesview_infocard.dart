
import 'package:flutter/material.dart';

import '../../../../../common/widgets/genesis_card.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class GradesViewInfoCard extends StatelessWidget {
  const GradesViewInfoCard({
    super.key,
    required this.weeklyChange,
    required this.monthlyChange,
    required this.semesterChange,
    required this.letterGrade,
    required this.missingAssignments,
    required this.gradePercent,
  });
  final String letterGrade;
  final int missingAssignments;
  final double gradePercent;
  final int weeklyChange;
  final int monthlyChange;
  final int semesterChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: GenesisSizes.md),
      child: GenesisCard(
        child: SizedBox(
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Grades",
                        style: Theme.of(context).textTheme.titleLarge!),
                    const SizedBox(height: GenesisSizes.sm),
                    Text(
                      letterGrade,
                      style: const TextStyle(
                        fontSize: 60.0,
                        fontWeight: FontWeight.w500,
                        color: GenesisColors.primaryColor,
                      ),
                      textHeightBehavior: const TextHeightBehavior(
                        applyHeightToFirstAscent: false,
                        applyHeightToLastDescent: false,
                      ),
                    ),
                    Text(
                      '${gradePercent.toStringAsFixed(2)}%',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .apply(color: GenesisColors.grey),
                      textHeightBehavior: const TextHeightBehavior(
                        applyHeightToFirstAscent: false,
                        applyHeightToLastDescent: false,
                      ),
                    ),
                    const SizedBox(height: GenesisSizes.spaceBtwItems),
                    Text(
                      '$missingAssignments missing assignments',
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .apply(color: GenesisColors.darkGrey),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Trends",
                        style: Theme.of(context).textTheme.titleLarge!),
                    const SizedBox(height: GenesisSizes.spaceBtwItems),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                            "${weeklyChange >= 0 ? '+' : '-'}${weeklyChange.abs()}%",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .apply(
                              color: weeklyChange >= 0
                                  ? Colors.greenAccent
                                  : Colors.redAccent,
                            ),
                          ),
                          TextSpan(
                            text: " change this week",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .apply(color: GenesisColors.darkerGrey),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: GenesisSizes.sm),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                            "${monthlyChange >= 0 ? '+' : '-'}${monthlyChange.abs()}%",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .apply(
                              color: monthlyChange >= 0
                                  ? Colors.greenAccent
                                  : Colors.redAccent,
                            ),
                          ),
                          TextSpan(
                            text: " change this month",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .apply(color: GenesisColors.darkerGrey),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: GenesisSizes.sm),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                            "${semesterChange >= 0 ? '+' : '-'}${semesterChange.abs()}%",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .apply(
                              color: semesterChange >= 0
                                  ? Colors.greenAccent
                                  : Colors.redAccent,
                            ),
                          ),
                          TextSpan(
                            text: " change this semester",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .apply(color: GenesisColors.darkerGrey),
                          ),
                        ],
                      ),
                    ),
                    // this one needs to be at the bottom
                    const SizedBox(height: GenesisSizes.spaceBtwItems),

                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Boosts your GPA ",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .apply(color: GenesisColors.darkerGrey),
                          ),
                          TextSpan(
                            text:
                            "${monthlyChange >= 0 ? '+' : '-'}${monthlyChange.abs()}%",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .apply(
                              color: monthlyChange >= 0
                                  ? Colors.greenAccent
                                  : Colors.redAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}