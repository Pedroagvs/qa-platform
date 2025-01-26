import 'dart:convert';
import 'dart:developer';

import 'package:back_end/app/api/api.dart';
import 'package:back_end/app/domain/exceptions/common/common_exceptions.dart';
import 'package:back_end/server/server.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_multipart/shelf_multipart.dart';
import 'package:shelf_router/shelf_router.dart';

class ShelfAdapter {
  final List<Controller> controllers;
  ShelfAdapter({required this.controllers});
  Router handler() {
    final router = Router();
    for (final controller in controllers) {
      _handler(controller, router);
    }
    return router;
  }

  void _handler(Controller controller, Router router) {
    try {
      final route = controller.route;
      final handlers = controller.handler;
      for (final handler in handlers.entries) {
        final verbAndPath = handler.key.split(' ');
        final verb = verbAndPath[0];
        final path = verbAndPath.length > 1
            ? verbAndPath[1]
                .replaceAllMapped('{', (match) => '<')
                .replaceAllMapped('}', (match) => '>')
            : '';
        router.add(verb, route.replaceAll(' ', '') + path,
            (Request request) async {
          late final Map<String, dynamic> body;
          if (MultipartRequest.of(request) != null) {
            body = {'formdata': await getParamsMultPartFile(request)};
          } else {
            if (request.requestedUri.queryParameters.isNotEmpty) {
              body = request.requestedUri.queryParameters;
            } else {
              final tmp = await request.readAsString();
              body = tmp.isNotEmpty ? jsonDecode(tmp) : {};
            }
          }
          final responseHandler = await handler.value(
            requestParams: RequestParams(
              body: body,
            ),
          );
          return getResponse(responseHandler);
        });
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}

Future<Map<String, Map<String, String>>> getParamsMultPartFile(
  Request request,
) async {
  final params = <String, Map<String, String>>{
    'dados': {},
    'arquivos': {},
  };

  final multipart = request.multipart();
  if (multipart != null) {
    await for (final part in multipart.parts) {
      final contentDisposition = part.headers['content-disposition'];

      final partName = _getPartNameFromContentDisposition(contentDisposition);

      if (contentDisposition != null &&
          contentDisposition.contains('filename')) {
        final bytes = await part.readBytes();
        final filename = _getFilenameFromContentDisposition(contentDisposition);

        params['arquivos']!.addEntries(
          {
            filename: jsonEncode(bytes),
          }.entries,
        );
      } else {
        // Para outros campos de dados
        final content = await part.readString();
        params['dados']!.addEntries(
          {
            partName: content,
          }.entries,
        );
      }
    }
  } else {
    throw Failure('Request não é do tipo multipart', StackTrace.current);
  }

  return params;
}

/// Função auxiliar para extrair o nome da parte do cabeçalho `content-disposition`.
String _getPartNameFromContentDisposition(String? contentDisposition) {
  final dispositionRegex = RegExp('form-data; name="([^"]+)"');
  final match = dispositionRegex.firstMatch(contentDisposition ?? '');
  if (match != null && match.groupCount > 0) {
    return match.group(1)!;
  }
  throw Failure('Nome da parte não encontrado', StackTrace.current);
}

/// Função auxiliar para extrair o nome do arquivo do cabeçalho `content-disposition`.
String _getFilenameFromContentDisposition(String contentDisposition) {
  final filenameRegex = RegExp('filename="([^"]+)"');
  final match = filenameRegex.firstMatch(contentDisposition);
  if (match != null && match.groupCount > 0) {
    return match.group(1)!;
  }
  throw Failure('Nome do arquivo não encontrado', StackTrace.current);
}

Response getResponse(ResponseHandler responseHandler) {
  switch (responseHandler.statusHandler) {
    case StatusHandler.ok:
      return ResponseJSON.ok(responseHandler.body);
    case StatusHandler.internalError:
      return ResponseJSON.internalError(responseHandler.body);
    case StatusHandler.badRequest:
      return ResponseJSON.badRequest(responseHandler.body);
    case StatusHandler.created:
      return ResponseJSON.created(responseHandler.body);
    case StatusHandler.forbidden:
      return ResponseJSON.forbidden(responseHandler.body);
  }
}
