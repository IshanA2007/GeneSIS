import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grades/navigation_menu.dart';
import 'package:grades/utils/constants/sizes.dart';
import 'package:grades/utils/constants/text_strings.dart';
import 'package:grades/utils/validators/validation.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../controllers/login/login_controller.dart';

class GenesisLoginForm extends StatelessWidget {
  const GenesisLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: GenesisSizes.spaceBtwSections),
        child: Column(children: [
          //email
          TextFormField(
              controller: controller.email,
              validator: (value) => GenesisValidator.validateEmail(value),
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: GenesisTexts.id,
              )),
          const SizedBox(height: GenesisSizes.spaceBtwInputFields),
          //pass
          Obx(
            () => TextFormField(
              controller: controller.password,
              obscureText: controller.hidePassword.value,
              validator: (value) =>
                  GenesisValidator.validateEmptyText('Password', value),
              decoration: InputDecoration(
                prefixIcon: const Icon(Iconsax.password_check),
                labelText: GenesisTexts.password,
                suffixIcon: IconButton(
                  onPressed: () => controller.hidePassword.value =
                      !controller.hidePassword.value,
                  icon: Icon(controller.hidePassword.value
                      ? Iconsax.eye_slash
                      : Iconsax.eye),
                ),
              ),
            ),
          ),
          const SizedBox(height: GenesisSizes.spaceBtwInputFields / 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Obx(
                    () => Checkbox(
                        value: controller.rememberMe.value,
                        onChanged: (value) => controller.rememberMe.value =
                            !controller.rememberMe.value),
                  ),
                  const Text(GenesisTexts.rememberMe)
                ],
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  GenesisTexts.forgotPassword,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .apply(color: GenesisColors.info),
                ),
              ),
            ],
          ),
          const SizedBox(height: GenesisSizes.spaceBtwSections),
          //sign in
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                controller.emailAndPasswordSignIn();
              },
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
