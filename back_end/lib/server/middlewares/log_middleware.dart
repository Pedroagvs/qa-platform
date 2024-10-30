import 'dart:developer';

import 'package:shelf/shelf.dart';

Middleware logMiddleware() {
  return createMiddleware(
    requestHandler: (p0) {
      logRequests(
        logger: (message, isError) {
          log(name: 'Log Server', message);
          log(name: 'Headers', p0.headers.toString());
        },
      );
      return null;
    },
  );
}
