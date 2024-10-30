import 'dart:typed_data';

import 'package:quality_assurance_platform/core/common/data/dtos/user_dto.dart';

abstract class UsersDataSource {
  Future<List<UserDto>> getUsers();
  Future<bool> setThumbnail({
    required Uint8List bytes,
    required int idUser,
  });
}
