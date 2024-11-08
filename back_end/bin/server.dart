import 'dart:developer';
import 'dart:io';
import 'package:back_end/app/infra/infra.dart';
import 'package:back_end/app/injects/injects_container.dart';
import 'package:back_end/config/config.dart';
import 'package:back_end/server/server.dart';

void main(List<String> arguments) async {
  for (final arg in arguments) {
    log(arg);
  }
  await injectInit();
  final server = await init();

  log(name: 'Server', 'http://${server.address.host}:${server.port}/');
  // withHotreload(init);
}

Future<HttpServer> init() async {
  await getIt.get<Connection>().initConnection();
  final httpServer = await Server.bootStrap(controllers);
  return httpServer;
}
