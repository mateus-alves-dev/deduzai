enum AppFlavor { dev, staging, prod }

class FlavorConfig {
  const FlavorConfig._({
    required this.apiBaseUrl,
    required this.enableLogging,
    required this.useMockOcr,
  });

  factory FlavorConfig.fromFlavor(AppFlavor flavor) => switch (flavor) {
        AppFlavor.dev => const FlavorConfig._(
          apiBaseUrl: 'http://localhost:8080/api/v1',
          enableLogging: true,
          useMockOcr: true,
        ),
        AppFlavor.staging => const FlavorConfig._(
          apiBaseUrl: 'https://staging-api.deduzai.com.br/v1',
          enableLogging: true,
          useMockOcr: false,
        ),
        AppFlavor.prod => const FlavorConfig._(
          apiBaseUrl: 'https://api.deduzai.com.br/v1',
          enableLogging: false,
          useMockOcr: false,
        ),
      };

  final String apiBaseUrl;
  final bool enableLogging;
  final bool useMockOcr;
}
