import 'package:quality_assurance_platform/core/common/data/dtos/arquivo_dto.dart';
import 'package:quality_assurance_platform/core/common/domain/entities/test_entity.dart';

class TestesState {
  final StatusTestes statusTestes;
  final List<TesteEntity> testes;
  final List<TesteEntity> filteredTests;
  final TesteEntity selectedTest;
  final SituacaoTeste selectedSituation;
  final List<FileDto> cacheFiles;
  final bool isEditing;
  final bool showFormSelectedTest;
  final bool showForm;
  const TestesState({
    required this.statusTestes,
    required this.selectedTest,
    this.testes = const [],
    this.cacheFiles = const [],
    this.filteredTests = const [],
    this.isEditing = false,
    this.showFormSelectedTest = false,
    this.showForm = false,
    this.selectedSituation = SituacaoTeste.todos,
  });
}

enum StatusTestes {
  initial,
  loadingList,
  failureLoading,
  successloading,
  showInfoTest,
  loadingAddTeste,
  anexandoArquivos,
  baixandoArquivos,
  arquivosBaixados,
  removendoArquivo,
  successCreateTeste,
  failureCreateTeste,
  loadingDeleteFile,
  failureDeleteFile,
  successDeleteFile,
  loadingDownloadFile,
  successDownloadFile,
  failureDownloadFile,
  successDeleteTicket,
  failureDeleteTicket,
  loadingDeleteTicket,
  loadingUploadFiles,
  failureUploadFiles,
  successUploadFiles,
  successFinish,
  failureFinish,
  loadingFinish,
}
