



import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sw2project/core/utils/asset.dart';
import 'package:sw2project/core/utils/colors.dart';
import 'package:sw2project/features/customer_flow/presentation/widgets/images.dart';
import 'package:sw2project/features/customer_flow/presentation/widgets/ticket_widgwt.dart';

class Open_account extends StatelessWidget {
  const Open_account({super.key});

  @override
  Widget build(BuildContext context) {
    // استقبال نوع الخدمة المبعوثة (سواء كانت Deposit أو Open Account أو Cash Withdrawal)
    final String serviceName = ModalRoute.of(context)?.settings.arguments as String? ?? "Open account";

    return Scaffold(
      backgroundColor: AppColor.bgLight,
      body: SafeArea(
        child: Column(
          children: [
            // 1. Header (Book Your Queue Number)
            Container(
              padding: const EdgeInsets.only(top: 10, bottom: 25, left: 8, right: 24),
              decoration: const BoxDecoration(
                color: AppColor.primaryHeader,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25), 
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 22),
                    onPressed: () => Navigator.pop(context),
                  ),
                  // أيقونة التذكرة الصغيرة في الهيدر
                  const Icon(Icons.confirmation_num_outlined, color: Colors.white, size: 28),
                  const Gap(10),
                  const Text(
                    "Book Your Queue Number",
                    style: TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                children: [
                  // 2. Service Card
                  _buildSelectionCard(
                    label: "Service",
                    value: serviceName, 
                    // هنا بنحط الأيقونة المناسبة للخدمة
                    iconData: serviceName.contains("account") ? Icons.person_add_alt_1_rounded : Icons.wallet_rounded,
                    isActive: true,
                  ),
                  const Gap(15),
                  
                  // 3. Branch Card
                  _buildSelectionCard(
                    label: "Branch",
                    value: "Mansoura Main Branch",
                    iconData: Icons.location_on_rounded,
                    isActive: false,
                  ),
                  const Gap(25),
                  
                  // 4. Statistics Row (People & Time)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Row(
                      children: [
                        _buildStatBox(
                          color: const Color(0xFF4DB6AC), // اللون التركواز
                          icon: Icons.people_outline, 
                          label: "People\nWaiting:", 
                          value: "6",
                        ),
                        _buildStatBox(
                          color: const Color(0xFF3B7D91), // اللون الأزرق الغامق
                          icon: Icons.access_time, 
                          label: "Estimated", 
                          value: "15 min",
                        ),
                      ],
                    ),
                  ),
                  const Gap(25),
                  
                  // 5. The Ticket Section (استدعاء الويدجت اللي في الفايل المنفصل)
                  const TicketWidget(
                    ticketNumber: "B104",
                    peopleBefore: 5,
                    estTime: "12 min",
                  ),
                  
                  const Gap(25),
                  
                  // 6. Track Queue Button
                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: ElevatedButton(
                      onPressed: () {
                        // الانتقال لصفحة التتبع
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2397C3),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        elevation: 0,
                      ),
                      child: const Text(
                        "Track Queue", 
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ميثود لبناء كروت الاختيار (Service & Branch)
  Widget _buildSelectionCard({
    required String label, 
    required String value, 
    required IconData iconData, 
    required bool isActive
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: isActive ? Border.all(color: const Color(0xFF2397C3), width: 1.5) : null,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFE0F2F1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(iconData, color: const Color(0xFF3B7D91), size: 30),
          ),
          const Gap(15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(color: Colors.blueGrey, fontSize: 13, fontWeight: FontWeight.bold)),
                Text(value, style: const TextStyle(color: Color(0xFF0F4257), fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF3B7D91), size: 30),
        ],
      ),
    );
  }

  // ميثود لبناء مربعات الإحصائيات
  Widget _buildStatBox({
    required Color color, 
    required IconData icon, 
    required String label, 
    required String value
  }) {
    return Expanded(
      child: Container(
        height: 90,
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