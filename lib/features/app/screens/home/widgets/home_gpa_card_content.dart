
import 'package:flutter/material.dart';
import 'package:grades/utils/device/device_utilities.dart';

class GenesisGPACardContent extends StatelessWidget {
  const GenesisGPACardContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: GenesisDeviceUtils.getScreenHeight() * .145,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            )
          )
        ]
      ),
    );
  }
}