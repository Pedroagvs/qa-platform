part of data;

class AplicationService implements AplicationUseCase {
  final AplicationGateway aplicationGateway;
  AplicationService({
    required this.aplicationGateway,
  });

  @override
  Future<bool> create({
    required RequestParams requestParams,
  }) async {
    final exists = await aplicationGateway.checkExistsApplication(
      requestParams: requestParams,
    );
    if (exists) {
      return false;
    }
    return aplicationGateway.create(requestParams: requestParams);
  }

  @override
  Future<bool> delete({
    required RequestParams requestParams,
  }) async =>
      aplicationGateway.delete(requestParams: requestParams);

  @override
  Future<List<AplicationDto>> get() async => aplicationGateway.get();

  @override
  Future<bool> update({required RequestParams requestParams}) async =>
      aplicationGateway.update(requestParams: requestParams);
}
