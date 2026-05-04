import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:sw2project/features/customer_flow/presentation/bloc/cubit.dart';
import 'package:sw2project/features/customer_flow/presentation/bloc/customer_state.dart';
import 'package:sw2project/features/customer_flow/presentation/screens/Withdrawal.dart';
import 'package:sw2project/features/customer_flow/presentation/screens/Deposit.dart';
import 'package:sw2project/features/customer_flow/presentation/screens/booking_successfully.dart';
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

  // service IDs must match the backend IDs
  final List<Map<String, dynamic>> services = const [
    {'title': 'Deposit',          'path': 'assets/images/icons/Group@2x.png',                                'serviceId': 1},
    {'title': 'Withdrawal',       'path': 'assets/images/icons/emojione_atm-sign.png',                      'serviceId': 2},
    {'title': 'Open Account',     'path': 'assets/images/icons/la_file-invoice-dollar.png',                 'serviceId': 3},
    {'title': 'Card Services',    'path': 'assets/images/icons/icon-park-outline_open-an-account.png',      'serviceId': 4},
    {'title': 'Loan Inquiry',     'path': 'assets/images/icons/ic_twotone-credit-card.png',                 'serviceId': 5},
    {'title': 'Customer Support', 'path': 'assets/images/icons/streamline-plump-color_customer-support-3.png', 'serviceId': 6},
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<CustomerCubit>(),
      child: BlocConsumer<CustomerCubit, CustomerState>(
        listener: (context, state) {
          if (state is CustomerSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const BookingSuccessScreen()),
            );
          } else if (state is CustomerError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is CustomerLoading;

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
                            onTap: isLoading
                                ? null
                                : () {
                                    setState(() {
                                      selectedIndex = index;
                                    });
                                    _navigateToService(service['title']! as String);
                                  },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              decoration: BoxDecoration(
                                color: isSelected ? const Color(0xFFB2DEE0) : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.05),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    service['path']! as String,
                                    height: 55,
                                    width: 55,
                                    fit: BoxFit.contain,
                                  ),
                                  const Gap(12),
                                  Text(
                                    service['title']! as String,
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
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: isLoading || selectedIndex == -1
                            ? null
                            : () {
                                final serviceId = services[selectedIndex]['serviceId'] as int;
                                context.read<CustomerCubit>().bookTicket(serviceId);
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2397C3),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text(
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
        },
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
        return;
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