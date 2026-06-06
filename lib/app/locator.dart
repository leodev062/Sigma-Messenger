import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_database/sigma_database.dart';
import 'package:sigma_auth/sigma_auth.dart';
import 'package:sigma_chat/sigma_chat.dart';
import 'package:sigma_chat/src/data/services/content/location_content_processor.dart';
import 'package:sigma_chat/src/data/services/content/poll_content_processor.dart';
import 'package:sigma_chat/src/domain/interactors/send_poll_interactor.dart';
import 'package:sigma_chat/src/data/jobs/chat/push_text_send_job.dart';
import 'package:sigma_chat/src/data/jobs/chat/push_location_send_job.dart';
import 'package:sigma_chat/src/data/jobs/chat/push_poll_send_job.dart';
import 'package:sigma_chat/src/data/jobs/chat/receipt_send_job.dart';
import 'package:sigma_chat/src/data/jobs/chat/typing_indicator_job.dart';
import 'package:sigma_profile/sigma_profile.dart';
import 'package:sigma_contacts/sigma_contacts.dart';
import 'package:sigma_settings/sigma_settings.dart';
import 'package:sigma_ui/sigma_ui.dart';
import '../presentation/viewmodels/home_viewmodel.dart';

void setupLocator() {
  if (locator.isRegistered<SigmaDatabase>()) return;

  _initCoreModule();
  _initRegistrationModule();
  _initAuthModule();
  _initChatModule();
  _initUpdaterModule();
}

void _initRegistrationModule() {
  locator.registerLazySingleton<IRegistrationRepository>(() => RegistrationRepositoryImpl(
    remoteDataSource: locator<RegistrationRemoteDataSource>(),
    store: locator<SigmaStore>(),
    keysService: locator<KeysService>(),
  ));
}

void _initCoreModule() {
  locator.registerLazySingleton(() => AppConfig.fromEnvironment());
  
  // 1. Infrastructure & Database (Dependencies of almost everything)
  const secureStorage = FlutterSecureStorage();
  locator.registerLazySingleton(() => AccountStore(secureStorage));
  locator.registerLazySingleton(() => KeyStore(secureStorage));
  
  final database = SigmaDatabase(locator<KeyStore>());
  locator.registerSingleton(database);
  
  locator.registerSingleton<RecipientDatabase>(RecipientDatabase(database));
  locator.registerSingleton<ThreadTable>(ThreadTable(database));
  locator.registerSingleton<MessageTable>(MessageTable(database));
  locator.registerSingleton<JobDatabase>(JobDatabase(database));
  locator.registerSingleton<KeyValueDatabase>(KeyValueDatabase(database));
  locator.registerSingleton<AttachmentTable>(AttachmentTable(database));
  locator.registerSingleton<PollTable>(PollTable(database));

  // 2. Storage & Network Access
  locator.registerLazySingleton(() => SettingsStore(locator<KeyValueDatabase>()));
  
  locator.registerLazySingleton(() => SigmaStore(
    account: locator<AccountStore>(),
    keys: locator<KeyStore>(),
    settings: locator<SettingsStore>(),
  ));

  locator.registerLazySingleton(() => FeedbackService());
  locator.registerLazySingleton(() => SigmaDialogService());
  locator.registerLazySingleton<IConnectivityService>(() => ConnectivityServiceImpl());
  
  locator.registerLazySingleton(() => SigmaNetworkAccess(locator<AppConfig>(), locator<SigmaStore>(), locator<IConnectivityService>()));
  
  locator.registerLazySingleton(() => SigmaHttpClient(locator<SigmaNetworkAccess>()));
  
  locator.registerLazySingleton<ISocketService>(() => SignalServiceMessageReceiver(
    locator<AppConfig>(),
    locator<IConnectivityService>(),
    locator<SigmaStore>(),
  ));
  
  locator.registerLazySingleton(() => KeysService(locator<KeyStore>()));

  // 3. Services (Depend on HttpClient)
  locator.registerLazySingleton(() => RegistrationService(locator<SigmaHttpClient>().dio));
  locator.registerLazySingleton(() => AccountService(locator<SigmaHttpClient>().dio));
  locator.registerLazySingleton(() => ProfileService(locator<SigmaHttpClient>().dio));
  locator.registerLazySingleton(() => KeysApiService(locator<SigmaHttpClient>().dio));

  // DataSources
  locator.registerLazySingleton<RegistrationRemoteDataSource>(() => RegistrationRemoteDataSourceImpl(locator<RegistrationService>()));
  locator.registerLazySingleton<AccountRemoteDataSource>(() => AccountRemoteDataSourceImpl(locator<AccountService>()));
  locator.registerLazySingleton<ProfileRemoteDataSource>(() => ProfileRemoteDataSourceImpl(locator<ProfileService>()));
  locator.registerLazySingleton<KeysRemoteDataSource>(() => KeysRemoteDataSourceImpl(locator<KeysApiService>()));
  
  locator.registerLazySingleton(() => SignalServiceAccountManager(
    registrationRemoteDataSource: locator<RegistrationRemoteDataSource>(),
    accountRemoteDataSource: locator<AccountRemoteDataSource>(),
    profileRemoteDataSource: locator<ProfileRemoteDataSource>(),
  ));

  locator.registerLazySingleton(() => AttachmentManager(locator<SigmaNetworkAccess>()));
  
  locator.registerLazySingleton(() => NotificationService());
  locator.registerLazySingleton(() => MediaCryptoService());
  locator.registerLazySingleton(() => LocationService());
  locator.registerLazySingleton(() => MediaPreviewService());

  final jobManager = SigmaJobManager(locator<JobDatabase>(), locator<ISocketService>(), locator);
  jobManager.registerFactory(PushTextSendJob.KEY, PushTextSendJob.create);
  jobManager.registerFactory(PushLocationSendJob.KEY, PushLocationSendJob.create);
  jobManager.registerFactory(PushPollSendJob.KEY, PushPollSendJob.create);
  jobManager.registerFactory(PushMediaSendJob.KEY, PushMediaSendJob.create);
  jobManager.registerFactory(PushReceiveJob.KEY, PushReceiveJob.create);
  jobManager.registerFactory(FetchProfileJob.KEY, FetchProfileJob.create);
  jobManager.registerFactory(PushKeysUploadJob.KEY, PushKeysUploadJob.create);
  jobManager.registerFactory(UpdateProfileJob.KEY, UpdateProfileJob.create);
  jobManager.registerFactory(ReactionSendJob.KEY, ReactionSendJob.create);
  jobManager.registerFactory(SyncContactsJob.KEY, SyncContactsJob.create);
  jobManager.registerFactory(ReceiptSendJob.KEY, ReceiptSendJob.create);
  jobManager.registerFactory(TypingIndicatorJob.KEY, TypingIndicatorJob.create);
  locator.registerSingleton(jobManager);

  locator.registerLazySingleton(() => DriftSignalProtocolStore(locator<SigmaDatabase>(), locator<KeyStore>()));
  
  locator.registerLazySingleton(() => CryptoManager(
    locator<KeysRemoteDataSource>(),
    locator<DriftSignalProtocolStore>(),
  ));
}

