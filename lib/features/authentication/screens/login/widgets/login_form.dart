
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grades/navigation_menu.dart';
import 'package:grades/utils/constants/sizes.dart';
import 'package:grades/utils/constants/text_strings.dart';
import 'package:iconsax/iconsax.dart';

class GenesisLoginForm extends StatelessWidget {
  const GenesisLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: GenesisSizes.spaceBtwSections),
        child: Column(children: [
          //email
          TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: GenesisTexts.email,
              )),
          const SizedBox(height: GenesisSizes.spaceBtwInputFields),
          //pass
          TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.password_check),
                labelText: GenesisTexts.password,
                suffixIcon: Icon(Iconsax.eye_slash),
              )),
          const SizedBox(
              height: GenesisSizes.spaceBtwInputFields / 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(value: true, onChanged: (value) {}),
                  const Text(GenesisTexts.rememberMe)
                ],
              ),
              TextButton(
                  onPressed: () {},
                  child: const Text(GenesisTexts.forgotPassword))
            ],
          ),
          const SizedBox(height: GenesisSizes.spaceBtwSections),
          //sign in
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {Get.to(() => const NavigationMenu());},
              child: const Text(GenesisTexts.signIn),
            ),
          ),
          const SizedBox(
            height: GenesisSizes.spaceBtwSections,
          )
        ]),
      ),
    );
  }
}