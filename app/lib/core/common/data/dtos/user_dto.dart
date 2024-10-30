import 'dart:typed_data';

import 'package:quality_assurance_platform/core/common/domain/entities/user_entity.dart';

class UserDto extends UserEntity {
  UserDto({
    required super.name,
    required super.email,
    required super.id,
    super.thumbnail,
    required super.cargo,
    required super.funcionalidades,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      name: json['nome'] ?? '',
      email: json['email'] ?? '',
      id: json['id'] ?? -1,
      thumbnail: json['thumbnail'] != null
          ? Uint8List.fromList(json['thumbnail'].cast<int>())
          : null,
      cargo: json['cargo'] ?? '',
      funcionalidades: json['funcionalidades'].cast<String>() ?? [],
    );
  }
  static Map<String, dynamic> toJson(UserEntity user) {
    return {
      'nome': user.name,
      'email': user.email,
      'id': user.id,
      'thumbnail': user.thumbnail,
      'cargo': user.cargo,
      'funcionalidades': user.funcionalidades,
    };
  }

  factory UserDto.empty() {
    return UserDto(
      name: '',
      email: '',
      id: -1,
      cargo: '',
      funcionalidades: [],
    );
  }
}
