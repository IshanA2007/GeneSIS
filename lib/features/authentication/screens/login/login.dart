import 'package:flutter/material.dart';
import 'package:grades/common/styles/spacing_styles.dart';
import 'package:grades/features/authentication/screens/login/widgets/login_form.dart';
import 'package:grades/features/authentication/screens/login/widgets/login_header.dart';
import 'package:grades/utils/constants/colors.dart';
import 'package:grades/utils/constants/image_strings.dart';
import 'package:grades/utils/constants/sizes.dart';
import 'package:grades/utils/constants/text_strings.dart';
import 'package:grades/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = GenesisHelpers.isDarkMode(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: GenesisSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              GenesisLoginHeader(dark: dark),
              const GenesisLoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}

