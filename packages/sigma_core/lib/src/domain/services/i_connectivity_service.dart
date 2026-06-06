abstract class IConnectivityService {
  /// Stream que emite true se houver conexão com a internet e false caso contrário.
  Stream<bool> get isConnectedStream;

  /// Retorna o estado atual da conexão de forma síncrona.
  Future<bool> get isConnected;
}
