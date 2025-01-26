import 'package:asp/asp.dart';
import 'package:get_it/get_it.dart';
import 'package:quality_assurance_platform/app/common/atoms/message_atom.dart';
import 'package:quality_assurance_platform/app/common/atoms/user_atom.dart';
import 'package:quality_assurance_platform/app/historico/controller/states/historico_state.dart';
import 'package:quality_assurance_platform/core/common/data/dtos/arquivo_dto.dart';
import 'package:quality_assurance_platform/core/common/domain/entities/historico_entity.dart';
import 'package:quality_assurance_platform/externals/service/anexar_arquivos.dart';
import 'package:quality_assurance_platform/externals/service/html_service.dart';
import 'package:quality_assurance_platform/features/historico/data/dto/historico_dto.dart';
import 'package:quality_assurance_platform/features/historico/domain/usecases/interface/historico_usecase.dart';

final historicUseCase = GetIt.I.get<HistoricoUsecase>();
final anexarArquivosService = GetIt.I.get<AnexarArquivosService>();
//Atoms
final historicStatusAtom = atom<HistoricoStatus>(HistoricoStatus.initial);
final historicAtom = atom<List<HistoricEntity>>([]);
final filteredHistoricsAtom = atom<List<HistoricEntity>>([]);
final historicGenericAtom = atom<HistoricEntity>(HistoricoDto.empty());
final idHistoricAtom = atom<int>(0);
final idAplicacaoAtom = atom<int>(0);
final versionAppOrBranchAtom = atom<String>('');
final featuresTestadasAtom = atom<String>('');
final fileAtom = atom<FileDto>(FileDto.empty());
final showFormHistoricAtom = atom<bool>(false);
final isEditAtom = atom<bool>(false);
final filterAtom = atom<String>('');
final pageAtom = atom<int>(0);
// Actions

final updateShowForm = atomAction1<bool>(
  key: 'updateShowForm',
  (set, newValue) => set(showFormHistoricAtom, newValue),
);

final updateIsEdit = atomAction1<bool>(
  key: 'updateIsEdit',
  (set, newValue) => set(isEditAtom, newValue),
);

final updateIdHistoric = atomAction1<int>(
  key: 'updateIdHistoric',
  (set, newId) => set(idHistoricAtom, newId),
);
final updateFilter = atomAction1<String>(
  key: 'updateFilter',
  (set, newValue) => set(filterAtom, newValue),
);
final updateFilteredHistorics =
    atomAction1<List<HistoricEntity>>((set, historics) {
  set(filteredHistoricsAtom, historics);
});
final updatePage = atomAction1<int>(key: 'updatePage', (set, newId) {
  set(pageAtom, newId);
});

final updateFeaturesTestadas = atomAction1<String>(
  key: 'updateFeaturesTestadas',
  (set, newValue) => set(featuresTestadasAtom, newValue),
);

final updateVersionAppOrBranch = atomAction1<String>(
  key: 'updateVersionAppOrBranch',
  (set, newValue) => set(versionAppOrBranchAtom, newValue),
);
final updateIdAplicacao = atomAction1<int>(
  key: 'updateIdAplicacao',
  (set, newValue) => set(idAplicacaoAtom, newValue),
);

final updateFile = atomAction1<FileDto>(
  key: 'updateFile',
  (set, newFile) => set(fileAtom, newFile),
);

final historicStateAtom =
    selector<HistoricoState>(key: 'historicSelectedAtom', (get) {
  final genericHistoric = get(historicGenericSelector);
  final historicStatus = get(historicStatusAtom);
  final historics = get(historicAtom);
  final filteredHistorics = get(filteredHistoricsAtom);

  final page = get(pageAtom);
  final idAplicacao = get(idAplicacaoAtom);
  final isEdit = get(isEditAtom);
  return HistoricoState(
    historicEntity: genericHistoric,
    historicoStatus: historicStatus,
    historics: historics,
    page: page,
    filteredHistorics: filteredHistorics,
    idAplicacao: idAplicacao,
    isEdit: isEdit,
  );
});

final getHistorics = atomAction2<int, int>(key: 'getHistorics',
    (set, offset, idAplicacao) async {
  set(historicStatusAtom, HistoricoStatus.loading);
  final result = await historicUseCase.getHistorics(
    offset: offset * 10,
    idAplicacao: idAplicacao,
  );
  if (result.failure != null) {
    set(msgAtom, result.failure?.errorMessage.toString());
    set(historicStatusAtom, HistoricoStatus.failureGet);
  } else if (result.historicos != null) {
    set(historicAtom, result.historicos);
    set(historicStatusAtom, HistoricoStatus.successGet);
  }
});

final createHistoric = atomAction1(key: 'createHistoric', (
  set,
  (
    int idAplicacao,
    String creatorName,
    String versionAppOrBranch,
    String featuresTestadas,
    String aplicacao,
    FileDto? fileDto
  ) record,
) async {
  set(historicStatusAtom, HistoricoStatus.loading);
  final result = await historicUseCase.createHistoric(
    creatorName: record.$2,
    idAplicacao: record.$1,
    versionAppOrBranch: record.$3,
    featuresTestadas: record.$4,
    aplicacao: record.$5,
    fileDto: record.$6,
  );
  if (result.failure != null) {
    set(msgAtom, result.failure?.errorMessage.toString());
    set(historicStatusAtom, HistoricoStatus.failureCreate);
  } else if (result.message != null) {
    set(msgAtom, result.message.toString());
    set(historicStatusAtom, HistoricoStatus.successCreate);
  }
});

