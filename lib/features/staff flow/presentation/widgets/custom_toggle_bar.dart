import 'package:flutter/material.dart';

class CustomToggleBar extends StatelessWidget {
  final int selectedIndex; 
  final Function(int) onChanged; 

  const CustomToggleBar({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48, 
      decoration: BoxDecoration(
        color: const Color(0xFFD4D4D4),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          _buildToggleButton(0, 'Queues'),
          _buildToggleButton(1, 'Staff'),
          _buildToggleButton(2, 'Reports'),
        ],
      ),
    );
  }

  Widget _buildToggleButton(int index, String label) {
    bool isActive = selectedIndex == index; 

    return Expanded(
      child: GestureDetector(
        onTap: () => onChanged(index), 
        child: Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            boxShadow: isActive 
                ? [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4)]
                : [],
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,

              color: isActive ? Colors.black : Colors.black54,
            ),
          ),
        ),
      ),
    );
  }
}