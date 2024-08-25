import 'package:flutter/material.dart';
import 'package:grades/features/app/screens/home/widgets/genesis_card.dart';
import 'package:grades/utils/constants/sizes.dart';
import 'package:grades/features/app/screens/home/widgets/card_grid.dart';

class GenesisGPAGrid extends StatelessWidget {
  const GenesisGPAGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GenesisCardGrid(
      key: super.key,
      columns: 2,
      rows: 3,
      children: [
        Text("box1"),
        Text("box2"),
        Text("box3"),
        Text("box4")

      ]
    );
  }
}
