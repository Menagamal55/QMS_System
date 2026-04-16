import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class QueueActivityChart extends StatelessWidget {
  const QueueActivityChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. العنوان وزرار Weekly
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Queue Activity',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Georgia',
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F6FF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Text(
                      'Weekly',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(Icons.arrow_downward, color: Colors.blueAccent, size: 14),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),

          // 2. الرسم البياني الخطي
          SizedBox(
            height: 200, 
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false, 
                  horizontalInterval: 25,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey.withOpacity(0.2), 
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: 1,
                      getTitlesWidget: bottomTitleWidgets, 
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 25,
                      getTitlesWidget: leftTitleWidgets, 
                      reservedSize: 42,
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false), 
                minX: 0,
                maxX: 6,
                minY: 0,
                maxY: 120,
                lineBarsData: [
                  // الخط الأخضر
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 20),
                      FlSpot(1, 95),
                      FlSpot(2, 35),
                      FlSpot(3, 80),
                      FlSpot(4, 50),
                      FlSpot(5, 110),
                      FlSpot(6, 95),
                    ],
                    isCurved: true,
                    color: const Color(0xFF50E3C2), 
                    barWidth: 2,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false), 
                    belowBarData: BarAreaData(
                      show: true,
                      color: const Color(0xFF50E3C2).withOpacity(0.15), 
                    ),
                  ),
                  // الخط الأزرق
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 50),
                      FlSpot(1, 20),
                      FlSpot(2, 40),
                      FlSpot(3, 15),
                      FlSpot(4, 45),
                      FlSpot(5, 5),
                      FlSpot(6, 40),
                    ],
                    isCurved: true,
                    color: Colors.blueAccent, 
                    barWidth: 2,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // 3. مفاتيح الخريطة
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendItem(const Color(0xFF50E3C2), 'tickets created'),
              const SizedBox(width: 24),
              _buildLegendItem(Colors.blueAccent, 'tickets served'),
            ],
          ),
        ],
      ),
    );
  }

  // دالة الكلمات اللي تحت (التعديل هنا)
  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black54);
    const highlightStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.blueAccent);
    
    Widget text;
    switch (value.toInt()) {
      case 0: text = const Text('Sun', style: style); break;
      case 1: text = const Text('Mon', style: style); break;
      case 2: text = const Text('Tue', style: style); break;
      case 3: text = const Text('Wed', style: style); break;
      case 4: text = const Text('Thu', style: highlightStyle); break; 
      case 5: text = const Text('Fri', style: style); break;
      case 6: text = const Text('Sat', style: style); break;
      default: text = const Text('', style: style); break;
    }
    return SideTitleWidget(meta: meta, child: text);
  }

  // دالة الأرقام اللي على الشمال (التعديل هنا)
  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black54);
    String text;
    switch (value.toInt()) {
      case 0: text = '0'; break;
      case 25: text = '25'; break;
      case 50: text = '50'; break;
      case 100: text = '100'; break;
      default: return Container(); 
    }
    return SideTitleWidget(
      meta: meta,
      child: Text(text, style: style, textAlign: TextAlign.left),
    );
  }

  // دالة مفاتيح الخريطة
  Widget _buildLegendItem(Color color, String text) {
    return Row(
      children: [
        Icon(Icons.circle, size: 14, color: color),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
      ],
    );
  }
}