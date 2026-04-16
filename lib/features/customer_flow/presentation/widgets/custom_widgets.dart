import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

// كارت اختيار الخدمة أو الفرع
class SelectionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const SelectionCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: const Color(0xFFE0F2F1), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: const Color(0xFF3B7D91), size: 30),
          ),
          const Gap(15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.bold)),
                Text(value, style: const TextStyle(color: Color(0xFF0F4257), fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF3B7D91), size: 30),
        ],
      ),
    );
  }
}

class StatBox extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String label;
  final String value;

  const StatBox({
    super.key,
    required this.color,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 100,
        color: color,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 38),
            const Gap(8),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(color: Colors.white, fontSize: 13, height: 1.1)),
                Text(value, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}