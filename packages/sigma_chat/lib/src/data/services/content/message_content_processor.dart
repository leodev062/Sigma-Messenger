import 'package:sigma_core/src/network/pb/message.pb.dart' as sigmapb;

/// MessageContentProcessor - Interface para o padrão Strategy de processamento de conteúdo.
/// Permite que novos tipos de mensagens (Voz, Vídeo, Stickers) sejam adicionados sem alterar o Handler principal.
abstract class MessageContentProcessor {
  /// Define se este processador pode lidar com o payload recebido.
  bool canProcess(sigmapb.Content payload);

  /// Executa o processamento específico do conteúdo.
  Future<void> process({
    required String messageId,
    required String senderId,
    required sigmapb.Content payload,
    required int timestamp,
  });
}
