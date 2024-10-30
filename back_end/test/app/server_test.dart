import 'dart:io';

import 'package:test/test.dart';

void main() {
  const port = '8080';
  //const host = 'localhost';
  late final Process p;
  setUp(() async {
    p = await Process.start(
      'dart',
      ['run', 'bin/back_end.dart'],
      environment: {'PORT': port},
    );
    await p.stdout.first;
  });
  tearDown(() => p.kill());
  group('Server ->', () {
    test('Deve conter content-type "aplication/json" ', () async {
      //  final result =
    });
  });
}
