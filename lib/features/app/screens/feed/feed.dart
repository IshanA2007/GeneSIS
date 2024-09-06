import 'package:flutter/material.dart';
import 'package:grades/common/widgets/appbar/appbar.dart';
import 'package:grades/common/widgets/card_grid.dart';
import 'package:grades/common/widgets/containers/circular_container.dart';
import 'package:grades/features/app/screens/feed/widgets/feed_appbar.dart';
import 'package:grades/features/app/screens/feed/widgets/feed_filterbar.dart';
import 'package:grades/common/widgets/genesis_card.dart';
import 'package:grades/features/app/screens/home/widgets/home_carousel_graph.dart';
import 'package:grades/features/app/screens/home/widgets/home_gpa_card_content.dart';
import 'package:grades/features/app/screens/home/widgets/home_gpa_grid.dart';
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
            GenesisCardGrid(columns: 2, rows: 2, children: [Text("b1"), Text("b2"), Text("b3")], childAspectRatio: 0.8)
            ),
          ],
        ),
      ),
    );
  }
}
