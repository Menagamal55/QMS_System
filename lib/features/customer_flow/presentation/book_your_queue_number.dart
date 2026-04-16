import 'package:flutter/material.dart';
import 'package:sw2project/core/utils/asset.dart';
import 'package:sw2project/core/utils/colors.dart';
import 'package:sw2project/features/customer_flow/presentation/widgets/images.dart';
// التأكد من أن المسار هنا صحيح حسب مكان ملف التيكت الجديد
import 'package:sw2project/features/customer_flow/presentation/widgets/ticket_widgwt.dart'; 

class BookQueueScreen extends StatelessWidget {
  const BookQueueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // استقبال اسم الخدمة المبعوث من شاشة الاختيار
    final String serviceName = ModalRoute.of(context)?.settings.arguments as String? ?? "Deposit";

    return Scaffold(
      backgroundColor: AppColor.bgLight,
      body: SafeArea(
        child: Column(
          children: [
            // 1. Header Section
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
                  const CustomImageHandler(width: 35, height: 35, imagePath: 'assets/Combi Ticket (1).png'),
                  const SizedBox(width: 8),
                  const Text(
                    "Book Your Queue Number",
                    style: TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  const SizedBox(height: 8),
                  
                  // 2. Service Selection Card
                  _buildSelectionCard(
                    label: "Service",
                    value: serviceName, 
                    iconPath: 'assets/images/bookservice/Combi Ticket (1).png',
                    isActive: true,
                  ),
                  const SizedBox(height: 16),
                  
                  // 3. Branch Selection Card
                  _buildSelectionCard(
                    label: "Branch",
                    value: "Mansoura Main Branch",
                    iconPath: AppAssets.combiTicket,
                    isActive: false,
                  ),
                  const SizedBox(height: 24),
                  
                  // 4. Stats Bar (Waiting People & Time)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Row(
                      children: [
                        _buildStatItem(
                          color: AppColor.accentCyan, 
                          icon: Icons.people_outline, 
                          label: "People\nWaiting:", 
                          value: "6",
                        ),
                        _buildStatItem(
                          color: AppColor.primaryHeader, 
                          icon: Icons.access_time, 
                          label: "Estimated", 
                          value: "15 min",
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // 5. The Shared Ticket Widget (استخدام الويدجت اللي في فايل لوحده)
                  const TicketWidget(
                    ticketNumber: "B104",
                    peopleBefore: 5,
                    estTime: "12 min",
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // 6. Action Button
                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: ElevatedButton(
                      onPressed: () {
                        // أضيفي هنا الانتقال لصفحة التتبع لو موجودة
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
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ميثود مساعدة لبناء كروت الاختيار
  Widget _buildSelectionCard({
    required String label, 
    required String value, 
    required String iconPath, 
    required bool isActive
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.cardBg,
        borderRadius: BorderRadius.circular(18),
        border: isActive ? Border.all(color: AppColor.activeBorder, width: 2.2) : null,
      ),
      child: Row(
        children: [
          CustomImageHandler(width: 50, height: 40, imagePath: iconPath),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(color: Colors.blueGrey, fontSize: 14)),
                Text(value, style: const TextStyle(color: AppColor.textDark, fontSize: 19, fontWeight: FontWeight.w800)),
              ],
            ),
          ),
          const Icon(Icons.keyboard_arrow_down_rounded, color: AppColor.textDark, size: 35),
        ],
      ),
    );
  }

  // ميثود مساعدة لبناء مربعات الإحصائيات
  Widget _buildStatItem({
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
            const SizedBox(width: 8),
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