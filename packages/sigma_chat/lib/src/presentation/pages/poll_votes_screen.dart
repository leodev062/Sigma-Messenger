import 'package:flutter/material.dart';
import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_ui/sigma_ui.dart';
import 'package:sigma_chat/src/presentation/viewmodels/chat_viewmodel.dart';

class PollVotesScreen extends StatelessWidget {
  final String messageId;

  const PollVotesScreen({super.key, required this.messageId});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ChatViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Votos da Enquete"),
      ),
      body: StreamBuilder<PollRecordEntity?>(
        stream: viewModel.watchPoll(messageId),
        builder: (context, snapshot) {
          final poll = snapshot.data;
          if (poll == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: poll.options.length,
            itemBuilder: (context, index) {
              final option = poll.options[index];
              return ExpansionTile(
                title: Text(option.text),
                subtitle: Text("${option.voters.length} votos"),
                children: option.voters.map((voter) {
                  return FutureBuilder<Recipient?>(
                    // Simulação: Pegar perfil do votante
                    future: locator<IRecipientRepository>().getRecipientByUuid(voter.id),
                    builder: (context, snapshot) {
                      final recipient = snapshot.data;
                      return ListTile(
                        leading: AvatarImageView(
                          recipient: recipient ?? Recipient.createUnknown(voter.id),
                          size: 32,
                        ),
                        title: Text(recipient?.computedDisplayName ?? "Usuário Sigma"),
                      );
                    },
                  );
                }).toList(),
              );
            },
          );
        },
      ),
    );
  }
}
