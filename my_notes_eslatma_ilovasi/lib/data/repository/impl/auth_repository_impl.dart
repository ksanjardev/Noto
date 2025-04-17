import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_notes_eslatma_ilovasi/data/local/local_storage.dart';
import 'package:my_notes_eslatma_ilovasi/utils/response_enum.dart';

import '../../model/user_model/userdata.dart';
import '../auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<ResponseEnum> login(String userName, String password) async {
    try {
      final querySnapshot = await firestore
          .collection("Users")
          .where("name", isEqualTo: userName)
          .get();
      if (querySnapshot.docs.isEmpty) {
        return ResponseEnum.USER_NOT_FOUND;
      }
      final userDoc = querySnapshot.docs.first;
      final userData = UserData.fromJson(userDoc.data());
      if (userData.password == password) {
        saveUserId(userName);
        saveFirstEnter(true);
        return ResponseEnum.USER_FOUND;
      } else {
        return ResponseEnum.PASSWORD_MISMATCH;
      }
    } catch (e) {
      print("Login error $e");
      return ResponseEnum.UNKNOWN;
    }
  }

  @override
  Future<ResponseEnum> register(String userName, String password) async {
    try {
      final querySnapshot = await firestore
          .collection("Users")
          .where("name", isEqualTo: userName)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        return ResponseEnum.USER_ALREADY_EXIST;
      }
      final userData = UserData(userName, password, []);
      await firestore.collection("Users").add(userData.toJson());
      saveUserId(userName);
      saveFirstEnter(true);
      return ResponseEnum.REGISTER_SUCCESS;
    } catch (e) {
      print("Register error $e");
      return ResponseEnum.UNKNOWN;
    }
  }
}
