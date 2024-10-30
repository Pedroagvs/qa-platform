import 'dart:convert';
import 'dart:typed_data';

class UserDto {
  String name;
  String email;
  String cargo;
  int? id;
  Uint8List? thumbnail;
  List<String> funcionalidades;
  UserDto({
    required this.name,
    this.funcionalidades = const [],
    this.email = '',
    this.id,
    this.thumbnail,
    this.cargo = '',
  });
  factory UserDto.empty() {
    return UserDto(
      name: '',
    );
  }
  Map<String, dynamic> toJson() {
    if (email.isEmpty) {
      return {
        'nome': name,
        'id': id,
      };
    }
    return {
      'nome': name,
      'email': email,
      'id': id,
      'thumbnail': thumbnail,
      'cargo': cargo,
      'funcionalidades': funcionalidades,
    };
  }

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      name: json['nome'] ?? '',
      email: json['email'] ?? '',
      cargo: json['cargo'] ?? '',
      funcionalidades: json['funcionalidades'] != null
          ? (json['funcionalidades'] as String).trim().split(',')
          : <String>[],
      id: json['id'] != null ? int.parse(json['id']) : null,
      thumbnail: json['thumbnail'] != null
          ? Uint8List.fromList(jsonDecode(json['thumbnail']).cast<int>())
          : null,
    );
  }

  factory UserDto.fromJsonLessInformation(Map<String, dynamic> json) {
    return UserDto(
      name: json['nome'] ?? '',
      id: json['id'] != null ? int.parse(json['id']) : null,
      thumbnail: json['thumbnail'] != null
          ? Uint8List.fromList(jsonDecode(json['thumbnail']).cast<int>())
          : null,
    );
  }
}
