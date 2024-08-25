import 'package:flutter/material.dart';
import 'package:grades/features/app/screens/home/widgets/home_gpa_card.dart';
import 'package:grades/utils/constants/sizes.dart';

class GenesisGPAGrid extends StatelessWidget {
  const GenesisGPAGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: GenesisSizes.md),
      child: GridView.builder(
        itemCount: 4,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: GenesisSizes.spaceBtwItems,
            mainAxisSpacing: GenesisSizes.spaceBtwItems,
            childAspectRatio: 2.2),
        itemBuilder: (context, index) => GenesisGPACard(
          child: Container(
            child: Text("hi"),
          ),
        ),
      ),
    );
  }
}
