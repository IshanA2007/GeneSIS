import 'package:flutter/material.dart';
import 'package:grades/utils/constants/colors.dart';

class SettingsSwitch extends StatefulWidget {
  final int status;

  const SettingsSwitch({super.key, required this.status});

  @override
  _SettingsSwitchState createState() => _SettingsSwitchState();
}

class _SettingsSwitchState extends State<SettingsSwitch> {
  late bool onoff;

  @override
  void initState() {
    super.initState();
    // Initialize the switch state based on the passed status.
    onoff = widget.status == 0 ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: onoff,
      activeColor: GenesisColors.primaryColor,
      inactiveTrackColor: Colors.black,
      
      onChanged: (bool value) {
        // Update the state when the user toggles the switch.
        setState(() {
          onoff = value;
        });
        print(onoff); // Print the new value of the switch.
      },
    );
  }
}