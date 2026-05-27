import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';
import 'package:sigma/core/storage/sigma_store.dart';
import 'package:sigma/app/locator.dart';
import 'package:sigma/app/router.dart';
import 'package:sigma/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:sigma/features/chat/presentation/viewmodels/chat_viewmodel.dart';
import 'package:sigma/features/home/presentation/viewmodels/home_viewmodel.dart';
import 'package:sigma/features/contacts/presentation/viewmodels/contacts_viewmodel.dart';
import 'package:sigma/features/settings/presentation/viewmodels/settings_viewmodel.dart';
import 'package:sigma/features/updater/update_viewmodel.dart';
import 'package:sigma/domain/services/i_socket_service.dart';
import 'package:sigma/domain/repositories/i_chat_repository.dart';
import 'package:sigma/domain/repositories/i_recipient_repository.dart';
import 'package:sigma/core/updater/apk_update_notifications.dart';
import 'package:sigma/core/updater/apk_update_refresh_listener.dart';
import 'package:sigma/core/notifications/notification_service.dart';
import 'package:sigma/data/services/fcm_receiver_service.dart';
import 'package:sigma/core/theme/app_theme.dart';
import 'firebase_options.dart';

/// Top-level handler para mensagens FCM em background/killed state.
/// Roda num Isolate separado.
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Garante inicialização do Flutter no novo Isolate
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  final fcmService = FcmReceiverService();
  await fcmService.handleMessage(message, isBackground: true);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Future.wait([
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
    SigmaStore.instance.init(),
  ]);

  setupLocator();

  // Inicializar serviços de notificação
  await locator<NotificationService>().init();
  
  // Configurar Handlers de FCM
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  
  // Handler para foreground (caso o WebSocket falhe mas o Push chegue)
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    locator<FcmReceiverService>().handleMessage(message);
  });

  await locator<ApkUpdateNotifications>().init();
  locator<ApkUpdateRefreshListener>().schedulePeriodicChecks();

    runApp(
      MultiProvider(
        providers: [
          Provider<ISocketService>.value(value: locator<ISocketService>()),
          ChangeNotifierProvider.value(value: locator<AuthViewModel>()),
          ChangeNotifierProvider.value(value: locator<HomeViewModel>()),
          ChangeNotifierProvider.value(value: locator<ChatViewModel>()),
          ChangeNotifierProvider.value(value: locator<ContactsViewModel>()),
          ChangeNotifierProvider.value(value: locator<SettingsViewModel>()),
          ChangeNotifierProvider.value(value: locator<UpdateViewModel>()),
          Provider.value(value: locator<IChatRepository>()),
          Provider.value(value: locator<IRecipientRepository>()),
        ],
        child: const SigmaApp(),
      ),
    );
}

class SigmaApp extends StatelessWidget {
  const SigmaApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = locator<AuthViewModel>();
    final settingsViewModel = context.watch<SettingsViewModel>();

    return MaterialApp.router(
      title: 'Sigma',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: settingsViewModel.themeMode,
      locale: settingsViewModel.locale,
      routerConfig: createRouter(authViewModel),
    );
  }
}
