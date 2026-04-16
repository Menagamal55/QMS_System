import 'package:flutter/material.dart';
import 'package:sw2project/features/staff%20flow/presentation/screens/notification.dart';
import 'package:sw2project/features/staff%20flow/presentation/screens/queuheader.dart';
import 'package:sw2project/features/staff%20flow/presentation/screens/report.dart';
import 'package:sw2project/features/staff%20flow/presentation/screens/staffheader.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Dashboard',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NotificationsScreen()),
                );
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(Icons.notifications_none, size: 28, color: Colors.black),
                  Positioned(
                    right: 0,
                    top: 12,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                      constraints: const BoxConstraints(minWidth: 14, minHeight: 14),
                      child: const Text(
                        '3', 
                        style: TextStyle(color: Colors.white, fontSize: 8), 
                        textAlign: TextAlign.center
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildCustomToggle(),
          Expanded(
            child: _getSelectedTab(),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomToggle() {
    return Container(
      margin: const EdgeInsets.all(16),
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFFE0E0E0),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          _toggleBtn(0, "Queues"),
          _toggleBtn(1, "Staff"),
          _toggleBtn(2, "Reports"),
        ],
      ),
    );
  }

  Widget _toggleBtn(int index, String title) {
    bool isSelected = _selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedIndex = index),
        child: Container(
          margin: const EdgeInsets.all(4),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            boxShadow: isSelected ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)] : [],
          ),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.black : Colors.black54,
            ),
          ),
        ),
      ),
    );
  }

  Widget _getSelectedTab() {
    switch (_selectedIndex) {
      case 0:
        return const QueuesTab();
      case 1:
        return const StaffTab();
      case 2:
        return const ReportsTab();
      default:
        return const QueuesTab();
    }
  }
}