import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_firebase/colors.dart';
import 'package:whatsapp_clone_firebase/common/utils/utils.dart';
import 'package:whatsapp_clone_firebase/common/widgets/custom_button.dart';
import 'package:country_picker/country_picker.dart';

import '../controllers/auth_controller.dart';


class LoginScreens extends ConsumerStatefulWidget {
  static const routeName = '/login-screen';
  const LoginScreens({super.key});

  @override
  ConsumerState<LoginScreens> createState() => _LoginScreensState();
}

class _LoginScreensState extends ConsumerState<LoginScreens> {
  final phoneController = TextEditingController();
  Country? country;

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }
  void pickCountry(){
    showCountryPicker(
      context: context,
      showPhoneCode: true, // optional. Shows phone code before the country name.
      onSelect: (Country _country) {
        setState(() {
          country = _country;
        });
        print('Select country: ${_country.displayName}');
      },
    );

  }
  void sendPhoneNumber(){
    String phoneNumber = phoneController.text.trim();
    if (country != null && phoneNumber.isNotEmpty){
      ref.read(authControllerProvider).signInWithPhone(context, "${country!.phoneCode}$phoneNumber");
    }else{
      showSnackBar(context: context, content: 'Fill all the field');
    }
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter your phone number'),
        elevation: 0,
        backgroundColor: backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('WhatsApp will need to verify your phone number'),
            const SizedBox(
              height: 10,
            ),
            TextButton(onPressed: pickCountry, child: Text('Pick Country')),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                if(country != null )Text('+${country!.phoneCode}'),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: size.width * 0.7,
                  child: TextField(
                    controller: phoneController,
                    decoration:const InputDecoration(
                      hintText: 'Phone Number'
                    ),
                    onChanged: (value) => print(value ),
                  ),
                ),
              ],
            ),
            // SizedBox(height: size.height*0.6,),
            const Spacer(),
            SizedBox(width: 90,child: CustomButton(text: 'Next', onPressed: sendPhoneNumber),)
          ],
        ),
      ),
    );
  }
}
