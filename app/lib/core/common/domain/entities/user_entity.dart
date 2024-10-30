import 'dart:typed_data';

class UserEntity {
  final int id;
  final String name;
  final String email;
  final String cargo;
  final List<String> funcionalidades;
  Uint8List? thumbnail;
  UserEntity({
    required this.name,
    required this.email,
    required this.cargo,
    required this.funcionalidades,
    required this.id,
    required this.thumbnail,
  });
}
