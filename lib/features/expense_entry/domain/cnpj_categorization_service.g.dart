// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cnpj_categorization_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(cnpjCategorizationService)
final cnpjCategorizationServiceProvider = CnpjCategorizationServiceProvider._();

final class CnpjCategorizationServiceProvider
    extends
        $FunctionalProvider<
          CnpjCategorizationService,
          CnpjCategorizationService,
          CnpjCategorizationService
        >
    with $Provider<CnpjCategorizationService> {
  CnpjCategorizationServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cnpjCategorizationServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cnpjCategorizationServiceHash();

  @$internal
  @override
  $ProviderElement<CnpjCategorizationService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CnpjCategorizationService create(Ref ref) {
    return cnpjCategorizationService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CnpjCategorizationService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CnpjCategorizationService>(value),
    );
  }
}

String _$cnpjCategorizationServiceHash() =>
    r'1cf0d43caad8ca1b5047a8f1ed6185a317a2df85';
