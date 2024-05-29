import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_firebase/common/widgets/loader.dart';
import 'package:whatsapp_clone_firebase/features/auth/controllers/auth_controller.dart';
import 'package:whatsapp_clone_firebase/models/user_model.dart';

import '../../../colors.dart';
import '../widgets/bottom_chat_field.dart';
import '../widgets/chat_list.dart';


class MobileChatScreen extends ConsumerWidget {
  static const String routeName = '/mobile-chat-screen';
  final String name ;
  final String uid ;

  const MobileChatScreen({required this.name,required this.uid,
    Key? key,

  }) : super(key: key);




  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: StreamBuilder<UserModel>(
          stream: ref.read(authControllerProvider).userDataById(uid),
          builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting){
            print("connection done");
            return const Loader();
          }
          print("connection issue");
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name),
              Text(snapshot.data!.isOnline ? "Online" : "Offline",style: TextStyle(fontSize: 12,color:snapshot.data!.isOnline ? Colors.green:Colors.white ),),
            ],
          );

        },),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.video_call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        children: [
          Text("data"),
          Spacer(),
          BottomChatField(recieverUserId: uid)
        ],
      ),
    );

    //   CallPickupScreen(
    //   scaffold:
    //   ,
    // );
  }
}
