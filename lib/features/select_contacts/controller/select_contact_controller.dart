
import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_firebase/features/select_contacts/repository/select_contact_repository.dart';

final getContactsProvider = FutureProvider((ref) {
  final selectContactRepository = ref.watch(selectContactRepositoryProvider);
  return selectContactRepository.getContacts() ;
},);

final selectContactControllerProvider = Provider((ref) {
  final SelectContactRepository = ref.watch(selectContactRepositoryProvider);
  return SelectContactController(selectContactRepository: SelectContactRepository, ref: ref);
},);

class SelectContactController {
  final SelectContactRepository selectContactRepository;
  final ProviderRef ref;

  SelectContactController({required this.selectContactRepository, required this.ref});

  void selectContact(Contact selectedContact ,BuildContext context,){
     selectContactRepository.selectContact(selectedContact, context);
  }


}