void _initAuthModule() {
  locator.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(locator<ProfileRemoteDataSource>()));
  locator.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSourceImpl(locator<SigmaStore>()));

  locator.registerLazySingleton<IAuthRepository>(() => AuthRepositoryImpl(
    remoteDataSource: locator<AuthRemoteDataSource>(),
    localDataSource: locator<AuthLocalDataSource>(),
    accountRemoteDataSource: locator<AccountRemoteDataSource>(),
  ));

  locator.registerLazySingleton<IProfileRepository>(() => ProfileRepositoryImpl(
    locator<ProfileRemoteDataSource>(),
    locator<RecipientDatabase>(),
    locator<SigmaStore>(),
    locator<SigmaJobManager>(),
  ));

  // Interactors
  locator.registerLazySingleton(() => UpdateProfileInteractor(locator<IProfileRepository>()));
  locator.registerLazySingleton(() => LoginInteractor(locator<ISocketService>(), locator<SigmaJobManager>()));
  locator.registerLazySingleton(() => LogoutInteractor(
    locator<IAuthRepository>(),
    locator<SigmaStore>(),
    locator<SigmaDatabase>(),
    locator<ISocketService>(),
  ));
  locator.registerLazySingleton(() => CreateAccountInteractor(locator<IRegistrationRepository>(), locator<UpdateProfileInteractor>(), locator<SigmaStore>()));
  locator.registerLazySingleton(() => VerifyCodeInteractor(locator<IRegistrationRepository>(), locator<IProfileRepository>(), locator<SigmaStore>()));
  locator.registerLazySingleton(() => RequestVerificationInteractor(locator<IRegistrationRepository>()));

  locator.registerLazySingleton(() => AuthViewModel(
    updateProfileInteractor: locator<UpdateProfileInteractor>(),
    loginInteractor: locator<LoginInteractor>(),
    logoutInteractor: locator<LogoutInteractor>(),
    createAccountInteractor: locator<CreateAccountInteractor>(),
    authRepository: locator<IAuthRepository>(),
    profileRepository: locator<IProfileRepository>(),
    keysService: locator<KeysService>(),
  ));

  locator.registerLazySingleton(() => VerificationCodeViewModel(
    repository: locator<IRegistrationRepository>(),
    verifyCodeInteractor: locator<VerifyCodeInteractor>(),
    authViewModel: locator<AuthViewModel>(),
    sessionId: '', // Placeholder, will be replaced by factory if needed
    initialE164: '',
    onNavigateToPhoneNumber: () {},
    onVerificationSuccess: () {},
  ));
  
  locator.registerLazySingleton(() => PhoneNumberEntryViewModel(
    requestVerificationInteractor: locator<RequestVerificationInteractor>(),
    onNavigateToCountryPicker: () {},
    onNavigateToVerification: (e, s) {},
  ));
}

