import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grades/common/data/GPAHistory.dart';
import 'package:grades/common/widgets/genesis_card.dart';
import 'package:grades/utils/constants/colors.dart';
import 'package:grades/utils/constants/sizes.dart';
import 'package:grades/utils/device/device_utilities.dart';
import 'package:grades/utils/helpers/helper_functions.dart';

import '../../../../../common/data/History.dart';
import '../../../../authentication/controllers/user/user_controller.dart';

class GenesisCarouselGraph extends StatelessWidget {
  const GenesisCarouselGraph({
    super.key,
    required this.history,
    this.onPressed,
  });

  final VoidCallback? onPressed;
  final History history;

  @override
  Widget build(BuildContext context) {
    final user = Get.find<GenesisUserController>();
    final data = user.createDataPoints(history);

    final isDark = GenesisHelpers.isDarkMode(context);
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: GenesisSizes.md),
        child: GenesisCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                child: Text(
                  history.name == "overall" ? "GPA History" : "${history.name}History",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(
                height: GenesisSizes.spaceBtwItems * 2,
              ),
              AspectRatio(
                aspectRatio: 16 / 6,
                child: LineChart(
                  LineChartData(
                    lineTouchData: const LineTouchData(
                      handleBuiltInTouches: true,
                    ),
                    gridData: FlGridData(
                      show: true,
                      drawHorizontalLine: true,
                      drawVerticalLine: false,
                      horizontalInterval: 20,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: GenesisColors.primaryColor.withOpacity(0.2),
                          strokeWidth: 1,
                        );
                      },
                    ),
                    titlesData: FlTitlesData(
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false,
                        ),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false,
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            return data.bottomTitle[value.toInt()] != null
                                ? SideTitleWidget(
                                    axisSide: meta.axisSide,
                                    child: Text(
                                      data.bottomTitle[value.toInt()]
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    ),
                                  )
                                : const SizedBox();
                          },
                          interval: 1,
                          reservedSize: 40,
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            return data.leftTitle[value.toInt()] != null
                                ? SideTitleWidget(
                                    axisSide: meta.axisSide,
                                    child: Text(
                                      data.leftTitle[value.toInt()].toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    ),
                                  )
                                : const SizedBox();
                          },
                          interval: 1,
                          reservedSize: 40,
                        ),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        color: GenesisColors.primaryColor,
                        barWidth: 2.5,
                        belowBarData: BarAreaData(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              GenesisColors.primaryColor.withOpacity(0.5),
                              isDark ? GenesisColors.black : GenesisColors.lightBackground,
                            ],
                          ),
                          show: true,
                        ),
                        dotData: const FlDotData(
                          show: false,
                        ),
                        spots: data.spots,
                      ),
                    ],
                    minX: data.minX,
                    maxX: data.maxX,
                    minY: data.minY,
                    maxY: data.maxY,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
