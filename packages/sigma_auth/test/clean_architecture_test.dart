import 'package:flutter_test/flutter_test.dart';
import 'package:sigma_auth/sigma_auth.dart';
import 'package:sigma_core/sigma_core.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  RegistrationRemoteDataSource,
  SigmaStore,
  KeysService,
  KeyStore,
])
import 'clean_architecture_test.mocks.dart';

void main() {
  late RegistrationRepositoryImpl repository;
  late MockRegistrationRemoteDataSource mockRemote;
  late MockSigmaStore mockStore;
  late MockKeysService mockKeysService;
  late MockKeyStore mockKeyStore;

  setUp(() {
    mockRemote = MockRegistrationRemoteDataSource();
    mockStore = MockSigmaStore();
    mockKeysService = MockKeysService();
    mockKeyStore = MockKeyStore();

    when(mockStore.keys).thenReturn(mockKeyStore);

    repository = RegistrationRepositoryImpl(
      remoteDataSource: mockRemote,
      store: mockStore,
      keysService: mockKeysService,
    );
  });

  test('RegistrationRepositoryImpl should be an instance of IRegistrationRepository', () {
    expect(repository, isA<IRegistrationRepository>());
  });
}
