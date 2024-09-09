import 'package:flutter/material.dart';
import 'package:grades/common/widgets/appbar/appbar.dart';
import 'package:grades/common/widgets/card_grid.dart';
import 'package:grades/common/widgets/containers/circular_container.dart';
import 'package:grades/features/app/screens/feed/widgets/feed_appbar.dart';
import 'package:grades/features/app/screens/feed/widgets/feed_filterbar.dart';
import 'package:grades/features/app/screens/feed/widgets/feed_assignmentcard.dart';
import 'package:grades/utils/constants/colors.dart';
import 'package:grades/utils/constants/sizes.dart';
import 'package:grades/utils/constants/text_strings.dart';
import 'package:iconsax/iconsax.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Feed extends StatelessWidget {
  const Feed({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            FeedAppBar(),
            Padding(padding: EdgeInsets.symmetric(horizontal: GenesisSizes.md), child: FeedFilterBar()),
            SizedBox(
              height: GenesisSizes.spaceBtwItems,
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: GenesisSizes.md), child:
            GenesisCardGrid(cardPadding: EdgeInsets.all(0), columns: 2, rows: 2, children: [
              AssignmentCard(date: "8/26/24", className: "Mobile WebAppRes TJ AV", gradePercent: "50.4", points: 20, totalPoints: 30, impact: 1, name: "Unit 1 Roadmap"),
            AssignmentCard(date: "11/2/24", className: "Mobile WebAppRes TJ AV", gradePercent: "50.4", points: 20, totalPoints: 30, impact: -1, name: "Unit 1 Roadmap"),
            AssignmentCard(date: "11/22/24", className: "Mobile WebAppRes TJ AV", gradePercent: "50.4", points: 20, totalPoints: 30, impact: 1, name: "Unit 1 Roadmap"),], childAspectRatio: 0.8)
            ),
          ],
        ),
      ),
    );
  }
}
