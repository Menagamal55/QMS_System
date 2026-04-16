import 'package:flutter/material.dart';

class QueueManagementScreen extends StatelessWidget {
  const QueueManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAEAEA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF555555), size: 24),
                onPressed: () {
                  Navigator.pop(context); 
                },
              ),
              const SizedBox(height: 10),

              const Center(
                child: Text(
                  'Queue Management',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                    color: Color(0xFF555555),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // 3. زراير الـ New Ticket و Pause Queue
              Row(
                children: [
                  Expanded(
                    child: _buildActionButton(
                      icon: Icons.add_circle_outline,
                      label: 'New ticket',
                      color: const Color(0xFF81CBEB),
                      textColor: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildActionButton(
                      icon: Icons.pause,
                      label: 'Pause Queue',
                      color: const Color(0xFFC4C4C4),
                      textColor: const Color(0xFF555555),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      title: 'Avg Wait\nTime ',
                      value: '45 min',
                      icon: Icons.timer_outlined,
                      isBlue: true,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      title: 'Total in Queue\n',
                      value: '8',
                      icon: null,
                      isBlue: false,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD6D6D6),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.play_arrow, color: Color(0xFF2E7D32), size: 18),
                          SizedBox(width: 4),
                          Text('Status', style: TextStyle(fontSize: 16, color: Colors.black87)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFA1DFC1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Text(
                          'Active',
                          style: TextStyle(color: Color(0xFF1B5E20), fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(height: 2, width: 60, color: Colors.black87),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Current Customers',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Courier',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(height: 2, width: 180, color: Colors.black87),
                ],
              ),
              const SizedBox(height: 16),

              // 7. قائمة العملاء (Scrollable)
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildCustomerCard(
                      ticketNumber: 'A-105',
                      service: 'cash deposit',
                      time: '8 min ago',
                      status: 'now serving',
                      statusColor: Colors.green.shade800,
                    ),
                    const SizedBox(height: 12),
                    _buildCustomerCard(
                      ticketNumber: 'A-106',
                      service: 'account opening',
                      time: '3 min ago',
                      status: 'waiting',
                      statusColor: Colors.black,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildActionButton({required IconData icon, required String label, required Color color, required Color textColor}) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, color: textColor, size: 22),
      label: Text(label, style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 15)),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        elevation: 0,
      ),
    );
  }

  Widget _buildStatCard({required String title, required String value, IconData? icon, required bool isBlue}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isBlue
              ? [const Color(0xFF81CBEB), const Color(0xFFC3E7F4)]
              : [const Color(0xFFDCDCDC), const Color(0xFFECECEC)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, color: Colors.black87)),
              if (icon != null) ...[
                const SizedBox(width: 4),
                Icon(icon, size: 18, color: Colors.black87),
              ]
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 4),
          Container(height: 2, width: 60, color: Colors.black87),
        ],
      ),
    );
  }

  Widget _buildCustomerCard({
    required String ticketNumber,
    required String service,
    required String time,
    required String status,
    required Color statusColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(ticketNumber, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.edit_document, size: 18, color: Color(0xFF555555)),
              const SizedBox(width: 8),
              RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.black87, fontSize: 15),
                  children: [
                    const TextSpan(text: 'service: '),
                    TextSpan(text: service, style: const TextStyle(fontWeight: FontWeight.w900)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.access_time, size: 18, color: Color(0xFF555555)),
              const SizedBox(width: 8),
              RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.black87, fontSize: 15),
                  children: [
                    const TextSpan(text: 'time: '),
                    TextSpan(text: time, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.check_circle_outline, size: 18, color: Color(0xFF555555)),
                  const SizedBox(width: 8),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(color: Colors.black87, fontSize: 15),
                      children: [
                        const TextSpan(text: 'status: '),
                        TextSpan(text: status, style: TextStyle(color: statusColor, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.green.shade100,
                    radius: 16,
                    child: Icon(Icons.check, color: Colors.green.shade800, size: 20),
                  ),
                  const SizedBox(width: 10),
                  CircleAvatar(
                    backgroundColor: Colors.red.shade100,
                    radius: 16,
                    child: Icon(Icons.close, color: Colors.red.shade800, size: 20),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}