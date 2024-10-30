import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DownloadService {
  static Future<String> create(String nameFile, List<int> bytes) async {
    final dir = await getDownloadsDirectory();
    final file = await File('${dir!.path}/$nameFile').create(exclusive: true);
    await file.writeAsBytes(bytes);
    return file.path;
  }
}
