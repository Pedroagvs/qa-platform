part of data;

class HistoricService implements HistoricUseCase {
  final HistoricGateway historicGateway;
  final TestGateWay testGateWay;
  HistoricService({
    required this.historicGateway,
    required this.testGateWay,
  });

  @override
  Future<bool> create({required RequestParams requestParams}) async =>
      historicGateway.create(
        requestParams: requestParams,
      );

  @override
  Future<List<HistoricDto>> get({
    required RequestParams requestParams,
  }) async {
    final historicos = await historicGateway.get(
      requestParams: requestParams,
    );
    if (historicos.isNotEmpty) {
      for (final historico in historicos) {
        final listStatusTest = await historicGateway.countTickets(
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
      historicGateway.delete(
        requestParams: requestParams,
      );

  @override
  Future<bool> update({required RequestParams requestParams}) async =>
      historicGateway.update(
        requestParams: requestParams,
      );

  @override
  Future<bool> deleteFile({required RequestParams requestParams}) async =>
      historicGateway.deleteFile(
        requestParams: requestParams,
      );

  @override
  Future<Uint8List> downloadFile({
    required RequestParams requestParams,
  }) async =>
      historicGateway.downloadFile(
        requestParams: requestParams,
      );

  @override
  Future<bool> uploadFile({required RequestParams requestParams}) async =>
      historicGateway.uploadFile(
        requestParams: requestParams,
      );
}
