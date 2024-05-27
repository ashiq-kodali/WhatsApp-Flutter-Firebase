
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_firebase/colors.dart';
import 'package:whatsapp_clone_firebase/features/auth/controllers/auth_controller.dart';

class OtpScreen extends ConsumerWidget {
  static const String routeName = '/otp-screen';
  final String verificationID;
  const OtpScreen({super.key, required this.verificationID});
  void verifyOTP(WidgetRef ref,BuildContext context, String userOTP){
    ref.read(authControllerProvider).verifyOTP(context, verificationID, userOTP);
  }

  @override
  Widget build(BuildContext context , WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verifiying your number'),
        backgroundColor: backgroundColor,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20,),
            const Text('We have sent an SMS with a code.'),
            SizedBox(
              width: size.width * 0.50,
              child:TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: '--- ---',
                  hintStyle: TextStyle(letterSpacing: 5,fontSize: 30)
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  if( value.length == 6 ) {
                    verifyOTP(ref, context, value.trim());
                  }
                },
              ) ,
            )
          ],
        ),
      ),
    );
  }
}
