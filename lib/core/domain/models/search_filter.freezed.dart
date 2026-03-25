// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SearchFilter {

 String get query; List<DeductionCategory> get categories; DateTime? get dateFrom; DateTime? get dateTo; int? get amountMinCents; int? get amountMaxCents; SearchReceiptFilter get receiptFilter; SearchSortOrder get sortOrder;
/// Create a copy of SearchFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchFilterCopyWith<SearchFilter> get copyWith => _$SearchFilterCopyWithImpl<SearchFilter>(this as SearchFilter, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchFilter&&(identical(other.query, query) || other.query == query)&&const DeepCollectionEquality().equals(other.categories, categories)&&(identical(other.dateFrom, dateFrom) || other.dateFrom == dateFrom)&&(identical(other.dateTo, dateTo) || other.dateTo == dateTo)&&(identical(other.amountMinCents, amountMinCents) || other.amountMinCents == amountMinCents)&&(identical(other.amountMaxCents, amountMaxCents) || other.amountMaxCents == amountMaxCents)&&(identical(other.receiptFilter, receiptFilter) || other.receiptFilter == receiptFilter)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}


@override
int get hashCode => Object.hash(runtimeType,query,const DeepCollectionEquality().hash(categories),dateFrom,dateTo,amountMinCents,amountMaxCents,receiptFilter,sortOrder);

@override
String toString() {
  return 'SearchFilter(query: $query, categories: $categories, dateFrom: $dateFrom, dateTo: $dateTo, amountMinCents: $amountMinCents, amountMaxCents: $amountMaxCents, receiptFilter: $receiptFilter, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class $SearchFilterCopyWith<$Res>  {
  factory $SearchFilterCopyWith(SearchFilter value, $Res Function(SearchFilter) _then) = _$SearchFilterCopyWithImpl;
@useResult
$Res call({
 String query, List<DeductionCategory> categories, DateTime? dateFrom, DateTime? dateTo, int? amountMinCents, int? amountMaxCents, SearchReceiptFilter receiptFilter, SearchSortOrder sortOrder
});




}
/// @nodoc
class _$SearchFilterCopyWithImpl<$Res>
    implements $SearchFilterCopyWith<$Res> {
  _$SearchFilterCopyWithImpl(this._self, this._then);

  final SearchFilter _self;
  final $Res Function(SearchFilter) _then;

/// Create a copy of SearchFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? query = null,Object? categories = null,Object? dateFrom = freezed,Object? dateTo = freezed,Object? amountMinCents = freezed,Object? amountMaxCents = freezed,Object? receiptFilter = null,Object? sortOrder = null,}) {
  return _then(_self.copyWith(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<DeductionCategory>,dateFrom: freezed == dateFrom ? _self.dateFrom : dateFrom // ignore: cast_nullable_to_non_nullable
as DateTime?,dateTo: freezed == dateTo ? _self.dateTo : dateTo // ignore: cast_nullable_to_non_nullable
as DateTime?,amountMinCents: freezed == amountMinCents ? _self.amountMinCents : amountMinCents // ignore: cast_nullable_to_non_nullable
as int?,amountMaxCents: freezed == amountMaxCents ? _self.amountMaxCents : amountMaxCents // ignore: cast_nullable_to_non_nullable
as int?,receiptFilter: null == receiptFilter ? _self.receiptFilter : receiptFilter // ignore: cast_nullable_to_non_nullable
as SearchReceiptFilter,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as SearchSortOrder,
  ));
}

}


