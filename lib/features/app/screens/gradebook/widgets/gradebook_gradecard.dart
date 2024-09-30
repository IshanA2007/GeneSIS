import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grades/utils/constants/colors.dart';
import 'package:grades/utils/constants/sizes.dart';
import 'package:grades/utils/helpers/helper_functions.dart';

import '../../../../../common/data/ClassData.dart';
import 'gradebook_gradesview.dart';

class GradeCard extends StatelessWidget {
  const GradeCard({
    super.key,
    required this.className,
    required this.monthlyChange,
    required this.missingAssignments,
    required this.letterGrade,
    required this.gradePercent,
    required this.classData,
  });

  final String className;
  final ClassData classData;
  final double monthlyChange;
  final int missingAssignments;
  final String letterGrade;
  final double gradePercent;

  @override
  Widget build(BuildContext context) {
    final dark = GenesisHelpers.isDarkMode(context);

    return InkWell(
      onTap: () {
        Get.to(() => GradesView(classData: classData));
      },
      child: Row(
        children: [
          // left - class name, change %, missing assignments
          Expanded(
            flex: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    className,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headlineSmall!.apply(
                        color:
                            dark ? GenesisColors.white : GenesisColors.black),
                  ),
                ),
                const SizedBox(
                  height: GenesisSizes.spaceBtwItems,
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                          const Spacer(),
                          Text(
                            '$missingAssignments missing assignments',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .apply(color: GenesisColors.darkGrey),
                          ),
                          // const Spacer(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // right - grade letter, percent
          Expanded(
            flex: 4,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
