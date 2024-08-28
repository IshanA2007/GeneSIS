import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:grades/common/data/sample_gpa_data.dart';
import 'package:grades/common/widgets/genesis_card.dart';
import 'package:grades/utils/constants/colors.dart';
import 'package:grades/utils/constants/sizes.dart';

class GenesisCarouselGraph extends StatelessWidget {
  const GenesisCarouselGraph({
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final data = GPAData();
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: GenesisSizes.md),
        child: GenesisCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "GPA Overview",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium,
              ),
              const SizedBox(
                height: GenesisSizes.spaceBtwItems * 2,
              ),
              AspectRatio(
                aspectRatio: 16 / 6.5,
                child: LineChart(
                  LineChartData(
                    lineTouchData: const LineTouchData(
                      handleBuiltInTouches: true,
                    ),
                    gridData: const FlGridData(
                      show: false,
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
                                    child: Text(data.bottomTitle[value.toInt()]
                                        .toString()),
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
                                    child: Text(data.leftTitle[value.toInt()]
                                        .toString()),
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
                              GenesisColors.black,
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
                    minX: 10,
                    maxX: 120,
                    minY: 0,
                    maxY: 110,
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
