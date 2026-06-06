import 'package:get_it/get_it.dart';
import 'package:sigma_core/sigma_core.dart';

/// PushReceiveJob - Responsável por processar envelopes recebidos.
class PushReceiveJob extends Job {
  static const String KEY = "PushReceiveJob";
  final List<int> envelopeBytes;
  final PushMessageProcessor _processor;

  PushReceiveJob({
    required this.envelopeBytes,
    required PushMessageProcessor processor,
    int? databaseId,
  })  : _processor = processor,
        super(
          databaseId: databaseId, 
          factoryKey: KEY,
          queueKey: null, // Sem chave de fila para recebimento paralelo
        );

  @override
  Map<String, dynamic> serialize() => {'bytes': envelopeBytes};

  static Job create(Map<String, dynamic> data, int databaseId, GetIt locator) {
    return PushReceiveJob(
      envelopeBytes: List<int>.from(data['bytes']),
      processor: locator<PushMessageProcessor>(),
      databaseId: databaseId,
    );
  }

  @override
  Future<void> run() async {
    await _processor.process(envelopeBytes);
  }

  @override
  void onRunError(Object error, StackTrace stackTrace) {}
}
