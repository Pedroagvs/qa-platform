import 'dart:typed_data';

class ArquivoDto {
  int idArquivo;
  String nome;
  Uint8List? bytes;
  ArquivoDto({
    required this.idArquivo,
    required this.nome,
    required this.bytes,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': idArquivo,
      'nome': nome,
      'bytes': bytes,
    };
  }

  factory ArquivoDto.fromJson(Map<String, dynamic> map) {
    return ArquivoDto(
      idArquivo: int.parse(map['idArquivo']),
      nome: map['nome'] as String,
      bytes: map['bytes'],
    );
  }
}
