import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:grades/utils/constants/colors.dart';
import 'package:grades/utils/constants/sizes.dart';

class GenesisAnimationLoaderWidget extends StatelessWidget {
  const GenesisAnimationLoaderWidget(
      {super.key,
      required this.text,
      required this.animation,
      required this.showAction,
      this.actionText,
      this.onActionPressed});

  final String text;
  final String animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(animation,
              width: MediaQuery.of(context).size.width * 0.8),
          const SizedBox(height: GenesisSizes.defaultSpacing),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: GenesisSizes.defaultSpacing),
          showAction
              ? SizedBox(
                  width: 250,
                  child: OutlinedButton(
                    onPressed: onActionPressed,
                    style: OutlinedButton.styleFrom(
                        backgroundColor: GenesisColors.black),
                    child: Text(
                      actionText!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: GenesisColors.lightBackground),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
