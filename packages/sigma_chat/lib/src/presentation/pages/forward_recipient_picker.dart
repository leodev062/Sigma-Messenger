import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_ui/sigma_ui.dart';
import '../viewmodels/chat_viewmodel.dart';
import 'package:sigma_contacts/sigma_contacts.dart';

/// ForwardRecipientPicker - Tela de seleção para encaminhamento (Signal Style).
class ForwardRecipientPicker extends StatefulWidget {
  final MessageEntity message;

  const ForwardRecipientPicker({super.key, required this.message});

  @override
  State<ForwardRecipientPicker> createState() => _ForwardRecipientPickerState();
}

class _ForwardRecipientPickerState extends State<ForwardRecipientPicker> {
  final Set<String> _selectedChatIds = {};

  @override
  Widget build(BuildContext context) {
    final contactsViewModel = context.watch<ContactsViewModel>();
    final chatViewModel = context.read<ChatViewModel>();
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Encaminhar"),
        actions: [
          if (_selectedChatIds.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () async {
                await chatViewModel.forwardMessage(widget.message, _selectedChatIds.toList());
                if (context.mounted) Navigator.pop(context);
              },
            ),
        ],
      ),
      body: StreamBuilder<List<Recipient>>(
        stream: contactsViewModel.contacts,
        builder: (context, snapshot) {
          final contacts = snapshot.data ?? [];
          return ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              final contact = contacts[index];
              final isSelected = _selectedChatIds.contains(contact.id);

              return ListTile(
                leading: AvatarImageView(recipient: contact, size: 40),
                title: Text(contact.computedDisplayName),
                trailing: isSelected 
                    ? Icon(Icons.check_circle, color: colorScheme.primary)
                    : const Icon(Icons.circle_outlined),
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      _selectedChatIds.remove(contact.id);
                    } else {
                      _selectedChatIds.add(contact.id);
                    }
                  });
                },
              );
            },
          );
        },
      ),
    );
  }
}
