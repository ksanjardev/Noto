// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notedata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NoteData {
  String get id;
  String get title;
  String get description;
  DateTime get time;

  /// Create a copy of NoteData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NoteDataCopyWith<NoteData> get copyWith =>
      _$NoteDataCopyWithImpl<NoteData>(this as NoteData, _$identity);

  /// Serializes this NoteData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NoteData &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.time, time) || other.time == time));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, description, time);

  @override
  String toString() {
    return 'NoteData(id: $id, title: $title, description: $description, time: $time)';
  }
}

/// @nodoc
abstract mixin class $NoteDataCopyWith<$Res> {
  factory $NoteDataCopyWith(NoteData value, $Res Function(NoteData) _then) =
      _$NoteDataCopyWithImpl;
  @useResult
  $Res call({String id, String title, String description, DateTime time});
}

/// @nodoc
class _$NoteDataCopyWithImpl<$Res> implements $NoteDataCopyWith<$Res> {
  _$NoteDataCopyWithImpl(this._self, this._then);

  final NoteData _self;
  final $Res Function(NoteData) _then;

  /// Create a copy of NoteData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? time = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _self.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _NoteData implements NoteData {
  const _NoteData(this.id, this.title, this.description, this.time);
  factory _NoteData.fromJson(Map<String, dynamic> json) =>
      _$NoteDataFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final DateTime time;

  /// Create a copy of NoteData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NoteDataCopyWith<_NoteData> get copyWith =>
      __$NoteDataCopyWithImpl<_NoteData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$NoteDataToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NoteData &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.time, time) || other.time == time));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, description, time);

  @override
  String toString() {
    return 'NoteData(id: $id, title: $title, description: $description, time: $time)';
  }
}

/// @nodoc
abstract mixin class _$NoteDataCopyWith<$Res>
    implements $NoteDataCopyWith<$Res> {
  factory _$NoteDataCopyWith(_NoteData value, $Res Function(_NoteData) _then) =
      __$NoteDataCopyWithImpl;
  @override
  @useResult
  $Res call({String id, String title, String description, DateTime time});
}

/// @nodoc
class __$NoteDataCopyWithImpl<$Res> implements _$NoteDataCopyWith<$Res> {
  __$NoteDataCopyWithImpl(this._self, this._then);

  final _NoteData _self;
  final $Res Function(_NoteData) _then;

  /// Create a copy of NoteData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? time = null,
  }) {
    return _then(_NoteData(
      null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      null == time
          ? _self.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
