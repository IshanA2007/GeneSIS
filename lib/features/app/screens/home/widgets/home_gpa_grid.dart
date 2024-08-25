import 'package:flutter/material.dart';
import 'package:grades/features/app/screens/home/widgets/genesis_card.dart';
import 'package:grades/utils/constants/sizes.dart';
import 'package:grades/features/app/screens/home/widgets/card_grid.dart';
import 'package:iconsax/iconsax.dart';

import 'home_stats_card_content.dart';

class GenesisGPAGrid extends StatelessWidget {
  const GenesisGPAGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GenesisCardGrid(
      key: super.key,
      columns: 2,
      rows: 3,
      children: const [
        GenesisStatsCardContent(
          title: "Class Rank",
          stat: "15",
          units: " /500 students",
          icon: Icon(Iconsax.hashtag, color: Colors.yellow),
        ),
        GenesisStatsCardContent(
          title: "Attendance",
          stat: "95%",
          units: " 4 absences",
          icon: Icon(Iconsax.calendar, color: Colors.red),
        ),
        GenesisStatsCardContent(
          title: "AP Count",
          stat: "11",
          units: " APs taken",
          icon: Icon(Iconsax.book_1, color: Colors.green),
        ),
        GenesisStatsCardContent(
          title: "GPA Trend",
          stat: "-20%",
          units: " this month",
          icon: Icon(Iconsax.hashtag, color: Colors.blue),
        ),
      ],
    );
  }
}
