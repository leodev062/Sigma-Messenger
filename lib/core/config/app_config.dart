class AppConfig {
  final String apiBaseUrl;
  final String webSocketUrl;

  AppConfig({
    required this.apiBaseUrl,
    required this.webSocketUrl,
  });

  /// Pins de certificado para segurança extra contra MITM, espelhando o Signal.
  List<String> get certificatePins => [
        'sha256/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=',
      ];

  /// Factory para carregar configurações do ambiente via --dart-define.
  /// No Signal, as configurações são centralizadas para facilitar a mudança entre 
  /// ambientes de desenvolvimento, staging e produção.
  factory AppConfig.fromEnvironment() {
    return AppConfig(
      apiBaseUrl: const String.fromEnvironment(
        'SIGMA_API_URL',
        defaultValue: 'http://192.99.236.216:3000/',
      ),
      webSocketUrl: const String.fromEnvironment(
        'SIGMA_WS_URL',
        defaultValue: 'ws://192.99.236.216:3000/ws',
      ),
    );
  }
}
