part of domain;

abstract class HistoricoUseCase {
  Future<List<HistoricoDto>> get({
    required RequestParams requestParams,
  });
  Future<bool> create({required RequestParams requestParams});
  Future<bool> delete({required RequestParams requestParams});
  Future<bool> update({required RequestParams requestParams});
  Future<bool> deleteFile({required RequestParams requestParams});
  Future<bool> uploadFile({required RequestParams requestParams});
  Future<Uint8List> downloadFile({
    required RequestParams requestParams,
  });
}