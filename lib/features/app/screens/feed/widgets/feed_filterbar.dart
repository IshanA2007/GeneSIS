import 'package:flutter/material.dart';
import 'package:grades/utils/constants/colors.dart';
import 'package:grades/utils/constants/sizes.dart';

class FeedFilterBar extends StatefulWidget {
  final String filter;
  final Function(String) onFilterChanged;

  const FeedFilterBar(
      {super.key, required this.filter, required this.onFilterChanged});

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
    bool isSelected = widget.filter == label;

    return GestureDetector(
      onTap: () {
        widget.onFilterChanged(label);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
            vertical: GenesisSizes.xs, horizontal: GenesisSizes.lg),
        decoration: BoxDecoration(
          color: isSelected ? GenesisColors.darkestGrey : Colors.transparent,
          borderRadius:
              BorderRadius.circular(GenesisSizes.feedFilterBarButtonRadius),
        ),
        child: Text(label,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .apply(color: GenesisColors.grey)),
      ),
    );
  }
}
