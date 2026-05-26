import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sigma/core/util/sigma_log.dart';

/// Serviço responsável por apresentar notificações nativas ao utilizador.
/// Segue o padrão de canais de notificação do Android.
class NotificationService {
  static const String tag = "NotificationService";
  
  final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  static const String _channelId = "sigma_messages_channel";
  static const String _channelName = "Mensagens Sigma";
  static const String _channelDescription = "Notificações de novas mensagens recebidas";

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    // Ajustado para parâmetros nomeados conforme versão 21.0.0
    await _notificationsPlugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // Lógica de navegação ao clicar na notificação pode ser adicionada aqui
      },
    );

    SigmaLog.i(tag, "NotificationService inicializado.");
  }

  /// Apresenta uma notificação de nova mensagem com texto já desencriptado.
  Future<void> showNewMessageNotification({
    required String senderName,
    required String decryptedText,
    required String chatId,
  }) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
      styleInformation: BigTextStyleInformation(''),
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    // Ajustado para parâmetros nomeados conforme versão 21.0.0
    await _notificationsPlugin.show(
      id: chatId.hashCode,
      title: senderName,
      body: decryptedText,
      notificationDetails: platformChannelSpecifics,
      payload: chatId,
    );
  }
}
