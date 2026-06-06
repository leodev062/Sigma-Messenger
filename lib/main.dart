import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';
import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_auth/sigma_auth.dart';
import 'package:sigma_chat/sigma_chat.dart';
import 'package:sigma_contacts/sigma_contacts.dart';
import 'package:sigma_settings/sigma_settings.dart';
import 'package:sigma/app/locator.dart';
import 'presentation/viewmodels/home_viewmodel.dart';
import 'package:go_router/go_router.dart';
import 'package:sigma/app/router.dart';
import 'package:sigma/presentation/widgets/connectivity_banner.dart';
import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setupLocator();
  await locator<FcmReceiverService>().handleMessage(message, isBackground: true);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  setupLocator();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  // 1. Inicializar SigmaStore (Account, Keys, Settings base)
  await locator<SigmaStore>().init();

  // 2. Carregar Settings (Tema, Idioma)
  final settingsViewModel = locator<SettingsViewModel>();
  await settingsViewModel.load();

  await locator<NotificationService>().init();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    locator<FcmReceiverService>().handleMessage(message);
  });

  await locator<ApkUpdateNotifications>().init();
  locator<ApkUpdateRefreshListener>().schedulePeriodicChecks();

  final router = createRouter(locator<AuthViewModel>());

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
      child: SigmaApp(router: router),
    ),
  );
}

class SigmaApp extends StatelessWidget {
  final GoRouter router;
  const SigmaApp({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsViewModel>(
      builder: (context, settingsViewModel, child) {
        return MaterialApp.router(
          title: 'Sigma',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          themeMode: settingsViewModel.themeMode,
          locale: settingsViewModel.locale,
          routerConfig: router,
          builder: (context, child) {
            return ConnectivityBanner(child: child ?? const SizedBox.shrink());
          },
        );
      },
    );
  }
}
