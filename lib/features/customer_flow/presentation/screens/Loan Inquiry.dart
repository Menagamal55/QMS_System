import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Loan_inquiry extends StatelessWidget {
  const Loan_inquiry({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD6E6E8), // لون الخلفية الفاتح الموحد
      body: SafeArea(
        child: Column(
          children: [
            // 1. Header مع سهم الرجوع
            _buildHeader(context),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  // 2. Your Number Card (التصميم المتدرج العلوي)
                  _buildYourNumberCard("B104"),
                  
                  const Gap(20),

                  // 3. Now Serving Section
                  _buildNowServingSection(
                    currentNumber: "B099",
                    waitingList: ["B099", "B100", "B101", "B102", "B103"],
                  ),

                  const Gap(20),

                  // 4. Statistics Card (People & Time)
                  _buildDetailedStatsCard(
                    peopleBefore: 5,
                    waitTime: "12 min",
                  ),

                  const Gap(30),

                  // 5. Refresh Button
                  _buildRefreshButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Widgets البناء ---

  // الهيدر مع سهم الرجوع في جهة اليسار
  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15, bottom: 10, left: 10, right: 20),
      child: Row(
        children: [
          // سهم الرجوع
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF3B7D91), size: 22),
            onPressed: () => Navigator.pop(context), 
          ),
          const Spacer(flex: 1), 
          const Icon(Icons.confirmation_num_outlined, color: Color(0xFF3B7D91), size: 28),
          const Gap(10),
          const Text(
            "Queue Status",
            style: TextStyle(
              color: Color(0xFF3B7D91),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(flex: 2), // لموازنة المسافة ليبقى النص في المنتصف
        ],
      ),
    );
  }

  // كارت رقم المستخدم بتصميم التدرج
  Widget _buildYourNumberCard(String number) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF53A1B1), Color(0xFF3B7D91)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.check_circle, color: Colors.white, size: 18),
              Gap(5),
              Text("Your Number", style: TextStyle(color: Colors.white, fontSize: 16)),
            ],
          ),
          const Gap(15),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              number,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF3B7D91),
                fontSize: 45,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // قسم الخدمة الحالية وقائمة الانتظار
  Widget _buildNowServingSection({required String currentNumber, required List<String> waitingList}) {
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
            "Now Serving",
            style: TextStyle(color: Color(0xFF3B7D91), fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Gap(15),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFE0F2F1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              currentNumber,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Color(0xFF00796B), fontSize: 35, fontWeight: FontWeight.w900),
            ),
          ),
          const Gap(20),
          // شريط الأرقام المنتظرة
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F8F9),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: waitingList.map((num) {
                bool isServing = num == currentNumber;
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: isServing 
                      ? BoxDecoration(color: const Color(0xFF14A3B4), borderRadius: BorderRadius.circular(20))
                      : null,
                  child: Text(
                    num,
                    style: TextStyle(
                      color: isServing ? Colors.white : Colors.blueGrey,
                      fontWeight: isServing ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // كارت الإحصائيات (الأشخاص والوقت)
  Widget _buildDetailedStatsCard({required int peopleBefore, required String waitTime}) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: const Color(0xFFE8EEF1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          _buildStatRow(Icons.people_alt_rounded, "People Before You:", "$peopleBefore"),
          const Divider(height: 1, indent: 50),
          _buildStatRow(Icons.access_time_filled_rounded, "Estimated Time:", waitTime),
        ],
      ),
    );
  }

  Widget _buildStatRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF3B7D91), size: 30),
          const Gap(15),
          Text(label, style: const TextStyle(color: Colors.blueGrey, fontSize: 16, fontWeight: FontWeight.w500)),
          const Spacer(),
          Text(value, style: const TextStyle(color: Color(0xFF0F4257), fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildRefreshButton() {
    return SizedBox(
      width: double.infinity,
      height: 58,
      child: ElevatedButton.icon(
        onPressed: () {
          // يمكن إضافة منطق التحديث هنا
        },
        icon: const Icon(Icons.refresh_rounded, color: Colors.white, size: 28),
        label: const Text("Refresh", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2397C3),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 0,
        ),
      ),
    );
  }
}