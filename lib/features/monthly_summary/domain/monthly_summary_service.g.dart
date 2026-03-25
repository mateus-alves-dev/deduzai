// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monthly_summary_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(monthlySummaryService)
final monthlySummaryServiceProvider = MonthlySummaryServiceProvider._();

final class MonthlySummaryServiceProvider
    extends
        $FunctionalProvider<
          MonthlySummaryService,
          MonthlySummaryService,
          MonthlySummaryService
        >
    with $Provider<MonthlySummaryService> {
  MonthlySummaryServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'monthlySummaryServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$monthlySummaryServiceHash();

  @$internal
  @override
  $ProviderElement<MonthlySummaryService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MonthlySummaryService create(Ref ref) {
    return monthlySummaryService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MonthlySummaryService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MonthlySummaryService>(value),
    );
  }
}

String _$monthlySummaryServiceHash() =>
    r'a7f79daa4be0b675155168c55dc7489e78dd1c6f';
