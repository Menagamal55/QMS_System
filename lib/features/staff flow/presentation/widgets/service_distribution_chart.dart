import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // تأكدي إنك عملتي استدعاء للمكتبة هنا

class ServiceDistributionChart extends StatelessWidget {
  const ServiceDistributionChart({super.key});

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
          const Text(
            'Service Distribution',
            style: TextStyle(fontSize: 18, fontFamily: 'Georgia', fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              // الرسمة الدائرية
              SizedBox(
                height: 120,
                width: 120,
                child: PieChart(
                  PieChartData(
                    sectionsSpace: 2,
                    centerSpaceRadius: 35,
                    sections: [
                      PieChartSectionData(color: Colors.black87, value: 52.1, title: '', radius: 25),
                      PieChartSectionData(color: const Color(0xFF8DC6DF), value: 13.9, title: '', radius: 25),
                      PieChartSectionData(color: const Color(0xFF84E8A8), value: 11.2, title: '', radius: 25),
                      PieChartSectionData(color: const Color(0xFF90B4F2), value: 22.8, title: '', radius: 25),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 20),
              // البيانات اللي على اليمين (Legend)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLegendItem(Colors.black87, 'Cash Deposit - 52.1%'),
                    _buildLegendItem(const Color(0xFF90B4F2), 'Account Opening - 22.8%'),
                    _buildLegendItem(const Color(0xFF8DC6DF), 'Card Replacement - 13.9%'),
                    _buildLegendItem(const Color(0xFF84E8A8), 'Other Services - 11.2%'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Icon(Icons.circle, size: 10, color: color),
          const SizedBox(width: 8),
          Expanded(
            child: Text(text, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}