void _initChatModule() {
  locator.registerLazySingleton<SignalServiceMessageSender>(() => SignalServiceMessageSenderImpl(locator<ISocketService>()));

  locator.registerLazySingleton<RecipientRemoteDataSource>(() => RecipientRemoteDataSourceImpl(locator<ProfileRemoteDataSource>()));
  locator.registerLazySingleton<IRecipientRepository>(() => RecipientRepositoryImpl(
    locator<RecipientDatabase>(),
    locator<RecipientRemoteDataSource>(),
  ));
  locator.registerLazySingleton<IChatRepository>(() => ChatRepositoryImpl(
    locator<MessageTable>(),
    locator<RecipientDatabase>(),
    locator<ThreadTable>(),
    locator<AttachmentTable>(),
    locator<PollTable>(),
    locator<SigmaJobManager>(),
  ));

  locator.registerLazySingleton(() => DataMessageHandler(
    locator<CryptoManager>(),
    [
      TextContentProcessor(locator<IChatRepository>()),
      MediaContentProcessor(locator<IChatRepository>()),
      LocationContentProcessor(locator<IChatRepository>()),
      PollContentProcessor(locator<IChatRepository>()),
      PollVoteContentProcessor(locator<IChatRepository>()),
    ],
  ));
  locator.registerLazySingleton(() => ReceiptMessageHandler(locator<IChatRepository>(), locator<CryptoManager>()));

  locator.registerLazySingleton<PushMessageProcessor>(() => PushMessageProcessorImpl(
    locator<SignalServiceMessageSender>(),
    locator<DataMessageHandler>(),
    locator<ReceiptMessageHandler>(),
  ));
  
  locator.registerLazySingleton(() => FcmReceiverService(
    cryptoManager: locator<CryptoManager>(),
    chatRepository: locator<IChatRepository>(),
    notificationService: locator<NotificationService>(),
  ));

  locator.registerLazySingleton(() => WatchChatsInteractor(locator<IChatRepository>()));
  locator.registerLazySingleton(() => WatchMessagesInteractor(locator<IChatRepository>()));
  locator.registerLazySingleton(() => SearchUsersInteractor(locator<IRecipientRepository>()));
  locator.registerLazySingleton(() => SendMessageInteractor(
    locator<IChatRepository>(),
    locator<SigmaJobManager>(),
  ));
  
  locator.registerLazySingleton(() => SendMediaInteractor(
    locator<IChatRepository>(),
  ));
  locator.registerLazySingleton(() => SendFileInteractor(
    locator<IChatRepository>(),
  ));
  locator.registerLazySingleton(() => SendLocationInteractor(
    locator<IChatRepository>(),
    locator<SigmaJobManager>(),
  ));
  locator.registerLazySingleton(() => SendPollInteractor(
    locator<IChatRepository>(),
  ));

  locator.registerLazySingleton(() => DeleteMessageInteractor(locator<IChatRepository>()));
  locator.registerLazySingleton(() => DeleteThreadInteractor(locator<IChatRepository>()));
  locator.registerLazySingleton(() => AddReactionInteractor(locator<IChatRepository>()));
  locator.registerLazySingleton(() => GetMessageDetailsInteractor(locator<IChatRepository>()));
  locator.registerLazySingleton(() => ForwardMessageInteractor(locator<SendMessageInteractor>(), locator<IChatRepository>()));
  
  locator.registerLazySingleton(() => ArchiveThreadInteractor(locator<IChatRepository>()));
  locator.registerLazySingleton(() => PinThreadInteractor(locator<IChatRepository>()));
  locator.registerLazySingleton(() => MarkAsReadInteractor(locator<IChatRepository>()));

  locator.registerLazySingleton(() => HomeViewModel(locator<ISocketService>(), locator<SigmaStore>()));
  locator.registerLazySingleton(() => ChatViewModel(
    locator<WatchChatsInteractor>(),
    locator<WatchMessagesInteractor>(),
    locator<SendMessageInteractor>(),
    locator<SendFileInteractor>(),
    locator<SendLocationInteractor>(),
    locator<SendPollInteractor>(),
    locator<SearchUsersInteractor>(),
    locator<DeleteMessageInteractor>(),
    locator<DeleteThreadInteractor>(),
    locator<AddReactionInteractor>(),
    locator<ForwardMessageInteractor>(),
    locator<GetMessageDetailsInteractor>(),
    locator<ArchiveThreadInteractor>(),
    locator<PinThreadInteractor>(),
    locator<MarkAsReadInteractor>(),
    locator<IChatRepository>(),
    locator<IRecipientRepository>(),
    locator<IAuthRepository>(),
    locator<LocationService>(),
    locator<MediaPreviewService>(),
  ));
  locator.registerLazySingleton(() => ContactsViewModel(locator<IRecipientRepository>()));
  locator.registerLazySingleton(() => SettingsViewModel(locator<SigmaStore>()));
  locator.registerLazySingleton(() => DevicesViewModel(locator<IAuthRepository>()));
}

void _initUpdaterModule() {
  locator.registerLazySingleton(() => ApkUpdateNotifications());
  locator.registerLazySingleton(() => ApkUpdateRefreshListener());

  locator.registerLazySingleton(() => UpdateViewModel(
    ApkUpdateManager(locator<SigmaNetworkAccess>()),
  ));
}
