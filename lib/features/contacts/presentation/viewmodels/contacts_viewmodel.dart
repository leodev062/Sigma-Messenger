import 'package:flutter/material.dart';
import 'package:sigma/domain/entities/user_entity.dart';
import 'package:sigma/domain/repositories/i_recipient_repository.dart';

class ContactsViewModel extends ChangeNotifier {
  final IRecipientRepository _recipientRepository;

  ContactsViewModel(this._recipientRepository);

  Stream<List<UserEntity>> get contacts => _recipientRepository.getAllRecipients();

  // Futuras lógicas de adicionar contacto, bloquear, etc.
}
