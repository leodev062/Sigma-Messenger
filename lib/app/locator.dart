import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_database/sigma_database.dart';
import 'package:sigma_auth/sigma_auth.dart';
import 'package:sigma_chat/sigma_chat.dart';
import 'package:sigma_profile/sigma_profile.dart';
import 'package:sigma_contacts/sigma_contacts.dart';
import 'package:sigma_settings/sigma_settings.dart';
import 'package:sigma_ui/sigma_ui.dart';

import 'package:sigma_chat/src/data/jobs/chat/push_text_send_job.dart';
import 'package:sigma_chat/src/data/jobs/chat/push_location_send_job.dart';
import 'package:sigma_chat/src/data/jobs/chat/push_poll_send_job.dart';
import 'package:sigma_chat/src/data/jobs/chat/push_media_send_job.dart';
import 'package:sigma_chat/src/data/jobs/chat/push_receive_job.dart';
import 'package:sigma_chat/src/data/jobs/chat/reaction_send_job.dart';
import 'package:sigma_chat/src/data/jobs/chat/receipt_send_job.dart';
import 'package:sigma_chat/src/data/jobs/chat/typing_indicator_job.dart';
import 'package:sigma_chat/src/data/services/content/location_content_processor.dart';
import 'package:sigma_chat/src/data/services/content/poll_content_processor.dart';
import 'package:sigma_chat/src/data/services/content/media_content_processor.dart';
import 'package:sigma_chat/src/data/services/content/text_content_processor.dart';
import 'package:sigma_chat/src/data/services/content/poll_vote_content_processor.dart';
import 'package:sigma_chat/src/domain/services/live_location_manager.dart';

import 'package:sigma_profile/src/data/jobs/profile/fetch_profile_job.dart';
import 'package:sigma_profile/src/data/jobs/profile/update_profile_job.dart';
import 'package:sigma_contacts/src/data/jobs/contacts/sync_contacts_job.dart';

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
  ));
}

void _initCoreModule() {
  locator.registerLazySingleton(() => AppConfig.fromEnvironment());
  
  const secureStorage = FlutterSecureStorage();
  locator.registerLazySingleton(() => AccountStore(secureStorage));
  locator.registerLazySingleton(() => KeyStore(secureStorage));
  
  final database = SigmaDatabase(locator<KeyStore>());
  locator.registerSingleton(database);
  
  locator.registerSingleton<UserDao>(database.userDao);
  locator.registerSingleton<ConversationDao>(database.conversationDao);
  locator.registerSingleton<MessageDao>(database.messageDao);
  locator.registerSingleton<PollDao>(database.pollDao);
  locator.registerSingleton<KeyValueDao>(database.keyValueDao);
  locator.registerSingleton<JobDao>(database.jobDao);

  locator.registerLazySingleton(() => SettingsStore(locator<KeyValueDao>()));
  
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

  locator.registerLazySingleton(() => RegistrationService(locator<SigmaHttpClient>().dio));
  locator.registerLazySingleton(() => AccountService(locator<SigmaHttpClient>().dio));
  locator.registerLazySingleton(() => ProfileService(locator<SigmaHttpClient>().dio));

  locator.registerLazySingleton<RegistrationRemoteDataSource>(() => RegistrationRemoteDataSourceImpl(locator<RegistrationService>()));
  locator.registerLazySingleton<AccountRemoteDataSource>(() => AccountRemoteDataSourceImpl(locator<AccountService>()));
  locator.registerLazySingleton<ProfileRemoteDataSource>(() => ProfileRemoteDataSourceImpl(locator<ProfileService>()));
  
  locator.registerLazySingleton(() => AccountManagementService(
    registrationRemoteDataSource: locator<RegistrationRemoteDataSource>(),
    accountRemoteDataSource: locator<AccountRemoteDataSource>(),
    profileRemoteDataSource: locator<ProfileRemoteDataSource>(),
  ));

  locator.registerLazySingleton(() => AttachmentManager(locator<SigmaNetworkAccess>()));
  
  locator.registerLazySingleton(() => NotificationService());
  locator.registerLazySingleton(() => LocationService());
  locator.registerLazySingleton(() => MediaPreviewService());
  locator.registerLazySingleton(() => LiveLocationManager(locator<IChatRepository>(), locator<SigmaJobManager>()));

  final jobManager = SigmaJobManager(locator<JobDao>(), locator<ISocketService>(), locator);
  jobManager.registerFactory(PushTextSendJob.KEY, PushTextSendJob.create);
  jobManager.registerFactory(PushLocationSendJob.KEY, PushLocationSendJob.create);
  jobManager.registerFactory(PushPollSendJob.KEY, PushPollSendJob.create);
  jobManager.registerFactory(PushMediaSendJob.KEY, PushMediaSendJob.create);
  jobManager.registerFactory(PushReceiveJob.KEY, PushReceiveJob.create);
  jobManager.registerFactory(FetchProfileJob.KEY, FetchProfileJob.create);
  jobManager.registerFactory(UpdateProfileJob.KEY, UpdateProfileJob.create);
  jobManager.registerFactory(ReactionSendJob.KEY, ReactionSendJob.create);
  jobManager.registerFactory(SyncContactsJob.KEY, SyncContactsJob.create);
  jobManager.registerFactory(ReceiptSendJob.KEY, ReceiptSendJob.create);
  jobManager.registerFactory(TypingIndicatorJob.KEY, TypingIndicatorJob.create);
  locator.registerSingleton(jobManager);
}

