import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_firebase/common/repositories/common_firebase_storage_repository.dart';
import 'package:whatsapp_clone_firebase/common/urls/icon_urls.dart';
import 'package:whatsapp_clone_firebase/common/utils/utils.dart';
import 'package:whatsapp_clone_firebase/features/auth/screens/otp_screen.dart';
import 'package:whatsapp_clone_firebase/features/auth/screens/user_info_screen.dart';
import 'package:whatsapp_clone_firebase/models/user_model.dart';
import 'package:whatsapp_clone_firebase/screens/mobile_layout_screen.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
      auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance),
);

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRepository({required this.auth, required this.firestore});

  Future<UserModel?> getCurrentUserData()async{
    var userData = await firestore.collection('users').doc(auth.currentUser?.uid).get();
    UserModel? user;
    if (userData.data() != null){
      user = UserModel.fromJson(userData.data()!);
    }
    return user;
  }

  void signInWithPhone(
      {required BuildContext context, required String phoneNumber}) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (phoneAuthCredential) async {
          await auth.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (error) {
          throw Exception(error.message);
        },
        codeSent: (verificationId, forceResendingToken) async {
          Navigator.of(context)
              .pushNamed(OtpScreen.routeName, arguments: verificationId);
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      showSnackBar(context: context, content: e.message ?? 'Error occured');
    }
  }

  void verfyOTP({
    required BuildContext context,
    required String verificationId,
    required String userOTP,
  }) async {
    try {
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOTP);
      await auth.signInWithCredential(phoneAuthCredential);
      if (auth.currentUser != null) {
        showSnackBar(context: context, content: 'Successfully logged');
        Navigator.pushReplacementNamed(context, UserInfoScreen.routeName);
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, content: e.message ?? 'Error occured');
      print(e);
    }
  }

  void saveUserDataToFirebase({
    required String name,
    required File? profilePic,
    required ProviderRef ref,
    required BuildContext context,
  }) async {
    try {
      String uid = await auth.currentUser!.uid;
      String photoURL = myDP;
      if( profilePic != null){
         photoURL = await ref.read(commonFirebaseStorageRepositoryProvider).storeFileToFirebase('profilePic/$uid', profilePic);
      }
      var user = UserModel(name: name, uid: uid, profilePic: photoURL, phoneNumber: auth.currentUser!.uid, isOnline: true, groupId: []);
      await firestore.collection('users').doc(uid).set(user.toJson());
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const MobileLayoutScreen(),), (route) => false,);

    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, content: e.message ?? 'Error occured');
      print(e);
    }
  }
}
