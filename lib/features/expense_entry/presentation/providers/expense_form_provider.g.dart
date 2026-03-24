// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_form_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$expenseFormHash() => r'4141cad2983b02a38111ca1ffac43e16a4ab3f7f';

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

/// See also [expenseForm].
@ProviderFor(expenseForm)
const expenseFormProvider = ExpenseFormFamily();

/// See also [expenseForm].
class ExpenseFormFamily extends Family<AsyncValue<Expense?>> {
  /// See also [expenseForm].
  const ExpenseFormFamily();

  /// See also [expenseForm].
  ExpenseFormProvider call(String? expenseId) {
    return ExpenseFormProvider(expenseId);
  }

  @override
  ExpenseFormProvider getProviderOverride(
    covariant ExpenseFormProvider provider,
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
  String? get name => r'expenseFormProvider';
}

/// See also [expenseForm].
class ExpenseFormProvider extends AutoDisposeFutureProvider<Expense?> {
  /// See also [expenseForm].
  ExpenseFormProvider(String? expenseId)
    : this._internal(
        (ref) => expenseForm(ref as ExpenseFormRef, expenseId),
        from: expenseFormProvider,
        name: r'expenseFormProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$expenseFormHash,
        dependencies: ExpenseFormFamily._dependencies,
        allTransitiveDependencies: ExpenseFormFamily._allTransitiveDependencies,
        expenseId: expenseId,
      );

  ExpenseFormProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.expenseId,
  }) : super.internal();

  final String? expenseId;

  @override
  Override overrideWith(
    FutureOr<Expense?> Function(ExpenseFormRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ExpenseFormProvider._internal(
        (ref) => create(ref as ExpenseFormRef),
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
  AutoDisposeFutureProviderElement<Expense?> createElement() {
    return _ExpenseFormProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ExpenseFormProvider && other.expenseId == expenseId;
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
mixin ExpenseFormRef on AutoDisposeFutureProviderRef<Expense?> {
  /// The parameter `expenseId` of this provider.
  String? get expenseId;
}

class _ExpenseFormProviderElement
    extends AutoDisposeFutureProviderElement<Expense?>
    with ExpenseFormRef {
  _ExpenseFormProviderElement(super.provider);

  @override
  String? get expenseId => (origin as ExpenseFormProvider).expenseId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
