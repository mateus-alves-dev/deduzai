// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'annual_summary_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$annualSummaryHash() => r'8197c598969dca5a5df606686a8930bfa3b6fb3c';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// Reactive stream of [AnnualSummary] for [year].
///
/// Recomputes whenever the underlying expenses change (Drift stream).
///
/// Copied from [annualSummary].
@ProviderFor(annualSummary)
const annualSummaryProvider = AnnualSummaryFamily();

/// Reactive stream of [AnnualSummary] for [year].
///
/// Recomputes whenever the underlying expenses change (Drift stream).
///
/// Copied from [annualSummary].
class AnnualSummaryFamily extends Family<AsyncValue<AnnualSummary>> {
  /// Reactive stream of [AnnualSummary] for [year].
  ///
  /// Recomputes whenever the underlying expenses change (Drift stream).
  ///
  /// Copied from [annualSummary].
  const AnnualSummaryFamily();

  /// Reactive stream of [AnnualSummary] for [year].
  ///
  /// Recomputes whenever the underlying expenses change (Drift stream).
  ///
  /// Copied from [annualSummary].
  AnnualSummaryProvider call(int year) {
    return AnnualSummaryProvider(year);
  }

  @override
  AnnualSummaryProvider getProviderOverride(
    covariant AnnualSummaryProvider provider,
  ) {
    return call(provider.year);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'annualSummaryProvider';
}

/// Reactive stream of [AnnualSummary] for [year].
///
/// Recomputes whenever the underlying expenses change (Drift stream).
///
/// Copied from [annualSummary].
class AnnualSummaryProvider extends AutoDisposeStreamProvider<AnnualSummary> {
  /// Reactive stream of [AnnualSummary] for [year].
  ///
  /// Recomputes whenever the underlying expenses change (Drift stream).
  ///
  /// Copied from [annualSummary].
  AnnualSummaryProvider(int year)
    : this._internal(
        (ref) => annualSummary(ref as AnnualSummaryRef, year),
        from: annualSummaryProvider,
        name: r'annualSummaryProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$annualSummaryHash,
        dependencies: AnnualSummaryFamily._dependencies,
        allTransitiveDependencies:
            AnnualSummaryFamily._allTransitiveDependencies,
        year: year,
      );

  AnnualSummaryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.year,
  }) : super.internal();

  final int year;

  @override
  Override overrideWith(
    Stream<AnnualSummary> Function(AnnualSummaryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AnnualSummaryProvider._internal(
        (ref) => create(ref as AnnualSummaryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        year: year,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<AnnualSummary> createElement() {
    return _AnnualSummaryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AnnualSummaryProvider && other.year == year;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, year.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AnnualSummaryRef on AutoDisposeStreamProviderRef<AnnualSummary> {
  /// The parameter `year` of this provider.
  int get year;
}

class _AnnualSummaryProviderElement
    extends AutoDisposeStreamProviderElement<AnnualSummary>
    with AnnualSummaryRef {
  _AnnualSummaryProviderElement(super.provider);

  @override
  int get year => (origin as AnnualSummaryProvider).year;
}

String _$expensesForYearHash() => r'e33d3085c6d799b9b696b1e0228fb98ba25a2d94';

/// Raw expenses for [year] — used by [ExportService] to build exports.
///
/// Copied from [expensesForYear].
@ProviderFor(expensesForYear)
const expensesForYearProvider = ExpensesForYearFamily();

/// Raw expenses for [year] — used by [ExportService] to build exports.
///
/// Copied from [expensesForYear].
class ExpensesForYearFamily extends Family<AsyncValue<List<Expense>>> {
  /// Raw expenses for [year] — used by [ExportService] to build exports.
  ///
  /// Copied from [expensesForYear].
  const ExpensesForYearFamily();

  /// Raw expenses for [year] — used by [ExportService] to build exports.
  ///
  /// Copied from [expensesForYear].
  ExpensesForYearProvider call(int year) {
    return ExpensesForYearProvider(year);
  }

  @override
  ExpensesForYearProvider getProviderOverride(
    covariant ExpensesForYearProvider provider,
  ) {
    return call(provider.year);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'expensesForYearProvider';
}

/// Raw expenses for [year] — used by [ExportService] to build exports.
///
/// Copied from [expensesForYear].
class ExpensesForYearProvider extends AutoDisposeFutureProvider<List<Expense>> {
  /// Raw expenses for [year] — used by [ExportService] to build exports.
  ///
  /// Copied from [expensesForYear].
  ExpensesForYearProvider(int year)
    : this._internal(
        (ref) => expensesForYear(ref as ExpensesForYearRef, year),
        from: expensesForYearProvider,
        name: r'expensesForYearProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$expensesForYearHash,
        dependencies: ExpensesForYearFamily._dependencies,
        allTransitiveDependencies:
            ExpensesForYearFamily._allTransitiveDependencies,
        year: year,
      );

  ExpensesForYearProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.year,
  }) : super.internal();

  final int year;

  @override
  Override overrideWith(
    FutureOr<List<Expense>> Function(ExpensesForYearRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ExpensesForYearProvider._internal(
        (ref) => create(ref as ExpensesForYearRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        year: year,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Expense>> createElement() {
    return _ExpensesForYearProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ExpensesForYearProvider && other.year == year;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, year.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ExpensesForYearRef on AutoDisposeFutureProviderRef<List<Expense>> {
  /// The parameter `year` of this provider.
  int get year;
}

class _ExpensesForYearProviderElement
    extends AutoDisposeFutureProviderElement<List<Expense>>
    with ExpensesForYearRef {
  _ExpensesForYearProviderElement(super.provider);

  @override
  int get year => (origin as ExpensesForYearProvider).year;
}

String _$selectedYearHash() => r'f28ba273bb827b4fb9196410a9a73ffe53d37dcf';

/// Currently selected fiscal year. Defaults to the current calendar year.
///
/// Copied from [SelectedYear].
@ProviderFor(SelectedYear)
final selectedYearProvider =
    AutoDisposeNotifierProvider<SelectedYear, int>.internal(
      SelectedYear.new,
      name: r'selectedYearProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$selectedYearHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SelectedYear = AutoDisposeNotifier<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
