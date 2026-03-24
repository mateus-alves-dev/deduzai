enum AppFlavor { dev, staging, prod }

class FlavorConfig {
  const FlavorConfig._({
    required this.enableLogging,
    required this.useMockOcr,
  });

  factory FlavorConfig.fromFlavor(AppFlavor flavor) => switch (flavor) {
        AppFlavor.dev => const FlavorConfig._(
          enableLogging: true,
          useMockOcr: true,
        ),
        AppFlavor.staging => const FlavorConfig._(
          enableLogging: true,
          useMockOcr: false,
        ),
        AppFlavor.prod => const FlavorConfig._(
          enableLogging: false,
          useMockOcr: false,
        ),
      };

  final bool enableLogging;
  final bool useMockOcr;
}
