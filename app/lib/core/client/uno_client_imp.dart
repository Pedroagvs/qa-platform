import 'dart:async';
import 'dart:developer';

import 'package:quality_assurance_platform/core/client/client.dart';
import 'package:quality_assurance_platform/core/failure/failure.dart';
import 'package:uno/uno.dart';

class ClientImp implements Client {
  final Uno uno;
  ClientImp({required this.uno});
  @override
  Future<Response> delete({
    required String path,
    required Map<String, dynamic> data,
    void Function(int, int)? onProgress,
    Duration? timeOut,
  }) async {
    try {
      log(
        name: 'Uno DELETE',
        '$path \n $data',
      );
      return await uno.delete(
        path,
        onDownloadProgress: onProgress,
        data: data,
        timeout: timeOut,
      );
    } on TimeoutException {
      throw Failure(
        errorMessage: 'Tempo esgotado, tente novamente.',
      );
    } catch (e, s) {
      throw Failure(
        errorMessage: e.toString(),
        stackTrace: s,
      );
    }
  }

  @override
  Future<Response> get({
    required String path,
    Map<String, String> params = const {},
    void Function(int, int)? onProgress,
    Duration? timeOut,
  }) async {
    try {
      log(
        name: 'Uno GET',
        '$path \n $params',
      );
      return await uno.get(
        path,
        params: params,
        onDownloadProgress: onProgress,
        timeout: timeOut,
      );
    } on UnoError catch (e, s) {
      if (e.response != null) {
        throw Failure(
          errorMessage: e.response!.data['mensagem'].toString(),
          stackTrace: e.response!.data['stackTrace'],
        );
      } else {
        throw Failure(
          errorMessage: e.toString(),
          stackTrace: s,
        );
      }
    } on TimeoutException {
      throw Failure(
        errorMessage: 'Tempo esgotado, tente novamente.',
      );
    } catch (e, s) {
      throw Failure(
        errorMessage: e.toString(),
        stackTrace: s,
      );
    }
  }

  @override
  Future<Response> post({
    required String path,
    required dynamic data,
    Duration? timeOut,
    Map<String, String> headers = const {},
    void Function(int, int)? onProgress,
  }) async {
    try {
      log(
        name: 'Uno POST',
        '$path \n $data',
      );
      return await uno.post(
        path,
        data: data,
        headers: headers,
        onDownloadProgress: onProgress,
        timeout: timeOut,
      );
    } on UnoError catch (e, s) {
      if (e.response != null) {
        throw Failure(
          errorMessage: e.response!.data['mensagem'].toString(),
          stackTrace: e.response!.data['stackTrace'],
        );
      } else {
        throw Failure(
          errorMessage: e.toString(),
          stackTrace: s,
        );
      }
    } on TimeoutException {
      throw Failure(
        errorMessage: 'Tempo esgotado, tente novamente.',
      );
    } catch (e, s) {
      throw Failure(
        errorMessage: e.toString(),
        stackTrace: s,
      );
    }
  }

  @override
  Future<Response> put({
    required String path,
    required dynamic data,
    Duration? timeOut,
    Map<String, String> headers = const {},
    void Function(int, int)? onProgress,
  }) async {
    try {
      log(
        name: 'Uno PUT',
        '$path \n $data',
      );
      return await uno.put(
        path,
        data: data,
        onDownloadProgress: onProgress,
        timeout: timeOut,
      );
    } on UnoError catch (e, s) {
      if (e.response != null) {
        throw Failure(
          errorMessage: e.response!.data['mensagem'].toString(),
          stackTrace: e.response!.data['stackTrace'],
        );
      } else {
        throw Failure(
          errorMessage: e.toString(),
          stackTrace: s,
        );
      }
    } on TimeoutException {
      throw Failure(
        errorMessage: 'Tempo esgotado, tente novamente.',
      );
    } catch (e, s) {
      throw Failure(
        errorMessage: e.toString(),
        stackTrace: s,
      );
    }
  }
}
