// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recurring_expense.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RecurringExpense {

 String get id; String get description; int get amountInCents; DeductionCategory get category; RecurrenceFrequency get frequency; DateTime get referenceDate; DateTime get nextDueDate; bool get isActive; DateTime get createdAt; int? get dayOfMonth; String? get beneficiario; String? get cnpj; DateTime? get updatedAt; DateTime? get deletedAt;
/// Create a copy of RecurringExpense
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecurringExpenseCopyWith<RecurringExpense> get copyWith => _$RecurringExpenseCopyWithImpl<RecurringExpense>(this as RecurringExpense, _$identity);

  /// Serializes this RecurringExpense to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecurringExpense&&(identical(other.id, id) || other.id == id)&&(identical(other.description, description) || other.description == description)&&(identical(other.amountInCents, amountInCents) || other.amountInCents == amountInCents)&&(identical(other.category, category) || other.category == category)&&(identical(other.frequency, frequency) || other.frequency == frequency)&&(identical(other.referenceDate, referenceDate) || other.referenceDate == referenceDate)&&(identical(other.nextDueDate, nextDueDate) || other.nextDueDate == nextDueDate)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.dayOfMonth, dayOfMonth) || other.dayOfMonth == dayOfMonth)&&(identical(other.beneficiario, beneficiario) || other.beneficiario == beneficiario)&&(identical(other.cnpj, cnpj) || other.cnpj == cnpj)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,description,amountInCents,category,frequency,referenceDate,nextDueDate,isActive,createdAt,dayOfMonth,beneficiario,cnpj,updatedAt,deletedAt);

@override
String toString() {
  return 'RecurringExpense(id: $id, description: $description, amountInCents: $amountInCents, category: $category, frequency: $frequency, referenceDate: $referenceDate, nextDueDate: $nextDueDate, isActive: $isActive, createdAt: $createdAt, dayOfMonth: $dayOfMonth, beneficiario: $beneficiario, cnpj: $cnpj, updatedAt: $updatedAt, deletedAt: $deletedAt)';
}


}

