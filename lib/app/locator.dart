import 'package:get_it/get_it.dart';
import 'package:sigma/core/storage/database.dart';
import 'package:sigma/core/network/api_service.dart';
import 'package:sigma/core/network/dio_client.dart';
import 'package:sigma/core/network/socket_manager.dart';
import 'package:sigma/core/crypto/crypto_manager.dart';
import 'package:sigma/core/jobs/job_manager.dart';
import 'package:sigma/core/notifications/notification_service.dart';

// Domain
import 'package:sigma/domain/repositories/i_auth_repository.dart';
import 'package:sigma/domain/repositories/i_chat_repository.dart';
import 'package:sigma/domain/repositories/i_recipient_repository.dart';
import 'package:sigma/domain/interactors/auth/request_code_interactor.dart';
import 'package:sigma/domain/interactors/auth/verify_code_interactor.dart';
import 'package:sigma/domain/interactors/chat/send_message_interactor.dart';
import 'package:sigma/domain/interactors/chat/watch_chats_interactor.dart';
import 'package:sigma/domain/interactors/chat/watch_messages_interactor.dart';

// Data
import 'package:sigma/data/repositories/auth_repository_impl.dart';
import 'package:sigma/data/repositories/chat_repository_impl.dart';
import 'package:sigma/data/repositories/recipient_repository_impl.dart';
import 'package:sigma/data/datasources/auth_local_data_source.dart';
import 'package:sigma/data/datasources/auth_remote_data_source.dart';
import 'package:sigma/data/datasources/chat/chat_local_data_source.dart';
import 'package:sigma/data/datasources/chat/chat_remote_data_source.dart';
import 'package:sigma/data/datasources/chat/recipient_local_data_source.dart';
import 'package:sigma/data/datasources/crypto/drift_signal_protocol_store.dart';

// Services
import 'package:sigma/data/services/incoming_message_processor.dart';
import 'package:sigma/data/services/message_sender_service.dart';
import 'package:sigma/data/services/fcm_receiver_service.dart';

// Presentation
import 'package:sigma/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:sigma/features/chat/presentation/viewmodels/chat_viewmodel.dart';
import 'package:sigma/features/updater/update_viewmodel.dart';

// Core Util
import 'package:sigma/core/updater/apk_update_manager.dart';
import 'package:sigma/core/updater/apk_update_notifications.dart';
import 'package:sigma/core/updater/apk_update_refresh_listener.dart';
import 'package:sigma/core/updater/apk_update_download_manager_receiver.dart';

final locator = GetIt.instance;

void setupLocator() {
  // Garantir idempotência da inicialização (importante para background isolates)
  if (locator.isRegistered<AppDatabase>()) return;

  _initCoreModule();
  _initAuthModule();
  _initChatModule();
  _initUpdaterModule();
}

void _initCoreModule() {
  locator.registerLazySingleton(() => SocketManager());
  locator.registerLazySingleton(() => AppDatabase());
  locator.registerLazySingleton(() => ApiService(DioClient.getDio()));
  
  // Notificações Nativas
  locator.registerLazySingleton(() => NotificationService());

  // JobManager para processamento confiável em background
  locator.registerLazySingleton(() => JobManager(locator<SocketManager>()));

  // DataSources de Criptografia
  locator.registerLazySingleton(() => DriftSignalProtocolStore(locator<AppDatabase>()));
  
  locator.registerLazySingleton(() => CryptoManager(
    locator<ApiService>(),
    locator<DriftSignalProtocolStore>(),
  ));
}

void _initAuthModule() {
  locator.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl());
  locator.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSourceImpl());

  locator.registerLazySingleton<IAuthRepository>(() => AuthRepositoryImpl(
    remoteDataSource: locator<AuthRemoteDataSource>(),
    localDataSource: locator<AuthLocalDataSource>(),
  ));

  locator.registerLazySingleton(() => RequestCodeInteractor(locator<IAuthRepository>()));
  locator.registerLazySingleton(() => VerifyCodeInteractor(locator<IAuthRepository>()));

  locator.registerLazySingleton(() => AuthViewModel(
    locator<RequestCodeInteractor>(),
    locator<VerifyCodeInteractor>(),
    locator<IAuthRepository>(),
    locator<SocketManager>(),
  ));
}

void _initChatModule() {
  // DataSources
  locator.registerLazySingleton<ChatLocalDataSource>(() => ChatLocalDataSourceImpl(locator<AppDatabase>()));
  locator.registerLazySingleton<ChatRemoteDataSource>(() => ChatRemoteDataSourceImpl(locator<SocketManager>()));
  locator.registerLazySingleton<RecipientLocalDataSource>(() => RecipientLocalDataSourceImpl(locator<AppDatabase>()));

  // Repository
  locator.registerLazySingleton<IRecipientRepository>(() => RecipientRepositoryImpl(locator<RecipientLocalDataSource>()));
  locator.registerLazySingleton<IChatRepository>(() => ChatRepositoryImpl(locator<ChatLocalDataSource>()));

  // Services
  locator.registerLazySingleton(() => IncomingMessageProcessor(
    locator<ChatRemoteDataSource>(),
    locator<IChatRepository>(),
    locator<CryptoManager>(),
  ));
  
  locator.registerLazySingleton(() => MessageSenderService(
    locator<IChatRepository>(),
    locator<JobManager>(),
  ));

  locator.registerLazySingleton(() => FcmReceiverService());

  // Interactors
  locator.registerLazySingleton(() => WatchChatsInteractor(locator<IChatRepository>()));
  locator.registerLazySingleton(() => WatchMessagesInteractor(locator<IChatRepository>()));
  locator.registerLazySingleton(() => SendMessageInteractor(locator<MessageSenderService>()));

  // ViewModel
  locator.registerLazySingleton(() => ChatViewModel(
    locator<WatchChatsInteractor>(),
    locator<WatchMessagesInteractor>(),
    locator<SendMessageInteractor>(),
  ));
}

void _initUpdaterModule() {
  locator.registerLazySingleton(() => ApkUpdateNotifications());
  locator.registerLazySingleton(() => ApkUpdateRefreshListener());
  locator.registerLazySingleton(() => ApkUpdateDownloadManagerReceiver(
    DioClient.getDio(),
    locator<ApkUpdateNotifications>(),
  ));

  locator.registerLazySingleton(() => UpdateViewModel(
    ApkUpdateManager(DioClient.getDio()),
  ));
}
