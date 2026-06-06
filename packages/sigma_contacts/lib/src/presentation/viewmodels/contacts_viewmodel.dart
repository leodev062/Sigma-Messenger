import 'package:flutter/material.dart';
import 'package:sigma_core/sigma_core.dart';

class ContactsViewModel extends ChangeNotifier {
  final IRecipientRepository _recipientRepository;

  ContactsViewModel(this._recipientRepository);

  Stream<List<Recipient>> get contacts => _recipientRepository.watchAllRecipients();
}