final editHistoric = atomAction1<Map<String, dynamic>>(key: 'editHistoric', (
  set,
  maUpdate,
) async {
  set(historicStatusAtom, HistoricoStatus.loading);
  final result = await historicUseCase.update(
    maUpdate,
  );

  if (result.failure != null) {
    set(msgAtom, result.failure?.errorMessage.toString());
    set(historicStatusAtom, HistoricoStatus.failureEdit);
  } else if (result.message != null) {
    set(msgAtom, result.message.toString());
    set(historicStatusAtom, HistoricoStatus.successEdit);
  }
});

final deleteHistoric = atomAction2<int, int>(key: 'deleteHistoric',
    (set, int idHistorico, int idAplicacao) async {
  set(historicStatusAtom, HistoricoStatus.loading);
  final result = await historicUseCase.deleteHistoric(
    idHistorico: idHistorico,
    idAplicacao: idAplicacao,
  );
  if (result.failure != null) {
    set(msgAtom, result.failure?.errorMessage.toString());
    set(historicStatusAtom, HistoricoStatus.failureDelete);
  } else if (result.message != null) {
    set(msgAtom, result.message.toString());
    set(historicStatusAtom, HistoricoStatus.successDelete);
  }
});
final deleteFileHistoric =
    atomAction1<int>(key: 'deleteFileHistoric', (set, int idHistorico) async {
  set(historicStatusAtom, HistoricoStatus.loading);
  final result = await historicUseCase.deleteFileHistoric(
    idHistorico,
  );
  if (result.failure != null) {
    set(msgAtom, result.failure?.errorMessage.toString());
    set(historicStatusAtom, HistoricoStatus.failureDelete);
  } else if (result.message != null) {
    set(msgAtom, result.message.toString());
    set(historicStatusAtom, HistoricoStatus.successDelete);
  }
});
final getReport = atomAction1<int>((set, idHistorico) {});

final getFileHistoric = atomAction3<int, int, String>(key: 'getFileHistoric',
    (set, int idHistorico, int idArquivo, String nameFile) async {
  set(historicStatusAtom, HistoricoStatus.loadingDownload);
  final result = await historicUseCase.downloadFileHistoric(
    idHistorico: idHistorico,
    idArquivo: idArquivo,
  );
  if (result.failure != null) {
    set(msgAtom, result.failure?.errorMessage.toString());
    set(historicStatusAtom, HistoricoStatus.failureDownload);
  } else if (result.bytes != null) {
    HtmlService.donwloadFile(nameFile, result.bytes!);
    set(historicStatusAtom, HistoricoStatus.successDownload);
    Future.delayed(
      const Duration(seconds: 1),
      () => set(historicStatusAtom, HistoricoStatus.initial),
    );
  }
});

final sendFileHistoric = atomAction2<int, FileDto>(key: 'sendFileHistoric',
    (set, int idHistorico, FileDto fileDto) async {
  set(historicStatusAtom, HistoricoStatus.loading);
  final result = await historicUseCase.uploadFileHistoric(
    idHistorico,
    fileDto,
  );
  if (result.failure != null) {
    set(msgAtom, result.failure?.errorMessage.toString());
    set(historicStatusAtom, HistoricoStatus.failureUpload);
  } else if (result.message != null) {
    set(msgAtom, result.message.toString());
    set(historicStatusAtom, HistoricoStatus.successUpload);
  }
});

final getFile = atomAction((set) async {
  set(historicStatusAtom, HistoricoStatus.anexarArquivo);
  final map = await anexarArquivosService.buscarAquivo().whenComplete(
        () => set(historicStatusAtom, HistoricoStatus.initial),
      );
  set(
    fileAtom,
    FileDto(
      path: map['path'] ?? '',
      name: map['nome'] ?? '${DateTime.now().millisecond}',
      bytes: map['bytes'],
      id: -1,
    ),
  );
});

final filterList =
    atomAction2<String, List<HistoricEntity>>((set, filter, historic) {
  if (filter.isEmpty) {
    set(filteredHistoricsAtom, <HistoricEntity>[]);
  } else {
    final historics = historic
        .where(
          (h) =>
              h.creator.toLowerCase().contains(filter.toLowerCase()) ||
              h.dataCadastro.replaceAll('/', '').contains(filter) ||
              h.source.toLowerCase().contains(filter.toLowerCase()),
        )
        .toList();
    set(
      filteredHistoricsAtom,
      historics,
    );
  }
});

final historicGenericSelector = selector(key: 'historicGenericSelector', (get) {
  final file = get(fileAtom);
  final source = get(versionAppOrBranchAtom);
  final features = get(featuresTestadasAtom);
  final user = get(userAtom);
  return HistoricEntity(
    creator: user?.name ?? '',
    source: source,
    feature: features,
    dataCadastro: '',
    fileDto: file,
  );
});

final updateHistoricGeneric = atomAction1<HistoricEntity>(
  (set, historic) => set(
    historicGenericSelector,
    historic,
  ),
);

final updateHistoricStatus = atomAction1<HistoricoStatus>(
  key: 'clearHistoricStatus',
  (set, newStatus) => set(historicStatusAtom, newStatus),
);
