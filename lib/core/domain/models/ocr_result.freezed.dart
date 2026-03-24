// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ocr_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OcrResult {

 OcrStatus get status;/// Path to the (possibly compressed) image saved on disk.
 String get imagePath;/// Extracted amount in centavos.
 int? get valor;/// Extracted expense date.
 DateTime? get data;/// Extracted CNPJ (digits only, 14 chars).
 String? get cnpj;/// Extracted issuer name / beneficiário.
 String? get beneficiario;
/// Create a copy of OcrResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OcrResultCopyWith<OcrResult> get copyWith => _$OcrResultCopyWithImpl<OcrResult>(this as OcrResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OcrResult&&(identical(other.status, status) || other.status == status)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.valor, valor) || other.valor == valor)&&(identical(other.data, data) || other.data == data)&&(identical(other.cnpj, cnpj) || other.cnpj == cnpj)&&(identical(other.beneficiario, beneficiario) || other.beneficiario == beneficiario));
}


@override
int get hashCode => Object.hash(runtimeType,status,imagePath,valor,data,cnpj,beneficiario);

@override
String toString() {
  return 'OcrResult(status: $status, imagePath: $imagePath, valor: $valor, data: $data, cnpj: $cnpj, beneficiario: $beneficiario)';
}


}

/// @nodoc
abstract mixin class $OcrResultCopyWith<$Res>  {
  factory $OcrResultCopyWith(OcrResult value, $Res Function(OcrResult) _then) = _$OcrResultCopyWithImpl;
@useResult
$Res call({
 OcrStatus status, String imagePath, int? valor, DateTime? data, String? cnpj, String? beneficiario
});




}
/// @nodoc
class _$OcrResultCopyWithImpl<$Res>
    implements $OcrResultCopyWith<$Res> {
  _$OcrResultCopyWithImpl(this._self, this._then);

  final OcrResult _self;
  final $Res Function(OcrResult) _then;

/// Create a copy of OcrResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? imagePath = null,Object? valor = freezed,Object? data = freezed,Object? cnpj = freezed,Object? beneficiario = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OcrStatus,imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,valor: freezed == valor ? _self.valor : valor // ignore: cast_nullable_to_non_nullable
as int?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as DateTime?,cnpj: freezed == cnpj ? _self.cnpj : cnpj // ignore: cast_nullable_to_non_nullable
as String?,beneficiario: freezed == beneficiario ? _self.beneficiario : beneficiario // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OcrResult].
extension OcrResultPatterns on OcrResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OcrResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OcrResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OcrResult value)  $default,){
final _that = this;
switch (_that) {
case _OcrResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OcrResult value)?  $default,){
final _that = this;
switch (_that) {
case _OcrResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( OcrStatus status,  String imagePath,  int? valor,  DateTime? data,  String? cnpj,  String? beneficiario)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OcrResult() when $default != null:
return $default(_that.status,_that.imagePath,_that.valor,_that.data,_that.cnpj,_that.beneficiario);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( OcrStatus status,  String imagePath,  int? valor,  DateTime? data,  String? cnpj,  String? beneficiario)  $default,) {final _that = this;
switch (_that) {
case _OcrResult():
return $default(_that.status,_that.imagePath,_that.valor,_that.data,_that.cnpj,_that.beneficiario);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( OcrStatus status,  String imagePath,  int? valor,  DateTime? data,  String? cnpj,  String? beneficiario)?  $default,) {final _that = this;
switch (_that) {
case _OcrResult() when $default != null:
return $default(_that.status,_that.imagePath,_that.valor,_that.data,_that.cnpj,_that.beneficiario);case _:
  return null;

}
}

}

/// @nodoc


class _OcrResult implements OcrResult {
  const _OcrResult({required this.status, required this.imagePath, this.valor, this.data, this.cnpj, this.beneficiario});
  

@override final  OcrStatus status;
/// Path to the (possibly compressed) image saved on disk.
@override final  String imagePath;
/// Extracted amount in centavos.
@override final  int? valor;
/// Extracted expense date.
@override final  DateTime? data;
/// Extracted CNPJ (digits only, 14 chars).
@override final  String? cnpj;
/// Extracted issuer name / beneficiário.
@override final  String? beneficiario;

/// Create a copy of OcrResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OcrResultCopyWith<_OcrResult> get copyWith => __$OcrResultCopyWithImpl<_OcrResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OcrResult&&(identical(other.status, status) || other.status == status)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.valor, valor) || other.valor == valor)&&(identical(other.data, data) || other.data == data)&&(identical(other.cnpj, cnpj) || other.cnpj == cnpj)&&(identical(other.beneficiario, beneficiario) || other.beneficiario == beneficiario));
}


@override
int get hashCode => Object.hash(runtimeType,status,imagePath,valor,data,cnpj,beneficiario);

@override
String toString() {
  return 'OcrResult(status: $status, imagePath: $imagePath, valor: $valor, data: $data, cnpj: $cnpj, beneficiario: $beneficiario)';
}


}

/// @nodoc
abstract mixin class _$OcrResultCopyWith<$Res> implements $OcrResultCopyWith<$Res> {
  factory _$OcrResultCopyWith(_OcrResult value, $Res Function(_OcrResult) _then) = __$OcrResultCopyWithImpl;
@override @useResult
$Res call({
 OcrStatus status, String imagePath, int? valor, DateTime? data, String? cnpj, String? beneficiario
});




}
/// @nodoc
class __$OcrResultCopyWithImpl<$Res>
    implements _$OcrResultCopyWith<$Res> {
  __$OcrResultCopyWithImpl(this._self, this._then);

  final _OcrResult _self;
  final $Res Function(_OcrResult) _then;

/// Create a copy of OcrResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? imagePath = null,Object? valor = freezed,Object? data = freezed,Object? cnpj = freezed,Object? beneficiario = freezed,}) {
  return _then(_OcrResult(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OcrStatus,imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,valor: freezed == valor ? _self.valor : valor // ignore: cast_nullable_to_non_nullable
as int?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as DateTime?,cnpj: freezed == cnpj ? _self.cnpj : cnpj // ignore: cast_nullable_to_non_nullable
as String?,beneficiario: freezed == beneficiario ? _self.beneficiario : beneficiario // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
