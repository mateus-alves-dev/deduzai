// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dependent_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(dependentService)
final dependentServiceProvider = DependentServiceProvider._();

final class DependentServiceProvider
    extends
        $FunctionalProvider<
          DependentService,
          DependentService,
          DependentService
        >
    with $Provider<DependentService> {
  DependentServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dependentServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dependentServiceHash();

  @$internal
  @override
  $ProviderElement<DependentService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DependentService create(Ref ref) {
    return dependentService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DependentService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DependentService>(value),
    );
  }
}

String _$dependentServiceHash() => r'7b9b5a6e1c8bdf021ea2ffe821247ebb6cb0c24c';
