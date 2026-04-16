import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
// استيراد الشاشات (تأكدي من المسميات عندك)
import 'package:sw2project/features/customer_flow/presentation/screens/Withdrawal.dart';
import 'package:sw2project/features/customer_flow/presentation/screens/Deposit.dart';
import 'package:sw2project/features/customer_flow/presentation/screens/open_account.dart';
import 'package:sw2project/features/customer_flow/presentation/screens/card_services.dart';
import 'package:sw2project/features/customer_flow/presentation/screens/Loan%20Inquiry.dart';
import 'package:sw2project/features/customer_flow/presentation/screens/customer_support.dart';

class ChooseServiceScreen extends StatefulWidget {
  const ChooseServiceScreen({super.key});

  @override
  State<ChooseServiceScreen> createState() => _ChooseServiceScreenState();
}

class _ChooseServiceScreenState extends State<ChooseServiceScreen> {
  int selectedIndex = -1;

  final List<Map<String, String>> services = const [
    {'title': 'Deposit', 'path': 'assets/images/icons/Group@2x.png'},
    {'title': 'Withdrawal', 'path': 'assets/images/icons/emojione_atm-sign.png'},
    {'title': 'Open Account', 'path': 'assets/images/icons/la_file-invoice-dollar.png'},
    {'title': 'Card Services', 'path': 'assets/images/icons/icon-park-outline_open-an-account.png'},
    {'title': 'Loan Inquiry', 'path': 'assets/images/icons/ic_twotone-credit-card.png'},
    {'title': 'Customer Support', 'path': 'assets/images/icons/streamline-plump-color_customer-support-3.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDAEBEE),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              const Gap(30),
              const Text(
                'Choose Your Service',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF0F4257)),
              ),
              const Gap(10),
              const Text(
                'What service do you need today?',
                style: TextStyle(fontSize: 15, color: Color(0xFF0F4257)),
              ),
              const Gap(30),
              Expanded(
                child: GridView.builder(
                  itemCount: services.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemBuilder: (context, index) {
                    final service = services[index];
                    bool isSelected = selectedIndex == index;

                    return GestureDetector(
                      onTap: () async {
                        setState(() {
                          selectedIndex = index; // تلوين الكارت فوراً
                        });

                        // انتظار بسيط جداً (اختياري) عشان المستخدم يشوف اللون اتغير قبل ما ينتقل
                        await Future.delayed(const Duration(milliseconds: 150));

                        // الانتقال المباشر للشاشة المطلوبة
                        _navigateToService(service['title']!);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFFB2DEE0) : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              service['path']!,
                              height: 55,
                              width: 55,
                              fit: BoxFit.contain,
                            ),
                            const Gap(12),
                            Text(
                              service['title']!,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0F4257),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Gap(20),
              // الزرار السفلي "Get Your Ticket" زي ما هو لو احتجتيه للـ Submit أو أي وظيفة تانية
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    // هنا ممكن تخليه يفتح الـ BottomSheet أو أي حاجة تانية
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2397C3),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  child: const Text(
                    'Get Your Ticket',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToService(String title) {
    Widget targetScreen;
    switch (title) {
      case 'Withdrawal':
        targetScreen = const WithdrawalScreen();
        break;
      case 'Deposit':
        targetScreen = const Deposit();
        break;
      case 'Open Account':
        targetScreen = const Open_account();
        break;
      case 'Card Services':
        targetScreen = const CardServices();
        break;
      case 'Loan Inquiry':
        targetScreen = const Loan_inquiry();
        break;
      case 'Customer Support':
        targetScreen = const Customer_support();
        break;
      default:
        targetScreen = const WithdrawalScreen();
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => targetScreen,
        settings: RouteSettings(arguments: title),
      ),
    );
  }
}