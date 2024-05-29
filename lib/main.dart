import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_firebase/common/widgets/error.dart';
import 'package:whatsapp_clone_firebase/common/widgets/loader.dart';
import 'package:whatsapp_clone_firebase/features/auth/controllers/auth_controller.dart';
import 'package:whatsapp_clone_firebase/features/landing/screens/landing_screen.dart';
import 'package:whatsapp_clone_firebase/router.dart';
import 'package:whatsapp_clone_firebase/screens/mobile_layout_screen.dart';
import 'colors.dart';
import 'firebase_options.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Whatsapp UI',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor:
        backgroundColor,
        appBarTheme: const  AppBarTheme(color: appBarColor)
      ),
      onGenerateRoute: (settings) => genarateRoute(settings),
      home: ref.watch(userDataAuthProvider).when(data: (user) {
        if(user == null ){
          return const LandingScreen();
        }
        return const MobileLayoutScreen();
      }, error: (error, stackTrace) => ErrorScreen(error: error.toString()), loading: () => const Loader(),)
      // const LandingScreen()
      // ResponsiveLayout(
      //   mobileScreenLayout: MobileLayoutScreen(),
      //   webScreenLayout: WebLayoutScreen(),
      // ),
    );
  }
}
