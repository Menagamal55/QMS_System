import 'package:flutter/material.dart';

class CustomImageHandler extends StatelessWidget {
  final double width;
  final double height;
  final String? imagePath; 
  final String label;

  const CustomImageHandler({
    super.key,
    required this.width,
    required this.height,
    this.imagePath,
    this.label = "Image",
  });

  @override
  Widget build(BuildContext context) {
    if (imagePath != null && imagePath!.isNotEmpty) {
      return Image.asset(
        imagePath!,
        width: width,
        height: height,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
      );
    } else {
      return _buildPlaceholder();
    }
  }

  Widget _buildPlaceholder() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(fontSize: 8, color: Colors.black54),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}