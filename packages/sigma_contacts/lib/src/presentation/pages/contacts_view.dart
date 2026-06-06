import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_ui/sigma_ui.dart';
import 'package:sigma_contacts/src/presentation/viewmodels/contacts_viewmodel.dart';

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
          child: StreamBuilder<List<Recipient>>(
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
                    leading: AvatarImageView(
                      recipient: contact,
                      size: 40,
                    ),
                    title: Text(contact.computedDisplayName),
                    subtitle: Text(contact.id),
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
