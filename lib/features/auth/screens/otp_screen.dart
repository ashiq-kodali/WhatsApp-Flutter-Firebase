
import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  static const String routeName = '/otp-screen';
  final String verificationID;
  const OtpScreen({super.key, required this.verificationID});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
