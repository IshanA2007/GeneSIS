import 'package:flutter/material.dart';
import 'package:grades/utils/constants/colors.dart';
import 'package:grades/utils/constants/sizes.dart';
import 'package:grades/utils/helpers/helper_functions.dart';

class GradeCard extends StatelessWidget {
  const GradeCard({
    super.key,
    required this.className,
    required this.monthlyChange,
    required this.missingAssignments,
    required this.letterGrade,
    required this.gradePercent,
  });

  final String className;
  final int monthlyChange;
  final int missingAssignments;
  final String letterGrade;
  final double gradePercent;
  @override
  Widget build(BuildContext context) {
    final dark = GenesisHelpers.isDarkMode(context);

    return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: GenesisSizes.sm,
                  vertical: GenesisSizes.sm),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // left - class name, change %, missing assignments
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        className,
                        style: Theme.of(context).textTheme.headlineMedium!.apply(color: dark ? GenesisColors.white : GenesisColors.white)
                      ),
                      const Spacer(),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "${monthlyChange >= 0 ? '+' : '-'}${monthlyChange.abs()}%",
                              style: TextStyle(
                                fontSize: 14.0,
                                color: monthlyChange >= 0 ? Colors.greenAccent : Colors.redAccent,
                              ),
                            ),
                            const TextSpan(
                              text: " change this month",
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '$missingAssignments missing assignments',
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  // right - grade letter, percent
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        letterGrade,
                        style: const TextStyle(
                          fontSize: 64.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.tealAccent,
                          
                        ),
                      ),
                      Text(
                        '${gradePercent.toStringAsFixed(2)}%',
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
  }
}