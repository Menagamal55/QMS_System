import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:sw2project/features/customer_flow/presentation/bloc/cubit.dart';
import 'package:sw2project/features/customer_flow/presentation/bloc/customer_state.dart';

class Loan_inquiry extends StatelessWidget {
  const Loan_inquiry({super.key});

  static const int serviceId = 5;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<CustomerCubit>()
        ..getMyTicket()
        ..getQueueStatus(),
      child: BlocBuilder<CustomerCubit, CustomerState>(
        builder: (context, state) {
          final ticketNumber = state is CustomerSuccess ? state.ticket.ticketNumber : '----';
          final peopleBefore = state is CustomerSuccess ? state.ticket.peopleWaiting : 0;
          final estTime = state is CustomerSuccess ? '${peopleBefore * 3} min' : '-- min';
          final queueLength = state is QueueStatusSuccess
              ? '${state.status['peopleWaiting'] ?? state.status['queueLength'] ?? '-'}'
              : '-';
          final isLoading = state is CustomerLoading;

          return Scaffold(
            backgroundColor: const Color(0xFFD6E6E8),
            body: SafeArea(
              child: Column(
                children: [
                  _buildHeader(context),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(20),
                      children: [
                        _buildYourNumberCard(ticketNumber),
                        const Gap(20),
                        _buildNowServingSection(
                          queueLength: queueLength,
                        ),
                        const Gap(20),
                        _buildDetailedStatsCard(
                          peopleBefore: peopleBefore,
                          waitTime: estTime,
                        ),
                        const Gap(30),
                        _buildRefreshButton(context, isLoading),
                        if (state is CustomerError)
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Text(
                              state.message,
                              style: const TextStyle(color: Colors.red, fontSize: 13),
                              textAlign: TextAlign.center,
                            ),
                          ),
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

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15, bottom: 10, left: 10, right: 20),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF3B7D91), size: 22),
            onPressed: () => Navigator.pop(context),
          ),
          const Spacer(flex: 1),
          const Icon(Icons.confirmation_num_outlined, color: Color(0xFF3B7D91), size: 28),
          const Gap(10),
          const Text(
            "Queue Status",
            style: TextStyle(color: Color(0xFF3B7D91), fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }

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
              color: Colors.white.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              number,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Color(0xFF3B7D91), fontSize: 45, fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNowServingSection({required String queueLength}) {
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
            "Queue Status",
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
            child: Column(
              children: [
                const Text("People in Queue", style: TextStyle(color: Colors.blueGrey, fontSize: 14)),
                const Gap(6),
                Text(
                  queueLength,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Color(0xFF00796B), fontSize: 35, fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

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

  Widget _buildRefreshButton(BuildContext context, bool isLoading) {
    return SizedBox(
      width: double.infinity,
      height: 58,
      child: ElevatedButton.icon(
        onPressed: isLoading
            ? null
            : () {
                context.read<CustomerCubit>()
                  ..getMyTicket()
                  ..getQueueStatus();
              },
        icon: isLoading
            ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
            : const Icon(Icons.refresh_rounded, color: Colors.white, size: 28),
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