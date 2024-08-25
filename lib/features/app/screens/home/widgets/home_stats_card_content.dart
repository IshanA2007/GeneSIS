import 'package:flutter/material.dart';
import 'package:grades/utils/constants/colors.dart';

class GenesisStatsCardContent extends StatelessWidget {
  const GenesisStatsCardContent(
      {super.key,
      required this.title,
      required this.stat,
      required this.units,
      required this.icon});

  final String title;
  final String stat;
  final String units;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleMedium!),
              const Spacer(),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: stat,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .apply(color: GenesisColors.grey)),
                    TextSpan(
                        text: units,
                        style: Theme.of(context).textTheme.labelSmall!),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              icon,
            ],
          ),
        ),
      ],
    );
  }
}
