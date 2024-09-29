import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grades/common/widgets/containers/circular_container.dart';
import 'package:grades/features/app/controllers/home_controller.dart';
import 'package:grades/features/app/screens/home/widgets/home_carousel_graph.dart';
import 'package:grades/utils/constants/colors.dart';
import 'package:grades/utils/constants/sizes.dart';

import '../../../../../common/data/History.dart';
import '../../../../authentication/controllers/user/user_controller.dart';

class GenesisGPACarousel extends StatelessWidget {
  const GenesisGPACarousel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    final user = Get.find<GenesisUserController>();
    List<GenesisCarouselGraph> historyGraphs = [];
    for (History history in user.curUser?.history ?? []){
      historyGraphs.add(GenesisCarouselGraph(history: history));
    }
    return Column(
      children: [
        CarouselSlider(
          items: historyGraphs,
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
                for (int i = 0; i < historyGraphs.length; i++)
                  GenesisCircularContainer(
                    width: 100 / historyGraphs.length,
                    height: 4,
                    margin: const EdgeInsets.only(right: 10),
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
