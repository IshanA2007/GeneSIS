import 'package:flutter/material.dart';
import 'package:grades/common/widgets/appbar/appbar.dart';
import 'package:grades/utils/constants/sizes.dart';
import 'package:grades/utils/constants/colors.dart';
import 'package:grades/utils/helpers/helper_functions.dart';

class PolicyView extends StatelessWidget {
  const PolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = GenesisHelpers.isDarkMode(context);
    return Scaffold(
      appBar: GenesisAppBar(
        title: Text(
          "Privacy Policy",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(GenesisSizes.defaultSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "1. Introduction",
              style: Theme.of(context).textTheme.headlineSmall!.apply(
                  color: dark ? GenesisColors.white : GenesisColors.black),
            ),
            const SizedBox(height: GenesisSizes.spaceBtwItems),
            Text(
              "We are committed to safeguarding the privacy of our users. This Privacy Policy outlines how we handle your personal data when using our application, particularly focusing on login credentials and academic information.",
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: dark ? GenesisColors.grey : GenesisColors.darkGrey),
            ),
            const SizedBox(height: GenesisSizes.spaceBtwSections),

            Text(
              "2. Collection and Use of Personal Information",
              style: Theme.of(context).textTheme.headlineSmall!.apply(
                  color: dark ? GenesisColors.white : GenesisColors.black),
            ),
            const SizedBox(height: GenesisSizes.spaceBtwItems),
            Text(
              "Our app collects only the data necessary for functionality, specifically your username and password for authenticating with the SIS StudentVue system. This information is solely used to retrieve your academic data and is never stored or transmitted to any third party.",
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: dark ? GenesisColors.grey : GenesisColors.darkGrey),
            ),
            const SizedBox(height: GenesisSizes.spaceBtwSections),

            Text(
              "3. Login Credentials and Security",
              style: Theme.of(context).textTheme.headlineSmall!.apply(
                  color: dark ? GenesisColors.white : GenesisColors.black),
            ),
            const SizedBox(height: GenesisSizes.spaceBtwItems),
            Text(
              "When you input your login details, they are immediately sent directly to the SIS StudentVue system for authentication. At no point are your username and password stored on external servers. If you opt to use the 'Remember Me' feature, your credentials are securely stored locally on your device only, and are never accessible by us or any third party.",
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: dark ? GenesisColors.grey : GenesisColors.darkGrey),
            ),
            const SizedBox(height: GenesisSizes.spaceBtwSections),

            Text(
              "4. Academic Data",
              style: Theme.of(context).textTheme.headlineSmall!.apply(
                  color: dark ? GenesisColors.white : GenesisColors.black),
            ),
            const SizedBox(height: GenesisSizes.spaceBtwItems),
            Text(
              "Once authenticated, your academic data is retrieved from SIS StudentVue and displayed within the app. This data is never stored externally; it is processed only for the purpose of being displayed on your device. No sensitive academic information is saved on external databases, ensuring that only you have access to your academic records.",
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: dark ? GenesisColors.grey : GenesisColors.darkGrey),
            ),
            const SizedBox(height: GenesisSizes.spaceBtwSections),

            Text(
              "5. Data Security",
              style: Theme.of(context).textTheme.headlineSmall!.apply(
                  color: dark ? GenesisColors.white : GenesisColors.black),
            ),
            const SizedBox(height: GenesisSizes.spaceBtwItems),
            Text(
              "We take security very seriously and employ industry-standard measures to protect your data. As your username and password are not stored externally, and all academic data is simply read and displayed on your device without being retained, we minimize any potential risk of data exposure.",
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: dark ? GenesisColors.grey : GenesisColors.darkGrey),
            ),
            const SizedBox(height: GenesisSizes.spaceBtwSections),

            Text(
              "6. Conclusion",
              style: Theme.of(context).textTheme.headlineSmall!.apply(
                  color: dark ? GenesisColors.white : GenesisColors.black),
            ),
            const SizedBox(height: GenesisSizes.spaceBtwItems),
            Text(
              "Your privacy is our utmost priority. By using this app, you can be assured that we do not store or share any sensitive information like your username, password, or academic data externally. We are committed to respecting your privacy and ensuring the security of your personal data at all times.",
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: dark ? GenesisColors.grey : GenesisColors.darkGrey),
            ),
          ],
        ),
      ),
    );
  }
}
