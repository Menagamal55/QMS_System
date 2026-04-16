import 'package:flutter/material.dart';

class NextInLineList extends StatelessWidget {
  const NextInLineList({super.key});

  @override
  Widget build(BuildContext context) {
    // داتا مؤقتة (Mock Data)
    final List<Map<String, String>> queueData = [
      {'ticket': 'A-106', 'service': 'Account opening'},
      {'ticket': 'A-107', 'service': 'Card Replacament'},
      {'ticket': 'A-108', 'service': 'Cash Deposit'},
    ];

    return ListView.separated(
      shrinkWrap: true, // عشان الـ ListView ميعملش مشكلة جوه الـ Column
      physics: const NeverScrollableScrollPhysics(), 
      itemCount: queueData.length,
      separatorBuilder: (context, index) => const Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Divider(
          color: Colors.black, 
          thickness: 1, 
          indent: 40, // عشان الخط ميبدأش من أول الشاشة
          endIndent: 40, // وعشان ينتهي قبل آخر الشاشة
        ),
      ),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              // الترتيب (1- , 2-)
              Text(
                '${index + 1}-',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(width: 16),
              
              // رقم التذكرة
              SizedBox(
                width: 60, // تثبيت العرض عشان الكلام ميرحلش
                child: Text(
                  queueData[index]['ticket']!,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              
              // اسم الخدمة
              Expanded(
                child: Text(
                  queueData[index]['service']!,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              
              // زرار pending
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF84CBE5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'pending',
                  style: TextStyle(
                    color: Colors.white, 
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}