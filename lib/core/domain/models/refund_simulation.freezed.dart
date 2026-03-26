// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'refund_simulation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RefundSimulation {

/// Gross annual income declared by the user (centavos).
 int get grossIncomeInCents;/// Total deductible amount from registered expenses (centavos).
 int get totalDeductibleInCents;/// Taxable base = gross income - total deductible (centavos).
 int get taxableBaseInCents;/// Income tax calculated on gross income without any deductions (centavos).
 int get taxWithoutDeductionsInCents;/// Income tax calculated on taxable base (with deductions applied) (centavos).
 int get taxWithDeductionsInCents;/// Estimated refund = tax without deductions - tax with deductions (centavos).
/// Positive means the user gets money back. Negative means extra tax to pay.
 int get estimatedRefundInCents;/// Effective tax rate after deductions, as a percentage (e.g. 15.3).
 double get effectiveRatePercent;
/// Create a copy of RefundSimulation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RefundSimulationCopyWith<RefundSimulation> get copyWith => _$RefundSimulationCopyWithImpl<RefundSimulation>(this as RefundSimulation, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RefundSimulation&&(identical(other.grossIncomeInCents, grossIncomeInCents) || other.grossIncomeInCents == grossIncomeInCents)&&(identical(other.totalDeductibleInCents, totalDeductibleInCents) || other.totalDeductibleInCents == totalDeductibleInCents)&&(identical(other.taxableBaseInCents, taxableBaseInCents) || other.taxableBaseInCents == taxableBaseInCents)&&(identical(other.taxWithoutDeductionsInCents, taxWithoutDeductionsInCents) || other.taxWithoutDeductionsInCents == taxWithoutDeductionsInCents)&&(identical(other.taxWithDeductionsInCents, taxWithDeductionsInCents) || other.taxWithDeductionsInCents == taxWithDeductionsInCents)&&(identical(other.estimatedRefundInCents, estimatedRefundInCents) || other.estimatedRefundInCents == estimatedRefundInCents)&&(identical(other.effectiveRatePercent, effectiveRatePercent) || other.effectiveRatePercent == effectiveRatePercent));
}


@override
int get hashCode => Object.hash(runtimeType,grossIncomeInCents,totalDeductibleInCents,taxableBaseInCents,taxWithoutDeductionsInCents,taxWithDeductionsInCents,estimatedRefundInCents,effectiveRatePercent);

@override
String toString() {
  return 'RefundSimulation(grossIncomeInCents: $grossIncomeInCents, totalDeductibleInCents: $totalDeductibleInCents, taxableBaseInCents: $taxableBaseInCents, taxWithoutDeductionsInCents: $taxWithoutDeductionsInCents, taxWithDeductionsInCents: $taxWithDeductionsInCents, estimatedRefundInCents: $estimatedRefundInCents, effectiveRatePercent: $effectiveRatePercent)';
}


}

