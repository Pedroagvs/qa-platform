import 'package:quality_assurance_platform/core/common/data/dtos/user_dto.dart';

abstract class AuthDataSource {
  Future<bool> createUserWithEmailAndPassword({
    required String nome,
    required String email,
    required String cargo,
    required String password,
  });
  Future<UserDto> signInWithEmailAndPassword({
    required String email,
    required String passWord,
  });
  Future<bool> changePassword({
    required String password,
    required String newPassword,
    required int idUser,
  });
}
