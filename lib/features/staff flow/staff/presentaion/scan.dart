import 'package:flutter/material.dart';

class QrScannerScreen extends StatelessWidget {
  const QrScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBEBEB), // نفس لون الخلفية الرمادي الفاتح
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 1. العنوان
              const Text(
                'Scan your QR Code',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              
              const SizedBox(height: 60),

              // 2. مربع الـ QR Code بالزوايا
              SizedBox(
                width: 280,
                height: 280,
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        width: 220,
                        height: 220,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade300, width: 1),
                        ),
                        // حطيت أيكون مؤقتة كشكل للـ QR Code
                        child: const Icon(
                          Icons.qr_code_2,
                          size: 180,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    
                    // الزاوية اللي فوق على الشمال
                    Positioned(
                      top: 0, left: 0,
                      child: _buildCorner(isTop: true, isLeft: true),
                    ),
                    // الزاوية اللي فوق على اليمين
                    Positioned(
                      top: 0, right: 0,
                      child: _buildCorner(isTop: true, isLeft: false),
                    ),
                    // الزاوية اللي تحت على الشمال
                    Positioned(
                      bottom: 0, left: 0,
                      child: _buildCorner(isTop: false, isLeft: true),
                    ),
                    // الزاوية اللي تحت على اليمين
                    Positioned(
                      bottom: 0, right: 0,
                      child: _buildCorner(isTop: false, isLeft: false),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 60),

              // 3. الزرار اللبني
              ElevatedButton.icon(
                onPressed: () {
                  // هنا هنحط كود فتح الكاميرا بعدين
                },
                icon: const Icon(Icons.crop_free, color: Colors.white, size: 24),
                label: const Text(
                  'Scan QR Code',
                  style: TextStyle(
                    color: Colors.white, 
                    fontSize: 18, 
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8DC6DF), // اللون اللبني بتاعكم
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
              ),
              
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCorner({required bool isTop, required bool isLeft}) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        border: Border(
          top: isTop ? const BorderSide(color: Colors.black87, width: 3) : BorderSide.none,
          bottom: !isTop ? const BorderSide(color: Colors.black87, width: 3) : BorderSide.none,
          left: isLeft ? const BorderSide(color: Colors.black87, width: 3) : BorderSide.none,
          right: !isLeft ? const BorderSide(color: Colors.black87, width: 3) : BorderSide.none,
        ),
      ),
    );
  }
}