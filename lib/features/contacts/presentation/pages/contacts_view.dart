import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sigma/domain/entities/user_entity.dart';
import 'package:sigma/features/contacts/presentation/viewmodels/contacts_viewmodel.dart';
import 'package:sigma/core/i18n/strings.dart';
import 'package:sigma/core/widgets/sigma_avatar.dart';

class ContactsView extends StatelessWidget {
  const ContactsView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final viewModel = context.watch<ContactsViewModel>();

    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundColor: colorScheme.primary,
            child: const Icon(Icons.group, color: Colors.white),
          ),
          title: Text(context.translate('new_group'), style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundColor: colorScheme.primary,
            child: const Icon(Icons.person_add, color: Colors.white),
          ),
          title: Text(context.translate('new_contact'), style: const TextStyle(fontWeight: FontWeight.bold)),
          trailing: const Icon(Icons.qr_code_scanner),
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundColor: colorScheme.primary,
            child: const Icon(Icons.groups, color: Colors.white),
          ),
          title: Text(context.translate('new_community'), style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              context.translate('contacts_header'),
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            ),
          ),
        ),
        Expanded(
          child: StreamBuilder<List<UserEntity>>(
            stream: viewModel.contacts,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              
              final contacts = snapshot.data ?? [];
              
              if (contacts.isEmpty) {
                return Center(
                  child: Text(
                    context.translate('no_contacts'),
                    style: TextStyle(color: colorScheme.onSurface.withOpacity(0.4)),
                  ),
                );
              }

              return ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  final contact = contacts[index];
                  return ListTile(
                    leading: SigmaAvatar(
                      avatarUrl: contact.avatarUrl,
                      name: contact.name ?? contact.username,
                    ),
                    title: Text(contact.name ?? contact.username ?? contact.phone),
                    subtitle: Text(contact.phone),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
