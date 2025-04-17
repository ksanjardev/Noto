import 'package:freezed_annotation/freezed_annotation.dart';

part 'notedata.freezed.dart';
part 'notedata.g.dart';

@freezed
abstract class NoteData with _$NoteData {
  const factory NoteData(String id, String title, String description, DateTime time) =
      _NoteData;

  factory NoteData.fromJson(Map<String, dynamic> json) =>
      _$NoteDataFromJson(json);
}
