import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_firebase/common/utils/utils.dart';
import 'package:whatsapp_clone_firebase/features/auth/screens/otp_screen.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance),);

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRepository({required this.auth, required this.firestore});

  void signInWithPhone(
      {required BuildContext context, required String phoneNumber}) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
          verificationCompleted: (phoneAuthCredential) async{
            await auth.signInWithCredential(phoneAuthCredential);
          },
          verificationFailed: (error) {
            throw Exception(error.message);
          },
          codeSent: (verificationId, forceResendingToken) async{
            Navigator.of(context).pushNamed(OtpScreen.routeName,arguments: verificationId);
          },
          codeAutoRetrievalTimeout: (verificationId) {

          },);
    } on FirebaseAuthException catch (e) {
      print(e);
      showSnackBar(context: context, content: e.message ?? 'Error occured');
    }
  }
}
