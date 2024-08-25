import 'package:flutter/material.dart';
import 'package:grades/common/widgets/appbar/appbar.dart';
import 'package:grades/features/app/screens/home/widgets/home_appbar.dart';
import 'package:grades/features/app/screens/home/widgets/genesis_card.dart';
import 'package:grades/features/app/screens/home/widgets/home_gpa_card_content.dart';
import 'package:grades/features/app/screens/home/widgets/home_gpa_grid.dart';
import 'package:grades/utils/constants/colors.dart';
import 'package:grades/utils/constants/sizes.dart';
import 'package:grades/utils/constants/text_strings.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            GenesisHomeAppBar(),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: GenesisSizes.md,
                  vertical: GenesisSizes.spaceBtwItems),
              child: GenesisCard(
                child: GenesisGPACardContent(),
              ),
            ),
            GenesisGPAGrid()
            //GenesisStatsGridView
            //GenesisGPACarousel
          ],
        ),
      ),
    );
  }
}