/// @nodoc
abstract mixin class $RefundSimulationCopyWith<$Res>  {
  factory $RefundSimulationCopyWith(RefundSimulation value, $Res Function(RefundSimulation) _then) = _$RefundSimulationCopyWithImpl;
@useResult
$Res call({
 int grossIncomeInCents, int totalDeductibleInCents, int taxableBaseInCents, int taxWithoutDeductionsInCents, int taxWithDeductionsInCents, int estimatedRefundInCents, double effectiveRatePercent
});




}
/// @nodoc
class _$RefundSimulationCopyWithImpl<$Res>
    implements $RefundSimulationCopyWith<$Res> {
  _$RefundSimulationCopyWithImpl(this._self, this._then);

  final RefundSimulation _self;
  final $Res Function(RefundSimulation) _then;

/// Create a copy of RefundSimulation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? grossIncomeInCents = null,Object? totalDeductibleInCents = null,Object? taxableBaseInCents = null,Object? taxWithoutDeductionsInCents = null,Object? taxWithDeductionsInCents = null,Object? estimatedRefundInCents = null,Object? effectiveRatePercent = null,}) {
  return _then(_self.copyWith(
grossIncomeInCents: null == grossIncomeInCents ? _self.grossIncomeInCents : grossIncomeInCents // ignore: cast_nullable_to_non_nullable
as int,totalDeductibleInCents: null == totalDeductibleInCents ? _self.totalDeductibleInCents : totalDeductibleInCents // ignore: cast_nullable_to_non_nullable
as int,taxableBaseInCents: null == taxableBaseInCents ? _self.taxableBaseInCents : taxableBaseInCents // ignore: cast_nullable_to_non_nullable
as int,taxWithoutDeductionsInCents: null == taxWithoutDeductionsInCents ? _self.taxWithoutDeductionsInCents : taxWithoutDeductionsInCents // ignore: cast_nullable_to_non_nullable
as int,taxWithDeductionsInCents: null == taxWithDeductionsInCents ? _self.taxWithDeductionsInCents : taxWithDeductionsInCents // ignore: cast_nullable_to_non_nullable
as int,estimatedRefundInCents: null == estimatedRefundInCents ? _self.estimatedRefundInCents : estimatedRefundInCents // ignore: cast_nullable_to_non_nullable
as int,effectiveRatePercent: null == effectiveRatePercent ? _self.effectiveRatePercent : effectiveRatePercent // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [RefundSimulation].
extension RefundSimulationPatterns on RefundSimulation {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RefundSimulation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RefundSimulation() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RefundSimulation value)  $default,){
final _that = this;
switch (_that) {
case _RefundSimulation():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RefundSimulation value)?  $default,){
final _that = this;
switch (_that) {
case _RefundSimulation() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int grossIncomeInCents,  int totalDeductibleInCents,  int taxableBaseInCents,  int taxWithoutDeductionsInCents,  int taxWithDeductionsInCents,  int estimatedRefundInCents,  double effectiveRatePercent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RefundSimulation() when $default != null:
return $default(_that.grossIncomeInCents,_that.totalDeductibleInCents,_that.taxableBaseInCents,_that.taxWithoutDeductionsInCents,_that.taxWithDeductionsInCents,_that.estimatedRefundInCents,_that.effectiveRatePercent);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int grossIncomeInCents,  int totalDeductibleInCents,  int taxableBaseInCents,  int taxWithoutDeductionsInCents,  int taxWithDeductionsInCents,  int estimatedRefundInCents,  double effectiveRatePercent)  $default,) {final _that = this;
switch (_that) {
case _RefundSimulation():
return $default(_that.grossIncomeInCents,_that.totalDeductibleInCents,_that.taxableBaseInCents,_that.taxWithoutDeductionsInCents,_that.taxWithDeductionsInCents,_that.estimatedRefundInCents,_that.effectiveRatePercent);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int grossIncomeInCents,  int totalDeductibleInCents,  int taxableBaseInCents,  int taxWithoutDeductionsInCents,  int taxWithDeductionsInCents,  int estimatedRefundInCents,  double effectiveRatePercent)?  $default,) {final _that = this;
switch (_that) {
case _RefundSimulation() when $default != null:
return $default(_that.grossIncomeInCents,_that.totalDeductibleInCents,_that.taxableBaseInCents,_that.taxWithoutDeductionsInCents,_that.taxWithDeductionsInCents,_that.estimatedRefundInCents,_that.effectiveRatePercent);case _:
  return null;

}
}

}

/// @nodoc


class _RefundSimulation implements RefundSimulation {
  const _RefundSimulation({required this.grossIncomeInCents, required this.totalDeductibleInCents, required this.taxableBaseInCents, required this.taxWithoutDeductionsInCents, required this.taxWithDeductionsInCents, required this.estimatedRefundInCents, required this.effectiveRatePercent});
  

/// Gross annual income declared by the user (centavos).
@override final  int grossIncomeInCents;
/// Total deductible amount from registered expenses (centavos).
@override final  int totalDeductibleInCents;
/// Taxable base = gross income - total deductible (centavos).
@override final  int taxableBaseInCents;
/// Income tax calculated on gross income without any deductions (centavos).
@override final  int taxWithoutDeductionsInCents;
/// Income tax calculated on taxable base (with deductions applied) (centavos).
@override final  int taxWithDeductionsInCents;
/// Estimated refund = tax without deductions - tax with deductions (centavos).
/// Positive means the user gets money back. Negative means extra tax to pay.
@override final  int estimatedRefundInCents;
/// Effective tax rate after deductions, as a percentage (e.g. 15.3).
@override final  double effectiveRatePercent;

/// Create a copy of RefundSimulation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RefundSimulationCopyWith<_RefundSimulation> get copyWith => __$RefundSimulationCopyWithImpl<_RefundSimulation>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RefundSimulation&&(identical(other.grossIncomeInCents, grossIncomeInCents) || other.grossIncomeInCents == grossIncomeInCents)&&(identical(other.totalDeductibleInCents, totalDeductibleInCents) || other.totalDeductibleInCents == totalDeductibleInCents)&&(identical(other.taxableBaseInCents, taxableBaseInCents) || other.taxableBaseInCents == taxableBaseInCents)&&(identical(other.taxWithoutDeductionsInCents, taxWithoutDeductionsInCents) || other.taxWithoutDeductionsInCents == taxWithoutDeductionsInCents)&&(identical(other.taxWithDeductionsInCents, taxWithDeductionsInCents) || other.taxWithDeductionsInCents == taxWithDeductionsInCents)&&(identical(other.estimatedRefundInCents, estimatedRefundInCents) || other.estimatedRefundInCents == estimatedRefundInCents)&&(identical(other.effectiveRatePercent, effectiveRatePercent) || other.effectiveRatePercent == effectiveRatePercent));
}


@override
int get hashCode => Object.hash(runtimeType,grossIncomeInCents,totalDeductibleInCents,taxableBaseInCents,taxWithoutDeductionsInCents,taxWithDeductionsInCents,estimatedRefundInCents,effectiveRatePercent);

@override
String toString() {
  return 'RefundSimulation(grossIncomeInCents: $grossIncomeInCents, totalDeductibleInCents: $totalDeductibleInCents, taxableBaseInCents: $taxableBaseInCents, taxWithoutDeductionsInCents: $taxWithoutDeductionsInCents, taxWithDeductionsInCents: $taxWithDeductionsInCents, estimatedRefundInCents: $estimatedRefundInCents, effectiveRatePercent: $effectiveRatePercent)';
}


}

