part of data;

class TesteService implements TesteUseCase {
  final TesteGateWay testeGateWay;
  TesteService({
    required this.testeGateWay,
  });
  @override
  Future<bool> create({required RequestParams requestParams}) async =>
      testeGateWay.create(requestParams: requestParams);

  @override
  Future<bool> delete({required RequestParams requestParams}) async =>
      testeGateWay.delete(requestParams: requestParams);

  @override
  Future<List<TesteDto>> get({required RequestParams requestParams}) async =>
      testeGateWay.get(requestParams: requestParams);

  @override
  Future<bool> update({required RequestParams requestParams}) async =>
      testeGateWay.update(requestParams: requestParams);

  @override
  Future<Uint8List> downloadFile({
    required RequestParams requestParams,
  }) async =>
      testeGateWay.downloadFile(requestParams: requestParams);

  @override
  Future<bool> uploadFile({
    required RequestParams requestParams,
  }) async {
    return testeGateWay.uploadFile(
      requestParams: requestParams,
    );
  }

  @override
  Future<bool> deleteFile({required RequestParams requestParams}) async {
    return testeGateWay.deleteFile(
      requestParams: requestParams,
    );
  }
}
