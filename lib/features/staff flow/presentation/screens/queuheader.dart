import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; 
class QueuesTab extends StatelessWidget {
  const QueuesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        children: [
          _buildTopStatsGrid(),
          const SizedBox(height: 25),

          _buildCardWrapper(
            title: "Queue Activity",
            hasDropdown: true,
            child: SizedBox(
              height: 220,
              child: LineChart(_getQueueActivityData()),
            ),
          ),
          const SizedBox(height: 25),

          _buildCardWrapper(
            title: "Service Distribution",
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: SizedBox(
                    height: 160,
                    child: PieChart(_getServiceDistData()),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: _buildLegendList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  LineChartData _getQueueActivityData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (value) => FlLine(color: Colors.grey.withOpacity(0.2), strokeWidth: 1),
      ),
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 30)),
        bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (val, _) {
          const days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
          return Text(days[val.toInt() % 7], style: const TextStyle(fontSize: 10));
        })),
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      borderData: FlBorderData(show: false),
      lineBarsData: [
        _generateLineBarData(const Color(0xFF42A5F5), [const FlSpot(0, 50), const FlSpot(1, 110), const FlSpot(2, 30), const FlSpot(3, 60), const FlSpot(4, 20), const FlSpot(5, 40)]),
        _generateLineBarData(const Color(0xFF5ED5A8), [const FlSpot(0, 20), const FlSpot(1, 90), const FlSpot(2, 40), const FlSpot(3, 80), const FlSpot(4, 100), const FlSpot(5, 70)]),
      ],
    );
  }

  LineChartBarData _generateLineBarData(Color color, List<FlSpot> spots) {
    return LineChartBarData(
      spots: spots,
      isCurved: true, 
      curveSmoothness: 0.35,
      color: color,
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: true), 
      belowBarData: BarAreaData(show: true, color: color.withOpacity(0.1)), // الظل الخفيف تحت الخط
    );
  }

  PieChartData _getServiceDistData() {
    return PieChartData(
      sectionsSpace: 2,
      centerSpaceRadius: 45, 
      sections: [
        PieChartSectionData(color: const Color(0xFF333333), value: 52.1, radius: 25, showTitle: false),
        PieChartSectionData(color: const Color(0xFFA5D6F1), value: 22.8, radius: 25, showTitle: false),
        PieChartSectionData(color: const Color(0xFFB2EBC3), value: 13.9, radius: 25, showTitle: false),
        PieChartSectionData(color: const Color(0xFFE0E0E0), value: 11.2, radius: 25, showTitle: false),
      ],
    );
  }

  Widget _buildTopStatsGrid() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.8,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _statCard("Total tickets Today", "80", [const Color(0xFFA5D6F1), const Color(0xFF72C2EB)]),
        _statCard("Wating Custmers", "40", [const Color(0xFFE0E0E0), const Color(0xFFBDBDBD)]),
        _statCard("Active Staff", "8", [const Color(0xFFD9D9D9), const Color(0xFFBDBDBD)]),
        _statCard("Active Queue", "3", [const Color(0xFFA5D6F1), const Color(0xFF72C2EB)]),
      ],
    );
  }

  Widget _statCard(String t, String v, List<Color> c) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: c, begin: Alignment.topCenter, end: Alignment.bottomCenter),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(t, style: const TextStyle(fontSize: 11, color: Colors.black87)),
          Text(v, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildCardWrapper({required String title, required Widget child, bool hasDropdown = false}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: const Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(35)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              if (hasDropdown) const Icon(Icons.keyboard_arrow_down, color: Colors.blue),
            ],
          ),
          const SizedBox(height: 15),
          child,
        ],
      ),
    );
  }

  Widget _buildLegendList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _legendItem("Cash Deposit", "52.1%"),
        _legendItem("Account Opening", "22.8%"),
        _legendItem("Card Replacement", "13.9%"),
        _legendItem("Other Services", "11.2%"),
      ],
    );
  }

  Widget _legendItem(String label, String val) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(children: [const Icon(Icons.circle, size: 6), const SizedBox(width: 8), Expanded(child: Text(label, style: const TextStyle(fontSize: 11))), Text(val, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))]),
    );
  }
}