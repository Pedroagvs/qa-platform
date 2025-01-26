part of data;

class TestService implements TestUseCase {
  final TestGateWay testGateWay;
  TestService({
    required this.testGateWay,
  });
  @override
  Future<bool> create({required RequestParams requestParams}) async =>
      testGateWay.create(requestParams: requestParams);

  @override
  Future<bool> delete({required RequestParams requestParams}) async =>
      testGateWay.delete(requestParams: requestParams);

  @override
  Future<List<TestDto>> get({required RequestParams requestParams}) async =>
      testGateWay.get(requestParams: requestParams);

  @override
  Future<bool> update({required RequestParams requestParams}) async =>
      testGateWay.update(requestParams: requestParams);

  @override
  Future<Uint8List> downloadFile({
    required RequestParams requestParams,
  }) async =>
      testGateWay.downloadFile(requestParams: requestParams);

  @override
  Future<bool> uploadFile({
    required RequestParams requestParams,
  }) async {
    return testGateWay.uploadFile(
      requestParams: requestParams,
    );
  }

  @override
  Future<bool> deleteFile({required RequestParams requestParams}) async {
    return testGateWay.deleteFile(
      requestParams: requestParams,
    );
  }
}
