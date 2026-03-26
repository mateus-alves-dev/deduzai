// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(database)
final databaseProvider = DatabaseProvider._();

final class DatabaseProvider
    extends $FunctionalProvider<AppDatabase, AppDatabase, AppDatabase>
    with $Provider<AppDatabase> {
  DatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'databaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$databaseHash();

  @$internal
  @override
  $ProviderElement<AppDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppDatabase create(Ref ref) {
    return database(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppDatabase>(value),
    );
  }
}

String _$databaseHash() => r'd6e05638b723b0524e474cecb5226cbaac2e507a';

@ProviderFor(expenseDao)
final expenseDaoProvider = ExpenseDaoProvider._();

final class ExpenseDaoProvider
    extends $FunctionalProvider<ExpenseDao, ExpenseDao, ExpenseDao>
    with $Provider<ExpenseDao> {
  ExpenseDaoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'expenseDaoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$expenseDaoHash();

  @$internal
  @override
  $ProviderElement<ExpenseDao> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ExpenseDao create(Ref ref) {
    return expenseDao(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ExpenseDao value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExpenseDao>(value),
    );
  }
}

String _$expenseDaoHash() => r'3608ecba0df1903e7b5da617a71c40afb2db9659';

@ProviderFor(receiptDao)
final receiptDaoProvider = ReceiptDaoProvider._();

final class ReceiptDaoProvider
    extends $FunctionalProvider<ReceiptDao, ReceiptDao, ReceiptDao>
    with $Provider<ReceiptDao> {
  ReceiptDaoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'receiptDaoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$receiptDaoHash();

  @$internal
  @override
  $ProviderElement<ReceiptDao> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ReceiptDao create(Ref ref) {
    return receiptDao(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReceiptDao value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReceiptDao>(value),
    );
  }
}

String _$receiptDaoHash() => r'8d461c97b3f37c74b9d046a340eacaacd71d476a';

@ProviderFor(cnpjPreferenceDao)
final cnpjPreferenceDaoProvider = CnpjPreferenceDaoProvider._();

final class CnpjPreferenceDaoProvider
    extends
        $FunctionalProvider<
          CnpjPreferenceDao,
          CnpjPreferenceDao,
          CnpjPreferenceDao
        >
    with $Provider<CnpjPreferenceDao> {
  CnpjPreferenceDaoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cnpjPreferenceDaoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cnpjPreferenceDaoHash();

  @$internal
  @override
  $ProviderElement<CnpjPreferenceDao> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CnpjPreferenceDao create(Ref ref) {
    return cnpjPreferenceDao(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CnpjPreferenceDao value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CnpjPreferenceDao>(value),
    );
  }
}

String _$cnpjPreferenceDaoHash() => r'a13e517ac2fc0a140be4aa8ffd3b28133fdf9a4c';

@ProviderFor(appSettingsDao)
final appSettingsDaoProvider = AppSettingsDaoProvider._();

final class AppSettingsDaoProvider
    extends $FunctionalProvider<AppSettingsDao, AppSettingsDao, AppSettingsDao>
    with $Provider<AppSettingsDao> {
  AppSettingsDaoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appSettingsDaoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appSettingsDaoHash();

  @$internal
  @override
  $ProviderElement<AppSettingsDao> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppSettingsDao create(Ref ref) {
    return appSettingsDao(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppSettingsDao value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppSettingsDao>(value),
    );
  }
}

String _$appSettingsDaoHash() => r'744fed9d19bd0a178b347f584ca3fdaca6275d63';

@ProviderFor(recurringExpenseDao)
final recurringExpenseDaoProvider = RecurringExpenseDaoProvider._();

final class RecurringExpenseDaoProvider
    extends
        $FunctionalProvider<
          RecurringExpenseDao,
          RecurringExpenseDao,
          RecurringExpenseDao
        >
    with $Provider<RecurringExpenseDao> {
  RecurringExpenseDaoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recurringExpenseDaoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recurringExpenseDaoHash();

  @$internal
  @override
  $ProviderElement<RecurringExpenseDao> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RecurringExpenseDao create(Ref ref) {
    return recurringExpenseDao(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RecurringExpenseDao value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RecurringExpenseDao>(value),
    );
  }
}

String _$recurringExpenseDaoHash() =>
    r'4e5030a5ecf4de9ad992764dc0b5563ab7a8530d';

@ProviderFor(filterFavoriteDao)
final filterFavoriteDaoProvider = FilterFavoriteDaoProvider._();

final class FilterFavoriteDaoProvider
    extends
        $FunctionalProvider<
          FilterFavoriteDao,
          FilterFavoriteDao,
          FilterFavoriteDao
        >
    with $Provider<FilterFavoriteDao> {
  FilterFavoriteDaoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'filterFavoriteDaoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$filterFavoriteDaoHash();

  @$internal
  @override
  $ProviderElement<FilterFavoriteDao> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FilterFavoriteDao create(Ref ref) {
    return filterFavoriteDao(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FilterFavoriteDao value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FilterFavoriteDao>(value),
    );
  }
}

String _$filterFavoriteDaoHash() => r'29170105e013df02b2dd314e95369df1378483be';

@ProviderFor(dependentsDao)
final dependentsDaoProvider = DependentsDaoProvider._();

final class DependentsDaoProvider
    extends $FunctionalProvider<DependentsDao, DependentsDao, DependentsDao>
    with $Provider<DependentsDao> {
  DependentsDaoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dependentsDaoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dependentsDaoHash();

  @$internal
  @override
  $ProviderElement<DependentsDao> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DependentsDao create(Ref ref) {
    return dependentsDao(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DependentsDao value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DependentsDao>(value),
    );
  }
}

String _$dependentsDaoHash() => r'691484d2e87062d038aabedb0ece74a8ac2dea87';
