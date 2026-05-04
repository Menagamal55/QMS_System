import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:sw2project/core/utils/colors.dart';
import 'package:sw2project/features/customer_flow/presentation/bloc/cubit.dart';
import 'package:sw2project/features/customer_flow/presentation/bloc/customer_state.dart';
import 'package:sw2project/features/customer_flow/presentation/widgets/ticket_widgwt.dart';

class CardServices extends StatelessWidget {
  const CardServices({super.key});

  static const int serviceId = 4;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<CustomerCubit>()..getQueueStatus(),
      child: BlocBuilder<CustomerCubit, CustomerState>(
        builder: (context, state) {
          final String serviceName = ModalRoute.of(context)?.settings.arguments as String? ?? "Card Services";
          final isLoading = state is CustomerLoading;

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
                        _buildSelectionCard(
                          label: "Service",
                          value: serviceName,
                          iconData: Icons.credit_card_rounded,
                          isActive: true,
                        ),
                        const Gap(15),
                        _buildSelectionCard(
                          label: "Branch",
                          value: "Mansoura Main Branch",
                          iconData: Icons.location_on_rounded,
                          isActive: false,
                        ),
                  const Gap(25),
                  
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Row(
                            children: [
                              _buildStatBox(
                                color: const Color(0xFF4DB6AC),
                                icon: Icons.people_outline,
                                label: "People\nWaiting:",
                                value: state is QueueStatusSuccess ? '${state.status['peopleWaiting'] ?? state.status['queueLength'] ?? '-'}' : '-',
                              ),
                              _buildStatBox(
                                color: const Color(0xFF3B7D91),
                                icon: Icons.access_time,
                                label: "Estimated",
                                value: state is QueueStatusSuccess ? '${state.status['estimatedTime'] ?? state.status['avgWaitTime'] ?? '-'} min' : '- min',
                              ),
                            ],
                          ),
                        ),
                        const Gap(25),
                        state is CustomerSuccess
                            ? TicketWidget(
                                ticketNumber: state.ticket.ticketNumber,
                                peopleBefore: state.ticket.peopleWaiting,
                                estTime: "${state.ticket.peopleWaiting * 3} min",
                              )
                            : const TicketWidget(ticketNumber: "----", peopleBefore: 0, estTime: "-- min"),
                  
                        const Gap(25),
                        SizedBox(
                          width: double.infinity,
                          height: 58,
                          child: ElevatedButton(
                            onPressed: isLoading ? null : () => context.read<CustomerCubit>().bookTicket(serviceId),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2397C3),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                              elevation: 0,
                            ),
                            child: isLoading
                                ? const CircularProgressIndicator(color: Colors.white)
                                : const Text("Book & Track Queue", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        if (state is CustomerError)
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Text(state.message, style: const TextStyle(color: Colors.red, fontSize: 13), textAlign: TextAlign.center),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
  }

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