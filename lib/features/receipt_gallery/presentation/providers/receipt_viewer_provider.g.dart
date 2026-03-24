// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_viewer_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$receiptsByExpenseHash() => r'50790821868845aaf216e52b10a882d0d1cc4396';

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

/// Streams receipts linked to [expenseId] (Spec 4.1 / 4.2).
///
/// Copied from [receiptsByExpense].
@ProviderFor(receiptsByExpense)
const receiptsByExpenseProvider = ReceiptsByExpenseFamily();

/// Streams receipts linked to [expenseId] (Spec 4.1 / 4.2).
///
/// Copied from [receiptsByExpense].
class ReceiptsByExpenseFamily extends Family<AsyncValue<List<Receipt>>> {
  /// Streams receipts linked to [expenseId] (Spec 4.1 / 4.2).
  ///
  /// Copied from [receiptsByExpense].
  const ReceiptsByExpenseFamily();

  /// Streams receipts linked to [expenseId] (Spec 4.1 / 4.2).
  ///
  /// Copied from [receiptsByExpense].
  ReceiptsByExpenseProvider call(String expenseId) {
    return ReceiptsByExpenseProvider(expenseId);
  }

  @override
  ReceiptsByExpenseProvider getProviderOverride(
    covariant ReceiptsByExpenseProvider provider,
  ) {
    return call(provider.expenseId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'receiptsByExpenseProvider';
}

/// Streams receipts linked to [expenseId] (Spec 4.1 / 4.2).
///
/// Copied from [receiptsByExpense].
class ReceiptsByExpenseProvider
    extends AutoDisposeStreamProvider<List<Receipt>> {
  /// Streams receipts linked to [expenseId] (Spec 4.1 / 4.2).
  ///
  /// Copied from [receiptsByExpense].
  ReceiptsByExpenseProvider(String expenseId)
    : this._internal(
        (ref) => receiptsByExpense(ref as ReceiptsByExpenseRef, expenseId),
        from: receiptsByExpenseProvider,
        name: r'receiptsByExpenseProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$receiptsByExpenseHash,
        dependencies: ReceiptsByExpenseFamily._dependencies,
        allTransitiveDependencies:
            ReceiptsByExpenseFamily._allTransitiveDependencies,
        expenseId: expenseId,
      );

  ReceiptsByExpenseProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.expenseId,
  }) : super.internal();

  final String expenseId;

  @override
  Override overrideWith(
    Stream<List<Receipt>> Function(ReceiptsByExpenseRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ReceiptsByExpenseProvider._internal(
        (ref) => create(ref as ReceiptsByExpenseRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        expenseId: expenseId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Receipt>> createElement() {
    return _ReceiptsByExpenseProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ReceiptsByExpenseProvider && other.expenseId == expenseId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, expenseId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ReceiptsByExpenseRef on AutoDisposeStreamProviderRef<List<Receipt>> {
  /// The parameter `expenseId` of this provider.
  String get expenseId;
}

class _ReceiptsByExpenseProviderElement
    extends AutoDisposeStreamProviderElement<List<Receipt>>
    with ReceiptsByExpenseRef {
  _ReceiptsByExpenseProviderElement(super.provider);

  @override
  String get expenseId => (origin as ReceiptsByExpenseProvider).expenseId;
}

String _$receiptViewerExpenseHash() =>
    r'e181c0f4ad2ee0ee91b4d4e9ebd67fa1b7a24143';

/// Streams the parent expense for metadata display (Spec 4.1).
///
/// Copied from [receiptViewerExpense].
@ProviderFor(receiptViewerExpense)
const receiptViewerExpenseProvider = ReceiptViewerExpenseFamily();

/// Streams the parent expense for metadata display (Spec 4.1).
///
/// Copied from [receiptViewerExpense].
class ReceiptViewerExpenseFamily extends Family<AsyncValue<Expense?>> {
  /// Streams the parent expense for metadata display (Spec 4.1).
  ///
  /// Copied from [receiptViewerExpense].
  const ReceiptViewerExpenseFamily();

  /// Streams the parent expense for metadata display (Spec 4.1).
  ///
  /// Copied from [receiptViewerExpense].
  ReceiptViewerExpenseProvider call(String expenseId) {
    return ReceiptViewerExpenseProvider(expenseId);
  }

  @override
  ReceiptViewerExpenseProvider getProviderOverride(
    covariant ReceiptViewerExpenseProvider provider,
  ) {
    return call(provider.expenseId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'receiptViewerExpenseProvider';
}

/// Streams the parent expense for metadata display (Spec 4.1).
///
/// Copied from [receiptViewerExpense].
class ReceiptViewerExpenseProvider extends AutoDisposeStreamProvider<Expense?> {
  /// Streams the parent expense for metadata display (Spec 4.1).
  ///
  /// Copied from [receiptViewerExpense].
  ReceiptViewerExpenseProvider(String expenseId)
    : this._internal(
        (ref) =>
            receiptViewerExpense(ref as ReceiptViewerExpenseRef, expenseId),
        from: receiptViewerExpenseProvider,
        name: r'receiptViewerExpenseProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$receiptViewerExpenseHash,
        dependencies: ReceiptViewerExpenseFamily._dependencies,
        allTransitiveDependencies:
            ReceiptViewerExpenseFamily._allTransitiveDependencies,
        expenseId: expenseId,
      );

  ReceiptViewerExpenseProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.expenseId,
  }) : super.internal();

  final String expenseId;

  @override
  Override overrideWith(
    Stream<Expense?> Function(ReceiptViewerExpenseRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ReceiptViewerExpenseProvider._internal(
        (ref) => create(ref as ReceiptViewerExpenseRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        expenseId: expenseId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Expense?> createElement() {
    return _ReceiptViewerExpenseProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ReceiptViewerExpenseProvider &&
        other.expenseId == expenseId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, expenseId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ReceiptViewerExpenseRef on AutoDisposeStreamProviderRef<Expense?> {
  /// The parameter `expenseId` of this provider.
  String get expenseId;
}

class _ReceiptViewerExpenseProviderElement
    extends AutoDisposeStreamProviderElement<Expense?>
    with ReceiptViewerExpenseRef {
  _ReceiptViewerExpenseProviderElement(super.provider);

  @override
  String get expenseId => (origin as ReceiptViewerExpenseProvider).expenseId;
}

String _$archivedReceiptsWithExpenseHash() =>
    r'6735ba53b51eb54d956de0e6612da63df9cca0ae';

/// Streams receipts of soft-deleted expenses (Spec 4.4).
///
/// Copied from [archivedReceiptsWithExpense].
@ProviderFor(archivedReceiptsWithExpense)
final archivedReceiptsWithExpenseProvider =
    AutoDisposeStreamProvider<
      List<({Receipt receipt, Expense expense})>
    >.internal(
      archivedReceiptsWithExpense,
      name: r'archivedReceiptsWithExpenseProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$archivedReceiptsWithExpenseHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ArchivedReceiptsWithExpenseRef =
    AutoDisposeStreamProviderRef<List<({Receipt receipt, Expense expense})>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
