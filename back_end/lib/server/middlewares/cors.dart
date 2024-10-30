import 'dart:developer';

import 'package:back_end/app/domain/exceptions/common/common_exceptions.dart';
import 'package:shelf/shelf.dart';

Middleware corsMiddleware() {
  return createMiddleware(
    responseHandler: (response) {
      return response.change(
        headers: {
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Methods': '*',
          'Access-Control-Allow-Headers': '*',
          ...response.headers,
        },
      );
    },
    requestHandler: (request) {
      if (request.method.toUpperCase() == 'OPTIONS') {
        return Response.ok(
          null,
          headers: {
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': '*',
            'Access-Control-Allow-Headers': '*',
            ...request.headers,
          },
        );
      } else {
        return null;
      }
    },
    errorHandler: (error, stackTrace) async {
      log(error.toString(), stackTrace: stackTrace);
      return Response.badRequest();
    },
  );
}
