import 'package:flutter/material.dart';
import 'package:grades/utils/constants/colors.dart';
import 'package:grades/utils/constants/sizes.dart';
import 'package:grades/utils/helpers/helper_functions.dart';

class GenesisCard extends StatelessWidget {
  const GenesisCard({super.key, required this.child, this.color, this.padding});

  final Widget child;
  final Color? color;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final dark = GenesisHelpers.isDarkMode(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(GenesisSizes.md),
        ),
        color: color ??
            (dark ? GenesisColors.darkContainer : GenesisColors.lightContainer),
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(GenesisSizes.cardPaddingLg),
        child: child,
      ),
    );
  }
}
