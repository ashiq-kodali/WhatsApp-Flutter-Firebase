import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_firebase/features/landing/screens/landing_screen.dart';
import 'package:whatsapp_clone_firebase/router.dart';
import 'package:whatsapp_clone_firebase/screens/mobile_layout_screen.dart';
import 'package:whatsapp_clone_firebase/screens/web_layout_screen.dart';
import 'package:whatsapp_clone_firebase/utils/responsive_layout.dart';

import 'colors.dart';
import 'firebase_options.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Whatsapp UI',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor:
        backgroundColor,
        appBarTheme: const  AppBarTheme(color: appBarColor)
      ),
      onGenerateRoute: (settings) => genarateRoute(settings),
      home: const LandingScreen()
      // ResponsiveLayout(
      //   mobileScreenLayout: MobileLayoutScreen(),
      //   webScreenLayout: WebLayoutScreen(),
      // ),
    );
  }
}