/// @nodoc
abstract mixin class _$RefundSimulationCopyWith<$Res> implements $RefundSimulationCopyWith<$Res> {
  factory _$RefundSimulationCopyWith(_RefundSimulation value, $Res Function(_RefundSimulation) _then) = __$RefundSimulationCopyWithImpl;
@override @useResult
$Res call({
 int grossIncomeInCents, int totalDeductibleInCents, int taxableBaseInCents, int taxWithoutDeductionsInCents, int taxWithDeductionsInCents, int estimatedRefundInCents, double effectiveRatePercent
});




}
/// @nodoc
class __$RefundSimulationCopyWithImpl<$Res>
    implements _$RefundSimulationCopyWith<$Res> {
  __$RefundSimulationCopyWithImpl(this._self, this._then);

  final _RefundSimulation _self;
  final $Res Function(_RefundSimulation) _then;

/// Create a copy of RefundSimulation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? grossIncomeInCents = null,Object? totalDeductibleInCents = null,Object? taxableBaseInCents = null,Object? taxWithoutDeductionsInCents = null,Object? taxWithDeductionsInCents = null,Object? estimatedRefundInCents = null,Object? effectiveRatePercent = null,}) {
  return _then(_RefundSimulation(
grossIncomeInCents: null == grossIncomeInCents ? _self.grossIncomeInCents : grossIncomeInCents // ignore: cast_nullable_to_non_nullable
as int,totalDeductibleInCents: null == totalDeductibleInCents ? _self.totalDeductibleInCents : totalDeductibleInCents // ignore: cast_nullable_to_non_nullable
as int,taxableBaseInCents: null == taxableBaseInCents ? _self.taxableBaseInCents : taxableBaseInCents // ignore: cast_nullable_to_non_nullable
as int,taxWithoutDeductionsInCents: null == taxWithoutDeductionsInCents ? _self.taxWithoutDeductionsInCents : taxWithoutDeductionsInCents // ignore: cast_nullable_to_non_nullable
as int,taxWithDeductionsInCents: null == taxWithDeductionsInCents ? _self.taxWithDeductionsInCents : taxWithDeductionsInCents // ignore: cast_nullable_to_non_nullable
as int,estimatedRefundInCents: null == estimatedRefundInCents ? _self.estimatedRefundInCents : estimatedRefundInCents // ignore: cast_nullable_to_non_nullable
as int,effectiveRatePercent: null == effectiveRatePercent ? _self.effectiveRatePercent : effectiveRatePercent // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
