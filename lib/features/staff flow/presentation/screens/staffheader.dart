import 'package:flutter/material.dart';

class StaffTab extends StatelessWidget {
  const StaffTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              _buildStatCard("Total Staff", "21", Icons.groups, const Color(0xFFD1E9F6)),
              _buildStatCard("On Duty", "15", Icons.assignment, const Color(0xFFD1E9F6)),
              _buildStatCard("pending request", "6", Icons.info_outline, const Color(0xFFD1E9F6)),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [
                _buildRow("Staff Member", "Role", "Counter", isHeader: true),
                const Divider(),
                _buildRow("Ahmed hassan", "Customer Support", "3"),
                _buildRow("Ali Mohamed", "Technical Support", "5"),
                _buildRow("Hassan Ali", "Technical Support", "7"),
                _buildRow("Mona Saeed", "Receptionist", "1"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String val, IconData icon, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontSize: 12), textAlign: TextAlign.center),
            Text(val, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Icon(icon, size: 40, color: Colors.blue[300]),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String c1, String c2, String c3, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(c1, style: TextStyle(fontWeight: isHeader ? FontWeight.bold : FontWeight.bold, color: isHeader ? Colors.grey : Colors.black))),
          Expanded(flex: 2, child: Text(c2, style: TextStyle(color: isHeader ? Colors.grey : Colors.blueGrey))),
          Expanded(flex: 1, child: Text(c3, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }
}