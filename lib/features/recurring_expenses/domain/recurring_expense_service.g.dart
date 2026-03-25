// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recurring_expense_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(recurringExpenseService)
final recurringExpenseServiceProvider = RecurringExpenseServiceProvider._();

final class RecurringExpenseServiceProvider
    extends
        $FunctionalProvider<
          RecurringExpenseService,
          RecurringExpenseService,
          RecurringExpenseService
        >
    with $Provider<RecurringExpenseService> {
  RecurringExpenseServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recurringExpenseServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recurringExpenseServiceHash();

  @$internal
  @override
  $ProviderElement<RecurringExpenseService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RecurringExpenseService create(Ref ref) {
    return recurringExpenseService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RecurringExpenseService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RecurringExpenseService>(value),
    );
  }
}

String _$recurringExpenseServiceHash() =>
    r'a6fc0848abaa71a4c82493450d323f8b3343fb00';
