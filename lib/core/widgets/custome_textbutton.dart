import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
   const CustomTextButton({super.key, required this.text, this.onTab,this.color, required Color textColor
  });

  final String text;
  final void Function()? onTab;
   final Color? color;

   @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTab,
      child: Text(text, style: const TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold,  color: Colors.white),),
    );
  }
}
