import 'package:quality_assurance_platform/core/common/domain/entities/historico_entity.dart';

class HistoricoState {
  final HistoricoStatus historicoStatus;
  final List<HistoricEntity> historics;
  final List<HistoricEntity> filteredHistorics;
  final int page;
  final int idFile;
  final int idAplicacao;
  final bool isEdit;
  final HistoricEntity historicEntity;
  const HistoricoState({
    this.historicoStatus = HistoricoStatus.initial,
    this.page = 0,
    this.idAplicacao = 0,
    this.isEdit = false,
    this.idFile = 0,
    this.historics = const [],
    this.filteredHistorics = const [],
    required this.historicEntity,
  });
}

enum HistoricoStatus {
  initial,
  loading,
  success,
  failureGet,
  successGet,
  failureCreate,
  successCreate,
  failureEdit,
  successEdit,
  failureDelete,
  successDelete,
  failureDownload,
  successDownload,
  failureUpload,
  successUpload,
  anexarArquivo,
  loadingDownload,
}
