import 'package:flutter/material.dart';
import 'package:sw2project/core/routs/app_routs.dart';
import 'package:sw2project/features/staff%20flow/staff/presentaion/scan.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // زرار Call Next
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
  Navigator.pushNamed(context, AppRoutes.ticketRequest);
},
            icon: const Icon(Icons.arrow_outward, color: Colors.white, size: 22),
            label: const Text(
              'Call Next',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF84CBE5), // اللون اللبني
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
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFA1A1A1), // اللون الرمادي
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