import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grades/common/widgets/appbar/appbar.dart';
import 'package:grades/utils/constants/colors.dart';
import 'package:grades/utils/constants/text_strings.dart';
import 'package:grades/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../authentication/screens/login/widgets/login_policy_view.dart';

class FeedAppBar extends StatelessWidget {
  const FeedAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = GenesisHelpers.isDarkMode(context);
    return GenesisAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(GenesisTexts.feedAppbarTitle,
              style: Theme.of(context).textTheme.headlineLarge!.apply(
                  color: dark ? GenesisColors.grey : GenesisColors.darkerGrey)),
          Text(GenesisTexts.feedAppbarSubTitle,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .apply(color: GenesisColors.darkGrey)),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Iconsax.notification,
              color: GenesisColors.primaryColor),
        ),
        IconButton(
          onPressed: () {Get.to(const PolicyView());},
          icon: const Icon(Iconsax.message_question, color: GenesisColors.primaryColor),
        )
      ],
    );
  }
}