void _initAuthModule() {
  locator.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(locator<ProfileRemoteDataSource>()));
  locator.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSourceImpl(locator<SigmaStore>()));

  locator.registerLazySingleton<IAuthRepository>(() => AuthRepositoryImpl(
    remoteDataSource: locator<AuthRemoteDataSource>(),
    localDataSource: locator<AuthLocalDataSource>(),
    accountRemoteDataSource: locator<AccountRemoteDataSource>(),
    userDao: locator<UserDao>(),
  ));

  locator.registerLazySingleton<IProfileRepository>(() => ProfileRepositoryImpl(
    locator<ProfileRemoteDataSource>(),
    locator<UserDao>(),
    locator<SigmaStore>(),
    locator<SigmaJobManager>(),
  ));

  locator.registerLazySingleton(() => UpdateProfileInteractor(locator<IProfileRepository>()));
  locator.registerLazySingleton(() => LoginInteractor(locator<ISocketService>(), locator<SigmaJobManager>(), locator<IAuthRepository>()));
  locator.registerLazySingleton(() => LogoutInteractor(
    locator<IAuthRepository>(),
    locator<SigmaStore>(),
    locator<SigmaDatabase>(),
    locator<ISocketService>(),
  ));
  locator.registerLazySingleton(() => CreateAccountInteractor(locator<IRegistrationRepository>(), locator<UpdateProfileInteractor>(), locator<SigmaStore>()));
  locator.registerLazySingleton(() => VerifyCodeInteractor(locator<IRegistrationRepository>(), locator<SigmaStore>()));
  locator.registerLazySingleton(() => RequestVerificationInteractor(locator<IRegistrationRepository>()));

  locator.registerLazySingleton(() => AuthViewModel(
    updateProfileInteractor: locator<UpdateProfileInteractor>(),
    loginInteractor: locator<LoginInteractor>(),
    logoutInteractor: locator<LogoutInteractor>(),
    createAccountInteractor: locator<CreateAccountInteractor>(),
    authRepository: locator<IAuthRepository>(),
    profileRepository: locator<IProfileRepository>(),
  ));

  locator.registerLazySingleton(() => VerificationCodeViewModel(
    repository: locator<IRegistrationRepository>(),
    verifyCodeInteractor: locator<VerifyCodeInteractor>(),
    authViewModel: locator<AuthViewModel>(),
    sessionId: '', 
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
    locator<UserDao>(),
    locator<RecipientRemoteDataSource>(),
  ));

  locator.registerLazySingleton(() => ResolveProfileInteractor(
    locator<IRecipientRepository>(),
    locator<SigmaJobManager>(),
  ));

  locator.registerLazySingleton<IChatRepository>(() => ChatRepositoryImpl(
    locator<MessageDao>(),
    locator<UserDao>(),
    locator<ConversationDao>(),
    locator<PollDao>(),
    locator<SigmaJobManager>(),
    locator<SigmaStore>(),
    locator<ResolveProfileInteractor>(),
  ));

  locator.registerLazySingleton(() => DataMessageHandler(
    [
      TextContentProcessor(locator<IChatRepository>()),
      MediaContentProcessor(locator<IChatRepository>()),
      LocationContentProcessor(locator<IChatRepository>()),
      PollContentProcessor(locator<IChatRepository>()),
      PollVoteContentProcessor(locator<IChatRepository>()),
    ],
  ));
  locator.registerLazySingleton(() => ReceiptMessageHandler(locator<IChatRepository>()));

  locator.registerLazySingleton<PushMessageProcessor>(() => PushMessageProcessorImpl(
    locator<SignalServiceMessageSender>(),
    locator<DataMessageHandler>(),
  ));
  
  locator.registerLazySingleton(() => FcmReceiverService(
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
    locator<SigmaJobManager>(),
    locator<LocationService>(),
    locator<LiveLocationManager>(),
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
