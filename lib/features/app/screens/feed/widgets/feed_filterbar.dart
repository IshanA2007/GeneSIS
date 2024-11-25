import 'package:flutter/material.dart';
import 'package:grades/utils/constants/colors.dart';
import 'package:grades/utils/constants/sizes.dart';

class FeedFilterBar extends StatefulWidget {
  const FeedFilterBar({super.key});

  @override
  _FeedFilterBarState createState() => _FeedFilterBarState();
}

class _FeedFilterBarState extends State<FeedFilterBar> {
  String selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Spacer(),
        _buildFilterButton('All'),
        const Spacer(),
        _buildFilterButton('New'),
        const Spacer(),
        _buildFilterButton('Major'),
        const Spacer(),
      ],
    );
  }

  Widget _buildFilterButton(String label) {
    bool isSelected = selectedFilter == label;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: GenesisSizes.xs, horizontal: GenesisSizes.lg),
        decoration: BoxDecoration(
          color: isSelected ? GenesisColors.darkestGrey : Colors.transparent,
          borderRadius: BorderRadius.circular(GenesisSizes.feedFilterBarButtonRadius),
        ),
        child: Text(
          label,
          style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .apply(color: GenesisColors.grey)),
        ),
    );
  }
}

void main() => runApp(const MaterialApp(
  home: Scaffold(
    backgroundColor: Colors.black,
    body: Center(child: FeedFilterBar()),
  ),
));