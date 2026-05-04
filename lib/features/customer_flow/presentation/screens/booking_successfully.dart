import 'package:flutter/material.dart';
import 'package:sw2project/features/customer_flow/presentation/choose_service.dart';

class BookingSuccessScreen extends StatelessWidget {
  const BookingSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: const Color.fromARGB(255, 195, 223, 235),
      body: Center(
        child: SingleChildScrollView( 
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 25),
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                _buildCheckIcon(),
                
                const SizedBox(height: 25),

                const Text(
                  'Booking Successful!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF234E6F),
                    letterSpacing: 0.5,
                  ),
                ),
                
                const SizedBox(height: 12),

                const Text(
                  'Your queue number has been\nbooked successfully.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 30),
                const Divider(thickness: 1, color: Color(0xFFF0F0F0)),
                const SizedBox(height: 30),

                const Text(
                  'Your Queue Number',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'B104',
                  style: TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF234E6F),
                  ),
                ),

                const SizedBox(height: 40),

                _buildButton(
                  text: 'Back to Home',
                  isPrimary: true, 
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChooseServiceScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCheckIcon() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: const Color(0xFFF1F8E9), 
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFF81C784), width: 1.5),
      ),
      child: const Icon(
        Icons.check_rounded,
        size: 45,
        color: Color(0xFF4CAF50),
      ),
    );
  }

  Widget _buildButton({
    required String text,
    required bool isPrimary,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? const Color(0xFF234E6F) : Colors.white,
          elevation: 0,
          side: isPrimary ? BorderSide.none : const BorderSide(color: Color(0xFF234E6F)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isPrimary ? Colors.white : const Color(0xFF234E6F),
          ),
        ),
      ),
    );
  }
}