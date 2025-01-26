import 'dart:typed_data';

class FileDto {
  final int id;
  final String path;
  final String name;
  Uint8List? bytes;
  bool downloading;
  double progress;
  FileDto({
    required this.id,
    required this.path,
    required this.name,
    this.bytes,
    this.progress = 0.0,
    this.downloading = false,
  });

  factory FileDto.fromJson(Map<String, dynamic> json) {
    return FileDto(
      id: json['id'] ?? -1,
      path: json['path'] ?? '',
      name: json['nome'] ?? '',
      bytes: json['bytes'],
    );
  }
  factory FileDto.empty() {
    return FileDto(path: '', name: '', id: -1);
  }
}
