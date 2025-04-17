// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userdata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserData _$UserDataFromJson(Map<String, dynamic> json) => _UserData(
      json['name'] as String,
      json['password'] as String,
      (json['notes'] as List<dynamic>)
          .map((e) => NoteData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserDataToJson(_UserData instance) => <String, dynamic>{
      'name': instance.name,
      'password': instance.password,
      'notes': instance.notes,
    };
