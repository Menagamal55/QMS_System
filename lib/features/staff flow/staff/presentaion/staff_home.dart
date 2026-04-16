import 'package:flutter/material.dart';
import 'package:sw2project/features/staff%20flow/staff/presentaion/widgets/action_buttons.dart';
import 'package:sw2project/features/staff%20flow/staff/presentaion/widgets/current_ticket_card.dart';
import 'package:sw2project/features/staff%20flow/staff/presentaion/widgets/next_in_line_list.dart';

class StaffHome extends StatelessWidget {
  const StaffHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBEBEB), // لون الخلفية الرمادي الفاتح
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                
                // العنوان
                const Text(
                  'Staff Home',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                    color: Color(0xFF4A4A4A),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // كارت التذكرة الحالي
                const CurrentTicketCard(),
                
                const SizedBox(height: 24),
                
                // زراير الأكشن
                const ActionButtons(),
                
                const SizedBox(height: 30),
                
                // البوكس الأبيض اللي جواه اللستة
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Next in line',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 16),
                      // لستة الانتظار
                      NextInLineList(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}