import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:sigma/core/config/app_config.dart';
import 'package:sigma/core/storage/database.dart';
import 'package:sigma/core/network/keys_manager.dart';
import 'package:sigma/core/network/search_manager.dart';
import 'package:sigma/core/network/account_manager.dart';
import 'package:sigma/core/network/profile_manager.dart';
import 'package:sigma/core/network/attachment_manager.dart';
import 'package:sigma/core/network/sigma_network_access.dart';
import 'package:sigma/core/network/socket_manager.dart';
import 'package:sigma/core/crypto/crypto_manager.dart';
import 'package:sigma/core/crypto/media_crypto_service.dart';
import 'package:sigma/core/jobs/job_manager.dart';
import 'package:sigma/core/notifications/notification_service.dart';

// Domain
import 'package:sigma/domain/repositories/i_auth_repository.dart';
import 'package:sigma/domain/repositories/i_chat_repository.dart';
import 'package:sigma/domain/repositories/i_recipient_repository.dart';
import 'package:sigma/domain/interactors/auth/request_code_interactor.dart';
import 'package:sigma/domain/interactors/auth/verify_code_interactor.dart';
import 'package:sigma/domain/interactors/auth/update_profile_interactor.dart';
import 'package:sigma/domain/interactors/chat/send_message_interactor.dart';
import 'package:sigma/domain/interactors/chat/send_media_interactor.dart';
import 'package:sigma/domain/interactors/chat/watch_chats_interactor.dart';
import 'package:sigma/domain/interactors/chat/watch_messages_interactor.dart';
import 'package:sigma/domain/interactors/chat/search_users_interactor.dart';

// Data
import 'package:sigma/data/repositories/auth_repository_impl.dart';
import 'package:sigma/data/repositories/chat_repository_impl.dart';
import 'package:sigma/data/repositories/recipient_repository_impl.dart';
import 'package:sigma/data/datasources/auth_local_data_source.dart';
import 'package:sigma/data/datasources/auth_remote_data_source.dart';
import 'package:sigma/data/datasources/chat/chat_local_data_source.dart';
import 'package:sigma/data/datasources/chat/chat_remote_data_source.dart';
import 'package:sigma/data/datasources/chat/recipient_local_data_source.dart';
import 'package:sigma/data/datasources/chat/recipient_remote_data_source.dart';
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
  // Configurações de Ambiente
  locator.registerLazySingleton(() => AppConfig.fromEnvironment());
  
  // Rede
  locator.registerLazySingleton(() => SigmaNetworkAccess(locator<AppConfig>()));
  locator.registerLazySingleton(() => SocketManager(locator<AppConfig>()));
  
  locator.registerLazySingleton(() => AppDatabase());
  locator.registerLazySingleton(() => AccountManager(locator<SigmaNetworkAccess>().getApiClient()));
  locator.registerLazySingleton(() => ProfileManager(locator<SigmaNetworkAccess>().getApiClient()));
  locator.registerLazySingleton(() => KeysManager(locator<SigmaNetworkAccess>().getApiClient()));
  locator.registerLazySingleton(() => SearchManager(locator<SigmaNetworkAccess>().getApiClient()));
  locator.registerLazySingleton(() => AttachmentManager(locator<SigmaNetworkAccess>()));
  
  // Notificações Nativas
  locator.registerLazySingleton(() => NotificationService());

  // JobManager para processamento confiável em background
  locator.registerLazySingleton(() => JobManager(locator<SocketManager>()));

  // DataSources de Criptografia
  locator.registerLazySingleton(() => DriftSignalProtocolStore(locator<AppDatabase>()));
  locator.registerLazySingleton(() => MediaCryptoService());
  
  locator.registerLazySingleton(() => CryptoManager(
    locator<KeysManager>(),
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
  locator.registerLazySingleton(() => VerifyCodeInteractor(
    locator<AccountManager>(),
    locator<ProfileManager>(),
    locator<AuthLocalDataSource>(),
  ));
  locator.registerLazySingleton(() => UpdateProfileInteractor(locator<IAuthRepository>()));

  locator.registerLazySingleton(() => AuthViewModel(
    locator<RequestCodeInteractor>(),
    locator<VerifyCodeInteractor>(),
    locator<UpdateProfileInteractor>(),
    locator<IAuthRepository>(),
    locator<SocketManager>(),
  ));
}

void _initChatModule() {
  // DataSources
  locator.registerLazySingleton<ChatLocalDataSource>(() => ChatLocalDataSourceImpl(locator<AppDatabase>()));
  locator.registerLazySingleton<ChatRemoteDataSource>(() => ChatRemoteDataSourceImpl(locator<SocketManager>()));
  locator.registerLazySingleton<RecipientLocalDataSource>(() => RecipientLocalDataSourceImpl(locator<AppDatabase>()));
  locator.registerLazySingleton<RecipientRemoteDataSource>(() => RecipientRemoteDataSourceImpl(locator<SearchManager>()));

  // Repository
  locator.registerLazySingleton<IRecipientRepository>(() => RecipientRepositoryImpl(
    locator<RecipientLocalDataSource>(),
    locator<RecipientRemoteDataSource>(),
  ));
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
  locator.registerLazySingleton(() => SearchUsersInteractor(locator<IRecipientRepository>()));
  locator.registerLazySingleton(() => SendMessageInteractor(locator<MessageSenderService>()));
  locator.registerLazySingleton(() => SendMediaInteractor(
    locator<MediaCryptoService>(),
    locator<AttachmentManager>(),
    locator<CryptoManager>(),
    locator<ChatRemoteDataSource>(),
    locator<IChatRepository>(),
  ));

  // ViewModel
  locator.registerLazySingleton(() => ChatViewModel(
    locator<WatchChatsInteractor>(),
    locator<WatchMessagesInteractor>(),
    locator<SendMessageInteractor>(),
    locator<SearchUsersInteractor>(),
    locator<IChatRepository>(),
    locator<IRecipientRepository>(),
  ));
}

void _initUpdaterModule() {
  locator.registerLazySingleton(() => ApkUpdateNotifications());
  locator.registerLazySingleton(() => ApkUpdateRefreshListener());
  locator.registerLazySingleton(() => ApkUpdateDownloadManagerReceiver(
    locator<SigmaNetworkAccess>().getMediaClient(),
    locator<ApkUpdateNotifications>(),
  ));

  locator.registerLazySingleton(() => UpdateViewModel(
    ApkUpdateManager(locator<SigmaNetworkAccess>()),
  ));
}
