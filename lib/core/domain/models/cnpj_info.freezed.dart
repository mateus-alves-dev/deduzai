// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cnpj_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CnpjInfo {

 String get cnpj; String get razaoSocial; int get cnaeFiscal; String get cnaeFiscalDescricao; String? get nomeFantasia;
/// Create a copy of CnpjInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CnpjInfoCopyWith<CnpjInfo> get copyWith => _$CnpjInfoCopyWithImpl<CnpjInfo>(this as CnpjInfo, _$identity);

  /// Serializes this CnpjInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CnpjInfo&&(identical(other.cnpj, cnpj) || other.cnpj == cnpj)&&(identical(other.razaoSocial, razaoSocial) || other.razaoSocial == razaoSocial)&&(identical(other.cnaeFiscal, cnaeFiscal) || other.cnaeFiscal == cnaeFiscal)&&(identical(other.cnaeFiscalDescricao, cnaeFiscalDescricao) || other.cnaeFiscalDescricao == cnaeFiscalDescricao)&&(identical(other.nomeFantasia, nomeFantasia) || other.nomeFantasia == nomeFantasia));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cnpj,razaoSocial,cnaeFiscal,cnaeFiscalDescricao,nomeFantasia);

@override
String toString() {
  return 'CnpjInfo(cnpj: $cnpj, razaoSocial: $razaoSocial, cnaeFiscal: $cnaeFiscal, cnaeFiscalDescricao: $cnaeFiscalDescricao, nomeFantasia: $nomeFantasia)';
}


}