/// Adds pattern-matching-related methods to [SearchFilter].
extension SearchFilterPatterns on SearchFilter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchFilter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchFilter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchFilter value)  $default,){
final _that = this;
switch (_that) {
case _SearchFilter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchFilter value)?  $default,){
final _that = this;
switch (_that) {
case _SearchFilter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String query,  List<DeductionCategory> categories,  DateTime? dateFrom,  DateTime? dateTo,  int? amountMinCents,  int? amountMaxCents,  SearchReceiptFilter receiptFilter,  SearchSortOrder sortOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchFilter() when $default != null:
return $default(_that.query,_that.categories,_that.dateFrom,_that.dateTo,_that.amountMinCents,_that.amountMaxCents,_that.receiptFilter,_that.sortOrder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String query,  List<DeductionCategory> categories,  DateTime? dateFrom,  DateTime? dateTo,  int? amountMinCents,  int? amountMaxCents,  SearchReceiptFilter receiptFilter,  SearchSortOrder sortOrder)  $default,) {final _that = this;
switch (_that) {
case _SearchFilter():
return $default(_that.query,_that.categories,_that.dateFrom,_that.dateTo,_that.amountMinCents,_that.amountMaxCents,_that.receiptFilter,_that.sortOrder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String query,  List<DeductionCategory> categories,  DateTime? dateFrom,  DateTime? dateTo,  int? amountMinCents,  int? amountMaxCents,  SearchReceiptFilter receiptFilter,  SearchSortOrder sortOrder)?  $default,) {final _that = this;
switch (_that) {
case _SearchFilter() when $default != null:
return $default(_that.query,_that.categories,_that.dateFrom,_that.dateTo,_that.amountMinCents,_that.amountMaxCents,_that.receiptFilter,_that.sortOrder);case _:
  return null;

}
}

}

/// @nodoc


class _SearchFilter extends SearchFilter {
  const _SearchFilter({this.query = '', final  List<DeductionCategory> categories = const [], this.dateFrom, this.dateTo, this.amountMinCents, this.amountMaxCents, this.receiptFilter = SearchReceiptFilter.all, this.sortOrder = SearchSortOrder.dateDesc}): _categories = categories,super._();
  

@override@JsonKey() final  String query;
 final  List<DeductionCategory> _categories;
@override@JsonKey() List<DeductionCategory> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

@override final  DateTime? dateFrom;
@override final  DateTime? dateTo;
@override final  int? amountMinCents;
@override final  int? amountMaxCents;
@override@JsonKey() final  SearchReceiptFilter receiptFilter;
@override@JsonKey() final  SearchSortOrder sortOrder;

/// Create a copy of SearchFilter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchFilterCopyWith<_SearchFilter> get copyWith => __$SearchFilterCopyWithImpl<_SearchFilter>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchFilter&&(identical(other.query, query) || other.query == query)&&const DeepCollectionEquality().equals(other._categories, _categories)&&(identical(other.dateFrom, dateFrom) || other.dateFrom == dateFrom)&&(identical(other.dateTo, dateTo) || other.dateTo == dateTo)&&(identical(other.amountMinCents, amountMinCents) || other.amountMinCents == amountMinCents)&&(identical(other.amountMaxCents, amountMaxCents) || other.amountMaxCents == amountMaxCents)&&(identical(other.receiptFilter, receiptFilter) || other.receiptFilter == receiptFilter)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}


@override
int get hashCode => Object.hash(runtimeType,query,const DeepCollectionEquality().hash(_categories),dateFrom,dateTo,amountMinCents,amountMaxCents,receiptFilter,sortOrder);

@override
String toString() {
  return 'SearchFilter(query: $query, categories: $categories, dateFrom: $dateFrom, dateTo: $dateTo, amountMinCents: $amountMinCents, amountMaxCents: $amountMaxCents, receiptFilter: $receiptFilter, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class _$SearchFilterCopyWith<$Res> implements $SearchFilterCopyWith<$Res> {
  factory _$SearchFilterCopyWith(_SearchFilter value, $Res Function(_SearchFilter) _then) = __$SearchFilterCopyWithImpl;
@override @useResult
$Res call({
 String query, List<DeductionCategory> categories, DateTime? dateFrom, DateTime? dateTo, int? amountMinCents, int? amountMaxCents, SearchReceiptFilter receiptFilter, SearchSortOrder sortOrder
});




}
/// @nodoc
class __$SearchFilterCopyWithImpl<$Res>
    implements _$SearchFilterCopyWith<$Res> {
  __$SearchFilterCopyWithImpl(this._self, this._then);

  final _SearchFilter _self;
  final $Res Function(_SearchFilter) _then;

/// Create a copy of SearchFilter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? query = null,Object? categories = null,Object? dateFrom = freezed,Object? dateTo = freezed,Object? amountMinCents = freezed,Object? amountMaxCents = freezed,Object? receiptFilter = null,Object? sortOrder = null,}) {
  return _then(_SearchFilter(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<DeductionCategory>,dateFrom: freezed == dateFrom ? _self.dateFrom : dateFrom // ignore: cast_nullable_to_non_nullable
as DateTime?,dateTo: freezed == dateTo ? _self.dateTo : dateTo // ignore: cast_nullable_to_non_nullable
as DateTime?,amountMinCents: freezed == amountMinCents ? _self.amountMinCents : amountMinCents // ignore: cast_nullable_to_non_nullable
as int?,amountMaxCents: freezed == amountMaxCents ? _self.amountMaxCents : amountMaxCents // ignore: cast_nullable_to_non_nullable
as int?,receiptFilter: null == receiptFilter ? _self.receiptFilter : receiptFilter // ignore: cast_nullable_to_non_nullable
as SearchReceiptFilter,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as SearchSortOrder,
  ));
}


}

// dart format on
