import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grades/common/widgets/genesis_card.dart';
import 'package:grades/features/authentication/controllers/user/user_controller.dart';
import 'package:grades/utils/constants/sizes.dart';
import 'package:grades/common/widgets/card_grid.dart';
import 'package:iconsax/iconsax.dart';

import 'home_stats_card_content.dart';

class GenesisGPAGrid extends StatelessWidget {
  const GenesisGPAGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Get.find<GenesisUserController>();
    return GenesisCardGrid(
      key: super.key,
      columns: 2,
      rows: 2,
      childAspectRatio: 2.2,
      children: [
        GenesisStatsCardContent(
          title: "Class Rank",
          stat: user.getClassRank(),
          units: " /500 students",
          icon: Icon(Iconsax.hashtag, color: Colors.yellow),
        ),
        GenesisStatsCardContent(
          title: "Attendance",
          stat: user.getAbsences().toString(),
          units: " absences",
          icon: Icon(Iconsax.calendar, color: Colors.red),
        ),
        GenesisStatsCardContent(
          title: "AP Count",
          stat: user.getAPCount(),
          units: " APs taken",
          icon: Icon(Iconsax.book_1, color: Colors.green),
        ),
        GenesisStatsCardContent(
          title: "GPA Trend",
          stat: "${user.getGPAYearlyChange()}%",
          units: " this month",
          icon: Icon(Iconsax.trend_up, color: Colors.blue),
        ),
      ],
    );
  }
}
