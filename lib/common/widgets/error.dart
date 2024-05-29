import 'package:flutter/cupertino.dart';

import '../../colors.dart';

class ErrorScreen extends StatelessWidget {
  final String error;

  const ErrorScreen({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child:  Container(width:size.width*0.5,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: tabColor),
          child: Text(error)),
    );
  }
}
