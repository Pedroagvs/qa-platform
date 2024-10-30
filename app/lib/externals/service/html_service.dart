import 'dart:typed_data';

import 'package:universal_html/html.dart' as html;

class HtmlService {
  static void donwloadFile(String nameFile, Uint8List bytes) {
    final url = html.Url.createObjectUrlFromBlob(html.Blob([bytes]));
    html.AnchorElement(
      href: url,
    )
      ..download = nameFile
      ..click()
      ..remove();
  }
}
