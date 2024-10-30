import 'dart:typed_data';

import 'package:quality_assurance_platform/core/common/data/dtos/user_dto.dart';
import 'package:quality_assurance_platform/core/failure/failure.dart';

abstract class UsersUseCase {
  Future<({Failure? failure, List<UserDto>? users})> getUsers();
  Future<({Failure? failure, bool? success})> setThumbnail({
    required Uint8List bytes,
    required int idUser,
  });
}
