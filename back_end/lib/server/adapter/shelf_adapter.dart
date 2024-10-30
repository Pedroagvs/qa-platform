import 'dart:convert';
import 'dart:developer';

import 'package:back_end/app/api/api.dart';
import 'package:back_end/app/domain/exceptions/common/common_exceptions.dart';
import 'package:back_end/server/server.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_multipart/form_data.dart';
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
          if (request.isMultipartForm) {
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
  await for (final formData in request.multipartFormData) {
    if (formData.name.contains('arquivo')) {
      if (formData.filename == null) {
        throw Failure('Arquivo sem nome', StackTrace.current);
      }
      params['arquivos']!.addEntries(
        {
          formData.filename!: jsonEncode(await formData.part.readBytes()),
        }.entries,
      );
    } else {
      params['dados']!.addEntries(
        {formData.name: await formData.part.readString()}.entries,
      );
    }
  }
  return params;
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
