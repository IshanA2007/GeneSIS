import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grades/common/widgets/appbar/appbar.dart';
import 'package:grades/features/app/screens/home/widgets/home_info_screen.dart';
import 'package:grades/features/authentication/controllers/user/user_controller.dart';
import 'package:grades/utils/constants/colors.dart';
import 'package:grades/utils/constants/text_strings.dart';
import 'package:grades/utils/device/device_utilities.dart';
import 'package:grades/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/local_storage/storage_utility.dart';
import '../../../../authentication/screens/login/widgets/login_policy_view.dart';

class GenesisHomeAppBar extends StatelessWidget {
  const GenesisHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = GenesisHelpers.isDarkMode(context);
    final user = Get.find<GenesisUserController>();
    return GenesisAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(GenesisTexts.homeAppbarTitle + user.getUsername(),
              style: Theme.of(context).textTheme.headlineLarge!.apply(
                  color: dark ? GenesisColors.grey : GenesisColors.black)),
          Text(GenesisTexts.homeAppbarSubTitle,
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
          onPressed: () {Get.to(const GenesisDashboardInfoScreen());},
          icon: const Icon(Iconsax.message_question, color: GenesisColors.primaryColor),
        )
      ],
    );
  }
}
