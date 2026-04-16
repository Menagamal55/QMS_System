// lib/features/customer_flow/presentation/screens/withdrawal_screen.dart

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sw2project/features/customer_flow/presentation/widgets/custom_widgets.dart';
import 'package:sw2project/features/customer_flow/presentation/widgets/ticket_widgwt.dart';

class WithdrawalScreen extends StatelessWidget {
  const WithdrawalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // استلام اسم الخدمة من ChooseServiceScreen
    final String serviceName = ModalRoute.of(context)?.settings.arguments as String? ?? "Cash Withdrawal";

    return Scaffold(
      backgroundColor: const Color(0xFFD6E6E8),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                children: [
                  SelectionCard(
                    icon: Icons.account_balance_wallet_rounded,
                    label: "Service",
                    value: serviceName,
                  ),
                  const Gap(15),
                  const SelectionCard(
                    icon: Icons.location_on_rounded,
                    label: "Branch",
                    value: "Mansoura Main Branch",
                  ),
                  const Gap(25),
                  _buildStatsRow(),
                  const Gap(25),
                  const TicketWidget(),
                ],
              ),
            ),
            _buildTrackButton(),
          ],
        ),
      ),
    );
  }

  // Header مع سهم الرجوع
  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      decoration: const BoxDecoration(
        color: Color(0xFF3B7D91),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
      ),
      child: Row(
        children: [
          const Icon(Icons.confirmation_num_outlined, color: Colors.white, size: 28),
          const Gap(12),
          const Expanded(
            child: Text(
              "Book Your Queue",
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
            onPressed: () => Navigator.pop(context), // العودة إلى ChooseServiceScreen
          ),
        ],
      ),
    );
  }

  // صف الإحصائيات (عدد الأشخاص والوقت)
  Widget _buildStatsRow() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: const Row(
        children: [
          StatBox(
            color: Color(0xFF4DB6AC),
            icon: Icons.people_outline,
            label: "People\nWaiting:",
            value: "6",
          ),
          StatBox(
            color: Color(0xFF3B7D91),
            icon: Icons.access_time,
            label: "Estimated",
            value: "15 min",
          ),
        ],
      ),
    );
  }

  // زر تتبع قائمة الانتظار
  Widget _buildTrackButton() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        width: double.infinity,
        height: 58,
        child: ElevatedButton(
          onPressed: () {
            // هنا يمكنك إضافة وظيفة تتبع الطابور لاحقاً
            // ScaffoldMessenger.of(conte).showSnackBar(
            //   const SnackBar(content: Text('Tracking your queue position...')),
            // );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2397C3),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
          child: const Text(
            "Track Queue",
            style: TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}