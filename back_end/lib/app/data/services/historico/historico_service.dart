part of data;

class HistoricoService implements HistoricoUseCase {
  final HistoricGateway historicoGateway;
  final TesteGateWay testeGateWay;
  HistoricoService({
    required this.historicoGateway,
    required this.testeGateWay,
  });

  @override
  Future<bool> create({required RequestParams requestParams}) async =>
      historicoGateway.create(
        requestParams: requestParams,
      );

  @override
  Future<List<HistoricoDto>> get({
    required RequestParams requestParams,
  }) async {
    final historicos = await historicoGateway.get(
      requestParams: requestParams,
    );
    if (historicos.isNotEmpty) {
      for (final historico in historicos) {
        final listStatusTest = await historicoGateway.countTickets(
          requestParams: RequestParams(
            body: <String, dynamic>{'idHistorico': historico.id},
          ),
        );
        if (listStatusTest.isNotEmpty) {
          if (listStatusTest.length == 2) {
            historico
              ..openedTickets =
                  int.tryParse(listStatusTest[0]['QtdTickets']) ?? 0
              ..closedTickets =
                  int.tryParse(listStatusTest[1]['QtdTickets']) ?? 0;
          } else {
            historico
              ..openedTickets =
                  listStatusTest[0]['Status'].toString().contains('Abertos')
                      ? int.parse(listStatusTest[0]['QtdTickets'])
                      : 0
              ..closedTickets =
                  listStatusTest[0]['Status'].toString().contains('Fechados')
                      ? int.parse(listStatusTest[0]['QtdTickets'])
                      : 0;
          }
        }
      }
    }
    return historicos;
  }

  @override
  Future<bool> delete({required RequestParams requestParams}) async =>
      historicoGateway.delete(
        requestParams: requestParams,
      );

  @override
  Future<bool> update({required RequestParams requestParams}) async =>
      historicoGateway.update(
        requestParams: requestParams,
      );

  @override
  Future<bool> deleteFile({required RequestParams requestParams}) async =>
      historicoGateway.deleteFile(
        requestParams: requestParams,
      );

  @override
  Future<Uint8List> downloadFile({
    required RequestParams requestParams,
  }) async =>
      historicoGateway.downloadFile(
        requestParams: requestParams,
      );

  @override
  Future<bool> uploadFile({required RequestParams requestParams}) async =>
      historicoGateway.uploadFile(
        requestParams: requestParams,
      );
}
