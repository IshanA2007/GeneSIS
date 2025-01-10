import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grades/features/authentication/controllers/user/user_controller.dart';
import 'package:grades/common/widgets/card_grid.dart';
import 'package:iconsax/iconsax.dart';

import 'home_stats_card_content.dart';

class GenesisGPAGrid extends StatelessWidget {
  const GenesisGPAGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Get.find<GenesisUserController>();
    var classrank = user.getClassRank()["rank"] ?? -1;
    var total = user.getClassRank()["total"] ?? 500;
    if(total==0){
      total = 1; // idk it should stop the error?
    }
    var multiplier = 500 / total;
    total = (total * multiplier).round();
    classrank = (classrank * multiplier).round();
    return GenesisCardGrid(
      key: super.key,
      columns: 2,
      rows: 2,
      childAspectRatio: 2.2,
      children: [
        GenesisStatsCardContent(
          title: "Class Rank",
          // stat: (user.getClassRank()["rank"] ?? -1).toString(),
          // units: " /${user.getClassRank()["total"]} students",
          stat: (classrank).toString(),
          units: " /$total students",
          icon: const Icon(Iconsax.hashtag, color: Colors.yellow),
        ),
        GenesisStatsCardContent(
          title: "Attendance",
          stat: user.getAbsences().toString(),
          units: " absences",
          icon: const Icon(Iconsax.calendar, color: Colors.red),
        ),
        GenesisStatsCardContent(
          title: "AP Count",
          stat: user.getAPCount(),
          units: " APs taken",
          icon: const Icon(Iconsax.book_1, color: Colors.green),
        ),
        GenesisStatsCardContent(
          title: "GPA Trend",
          stat: "${user.getGPAYearlyChange()}%",
          units: " this month",
          icon: const Icon(Iconsax.trend_up, color: Colors.blue),
        ),
      ],
    );
  }
}
