import 'package:file_picker/file_picker.dart';

class AnexarArquivosService {
  Future<List<Map<String, dynamic>>> buscarArquivos() async {
    final list = <Map<String, dynamic>>[];
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: true,
      allowedExtensions: ['jpg', 'pdf', 'doc', 'png', 'jpeg', 'mp4'],
    );

    if (result != null && result.files.isNotEmpty) {
      for (final file in result.files) {
        list.add(
          {
            'nome': file.name,
            'bytes': await file.xFile.readAsBytes(),
            'path': file.xFile.path,
          },
        );
      }
      return list;
    }
    return [];
  }

  Future<Map<String, dynamic>> buscarAquivo() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'ipa',
        'apk',
        'jpg',
        'pdf',
        'doc',
        'png',
        'jpeg',
        'pptx',
      ],
    );
    if (result != null) {
      return {
        'nome': result.files.first.xFile.name,
        'bytes': await result.files.first.xFile.readAsBytes(),
        'path': result.files.first.xFile.path,
      };
    }
    return {};
  }
}
