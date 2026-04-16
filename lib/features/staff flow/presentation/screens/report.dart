import 'package:flutter/material.dart';

class ReportsTab extends StatelessWidget {
  const ReportsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Complaints Overview",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Georgia'),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                flex: 5,
                child: SizedBox(
                  height: 180,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CustomPaint(
                        size: const Size(180, 180),
                        painter: ComplaintsPiePainter(),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    _buildLegendRow(const Color(0xFF64B5F6), "2 New"),
                    _buildLegendRow(const Color(0xFF81C784), "1 Resolved"),
                    _buildLegendRow(const Color(0xFFE57373), "1 In Progress"),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          _buildComplaintCard(
            "Amr yasser",
            "Queue Skipped",
            "B-102",
            "2:30Pm",
            "New",
            "https://i.pravatar.cc/150?u=amr",
          ),
          _buildComplaintCard(
            "Amira Ali",
            "Queue Delay",
            "A-102",
            "10:30Am",
            "New",
            "https://i.pravatar.cc/150?u=amira",
          ),
          _buildComplaintCard(
            "Omer Hassan",
            "System issue",
            "C-104",
            "9:15Am",
            "Resolved",
            "https://i.pravatar.cc/150?u=omer",
          ),
        ],
      ),
    );
  }

  Widget _buildComplaintCard(String name, String issue, String ticket, String time, String status, String imgUrl) {
    bool isResolved = status == "Resolved";
    
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(imgUrl),
            backgroundColor: Colors.grey[300],
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(issue, style: const TextStyle(color: Colors.black54, fontSize: 13)),
                Text("Ticket:$ticket", style: const TextStyle(color: Colors.black54, fontSize: 13)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isResolved ? const Color(0xFFA5D6A7) : const Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    if (isResolved) const Icon(Icons.check, size: 14, color: Colors.green),
                    Text(
                      status,
                      style: TextStyle(
                        color: isResolved ? Colors.green[800] : Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text("Today $time", style: const TextStyle(fontSize: 11, color: Colors.black45)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendRow(Color color, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(bottom: 2),
              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
              child: Text(text, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            ),
          ),
        ],
      ),
    );
  }
}

class ComplaintsPiePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final paintNew = Paint()..color = const Color(0xFF64B5F6);
    final paintResolved = Paint()..color = const Color(0xFF81C784);
    final paintInProgress = Paint()..color = const Color(0xFFE57373);

    canvas.drawArc(rect, -1.57, 3.14, true, paintNew);
    canvas.drawArc(rect, 1.57, 1.57, true, paintResolved);
    canvas.drawArc(rect, 0, 1.57, true, paintInProgress);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}