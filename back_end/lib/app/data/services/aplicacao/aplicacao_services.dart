part of data;

class AplicacaoService implements AplicacaoUseCase {
  final AplicacaoGateway aplicacaoGateway;
  AplicacaoService({
    required this.aplicacaoGateway,
  });

  @override
  Future<bool> create({
    required RequestParams requestParams,
  }) async {
    final exists = await aplicacaoGateway.checkExistsApplication(
      requestParams: requestParams,
    );
    if (exists) {
      return false;
    }
    return aplicacaoGateway.create(requestParams: requestParams);
  }

  @override
  Future<bool> delete({
    required RequestParams requestParams,
  }) async =>
      aplicacaoGateway.delete(requestParams: requestParams);

  @override
  Future<List<AplicacaoDto>> get() async => aplicacaoGateway.get();

  @override
  Future<bool> update({required RequestParams requestParams}) async =>
      aplicacaoGateway.update(requestParams: requestParams);
}
