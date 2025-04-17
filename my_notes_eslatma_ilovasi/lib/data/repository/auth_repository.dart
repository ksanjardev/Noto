import 'package:my_notes_eslatma_ilovasi/utils/response_enum.dart';

abstract class AuthRepository {
  Future<ResponseEnum> login(String userName, String password);

  Future<ResponseEnum> register(String userName, String password);
}