/// @nodoc
abstract mixin class $CnpjInfoCopyWith<$Res>  {
  factory $CnpjInfoCopyWith(CnpjInfo value, $Res Function(CnpjInfo) _then) = _$CnpjInfoCopyWithImpl;
@useResult
$Res call({
 String cnpj, String razaoSocial, int cnaeFiscal, String cnaeFiscalDescricao, String? nomeFantasia
});




}
/// @nodoc
class _$CnpjInfoCopyWithImpl<$Res>
    implements $CnpjInfoCopyWith<$Res> {
  _$CnpjInfoCopyWithImpl(this._self, this._then);

  final CnpjInfo _self;
  final $Res Function(CnpjInfo) _then;

/// Create a copy of CnpjInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cnpj = null,Object? razaoSocial = null,Object? cnaeFiscal = null,Object? cnaeFiscalDescricao = null,Object? nomeFantasia = freezed,}) {
  return _then(_self.copyWith(
cnpj: null == cnpj ? _self.cnpj : cnpj // ignore: cast_nullable_to_non_nullable
as String,razaoSocial: null == razaoSocial ? _self.razaoSocial : razaoSocial // ignore: cast_nullable_to_non_nullable
as String,cnaeFiscal: null == cnaeFiscal ? _self.cnaeFiscal : cnaeFiscal // ignore: cast_nullable_to_non_nullable
as int,cnaeFiscalDescricao: null == cnaeFiscalDescricao ? _self.cnaeFiscalDescricao : cnaeFiscalDescricao // ignore: cast_nullable_to_non_nullable
as String,nomeFantasia: freezed == nomeFantasia ? _self.nomeFantasia : nomeFantasia // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CnpjInfo].
extension CnpjInfoPatterns on CnpjInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CnpjInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CnpjInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CnpjInfo value)  $default,){
final _that = this;
switch (_that) {
case _CnpjInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CnpjInfo value)?  $default,){
final _that = this;
switch (_that) {
case _CnpjInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String cnpj,  String razaoSocial,  int cnaeFiscal,  String cnaeFiscalDescricao,  String? nomeFantasia)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CnpjInfo() when $default != null:
return $default(_that.cnpj,_that.razaoSocial,_that.cnaeFiscal,_that.cnaeFiscalDescricao,_that.nomeFantasia);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String cnpj,  String razaoSocial,  int cnaeFiscal,  String cnaeFiscalDescricao,  String? nomeFantasia)  $default,) {final _that = this;
switch (_that) {
case _CnpjInfo():
return $default(_that.cnpj,_that.razaoSocial,_that.cnaeFiscal,_that.cnaeFiscalDescricao,_that.nomeFantasia);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String cnpj,  String razaoSocial,  int cnaeFiscal,  String cnaeFiscalDescricao,  String? nomeFantasia)?  $default,) {final _that = this;
switch (_that) {
case _CnpjInfo() when $default != null:
return $default(_that.cnpj,_that.razaoSocial,_that.cnaeFiscal,_that.cnaeFiscalDescricao,_that.nomeFantasia);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CnpjInfo implements CnpjInfo {
  const _CnpjInfo({required this.cnpj, required this.razaoSocial, required this.cnaeFiscal, required this.cnaeFiscalDescricao, this.nomeFantasia});
  factory _CnpjInfo.fromJson(Map<String, dynamic> json) => _$CnpjInfoFromJson(json);

@override final  String cnpj;
@override final  String razaoSocial;
@override final  int cnaeFiscal;
@override final  String cnaeFiscalDescricao;
@override final  String? nomeFantasia;

/// Create a copy of CnpjInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CnpjInfoCopyWith<_CnpjInfo> get copyWith => __$CnpjInfoCopyWithImpl<_CnpjInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CnpjInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CnpjInfo&&(identical(other.cnpj, cnpj) || other.cnpj == cnpj)&&(identical(other.razaoSocial, razaoSocial) || other.razaoSocial == razaoSocial)&&(identical(other.cnaeFiscal, cnaeFiscal) || other.cnaeFiscal == cnaeFiscal)&&(identical(other.cnaeFiscalDescricao, cnaeFiscalDescricao) || other.cnaeFiscalDescricao == cnaeFiscalDescricao)&&(identical(other.nomeFantasia, nomeFantasia) || other.nomeFantasia == nomeFantasia));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cnpj,razaoSocial,cnaeFiscal,cnaeFiscalDescricao,nomeFantasia);

@override
String toString() {
  return 'CnpjInfo(cnpj: $cnpj, razaoSocial: $razaoSocial, cnaeFiscal: $cnaeFiscal, cnaeFiscalDescricao: $cnaeFiscalDescricao, nomeFantasia: $nomeFantasia)';
}


}

/// @nodoc
abstract mixin class _$CnpjInfoCopyWith<$Res> implements $CnpjInfoCopyWith<$Res> {
  factory _$CnpjInfoCopyWith(_CnpjInfo value, $Res Function(_CnpjInfo) _then) = __$CnpjInfoCopyWithImpl;
@override @useResult
$Res call({
 String cnpj, String razaoSocial, int cnaeFiscal, String cnaeFiscalDescricao, String? nomeFantasia
});




}
/// @nodoc
class __$CnpjInfoCopyWithImpl<$Res>
    implements _$CnpjInfoCopyWith<$Res> {
  __$CnpjInfoCopyWithImpl(this._self, this._then);

  final _CnpjInfo _self;
  final $Res Function(_CnpjInfo) _then;

/// Create a copy of CnpjInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cnpj = null,Object? razaoSocial = null,Object? cnaeFiscal = null,Object? cnaeFiscalDescricao = null,Object? nomeFantasia = freezed,}) {
  return _then(_CnpjInfo(
cnpj: null == cnpj ? _self.cnpj : cnpj // ignore: cast_nullable_to_non_nullable
as String,razaoSocial: null == razaoSocial ? _self.razaoSocial : razaoSocial // ignore: cast_nullable_to_non_nullable
as String,cnaeFiscal: null == cnaeFiscal ? _self.cnaeFiscal : cnaeFiscal // ignore: cast_nullable_to_non_nullable
as int,cnaeFiscalDescricao: null == cnaeFiscalDescricao ? _self.cnaeFiscalDescricao : cnaeFiscalDescricao // ignore: cast_nullable_to_non_nullable
as String,nomeFantasia: freezed == nomeFantasia ? _self.nomeFantasia : nomeFantasia // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
