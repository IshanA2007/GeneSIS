import 'package:flutter/material.dart';
import 'package:grades/features/app/screens/feed/widgets/feed_appbar.dart';
import 'package:grades/features/app/screens/settings/widgets/settings_setting.dart';
import 'package:grades/features/app/screens/settings/widgets/settings_appbar.dart';
import 'package:grades/utils/constants/colors.dart';
import 'package:grades/utils/constants/sizes.dart';


class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SettingsAppBar(),
            Padding(padding: const EdgeInsets.symmetric(horizontal: GenesisSizes.md), child:
              Text("General", style: Theme.of(context)
                        .textTheme
                        .titleLarge),
            ),
            const Padding(padding: EdgeInsets.symmetric(horizontal: GenesisSizes.md), child:
              Setting(name: "allow us to steal your user data", type: "switch", status: 0),
            ),
          ],
        ),
      ),
    );
  }
}
