import 'package:flutter/material.dart';

class StatsGrid extends StatelessWidget {
  const StatsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildStatCard('Total tickets Today', '80', true)),
            const SizedBox(width: 16),
            Expanded(child: _buildStatCard('Waiting Customers', '40', false)),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildStatCard('Active Staff', '8', false)),
            const SizedBox(width: 16),
            Expanded(child: _buildStatCard('Active Queue', '3', true)),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, bool isBlue) {
    return Container(
      // قللنا الـ padding اللي بالعرض شوية عشان ندي مساحة للكلام
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8), 
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          colors: isBlue
              ? [const Color(0xFF8DC6DF), const Color(0xFFB0DFE5)]
              : [const Color(0xFFD3D3D3), const Color(0xFFE5E5E5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start, // عشان لو الكلام نزل سطرين الأيقونة تفضل مظبوطة
            children: [
              // حطينا Flexible هنا عشان تمنع الـ Error وتخلي الكلام يلف (Wrap)
              Flexible(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 14, fontFamily: 'Georgia', fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.trending_up, size: 16, color: Colors.black87),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 28, fontFamily: 'Georgia', fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}