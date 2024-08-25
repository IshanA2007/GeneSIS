import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grades/common/widgets/containers/circular_container.dart';
import 'package:grades/features/app/controllers/home_controller.dart';
import 'package:grades/features/app/screens/home/widgets/home_carousel_graph.dart';
import 'package:grades/utils/constants/colors.dart';
import 'package:grades/utils/constants/sizes.dart';

class GenesisGPACarousel extends StatelessWidget {
  const GenesisGPACarousel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Column(
      children: [
        CarouselSlider(
          items: const [
            GenesisCarouselGraph(),
            GenesisCarouselGraph(),
            GenesisCarouselGraph(),
          ],
          options: CarouselOptions(
            viewportFraction: 1,
            onPageChanged: (index, _) => controller.updatePageIndicator(index),
          ),
        ),
        const SizedBox(height: GenesisSizes.spaceBtwItems),
        Center(
          child: Obx(
            () => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < 3; i++)
                  GenesisCircularContainer(
                    width: 20,
                    height: 4,
                    margin: EdgeInsets.only(right: 10),
                    backgroundColor: controller.carouselCurrentIndex.value == i
                        ? GenesisColors.primaryColor
                        : GenesisColors.primaryBackground.withOpacity(0.5),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: GenesisSizes.spaceBtwSections),
      ],
    );
  }
}
