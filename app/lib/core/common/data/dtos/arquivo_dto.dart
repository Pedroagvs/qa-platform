import 'package:quality_assurance_platform/core/common/domain/entities/arquivo_entity.dart';

class ArquivoDto extends ArquivoEntity {
  ArquivoDto({
    super.id,
    required super.path,
    required super.nome,
    super.bytes,
  });

  factory ArquivoDto.fromJson(Map<String, dynamic> json) {
    return ArquivoDto(
      id: json['id'] ?? -1,
      path: json['path'] ?? '',
      nome: json['nome'] ?? '',
      bytes: json['bytes'],
    );
  }
  factory ArquivoDto.empty() {
    return ArquivoDto(path: '', nome: '');
  }
}
