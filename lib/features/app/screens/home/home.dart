import 'package:flutter/material.dart';
import 'package:grades/features/app/screens/home/widgets/home_appbar.dart';
import 'package:grades/common/widgets/genesis_card.dart';
import 'package:grades/features/app/screens/home/widgets/home_gpa_card_content.dart';
import 'package:grades/features/app/screens/home/widgets/home_gpa_grid.dart';
import 'package:grades/utils/constants/sizes.dart';
import 'widgets/home_gpa_carousel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _appBarAnimation;
  late Animation<Offset> _gpaCardAnimation;
  late Animation<Offset> _gpaGridAnimation;
  late Animation<Offset> _carouselAnimation;

  @override
  void initState() {
    super.initState();

    // Create a single AnimationController
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000), // Total duration
    );

    // Use Tween<Offset> for slide animations, with staggered delays for each widget

    // AppBar slides in first (immediately)
    _appBarAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Start below the screen
      end: Offset.zero, // Slide to the normal position
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
    ));

    // GPA Card slides in next (after AppBar)
    _gpaCardAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.05, 0.35, curve: Curves.easeOut),
    ));

    // GPA Grid slides in next (after GPA Card)
    _gpaGridAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.10, 0.4, curve: Curves.easeOut),
    ));

    // Carousel slides in last
    _carouselAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.15, 0.45, curve: Curves.easeOut),
    ));

    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // GenesisHomeAppBar slides in first
            SlideTransition(
              position: _appBarAnimation,
              child: const GenesisHomeAppBar(),
            ),
            // GPA Card slides in next
            SlideTransition(
              position: _gpaCardAnimation,
              child: const Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: GenesisSizes.md,
                    vertical: GenesisSizes.spaceBtwItems),
                child: GenesisCard(
                  child: GenesisGPACardContent(),
                ),
              ),
            ),
            // GPA Grid slides in after GPA Card
            SlideTransition(
              position: _gpaGridAnimation,
              child: const GenesisGPAGrid(),
            ),
            const SizedBox(
              height: GenesisSizes.spaceBtwItems,
            ),
            // GPA Carousel slides in last
            SlideTransition(
              position: _carouselAnimation,
              child: const GenesisGPACarousel(),
            ),
          ],
        ),
      ),
    );
  }
}
