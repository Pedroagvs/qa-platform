import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:back_end/app/api/api.dart';
import 'package:back_end/server/adapter/shelf_adapter.dart';
import 'package:back_end/server/middlewares/cors.dart';
import 'package:back_end/server/middlewares/log_middleware.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_static/shelf_static.dart';
part 'response/response_json.dart';

class Server {
  static Future<HttpServer> bootStrap(
    List<Controller> controllers,
  ) async {
    final staticHandler = createStaticHandler(
      '${Directory.current.path}/app/build/web',
      serveFilesOutsidePath: true,
      useHeaderBytesForContentType: true,
      listDirectories: true,
      defaultDocument: 'index.html',
    );

    final router = ShelfAdapter(controllers: controllers).handler()
      ..mount('/', staticHandler);
    final handler = const Pipeline()
        .addMiddleware(corsMiddleware())
        .addMiddleware(logMiddleware())
        .addHandler(router);
    return shelf_io.serve(handler, '127.0.0.1', 8000);
  }
}
