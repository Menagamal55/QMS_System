import 'package:flutter/material.dart';
import 'package:sw2project/features/staff%20flow/presentation/screens/Queue%20Management.dart';
import 'package:sw2project/features/staff%20flow/staff/presentaion/scan.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // زرار Queue Management
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              // الانتقال لصفحة Queue Management
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const QueueManagementScreen(),
                ),
              );
            },
            icon: const Icon(Icons.arrow_outward, color: Colors.white, size: 22),
            label: const Text(
              'Queue Management', // تم تصحيح السبيلنج هنا
              style: TextStyle(
                color: Colors.white,
                fontSize: 16, // صغرت الخط شوية عشان الزرار يكفي الكلام
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF84CBE5),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
          ),
        ),

        const SizedBox(width: 16),

        // زرار Scan QR
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const QrScannerScreen()),
              );
            },
            icon: const Icon(Icons.qr_code_scanner, color: Colors.white, size: 22),
            label: const Text(
              'Scan QR',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFA1A1A1),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
          ),
        ),
      ],
    );
  }
}