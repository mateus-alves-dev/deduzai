// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cnpj_api_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Riverpod provider for [CnpjApiService].

@ProviderFor(cnpjApiService)
final cnpjApiServiceProvider = CnpjApiServiceProvider._();

/// Riverpod provider for [CnpjApiService].

final class CnpjApiServiceProvider
    extends $FunctionalProvider<CnpjApiService, CnpjApiService, CnpjApiService>
    with $Provider<CnpjApiService> {
  /// Riverpod provider for [CnpjApiService].
  CnpjApiServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cnpjApiServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cnpjApiServiceHash();

  @$internal
  @override
  $ProviderElement<CnpjApiService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CnpjApiService create(Ref ref) {
    return cnpjApiService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CnpjApiService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CnpjApiService>(value),
    );
  }
}

String _$cnpjApiServiceHash() => r'1bf23f842ab2191289b4a9d6c2799123bbdbd9cd';
