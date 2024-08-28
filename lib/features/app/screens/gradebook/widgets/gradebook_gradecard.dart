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

    return Row(
      children: [
        // left - class name, change %, missing assignments
        Expanded(
          flex: 8,
          child: FittedBox(fit: BoxFit.fitHeight, alignment: Alignment.centerLeft, child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                className,
                style: Theme.of(context).textTheme.headlineSmall!.apply(
                    color: dark ? GenesisColors.white : GenesisColors.white),
              ),
              // const Spacer(),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "${monthlyChange >= 0 ? '+' : '-'}${monthlyChange.abs()}%",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: monthlyChange >= 0
                            ? Colors.greenAccent
                            : Colors.redAccent,
                      ),
                    ),
                    const TextSpan(
                      text: " change this month",
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              // const Spacer(),
              Text(
                '$missingAssignments missing assignments',
                style: const TextStyle(
                  fontSize: 10.0,
                  color: Colors.grey,
                ),
              ),
              // const Spacer(),
              ],
            ),
          ),
        ),
        // right - grade letter, percent
        Expanded(
          flex: 4,
          child: FittedBox(fit: BoxFit.contain, child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                letterGrade,
                style: const TextStyle(
                  fontSize: 60.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.tealAccent,
                ),
                textHeightBehavior: const TextHeightBehavior(
                  applyHeightToFirstAscent: false,
                  applyHeightToLastDescent: false,
                ),
              ),
              Text(
                '${gradePercent.toStringAsFixed(2)}%',
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey,
                ),
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
    );
  }
}
