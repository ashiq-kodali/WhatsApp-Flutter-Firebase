

import 'package:flutter/material.dart';
import 'package:whatsapp_clone_firebase/features/auth/screens/login_screens.dart';
import 'package:whatsapp_clone_firebase/features/auth/screens/otp_screen.dart';

import 'common/widgets/error.dart';

Route<dynamic> genarateRoute (RouteSettings settings){
  switch(settings.name){
    case LoginScreens.routeName:
      return MaterialPageRoute(builder: (context) => const LoginScreens(),);
    case OtpScreen.routeName:
      final verificationId = settings.arguments as String;
      return MaterialPageRoute(builder: (context) =>  OtpScreen(verificationID: verificationId,),);
    default :
      return MaterialPageRoute(builder: (context) => const Scaffold(body: ErrorScreen(error: "This page doesn't exist"),),);
  }

}