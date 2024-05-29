

import 'package:flutter/material.dart';
import 'package:whatsapp_clone_firebase/features/auth/screens/login_screens.dart';
import 'package:whatsapp_clone_firebase/features/auth/screens/otp_screen.dart';
import 'package:whatsapp_clone_firebase/features/auth/screens/user_info_screen.dart';

import 'common/widgets/error.dart';
import 'features/select_contacts/screens/select_contact_screen.dart';
import 'features/chat/screens/mobile_chat_screen.dart';

Route<dynamic> genarateRoute (RouteSettings settings){
  switch(settings.name){
    case LoginScreens.routeName:
      return MaterialPageRoute(builder: (context) => const LoginScreens(),);
    case OtpScreen.routeName:
      final verificationId = settings.arguments as String;
      return MaterialPageRoute(builder: (context) =>  OtpScreen(verificationID: verificationId,),);
    case UserInfoScreen.routeName:
      return MaterialPageRoute(builder: (context) => const UserInfoScreen(),);
    case SelectContactScreen.routeName:
      return MaterialPageRoute(builder: (context) => const SelectContactScreen(),);
    case MobileChatScreen.routeName:
      final arguments = settings.arguments as Map<String,dynamic>;
      final name = arguments['name'];
      final uid = arguments['uid'];
      return MaterialPageRoute(builder: (context) =>  MobileChatScreen(name: name, uid: uid),);
    default :
      return MaterialPageRoute(builder: (context) => const Scaffold(body: ErrorScreen(error: "This page doesn't exist"),),);
  }

}