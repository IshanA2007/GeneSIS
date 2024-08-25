import 'package:flutter/material.dart';
import 'package:grades/features/app/screens/home/widgets/genesis_card.dart';
import 'package:grades/utils/constants/sizes.dart';

class GenesisCardGrid extends StatelessWidget {
  const GenesisCardGrid({super.key, required this.columns, required this.rows, required this.children});

  final int rows;
  final int columns;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: GenesisSizes.md),
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        removeBottom: true,
        child: GridView.builder(
          itemCount: columns*rows,
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              crossAxisSpacing: GenesisSizes.spaceBtwItems,
              mainAxisSpacing: GenesisSizes.spaceBtwItems,
              childAspectRatio: 2.2),
          itemBuilder: (context, index) {
            // make sure index in bounds
            if (index < children.length) {
              return GenesisCard(child: children[index]);
            }
            else{
              return const SizedBox.shrink();
            }
          }
        ),
      ),
    );
  }
}
