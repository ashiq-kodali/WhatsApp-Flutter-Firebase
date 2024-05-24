import 'package:flutter/material.dart';
import 'package:whatsapp_clone_firebase/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50),
          backgroundColor: tabColor,shape: RoundedRectangleBorder( borderRadius: BorderRadius.zero,)),
      child: Text(
        text,
        style: TextStyle(color: blackColor),
      ),
    );
  }
}
