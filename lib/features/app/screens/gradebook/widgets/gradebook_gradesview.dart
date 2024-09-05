import 'package:flutter/material.dart';
import 'package:grades/common/widgets/genesis_card.dart';
import 'package:grades/features/app/screens/gradebook/widgets/gradebook_gradesviewappbar.dart';
import 'package:grades/utils/constants/colors.dart';
import 'package:grades/utils/constants/sizes.dart';
import 'package:grades/utils/device/device_utilities.dart';

import 'gradebook_gradesview_gradebars.dart';

class GradesView extends StatelessWidget {
  const GradesView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            GradesViewAppBar(
              className: "Mobile/Web Research",
              gpaBoost: "1.0",
            ),
            SizedBox(
              height: GenesisSizes.spaceBtwSections,
            ),
            GradesViewGradeBars(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: GenesisSizes.md),
              child: GenesisCard(
                child: SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [

                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Grades"),
                          ],
                        ),
                      ),

                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Trends"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
