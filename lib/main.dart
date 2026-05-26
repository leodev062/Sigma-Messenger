import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:sigma/core/storage/sigma_store.dart';
import 'package:sigma/app/locator.dart';
import 'package:sigma/app/router.dart';
import 'package:sigma/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:sigma/features/chat/presentation/viewmodels/chat_viewmodel.dart';
import 'package:sigma/features/updater/update_viewmodel.dart';
import 'package:sigma/core/network/socket_manager.dart';
import 'package:sigma/features/chat/domain/repositories/chat_repository.dart';
import 'package:sigma/features/chat/domain/repositories/recipient_repository.dart';
import 'package:sigma/core/updater/apk_update_notifications.dart';
import 'package:sigma/core/updater/apk_update_refresh_listener.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Future.wait([
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
    SigmaStore.instance.init(),
  ]);

  setupLocator();

  await locator<ApkUpdateNotifications>().init();
  locator<ApkUpdateRefreshListener>().schedulePeriodicChecks();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: locator<SocketManager>()),
        ChangeNotifierProvider.value(value: locator<AuthViewModel>()),
        ChangeNotifierProvider.value(value: locator<ChatViewModel>()),
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

    return MaterialApp.router(
      title: 'Sigma',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      routerConfig: createRouter(authViewModel),
    );
  }
}
