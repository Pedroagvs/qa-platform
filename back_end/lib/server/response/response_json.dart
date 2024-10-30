part of '../server.dart';

class ResponseJSON extends Response {
  ResponseJSON.ok(dynamic body)
      : super.ok(
          body is Map || body is Uint8List
              ? jsonEncode(body)
              : body is List
                  ? jsonEncode(body.map((e) => e.toJson()).toList())
                  : jsonEncode(body.toJson()),
        );
  ResponseJSON.internalError(dynamic body)
      : super.internalServerError(
          body: jsonEncode(body),
        );
  ResponseJSON.badRequest(dynamic body)
      : super.badRequest(
          body: jsonEncode(body),
        );

  ResponseJSON.created(dynamic body)
      : super.notFound(
          jsonEncode(body),
        );
  ResponseJSON.forbidden(dynamic body)
      : super.forbidden(
          jsonEncode(body),
        );
}
