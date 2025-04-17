import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_notes_eslatma_ilovasi/data/model/note_model/notedata.dart';

part 'userdata.freezed.dart';
part 'userdata.g.dart';

@freezed
abstract class UserData with _$UserData {
  const factory UserData(String name, String password, List<NoteData> notes) =
      _UserData;

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);
}
