import 'package:get_it/get_it.dart';
import 'package:sigma/core/storage/database.dart';
import 'package:sigma/core/network/api_service.dart';
import 'package:sigma/core/network/dio_client.dart';
import 'package:sigma/features/chat/domain/repositories/chat_repository.dart';
import 'package:sigma/features/chat/domain/repositories/recipient_repository.dart';
import 'package:sigma/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:sigma/features/chat/data/repositories/recipient_repository_impl.dart';
import 'package:sigma/core/network/socket_manager.dart';
import 'package:sigma/core/crypto/crypto_manager.dart';
import 'package:sigma/features/auth/domain/repositories/auth_repository.dart';
import 'package:sigma/features/auth/domain/usecases/request_code_usecase.dart';
import 'package:sigma/features/auth/domain/usecases/verify_code_usecase.dart';
import 'package:sigma/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:sigma/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:sigma/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:sigma/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:sigma/features/chat/presentation/viewmodels/chat_viewmodel.dart';
import 'package:sigma/features/updater/update_viewmodel.dart';
import 'package:sigma/core/updater/apk_update_manager.dart';
import 'package:sigma/core/updater/apk_update_notifications.dart';
import 'package:sigma/core/updater/apk_update_download_manager_receiver.dart';
import 'package:sigma/core/updater/apk_update_installer.dart';
import 'package:sigma/core/updater/apk_update_notification_receiver.dart';
import 'package:sigma/core/updater/apk_update_package_installer_receiver.dart';
import 'package:sigma/core/updater/apk_update_refresh_listener.dart';

final locator = GetIt.instance;

/// Motor de Injeção de Dependência Lazy (Inspirado no Dagger/Hilt do Signal)
void setupLocator() {
  // 1. Core Services & Database
  locator.registerLazySingleton(() => SocketManager());
  locator.registerLazySingleton(() => AppDatabase());
  
  // 2. Network API & Crypto
  locator.registerLazySingleton(() => ApiService(DioClient.getDio()));
  locator.registerLazySingleton(() => CryptoManager(locator<ApiService>()));
  
  // 3. Repositories
  locator.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl());
  locator.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSourceImpl());
  locator.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
    remoteDataSource: locator<AuthRemoteDataSource>(),
    localDataSource: locator<AuthLocalDataSource>(),
  ));

  locator.registerLazySingleton<IRecipientRepository>(() => RecipientRepositoryImpl(
    locator<AppDatabase>(), 
  ));
  
  locator.registerLazySingleton<IChatRepository>(() => ChatRepositoryImpl(
    locator<AppDatabase>(), 
    locator<SocketManager>(), 
    locator<CryptoManager>()
  ));
  
  // 4. Use Cases
  locator.registerLazySingleton(() => RequestCodeUseCase(locator<AuthRepository>()));
  locator.registerLazySingleton(() => VerifyCodeUseCase(locator<AuthRepository>()));

  // 5. ViewModels
  locator.registerLazySingleton(() => AuthViewModel(
    locator<RequestCodeUseCase>(),
    locator<VerifyCodeUseCase>(),
    locator<AuthRepository>(),
    locator<SocketManager>(), 
  ));
  
  locator.registerLazySingleton(() => ChatViewModel(
    locator<IChatRepository>()
  ));

  // APK Update System (Signal-Style Architecture)
  locator.registerLazySingleton(() => ApkUpdateNotifications());
  locator.registerLazySingleton(() => ApkUpdateInstaller());
  locator.registerLazySingleton(() => ApkUpdateNotificationReceiver(locator<ApkUpdateInstaller>()));
  locator.registerLazySingleton(() => ApkUpdateDownloadManagerReceiver(DioClient.getDio(), locator<ApkUpdateNotifications>()));
  locator.registerLazySingleton(() => ApkUpdatePackageInstallerReceiver());
  locator.registerLazySingleton(() => ApkUpdateRefreshListener());
  
  locator.registerLazySingleton(() => UpdateViewModel(
    ApkUpdateManager(DioClient.getDio()),
  ));
}
