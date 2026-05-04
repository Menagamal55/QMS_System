import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:sw2project/core/utils/colors.dart';
import 'package:sw2project/core/utils/asset.dart';
import 'package:sw2project/features/customer_flow/presentation/bloc/cubit.dart';
import 'package:sw2project/features/customer_flow/presentation/bloc/customer_state.dart';
import 'package:sw2project/features/customer_flow/presentation/widgets/images.dart';
import 'package:sw2project/features/customer_flow/presentation/widgets/ticket_widgwt.dart';

class Customer_support extends StatelessWidget {
  const Customer_support({super.key});

  static const int serviceId = 6;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<CustomerCubit>()..getQueueStatus(),
      child: BlocBuilder<CustomerCubit, CustomerState>(
        builder: (context, state) {
          final serviceName = ModalRoute.of(context)?.settings.arguments as String? ?? "Customer Support";
          final isLoading = state is CustomerLoading;

          return Scaffold(
            backgroundColor: AppColor.bgLight,
            body: SafeArea(
              child: Column(
                children: [
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
                          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const CustomImageHandler(
                          width: 35,
                          height: 35,
                          imagePath: 'assets/Combi Ticket (1).png',
                        ),
                        const Gap(8),
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
                        const Gap(8),

                        _buildSelectionCard(
                          label: "Service",
                          value: serviceName,
                          iconPath: 'assets/images/bookservice/combi_ticket.png',
                          isActive: true,
                        ),

                        const Gap(16),

                        _buildSelectionCard(
                          label: "Branch",
                          value: "Mansoura Main Branch",
                          iconPath: AppAssets.combiTicket,
                          isActive: false,
                        ),

                        const Gap(24),

                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Row(
                            children: [
                              _buildStatItem(
                                color: AppColor.accentCyan,
                                icon: Icons.people_outline,
                                label: "People\nWaiting:",
                                value: state is QueueStatusSuccess
                                    ? '${state.status['peopleWaiting'] ?? state.status['queueLength'] ?? '-'}'
                                    : '-',
                              ),
                              _buildStatItem(
                                color: AppColor.primaryHeader,
                                icon: Icons.access_time,
                                label: "Estimated",
                                value: state is QueueStatusSuccess
                                    ? '${state.status['estimatedTime'] ?? state.status['avgWaitTime'] ?? '-'} min'
                                    : '- min',
                              ),
                            ],
                          ),
                        ),

                        const Gap(24),

                        state is CustomerSuccess
                            ? TicketWidget(
                                ticketNumber: state.ticket.ticketNumber,
                                peopleBefore: state.ticket.peopleWaiting,
                                estTime: "${state.ticket.peopleWaiting * 3} min",
                              )
                            : const TicketWidget(ticketNumber: "----", peopleBefore: 0, estTime: "-- min"),

                        const Gap(30),

                        SizedBox(
                          width: double.infinity,
                          height: 58,
                          child: ElevatedButton(
                            onPressed: isLoading
                                ? null
                                : () => context.read<CustomerCubit>().bookTicket(serviceId),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2397C3),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            ),
                            child: isLoading
                                ? const CircularProgressIndicator(color: Colors.white)
                                : const Text(
                                    "Book & Track Queue",
                                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                          ),
                        ),

                        if (state is CustomerError)
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Text(
                              state.message,
                              style: const TextStyle(color: Colors.red, fontSize: 13),
                              textAlign: TextAlign.center,
                            ),
                          ),

                        const Gap(20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSelectionCard({
    required String label,
    required String value,
    required String iconPath,
    required bool isActive,
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
          const Gap(15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(color: Colors.blueGrey, fontSize: 14)),
                Text(value, style: const TextStyle(color: AppColor.textDark, fontSize: 18, fontWeight: FontWeight.w800)),
              ],
            ),
          ),
          const Icon(Icons.keyboard_arrow_down_rounded, color: AppColor.textDark, size: 35),
        ],
      ),
    );
  }

  Widget _buildStatItem({required Color color, required IconData icon, required String label, required String value}) {
    return Expanded(
      child: Container(
        height: 95,
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