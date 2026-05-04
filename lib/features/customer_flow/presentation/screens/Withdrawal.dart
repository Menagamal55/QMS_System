import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:sw2project/features/customer_flow/presentation/bloc/cubit.dart';
import 'package:sw2project/features/customer_flow/presentation/bloc/customer_state.dart';
import 'package:sw2project/features/customer_flow/presentation/widgets/custom_widgets.dart';
import 'package:sw2project/features/customer_flow/presentation/widgets/ticket_widgwt.dart';

class WithdrawalScreen extends StatelessWidget {
  const WithdrawalScreen({super.key});

  static const int serviceId = 2;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<CustomerCubit>()..getQueueStatus(),
      child: BlocBuilder<CustomerCubit, CustomerState>(
        builder: (context, state) {
          final serviceName = ModalRoute.of(context)?.settings.arguments as String? ?? "Cash Withdrawal";
          final isLoading = state is CustomerLoading;

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
                        _buildStatsRow(state),
                        const Gap(25),
                        state is CustomerSuccess
                            ? TicketWidget(
                                ticketNumber: state.ticket.ticketNumber,
                                peopleBefore: state.ticket.peopleWaiting,
                                estTime: "${state.ticket.peopleWaiting * 3} min",
                              )
                            : const TicketWidget(),
                      ],
                    ),
                  ),
                  _buildTrackButton(context, state, isLoading),
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
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow(CustomerState state) {
    final peopleWaiting = state is QueueStatusSuccess
        ? '${state.status['peopleWaiting'] ?? state.status['queueLength'] ?? '-'}'
        : '-';
    final estTime = state is QueueStatusSuccess
        ? '${state.status['estimatedTime'] ?? state.status['avgWaitTime'] ?? '-'} min'
        : '- min';

    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Row(
        children: [
          StatBox(color: const Color(0xFF4DB6AC), icon: Icons.people_outline, label: "People\nWaiting:", value: peopleWaiting),
          StatBox(color: const Color(0xFF3B7D91), icon: Icons.access_time, label: "Estimated", value: estTime),
        ],
      ),
    );
  }

  Widget _buildTrackButton(BuildContext context, CustomerState state, bool isLoading) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
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
              : const Text("Book & Track Queue", style: TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}