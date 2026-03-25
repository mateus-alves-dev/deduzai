// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_mode_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(themeMode)
final themeModeProvider = ThemeModeProvider._();

final class ThemeModeProvider
    extends
        $FunctionalProvider<
          AsyncValue<ThemeMode>,
          ThemeMode,
          FutureOr<ThemeMode>
        >
    with $FutureModifier<ThemeMode>, $FutureProvider<ThemeMode> {
  ThemeModeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'themeModeProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$themeModeHash();

  @$internal
  @override
  $FutureProviderElement<ThemeMode> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<ThemeMode> create(Ref ref) {
    return themeMode(ref);
  }
}

String _$themeModeHash() => r'0f9bd253c041aad120cc0a5d18b8a2ad89601a8d';
