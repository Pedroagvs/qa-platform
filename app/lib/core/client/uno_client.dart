import 'package:uno/uno.dart';

abstract class UnoClient {
  Future<Response> get({
    required String path,
    Map<String, String> params = const {},
    void Function(int, int)? onProgress,
    Duration? timeOut,
  });
  Future<Response> post({
    required String path,
    required dynamic data,
    Duration? timeOut,
    void Function(int, int)? onProgress,
    Map<String, String> headers = const {},
  });
  Future<Response> delete({
    required String path,
    required Map<String, dynamic> data,
  });
  Future<Response> put({
    required String path,
    required dynamic data,
    Duration? timeOut,
    Map<String, String> headers = const {},
    void Function(int, int)? onProgress,
  });
}
