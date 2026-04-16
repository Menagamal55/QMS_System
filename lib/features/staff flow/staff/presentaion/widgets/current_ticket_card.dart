import 'package:flutter/material.dart';

class CurrentTicketCard extends StatelessWidget {
  const CurrentTicketCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        // تدرج الألوان
        gradient: const LinearGradient(
          colors: [
            Color(0xFF8DC6DF), // اللبني الفاتح
            Color(0xFFEAD2CB), // الخوخي الفاتح
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Current Ticket',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'A-105',
            style: TextStyle(
              color: Colors.white,
              fontSize: 54, // خط كبير وواضح
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}