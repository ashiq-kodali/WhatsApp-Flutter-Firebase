import 'package:flutter/material.dart';
import 'package:whatsapp_clone_firebase/colors.dart';
import 'package:whatsapp_clone_firebase/common/widgets/custom_button.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 50,
          ),
          const Text(
            'Welcome to WhatsApp',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: size.height / 12,
          ),
          Image.asset(
            'assets/bg.png',
            height: 220,
            width: 220,
            color: tabColor,
          ),
          SizedBox(
            height: size.height / 12,
          ),
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Read our privacy policy. Tap "Agree and continue" to accept the terms of service',
              style: TextStyle(color: greyColor),textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: size.width*0.75,
            child: CustomButton(text: 'AGREE AND CONTINUE', onPressed: () {
              print('button cliked');
            },),
          )
        ],
      )),
    );
  }
}
