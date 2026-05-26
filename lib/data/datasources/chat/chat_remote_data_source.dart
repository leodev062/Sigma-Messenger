import 'package:sigma/core/network/socket_manager.dart';

abstract class ChatRemoteDataSource {
  Stream<SignalMessage> get messageStream;
  void sendEnvelope(String chatId, String encryptedEnvelope);
  void acknowledgeReceipt(String requestId);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final SocketManager _socketManager;

  ChatRemoteDataSourceImpl(this._socketManager);

  @override
  Stream<SignalMessage> get messageStream => _socketManager.messages;

  @override
  void sendEnvelope(String chatId, String encryptedEnvelope) {
    _socketManager.sendRequest(
      verb: 'PUT',
      path: '/api/v1/message',
      body: {
        "destination_id": chatId,
        "envelope": encryptedEnvelope,
      },
    );
  }

  @override
  void acknowledgeReceipt(String requestId) {
    _socketManager.sendRequest(
      verb: 'DELETE',
      path: '/api/v1/message',
      body: requestId,
    );
  }
}
