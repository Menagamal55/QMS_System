import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TicketWidget extends StatelessWidget {
  final String ticketNumber;
  final int peopleBefore;
  final String estTime;

  const TicketWidget({
    super.key,
    this.ticketNumber = "B104",
    this.peopleBefore = 5,
    this.estTime = "12 min",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // الجزء العلوي (Ticket Header)
          Row(
            children: [
              const Expanded(child: Divider()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: const [
                    Icon(Icons.confirmation_num, color: Color(0xFF3B7D91), size: 18),
                    Gap(5),
                    Text(
                      "Ticket",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Expanded(child: Divider()),
            ],
          ),
          const Gap(15),

          // الخط المنقط الأول
          _buildDashedLine(),
          const Gap(15),

          // رقم التذكرة
          Text(
            ticketNumber,
            style: const TextStyle(
              color: Color(0xFF1D4D4F),
              fontSize: 55,
              fontWeight: FontWeight.w900,
            ),
          ),

          const Gap(15),

          // الخط المنقط الثاني
          _buildDashedLine(),
          const Gap(20),

          // البيانات السفلية والـ QR Code
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "People Before You: $peopleBefore",
                    style: const TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(12),
                  Text(
                    "Estimated Time: $estTime",
                    style: const TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const Icon(
                Icons.qr_code_2,
                size: 75,
                color: Color(0xFF1D4D4F),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ويدجت الخط المنقط
  Widget _buildDashedLine() {
    return Row(
      children: List.generate(
        20,
        (index) => Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 2),
            height: 1.5,
            color: index % 2 == 0 ? Colors.transparent : Colors.grey[300],
          ),
        ),
      ),
    );
  }
}