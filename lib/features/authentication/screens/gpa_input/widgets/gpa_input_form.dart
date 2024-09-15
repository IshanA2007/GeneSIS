import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grades/features/authentication/controllers/gpa_input/gpa_input_controller.dart';
import 'package:grades/navigation_menu.dart';
import 'package:grades/utils/constants/sizes.dart';
import 'package:grades/utils/constants/text_strings.dart';
import 'package:grades/utils/validators/validation.dart';
import 'package:iconsax/iconsax.dart';

import '../../../controllers/login/login_controller.dart';

class GenesisGPAInputForm extends StatelessWidget {
  const GenesisGPAInputForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GPAInputController());
    return Form(
      key: controller.gpaInputFormKey,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: GenesisSizes.spaceBtwSections),
        child: Column(
          children: [
            //email
            TextFormField(
                controller: controller.cumGPA,
                validator: (value) =>
                    GenesisValidator.validateCumGPA(value),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.trend_up),
                  labelText: GenesisTexts.cumGPA,
                )),
            const SizedBox(height: GenesisSizes.spaceBtwInputFields),
            //pass
            TextFormField(
              controller: controller.courseCreditsTaken,
              validator: (value) => GenesisValidator.validateEmptyText(
                  'Year courses taken', value),
              decoration: InputDecoration(
                prefixIcon: const Icon(Iconsax.hashtag),
                labelText: GenesisTexts.courseCreditsTaken,
              ),
            ),

            const SizedBox(height: GenesisSizes.spaceBtwInputFields / 2),
            const SizedBox(height: GenesisSizes.spaceBtwSections),

            //sign in
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  controller.submitGPAInput();
                },
                child: const Text(GenesisTexts.thereYouGo),
              ),
            ),
            const SizedBox(
              height: GenesisSizes.spaceBtwSections,
            )
          ],
        ),
      ),
    );
  }
}
