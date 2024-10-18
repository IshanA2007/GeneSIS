import 'package:flutter/material.dart';
import 'package:grades/common/widgets/appbar/appbar.dart';
import 'package:grades/utils/constants/sizes.dart';
import 'package:grades/utils/constants/colors.dart';
import 'package:grades/utils/helpers/helper_functions.dart';

class GenesisDashboardInfoScreen extends StatelessWidget {
  const GenesisDashboardInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = GenesisHelpers.isDarkMode(context);
    return Scaffold(
      appBar: GenesisAppBar(
        title: Text(
          "Dashboard Information",
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
              "1. Cumulative GPA",
              style: Theme.of(context).textTheme.headlineSmall!.apply(
                  color: dark ? GenesisColors.white : GenesisColors.black),
            ),
            const SizedBox(height: GenesisSizes.spaceBtwItems),
            Text(
              "Your cumulative GPA is an estimate based on the GPA you provide and your current classes and grades. "
                  "While not 100% accurate, the estimation has less than a 1% error margin, making it a reliable representation of your academic standing.",
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: dark ? GenesisColors.grey : GenesisColors.darkGrey),
            ),
            const SizedBox(height: GenesisSizes.spaceBtwSections),

            Text(
              "2. GPA Goal",
              style: Theme.of(context).textTheme.headlineSmall!.apply(
                  color: dark ? GenesisColors.white : GenesisColors.black),
            ),
            const SizedBox(height: GenesisSizes.spaceBtwItems),
            Text(
              "The GPA goal is a target set by you within the app’s settings. It serves as a personal motivational tool, "
                  "and can be adjusted at any time to reflect your academic aspirations.",
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: dark ? GenesisColors.grey : GenesisColors.darkGrey),
            ),
            const SizedBox(height: GenesisSizes.spaceBtwSections),

            Text(
              "3. Class Ranking",
              style: Theme.of(context).textTheme.headlineSmall!.apply(
                  color: dark ? GenesisColors.white : GenesisColors.black),
            ),
            const SizedBox(height: GenesisSizes.spaceBtwItems),
            Text(
              "Class ranking is an unofficial statistic calculated by the app based on the current cumulative GPAs of all users, "
                  "not including the previous year’s GPA. This statistic is meant to help you gauge your standing relative to your class. "
                  "For privacy, the cumulative GPA is stored anonymously in an external database and is never tied to your identity.",
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: dark ? GenesisColors.grey : GenesisColors.darkGrey),
            ),
            const SizedBox(height: GenesisSizes.spaceBtwSections),

            Text(
              "4. Attendance",
              style: Theme.of(context).textTheme.headlineSmall!.apply(
                  color: dark ? GenesisColors.white : GenesisColors.black),
            ),
            const SizedBox(height: GenesisSizes.spaceBtwItems),
            Text(
              "Your attendance statistic is pulled directly from SIS StudentVue. It includes all types of absences, both excused and unexcused.",
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: dark ? GenesisColors.grey : GenesisColors.darkGrey),
            ),
            const SizedBox(height: GenesisSizes.spaceBtwSections),

            Text(
              "5. AP Count",
              style: Theme.of(context).textTheme.headlineSmall!.apply(
                  color: dark ? GenesisColors.white : GenesisColors.black),
            ),
            const SizedBox(height: GenesisSizes.spaceBtwItems),
            Text(
              "The AP count represents the number of AP courses you're currently taking. It does not include Post-AP or other weighted courses that provide +1.0 GPA points.",
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: dark ? GenesisColors.grey : GenesisColors.darkGrey),
            ),
            const SizedBox(height: GenesisSizes.spaceBtwSections),

            Text(
              "6. GPA Trend",
              style: Theme.of(context).textTheme.headlineSmall!.apply(
                  color: dark ? GenesisColors.white : GenesisColors.black),
            ),
            const SizedBox(height: GenesisSizes.spaceBtwItems),
            Text(
              "The GPA trend statistic visualizes how your GPA has changed throughout the current academic year. It helps you track academic progress over time.",
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: dark ? GenesisColors.grey : GenesisColors.darkGrey),
            ),
            const SizedBox(height: GenesisSizes.spaceBtwSections),

            Text(
              "7. Grade History",
              style: Theme.of(context).textTheme.headlineSmall!.apply(
                  color: dark ? GenesisColors.white : GenesisColors.black),
            ),
            const SizedBox(height: GenesisSizes.spaceBtwItems),
            Text(
              "The grade history feature displays how your class grades or cumulative GPA have trended over time. "
                  "Individual class graphs update with each new assignment returned, while your cumulative GPA graph is updated daily. "
                  "This feature helps you identify trends in your academic performance.",
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: dark ? GenesisColors.grey : GenesisColors.darkGrey),
            ),
            const SizedBox(height: GenesisSizes.spaceBtwSections),
          ],
        ),
      ),
    );
  }
}
