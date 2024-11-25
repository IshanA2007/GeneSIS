import 'package:flutter/material.dart';
import 'package:grades/features/app/screens/settings/widgets/settings_setting.dart';
import 'package:grades/features/app/screens/settings/widgets/settings_appbar.dart';
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
            Padding(padding: const EdgeInsets.symmetric(horizontal: GenesisSizes.md * 2), child:
              Text("General", style: Theme.of(context)
                        .textTheme
                        .titleLarge),
            ),
            const Padding(padding: EdgeInsets.symmetric(horizontal: GenesisSizes.md * 2), child:
              Setting(name: "Login with FaceID", type: "switch", status: 0),
            ),
            const Padding(padding: EdgeInsets.symmetric(horizontal: GenesisSizes.md * 2), child:
            Setting(name: "Grade trend alerts", type: "switch", status: 0),
            ),
            const Padding(padding: EdgeInsets.symmetric(horizontal: GenesisSizes.md * 2), child:
            Setting(name: "Missing work alerts", type: "switch", status: 0),
            ),

          ],
        ),
      ),
    );
  }
}
