import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_firebase/common/urls/icon_urls.dart';
import 'package:whatsapp_clone_firebase/common/utils/utils.dart';
import 'package:whatsapp_clone_firebase/features/auth/controllers/auth_controller.dart';

class UserInfoScreen extends ConsumerStatefulWidget {
  static const String routeName = 'user-info';

  const UserInfoScreen({super.key});


  @override
  ConsumerState<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends ConsumerState<UserInfoScreen> {
  final TextEditingController nameController = TextEditingController();
  File? image;

void selectImage()async{
  image = await pickImageFromGallery(context);
  setState(() {
    
  });
}
void storeUserData()async{
  String name = nameController.text.trim();
  if (name.isNotEmpty){
    ref.read(authControllerProvider).saveUserDataToFirebase(context, name, image);
  }
}
  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(child: Center(child:
      Column(
        children: [
          const SizedBox(height: 020,),
          Stack(
            children: [
              CircleAvatar(radius: 64,
                backgroundImage: image == null ? const NetworkImage(myDP): FileImage(image!),
              ),
              Positioned(bottom: -10,
                  left: 80,
                  child: IconButton(onPressed: selectImage, icon: Icon(Icons.add_a_photo),))

            ],
              ),
          Row(
            children: [
              Container(
                width: size.width * 0.85,
                padding: const EdgeInsets.all(20),
                child:  TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Enter your name'
                  ),
                ),
              ),
              IconButton(onPressed: storeUserData, icon: Icon(Icons.done))
            ],
          )
        ],
      ),)),
    );
  }
}
