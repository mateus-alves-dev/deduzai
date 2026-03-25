// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cnpj_lookup_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CnpjLookupResult {

 DeductionCategory? get suggestedCategory; String? get beneficiario; bool? get isValid; String? get cnaeDescricao;
/// Create a copy of CnpjLookupResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CnpjLookupResultCopyWith<CnpjLookupResult> get copyWith => _$CnpjLookupResultCopyWithImpl<CnpjLookupResult>(this as CnpjLookupResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CnpjLookupResult&&(identical(other.suggestedCategory, suggestedCategory) || other.suggestedCategory == suggestedCategory)&&(identical(other.beneficiario, beneficiario) || other.beneficiario == beneficiario)&&(identical(other.isValid, isValid) || other.isValid == isValid)&&(identical(other.cnaeDescricao, cnaeDescricao) || other.cnaeDescricao == cnaeDescricao));
}


@override
int get hashCode => Object.hash(runtimeType,suggestedCategory,beneficiario,isValid,cnaeDescricao);

@override
String toString() {
  return 'CnpjLookupResult(suggestedCategory: $suggestedCategory, beneficiario: $beneficiario, isValid: $isValid, cnaeDescricao: $cnaeDescricao)';
}


}

/// @nodoc
abstract mixin class $CnpjLookupResultCopyWith<$Res>  {
  factory $CnpjLookupResultCopyWith(CnpjLookupResult value, $Res Function(CnpjLookupResult) _then) = _$CnpjLookupResultCopyWithImpl;
@useResult
$Res call({
 DeductionCategory? suggestedCategory, String? beneficiario, bool? isValid, String? cnaeDescricao
});




}
/// @nodoc
class _$CnpjLookupResultCopyWithImpl<$Res>
    implements $CnpjLookupResultCopyWith<$Res> {
  _$CnpjLookupResultCopyWithImpl(this._self, this._then);

  final CnpjLookupResult _self;
  final $Res Function(CnpjLookupResult) _then;

/// Create a copy of CnpjLookupResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? suggestedCategory = freezed,Object? beneficiario = freezed,Object? isValid = freezed,Object? cnaeDescricao = freezed,}) {
  return _then(_self.copyWith(
suggestedCategory: freezed == suggestedCategory ? _self.suggestedCategory : suggestedCategory // ignore: cast_nullable_to_non_nullable
as DeductionCategory?,beneficiario: freezed == beneficiario ? _self.beneficiario : beneficiario // ignore: cast_nullable_to_non_nullable
as String?,isValid: freezed == isValid ? _self.isValid : isValid // ignore: cast_nullable_to_non_nullable
as bool?,cnaeDescricao: freezed == cnaeDescricao ? _self.cnaeDescricao : cnaeDescricao // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CnpjLookupResult].
extension CnpjLookupResultPatterns on CnpjLookupResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CnpjLookupResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CnpjLookupResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CnpjLookupResult value)  $default,){
final _that = this;
switch (_that) {
case _CnpjLookupResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CnpjLookupResult value)?  $default,){
final _that = this;
switch (_that) {
case _CnpjLookupResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DeductionCategory? suggestedCategory,  String? beneficiario,  bool? isValid,  String? cnaeDescricao)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CnpjLookupResult() when $default != null:
return $default(_that.suggestedCategory,_that.beneficiario,_that.isValid,_that.cnaeDescricao);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DeductionCategory? suggestedCategory,  String? beneficiario,  bool? isValid,  String? cnaeDescricao)  $default,) {final _that = this;
switch (_that) {
case _CnpjLookupResult():
return $default(_that.suggestedCategory,_that.beneficiario,_that.isValid,_that.cnaeDescricao);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DeductionCategory? suggestedCategory,  String? beneficiario,  bool? isValid,  String? cnaeDescricao)?  $default,) {final _that = this;
switch (_that) {
case _CnpjLookupResult() when $default != null:
return $default(_that.suggestedCategory,_that.beneficiario,_that.isValid,_that.cnaeDescricao);case _:
  return null;

}
}

}

/// @nodoc


class _CnpjLookupResult implements CnpjLookupResult {
  const _CnpjLookupResult({this.suggestedCategory, this.beneficiario, this.isValid, this.cnaeDescricao});
  

@override final  DeductionCategory? suggestedCategory;
@override final  String? beneficiario;
@override final  bool? isValid;
@override final  String? cnaeDescricao;

/// Create a copy of CnpjLookupResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CnpjLookupResultCopyWith<_CnpjLookupResult> get copyWith => __$CnpjLookupResultCopyWithImpl<_CnpjLookupResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CnpjLookupResult&&(identical(other.suggestedCategory, suggestedCategory) || other.suggestedCategory == suggestedCategory)&&(identical(other.beneficiario, beneficiario) || other.beneficiario == beneficiario)&&(identical(other.isValid, isValid) || other.isValid == isValid)&&(identical(other.cnaeDescricao, cnaeDescricao) || other.cnaeDescricao == cnaeDescricao));
}


@override
int get hashCode => Object.hash(runtimeType,suggestedCategory,beneficiario,isValid,cnaeDescricao);

@override
String toString() {
  return 'CnpjLookupResult(suggestedCategory: $suggestedCategory, beneficiario: $beneficiario, isValid: $isValid, cnaeDescricao: $cnaeDescricao)';
}


}

/// @nodoc
abstract mixin class _$CnpjLookupResultCopyWith<$Res> implements $CnpjLookupResultCopyWith<$Res> {
  factory _$CnpjLookupResultCopyWith(_CnpjLookupResult value, $Res Function(_CnpjLookupResult) _then) = __$CnpjLookupResultCopyWithImpl;
@override @useResult
$Res call({
 DeductionCategory? suggestedCategory, String? beneficiario, bool? isValid, String? cnaeDescricao
});




}
/// @nodoc
class __$CnpjLookupResultCopyWithImpl<$Res>
    implements _$CnpjLookupResultCopyWith<$Res> {
  __$CnpjLookupResultCopyWithImpl(this._self, this._then);

  final _CnpjLookupResult _self;
  final $Res Function(_CnpjLookupResult) _then;

/// Create a copy of CnpjLookupResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? suggestedCategory = freezed,Object? beneficiario = freezed,Object? isValid = freezed,Object? cnaeDescricao = freezed,}) {
  return _then(_CnpjLookupResult(
suggestedCategory: freezed == suggestedCategory ? _self.suggestedCategory : suggestedCategory // ignore: cast_nullable_to_non_nullable
as DeductionCategory?,beneficiario: freezed == beneficiario ? _self.beneficiario : beneficiario // ignore: cast_nullable_to_non_nullable
as String?,isValid: freezed == isValid ? _self.isValid : isValid // ignore: cast_nullable_to_non_nullable
as bool?,cnaeDescricao: freezed == cnaeDescricao ? _self.cnaeDescricao : cnaeDescricao // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
