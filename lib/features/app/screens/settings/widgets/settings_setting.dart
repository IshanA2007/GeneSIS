import 'package:flutter/material.dart';
import 'package:grades/features/app/screens/settings/widgets/settings_switch.dart';
import 'package:grades/utils/constants/colors.dart';

class Setting extends StatelessWidget {
  final String name;
  final String type;
  final int status;

  const Setting({super.key, required this.name, required this.type, required this.status});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children:[
      Text(name, style: Theme.of(context)
                        .textTheme
                        .bodyMedium!.apply(color: GenesisColors.darkGrey)),
      SettingsSwitch(status: status),
    ],);
  }
}