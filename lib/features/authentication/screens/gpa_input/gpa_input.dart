import 'package:flutter/material.dart';
import 'package:grades/common/styles/spacing_styles.dart';
import 'package:grades/features/authentication/screens/gpa_input/widgets/gpa_input_form.dart';
import 'package:grades/features/authentication/screens/gpa_input/widgets/gpa_input_header.dart';
import 'package:grades/utils/helpers/helper_functions.dart';
import 'package:get_storage/get_storage.dart';

class GPAInputMenu extends StatelessWidget {
  const GPAInputMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final localStorage = GetStorage();
    final dark = GenesisHelpers.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: GenesisSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GenesisGPAInputHeader(dark: dark),
              const GenesisGPAInputForm(),

            ],
          ),
        ),
      ),
    );
  }
}
