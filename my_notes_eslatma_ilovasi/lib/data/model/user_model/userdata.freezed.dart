// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'userdata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserData {
  String get name;
  String get password;
  List<NoteData> get notes;

  /// Create a copy of UserData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UserDataCopyWith<UserData> get copyWith =>
      _$UserDataCopyWithImpl<UserData>(this as UserData, _$identity);

  /// Serializes this UserData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UserData &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.password, password) ||
                other.password == password) &&
            const DeepCollectionEquality().equals(other.notes, notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, name, password, const DeepCollectionEquality().hash(notes));

  @override
  String toString() {
    return 'UserData(name: $name, password: $password, notes: $notes)';
  }
}

/// @nodoc
abstract mixin class $UserDataCopyWith<$Res> {
  factory $UserDataCopyWith(UserData value, $Res Function(UserData) _then) =
      _$UserDataCopyWithImpl;
  @useResult
  $Res call({String name, String password, List<NoteData> notes});
}

/// @nodoc
class _$UserDataCopyWithImpl<$Res> implements $UserDataCopyWith<$Res> {
  _$UserDataCopyWithImpl(this._self, this._then);

  final UserData _self;
  final $Res Function(UserData) _then;

  /// Create a copy of UserData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? password = null,
    Object? notes = null,
  }) {
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _self.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      notes: null == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as List<NoteData>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _UserData implements UserData {
  const _UserData(this.name, this.password, final List<NoteData> notes)
      : _notes = notes;
  factory _UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  @override
  final String name;
  @override
  final String password;
  final List<NoteData> _notes;
  @override
  List<NoteData> get notes {
    if (_notes is EqualUnmodifiableListView) return _notes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_notes);
  }

  /// Create a copy of UserData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UserDataCopyWith<_UserData> get copyWith =>
      __$UserDataCopyWithImpl<_UserData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UserDataToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserData &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.password, password) ||
                other.password == password) &&
            const DeepCollectionEquality().equals(other._notes, _notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, name, password, const DeepCollectionEquality().hash(_notes));

  @override
  String toString() {
    return 'UserData(name: $name, password: $password, notes: $notes)';
  }
}

/// @nodoc
abstract mixin class _$UserDataCopyWith<$Res>
    implements $UserDataCopyWith<$Res> {
  factory _$UserDataCopyWith(_UserData value, $Res Function(_UserData) _then) =
      __$UserDataCopyWithImpl;
  @override
  @useResult
  $Res call({String name, String password, List<NoteData> notes});
}

/// @nodoc
class __$UserDataCopyWithImpl<$Res> implements _$UserDataCopyWith<$Res> {
  __$UserDataCopyWithImpl(this._self, this._then);

  final _UserData _self;
  final $Res Function(_UserData) _then;

  /// Create a copy of UserData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? password = null,
    Object? notes = null,
  }) {
    return _then(_UserData(
      null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      null == password
          ? _self.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      null == notes
          ? _self._notes
          : notes // ignore: cast_nullable_to_non_nullable
              as List<NoteData>,
    ));
  }
}

// dart format on
