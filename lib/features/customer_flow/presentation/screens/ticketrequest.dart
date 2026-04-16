import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TicketRequestScreen extends StatefulWidget {
  const TicketRequestScreen({super.key});

  @override
  State<TicketRequestScreen> createState() => _TicketRequestScreenState();
}

class _TicketRequestScreenState extends State<TicketRequestScreen> {
  String? selectedService;
  String? selectedBranch;
  String? ticketNumber;
  int? peopleBeforeYou;
  int? estimatedTime;
  bool showTicket = false;

  final List<String> services = [
    'Deposit',
    'Withdrawal',
    'Open Account',
    'Card Services',
    'Loan Inquiry',
    'Customer Support',
  ];

  final List<String> branches = [
    'Mansoura Main Branch',
    'Cairo Downtown Branch',
    'Alexandria Branch',
    'Giza Branch',
  ];

  final Random random = Random();

  void generateTicket() {
    if (selectedService == null || selectedBranch == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select both service type and branch'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      int randomNum = 100 + random.nextInt(900);
      ticketNumber = 'B$randomNum';
      peopleBeforeYou = 2 + random.nextInt(10);
      estimatedTime = peopleBeforeYou! * 2 + random.nextInt(5);
      showTicket = true;
    });
  }

  void resetForm() {
    setState(() {
      selectedService = null;
      selectedBranch = null;
      ticketNumber = null;
      peopleBeforeYou = null;
      estimatedTime = null;
      showTicket = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Your Queue Number'),
        backgroundColor: const Color(0xFF2397C3),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select Service',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const Gap(8),
                    DropdownButtonFormField<String>(
                      value: selectedService,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      items: services.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                      onChanged: (v) => setState(() {
                        selectedService = v;
                        showTicket = false;
                      }),
                    ),
                    const Gap(20),
                    const Text(
                      'Select Branch',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const Gap(8),
                    DropdownButtonFormField<String>(
                      value: selectedBranch,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      items: branches.map((b) => DropdownMenuItem(value: b, child: Text(b))).toList(),
                      onChanged: (v) => setState(() {
                        selectedBranch = v;
                        showTicket = false;
                      }),
                    ),
                    const Gap(24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: generateTicket,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2397C3),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('Get Queue Ticket'),
                      ),
                    ),
                    if (showTicket) ...[
                      const Gap(24),
                      const Divider(),
                      const Gap(16),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.blue.shade50, Colors.blue.shade100],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.blue.shade200),
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text(
                              ticketNumber!,
                              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                            ),
                            const Gap(8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFF2397C3),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(selectedService!, style: const TextStyle(color: Colors.white)),
                            ),
                            const Gap(20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    const Icon(Icons.people, size: 28),
                                    const Gap(6),
                                    Text('$peopleBeforeYou', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                                    const Text('People Before You'),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Icon(Icons.timer, size: 28),
                                    const Gap(6),
                                    Text('$estimatedTime min', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                                    const Text('Estimated Time'),
                                  ],
                                ),
                              ],
                            ),
                            const Gap(20),
                            Text(selectedBranch!, textAlign: TextAlign.center),
                            const Gap(16),
                            OutlinedButton.icon(
                              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Tracking your queue...')),
                              ),
                              icon: const Icon(Icons.track_changes),
                              label: const Text('Track Queue'),
                            ),
                            TextButton(
                              onPressed: resetForm,
                              child: const Text('Request Another Ticket'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}