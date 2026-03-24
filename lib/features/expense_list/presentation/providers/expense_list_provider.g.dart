// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$expenseListHash() => r'9f5c2d7a08b8c5a03bc508b033f12f3f98537908';

/// See also [expenseList].
@ProviderFor(expenseList)
final expenseListProvider = AutoDisposeStreamProvider<List<Expense>>.internal(
  expenseList,
  name: r'expenseListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$expenseListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ExpenseListRef = AutoDisposeStreamProviderRef<List<Expense>>;
String _$expenseHasReceiptHash() => r'a123e080d2dfe4113ab502c52238881b68a8b521';

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

/// Emits true when [expenseId] has at least one receipt attached (Spec 4.2).
///
/// Copied from [expenseHasReceipt].
@ProviderFor(expenseHasReceipt)
const expenseHasReceiptProvider = ExpenseHasReceiptFamily();

/// Emits true when [expenseId] has at least one receipt attached (Spec 4.2).
///
/// Copied from [expenseHasReceipt].
class ExpenseHasReceiptFamily extends Family<AsyncValue<bool>> {
  /// Emits true when [expenseId] has at least one receipt attached (Spec 4.2).
  ///
  /// Copied from [expenseHasReceipt].
  const ExpenseHasReceiptFamily();

  /// Emits true when [expenseId] has at least one receipt attached (Spec 4.2).
  ///
  /// Copied from [expenseHasReceipt].
  ExpenseHasReceiptProvider call(String expenseId) {
    return ExpenseHasReceiptProvider(expenseId);
  }

  @override
  ExpenseHasReceiptProvider getProviderOverride(
    covariant ExpenseHasReceiptProvider provider,
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
  String? get name => r'expenseHasReceiptProvider';
}

/// Emits true when [expenseId] has at least one receipt attached (Spec 4.2).
///
/// Copied from [expenseHasReceipt].
class ExpenseHasReceiptProvider extends AutoDisposeStreamProvider<bool> {
  /// Emits true when [expenseId] has at least one receipt attached (Spec 4.2).
  ///
  /// Copied from [expenseHasReceipt].
  ExpenseHasReceiptProvider(String expenseId)
    : this._internal(
        (ref) => expenseHasReceipt(ref as ExpenseHasReceiptRef, expenseId),
        from: expenseHasReceiptProvider,
        name: r'expenseHasReceiptProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$expenseHasReceiptHash,
        dependencies: ExpenseHasReceiptFamily._dependencies,
        allTransitiveDependencies:
            ExpenseHasReceiptFamily._allTransitiveDependencies,
        expenseId: expenseId,
      );

  ExpenseHasReceiptProvider._internal(
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
    Stream<bool> Function(ExpenseHasReceiptRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ExpenseHasReceiptProvider._internal(
        (ref) => create(ref as ExpenseHasReceiptRef),
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
  AutoDisposeStreamProviderElement<bool> createElement() {
    return _ExpenseHasReceiptProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ExpenseHasReceiptProvider && other.expenseId == expenseId;
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
mixin ExpenseHasReceiptRef on AutoDisposeStreamProviderRef<bool> {
  /// The parameter `expenseId` of this provider.
  String get expenseId;
}

class _ExpenseHasReceiptProviderElement
    extends AutoDisposeStreamProviderElement<bool>
    with ExpenseHasReceiptRef {
  _ExpenseHasReceiptProviderElement(super.provider);

  @override
  String get expenseId => (origin as ExpenseHasReceiptProvider).expenseId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
