// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'annual_summary_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(annualSummaryService)
final annualSummaryServiceProvider = AnnualSummaryServiceProvider._();

final class AnnualSummaryServiceProvider
    extends
        $FunctionalProvider<
          AnnualSummaryService,
          AnnualSummaryService,
          AnnualSummaryService
        >
    with $Provider<AnnualSummaryService> {
  AnnualSummaryServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'annualSummaryServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$annualSummaryServiceHash();

  @$internal
  @override
  $ProviderElement<AnnualSummaryService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AnnualSummaryService create(Ref ref) {
    return annualSummaryService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AnnualSummaryService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AnnualSummaryService>(value),
    );
  }
}

String _$annualSummaryServiceHash() =>
    r'a5e18566e71df191119b6d4647efac8ce6ba97c3';
