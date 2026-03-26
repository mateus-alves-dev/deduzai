// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refund_simulation_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(refundSimulationService)
final refundSimulationServiceProvider = RefundSimulationServiceProvider._();

final class RefundSimulationServiceProvider
    extends
        $FunctionalProvider<
          RefundSimulationService,
          RefundSimulationService,
          RefundSimulationService
        >
    with $Provider<RefundSimulationService> {
  RefundSimulationServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'refundSimulationServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$refundSimulationServiceHash();

  @$internal
  @override
  $ProviderElement<RefundSimulationService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RefundSimulationService create(Ref ref) {
    return refundSimulationService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RefundSimulationService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RefundSimulationService>(value),
    );
  }
}

String _$refundSimulationServiceHash() =>
    r'c5c57ed3ef04f3d1c6aa25267eb66896b0031e44';
