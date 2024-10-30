// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

class ArquivoEntity {
  final int id;
  final String path;
  final String nome;
  Uint8List? bytes;
  ArquivoEntity({
    this.id = -1,
    required this.path,
    required this.nome,
    this.bytes,
  });

  @override
  String toString() {
    return 'ArquivoEntity(id: $id, path: $path, nome: $nome, bytes: $bytes)';
  }
}
