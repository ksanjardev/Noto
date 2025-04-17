// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notedata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NoteData _$NoteDataFromJson(Map<String, dynamic> json) => _NoteData(
      json['id'] as String,
      json['title'] as String,
      json['description'] as String,
      DateTime.parse(json['time'] as String),
    );

Map<String, dynamic> _$NoteDataToJson(_NoteData instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'time': instance.time.toIso8601String(),
    };
