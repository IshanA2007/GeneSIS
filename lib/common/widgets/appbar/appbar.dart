import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grades/utils/constants/colors.dart';
import 'package:grades/utils/constants/sizes.dart';
import 'package:grades/utils/device/device_utilities.dart';
import 'package:iconsax/iconsax.dart';

class GenesisAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GenesisAppBar(
      {super.key,
      this.title,
      this.showBackArrow = false,
      this.leadingIcon,
      this.actions,
      this.leadingOnPressed});

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: GenesisSizes.md),
      child: AppBar(
        automaticallyImplyLeading: false,
        leading: showBackArrow
            ? IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(
                  Iconsax.arrow_left,
                  color: GenesisColors.primaryColor,
                ))
            : leadingIcon != null
                ? IconButton(
                    onPressed: leadingOnPressed, icon: Icon(leadingIcon))
                : null,
        title: title,
        actions: actions,
        toolbarHeight: 100.0,
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(GenesisDeviceUtils.getAppBarHeight());
}
