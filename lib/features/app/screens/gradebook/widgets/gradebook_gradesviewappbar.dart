import 'package:flutter/material.dart';
import 'package:grades/common/widgets/appbar/appbar.dart';
import 'package:grades/utils/constants/colors.dart';
import 'package:grades/utils/constants/text_strings.dart';
import 'package:grades/utils/helpers/helper_functions.dart';

class GradesViewAppBar extends StatelessWidget {
  const GradesViewAppBar({
    super.key,
    required this.className,

    required this.gpaBoost,
  });

  final String className;

  final String gpaBoost;

  @override
  Widget build(BuildContext context) {
    final dark = GenesisHelpers.isDarkMode(context);
    return GenesisAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(className,
                  style: Theme.of(context).textTheme.headlineMedium!.apply(
                      color: dark
                          ? GenesisColors.grey
                          : GenesisColors.darkerGrey)),
              const Spacer(),
              Text(
                GenesisTexts.plus + gpaBoost,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .apply(color: GenesisColors.darkGrey),
              ),
            ],
          ),
          Text(
            "Swipe right to go back",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .apply(color: GenesisColors.darkerGrey),
          ),
        ],
      ),
    );
  }
}