/// @nodoc
abstract mixin class $RecurringExpenseCopyWith<$Res>  {
  factory $RecurringExpenseCopyWith(RecurringExpense value, $Res Function(RecurringExpense) _then) = _$RecurringExpenseCopyWithImpl;
@useResult
$Res call({
 String id, String description, int amountInCents, DeductionCategory category, RecurrenceFrequency frequency, DateTime referenceDate, DateTime nextDueDate, bool isActive, DateTime createdAt, int? dayOfMonth, String? beneficiario, String? cnpj, DateTime? updatedAt, DateTime? deletedAt
});




}
/// @nodoc
class _$RecurringExpenseCopyWithImpl<$Res>
    implements $RecurringExpenseCopyWith<$Res> {
  _$RecurringExpenseCopyWithImpl(this._self, this._then);

  final RecurringExpense _self;
  final $Res Function(RecurringExpense) _then;

/// Create a copy of RecurringExpense
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? description = null,Object? amountInCents = null,Object? category = null,Object? frequency = null,Object? referenceDate = null,Object? nextDueDate = null,Object? isActive = null,Object? createdAt = null,Object? dayOfMonth = freezed,Object? beneficiario = freezed,Object? cnpj = freezed,Object? updatedAt = freezed,Object? deletedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,amountInCents: null == amountInCents ? _self.amountInCents : amountInCents // ignore: cast_nullable_to_non_nullable
as int,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as DeductionCategory,frequency: null == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as RecurrenceFrequency,referenceDate: null == referenceDate ? _self.referenceDate : referenceDate // ignore: cast_nullable_to_non_nullable
as DateTime,nextDueDate: null == nextDueDate ? _self.nextDueDate : nextDueDate // ignore: cast_nullable_to_non_nullable
as DateTime,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,dayOfMonth: freezed == dayOfMonth ? _self.dayOfMonth : dayOfMonth // ignore: cast_nullable_to_non_nullable
as int?,beneficiario: freezed == beneficiario ? _self.beneficiario : beneficiario // ignore: cast_nullable_to_non_nullable
as String?,cnpj: freezed == cnpj ? _self.cnpj : cnpj // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [RecurringExpense].
extension RecurringExpensePatterns on RecurringExpense {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecurringExpense value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecurringExpense() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecurringExpense value)  $default,){
final _that = this;
switch (_that) {
case _RecurringExpense():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecurringExpense value)?  $default,){
final _that = this;
switch (_that) {
case _RecurringExpense() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String description,  int amountInCents,  DeductionCategory category,  RecurrenceFrequency frequency,  DateTime referenceDate,  DateTime nextDueDate,  bool isActive,  DateTime createdAt,  int? dayOfMonth,  String? beneficiario,  String? cnpj,  DateTime? updatedAt,  DateTime? deletedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecurringExpense() when $default != null:
return $default(_that.id,_that.description,_that.amountInCents,_that.category,_that.frequency,_that.referenceDate,_that.nextDueDate,_that.isActive,_that.createdAt,_that.dayOfMonth,_that.beneficiario,_that.cnpj,_that.updatedAt,_that.deletedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String description,  int amountInCents,  DeductionCategory category,  RecurrenceFrequency frequency,  DateTime referenceDate,  DateTime nextDueDate,  bool isActive,  DateTime createdAt,  int? dayOfMonth,  String? beneficiario,  String? cnpj,  DateTime? updatedAt,  DateTime? deletedAt)  $default,) {final _that = this;
switch (_that) {
case _RecurringExpense():
return $default(_that.id,_that.description,_that.amountInCents,_that.category,_that.frequency,_that.referenceDate,_that.nextDueDate,_that.isActive,_that.createdAt,_that.dayOfMonth,_that.beneficiario,_that.cnpj,_that.updatedAt,_that.deletedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String description,  int amountInCents,  DeductionCategory category,  RecurrenceFrequency frequency,  DateTime referenceDate,  DateTime nextDueDate,  bool isActive,  DateTime createdAt,  int? dayOfMonth,  String? beneficiario,  String? cnpj,  DateTime? updatedAt,  DateTime? deletedAt)?  $default,) {final _that = this;
switch (_that) {
case _RecurringExpense() when $default != null:
return $default(_that.id,_that.description,_that.amountInCents,_that.category,_that.frequency,_that.referenceDate,_that.nextDueDate,_that.isActive,_that.createdAt,_that.dayOfMonth,_that.beneficiario,_that.cnpj,_that.updatedAt,_that.deletedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RecurringExpense implements RecurringExpense {
  const _RecurringExpense({required this.id, required this.description, required this.amountInCents, required this.category, required this.frequency, required this.referenceDate, required this.nextDueDate, required this.isActive, required this.createdAt, this.dayOfMonth, this.beneficiario, this.cnpj, this.updatedAt, this.deletedAt});
  factory _RecurringExpense.fromJson(Map<String, dynamic> json) => _$RecurringExpenseFromJson(json);

@override final  String id;
@override final  String description;
@override final  int amountInCents;
@override final  DeductionCategory category;
@override final  RecurrenceFrequency frequency;
@override final  DateTime referenceDate;
@override final  DateTime nextDueDate;
@override final  bool isActive;
@override final  DateTime createdAt;
@override final  int? dayOfMonth;
@override final  String? beneficiario;
@override final  String? cnpj;
@override final  DateTime? updatedAt;
@override final  DateTime? deletedAt;

/// Create a copy of RecurringExpense
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecurringExpenseCopyWith<_RecurringExpense> get copyWith => __$RecurringExpenseCopyWithImpl<_RecurringExpense>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecurringExpenseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecurringExpense&&(identical(other.id, id) || other.id == id)&&(identical(other.description, description) || other.description == description)&&(identical(other.amountInCents, amountInCents) || other.amountInCents == amountInCents)&&(identical(other.category, category) || other.category == category)&&(identical(other.frequency, frequency) || other.frequency == frequency)&&(identical(other.referenceDate, referenceDate) || other.referenceDate == referenceDate)&&(identical(other.nextDueDate, nextDueDate) || other.nextDueDate == nextDueDate)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.dayOfMonth, dayOfMonth) || other.dayOfMonth == dayOfMonth)&&(identical(other.beneficiario, beneficiario) || other.beneficiario == beneficiario)&&(identical(other.cnpj, cnpj) || other.cnpj == cnpj)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,description,amountInCents,category,frequency,referenceDate,nextDueDate,isActive,createdAt,dayOfMonth,beneficiario,cnpj,updatedAt,deletedAt);

@override
String toString() {
  return 'RecurringExpense(id: $id, description: $description, amountInCents: $amountInCents, category: $category, frequency: $frequency, referenceDate: $referenceDate, nextDueDate: $nextDueDate, isActive: $isActive, createdAt: $createdAt, dayOfMonth: $dayOfMonth, beneficiario: $beneficiario, cnpj: $cnpj, updatedAt: $updatedAt, deletedAt: $deletedAt)';
}


}

/// @nodoc
abstract mixin class _$RecurringExpenseCopyWith<$Res> implements $RecurringExpenseCopyWith<$Res> {
  factory _$RecurringExpenseCopyWith(_RecurringExpense value, $Res Function(_RecurringExpense) _then) = __$RecurringExpenseCopyWithImpl;
@override @useResult
$Res call({
 String id, String description, int amountInCents, DeductionCategory category, RecurrenceFrequency frequency, DateTime referenceDate, DateTime nextDueDate, bool isActive, DateTime createdAt, int? dayOfMonth, String? beneficiario, String? cnpj, DateTime? updatedAt, DateTime? deletedAt
});




}
/// @nodoc
class __$RecurringExpenseCopyWithImpl<$Res>
    implements _$RecurringExpenseCopyWith<$Res> {
  __$RecurringExpenseCopyWithImpl(this._self, this._then);

  final _RecurringExpense _self;
  final $Res Function(_RecurringExpense) _then;

/// Create a copy of RecurringExpense
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? description = null,Object? amountInCents = null,Object? category = null,Object? frequency = null,Object? referenceDate = null,Object? nextDueDate = null,Object? isActive = null,Object? createdAt = null,Object? dayOfMonth = freezed,Object? beneficiario = freezed,Object? cnpj = freezed,Object? updatedAt = freezed,Object? deletedAt = freezed,}) {
  return _then(_RecurringExpense(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,amountInCents: null == amountInCents ? _self.amountInCents : amountInCents // ignore: cast_nullable_to_non_nullable
as int,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as DeductionCategory,frequency: null == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as RecurrenceFrequency,referenceDate: null == referenceDate ? _self.referenceDate : referenceDate // ignore: cast_nullable_to_non_nullable
as DateTime,nextDueDate: null == nextDueDate ? _self.nextDueDate : nextDueDate // ignore: cast_nullable_to_non_nullable
as DateTime,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,dayOfMonth: freezed == dayOfMonth ? _self.dayOfMonth : dayOfMonth // ignore: cast_nullable_to_non_nullable
as int?,beneficiario: freezed == beneficiario ? _self.beneficiario : beneficiario // ignore: cast_nullable_to_non_nullable
as String?,cnpj: freezed == cnpj ? _self.cnpj : cnpj // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
