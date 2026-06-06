import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ApkUpdateNotifications {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static const _channelId = 'apk_update_channel';
  static const _notificationId = 1337;

  Future<void> init() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    // Versão 21+ exige parâmetro nomeado 'settings'
    await _notifications.initialize(
      settings: const InitializationSettings(android: androidSettings),
    );
  }

  Future<void> showDownloadInProgress(int progress) async {
    final androidDetails = AndroidNotificationDetails(
      _channelId,
      'Atualizações',
      channelDescription: 'Progresso do download do APK',
      importance: Importance.low,
      priority: Priority.low,
      showProgress: true,
      maxProgress: 100,
      progress: progress,
      ongoing: true,
      onlyAlertOnce: true,
    );
    
    // Versão 21+ exige parâmetros nomeados: id, title, body, notificationDetails
    await _notifications.show(
      id: _notificationId,
      title: 'Sigma',
      body: 'Descarregando atualização...',
      notificationDetails: NotificationDetails(android: androidDetails),
    );
  }

  Future<void> showUpdateReadyToInstall(String payload) async {
    final androidDetails = AndroidNotificationDetails(
      _channelId,
      'Atualizações',
      importance: Importance.high,
      priority: Priority.high,
      ongoing: false,
    );

    // Versão 21+ exige parâmetros nomeados: id, title, body, notificationDetails, payload
    await _notifications.show(
      id: _notificationId,
      title: 'Atualização Disponível',
      body: 'Toque para instalar a nova versão do Sigma.',
      notificationDetails: NotificationDetails(android: androidDetails),
      payload: payload,
    );
  }

  // Versão 21+ exige parâmetro nomeado 'id'
  Future<void> cancelNotifications() async => await _notifications.cancel(id: _notificationId);
}
