import 'dart:developer';

import 'package:asp/asp.dart';
import 'package:get_it/get_it.dart';
import 'package:quality_assurance_platform/app/common/message_atom.dart';
import 'package:quality_assurance_platform/app/testes/controller/states/testes_state.dart';
import 'package:quality_assurance_platform/core/common/data/dtos/arquivo_dto.dart';
import 'package:quality_assurance_platform/core/common/data/dtos/teste_dto.dart';
import 'package:quality_assurance_platform/core/common/domain/entities/arquivo_entity.dart';
import 'package:quality_assurance_platform/core/common/domain/entities/test_entity.dart';
import 'package:quality_assurance_platform/core/common/domain/entities/user_entity.dart';
import 'package:quality_assurance_platform/core/common/domain/usecases/interface/users_usecase.dart';
import 'package:quality_assurance_platform/externals/service/anexar_arquivos.dart';
import 'package:quality_assurance_platform/externals/service/html_service.dart';
import 'package:quality_assurance_platform/features/testes/domain/usecase/interface/teste_usecase.dart';

final testeUseCase = GetIt.I.get<TesteUseCase>();
final userUserCase = GetIt.I.get<UsersUseCase>();
final anexarArquivosService = GetIt.I.get<AnexarArquivosService>();
final cacheFilesAtom = atom<List<ArquivoEntity>>([]);
final selectedTestAtom = atom<TesteEntity>(TesteDto.empty());
final statusTestesAtom = atom<StatusTestes>(StatusTestes.initial);
final filterSituationAtom = atom<SituacaoTeste>(SituacaoTeste.todos);
final testesAtom = atom<List<TesteEntity>>([]);
final filteredTestsAtom = atom<List<TesteEntity>>([]);
final isEditingAtom = atom<bool>(false);
final showFormAtom = atom<bool>(false);
final showFormSelectedTestAtom = atom<bool>(false);
final usersAtom = atom<List<UserEntity>>([]);
final tagTesteAtom = atom<TagTeste>(TagTeste.melhoria);
final selectorTestStateAtom = selector(
  (get) => TestesState(
    statusTestes: get(statusTestesAtom),
    selectedTest: get(selectedTestAtom),
    testes: get(testesAtom),
    showFormSelectedTest: get(showFormSelectedTestAtom),
    showForm: get(showFormAtom),
    isEditing: get(isEditingAtom),
    cacheFiles: get(cacheFilesAtom),
    filteredTests: get(filteredTestsAtom),
    selectedSituation: get(filterSituationAtom),
  ),
);

final updateDescription = atomAction1<String>((set, newValue) {
  final test = selectedTestAtom.state..descricao = newValue;
  set(selectedTestAtom, test);
});
final updateObservation = atomAction1<String>((set, newValue) {
  final test = selectedTestAtom.state..observacoes = newValue;
  set(selectedTestAtom, test);
});
final updateTester = atomAction1<String>((set, newValue) {
  final test = selectedTestAtom.state..tester = newValue;
  set(selectedTestAtom, test);
});
final updateSenha = atomAction1<String>((set, newValue) {
  final test = selectedTestAtom.state..senhaTeste = newValue;
  set(selectedTestAtom, test);
});
final updateLogin = atomAction1<String>((set, newValue) {
  final test = selectedTestAtom.state..loginTeste = newValue;
  set(selectedTestAtom, test);
});
final updatePassos = atomAction1<String>((set, newValue) {
  final test = selectedTestAtom.state..passos = newValue;
  set(selectedTestAtom, test);
});
final updateResultadoEsperado = atomAction1<String>((set, newValue) {
  final test = selectedTestAtom.state..resultadoEsperado = newValue;
  set(selectedTestAtom, test);
});
final updateResponsavel = atomAction1<String>((set, newValue) {
  final test = selectedTestAtom.state..responsavel = newValue;
  set(selectedTestAtom, test);
});

final updateTagSelected = atomAction1<TagTeste>((set, newValue) {
  set(tagTesteAtom, newValue);
});

final updateStatusTeste = atomAction1<StatusTestes>((set, newValue) {
  set(statusTestesAtom, newValue);
});
final updateSituationTeste = atomAction1<SituacaoTeste>((set, newValue) {
  final test = selectedTestAtom.state..situacaoTeste = newValue;
  set(selectedTestAtom, test);
  set(statusTestesAtom, StatusTestes.initial);
});

final updateSelectedTest = atomAction1<TesteEntity>((set, test) {
  set(selectedTestAtom, test);
});

final getFiles = atomAction((set) async {
  set(statusTestesAtom, StatusTestes.anexandoArquivos);
  final files = await anexarArquivosService.buscarArquivos();
  final cachedFiles = cacheFilesAtom.state
    ..addAll(files.map((e) => ArquivoDto.fromJson(e)).toList());
  set(cacheFilesAtom, cachedFiles);
  set(statusTestesAtom, StatusTestes.initial);
});

final updateFilesTestSelected = atomAction((set) async {
  set(statusTestesAtom, StatusTestes.loadingUploadFiles);
  final result = await anexarArquivosService.buscarArquivos();
  final files = result.map((e) => ArquivoDto.fromJson(e)).toList();
  final testSelected = selectedTestAtom.state;
  final record = await testeUseCase.uploadArquivos(
    idTeste: testSelected.id,
    arquivos: files,
    onProgress: (int totalBytes, int currentBytes) {
      log((currentBytes / totalBytes * 100).round().toString());
    },
  );
  if (record.failure != null) {
    set(statusTestesAtom, StatusTestes.failureUploadFiles);
  } else if (record.success != null) {
    set(statusTestesAtom, StatusTestes.successUploadFiles);
    testSelected.arquivos.addAll(files);
  }
});

final removeFileInCache = atomAction1<String>((set, nameFile) {
  set(statusTestesAtom, StatusTestes.removendoArquivo);
  final cachedFiles = cacheFilesAtom.state
    ..removeWhere((f) => f.nome == nameFile);
  set(cacheFilesAtom, cachedFiles);
  set(statusTestesAtom, StatusTestes.initial);
});

final getUsers = atomAction((set) async {
  final record = await userUserCase.getUsers();
  if (record.failure != null) {
    set(statusTestesAtom, StatusTestes.failureLoading);
  } else if (record.users != null) {
    set(statusTestesAtom, StatusTestes.successloading);
    set(usersAtom, record.users);
  }
});
final createTicketTeste =
    atomAction2<int, TesteEntity>((set, idHistorico, teste) async {
  set(statusTestesAtom, StatusTestes.loadingAddTeste);
  final record = await testeUseCase.create(
    testeEntity: teste,
    idHistorico: idHistorico,
    onProgress: (int totalBytes, int currentBytes) {
      log((currentBytes / totalBytes * 100).round().toString());
    },
  );
  if (record.failure != null) {
    set(statusTestesAtom, StatusTestes.failureCreateTeste);
  } else if (record.success != null) {
    set(cacheFilesAtom, <ArquivoEntity>[]);
    set(statusTestesAtom, StatusTestes.successCreateTeste);
  }
});

final getTestes = atomAction1<int>((set, idHistorico) async {
  set(statusTestesAtom, StatusTestes.loadingList);
  final record = await testeUseCase.getTestes(
    idHistorico: idHistorico,
    onProgress: (int totalBytes, int currentBytes) {
      log((currentBytes / totalBytes * 100).round().toString());
    },
  );
  if (record.failure != null) {
    set(statusTestesAtom, StatusTestes.failureLoading);
  } else if (record.testes != null) {
    set(statusTestesAtom, StatusTestes.successloading);
    set(testesAtom, record.testes);
  }
});
final saveEdit = atomAction1<Map<String, dynamic>>((set, mapUpdate) async {
  set(statusTestesAtom, StatusTestes.loadingList);
  final record = await testeUseCase.updateTeste(
    mapUpdate: mapUpdate,
    onProgress: (int totalBytes, int currentBytes) {
      log((currentBytes / totalBytes * 100).round().toString());
    },
  );
  if (record.failure != null) {
    set(statusTestesAtom, StatusTestes.failureLoading);
  } else if (record.success != null) {
    set(statusTestesAtom, StatusTestes.successloading);
  }
});
final finishTest = atomAction1<Map<String, dynamic>>((set, mapUpdate) async {
  set(statusTestesAtom, StatusTestes.loadingFinish);
  final record = await testeUseCase.updateTeste(
    mapUpdate: mapUpdate,
    onProgress: (int totalBytes, int currentBytes) {
      log((currentBytes / totalBytes * 100).round().toString());
    },
  );
  if (record.failure != null) {
    set(msgAtom, record.failure?.errorMessage.toString());
    set(statusTestesAtom, StatusTestes.failureFinish);
  } else if (record.success != null) {
    set(msgAtom, 'Successo ao finalizar o ticket.');
    set(statusTestesAtom, StatusTestes.successFinish);
  }
});

final deleteFile = atomAction2<int, int>((set, idTeste, idArquivo) async {
  set(statusTestesAtom, StatusTestes.loadingDeleteFile);
  final record =
      await testeUseCase.deleteArquivo(idTeste: idTeste, idArquivo: idArquivo);
  if (record.failure != null) {
    set(msgAtom, record.failure?.errorMessage.toString());
    set(statusTestesAtom, StatusTestes.failureDeleteFile);
  } else if (record.success != null) {
    set(statusTestesAtom, StatusTestes.successDeleteFile);
  }
});

final getFilesTest = atomAction1<int>((
  set,
  idTeste,
) async {
  final files = selectedTestAtom.state.arquivos;
  if (files.any((f) => f.bytes == null)) {
    for (final file in files) {
      set(statusTestesAtom, StatusTestes.loadingDownloadFile);
      final record = await testeUseCase.downloadArquivos(
        idTeste: idTeste,
        idArquivo: file.id,
        onProgress: (int totalBytes, int currentBytes) {
          log((currentBytes / totalBytes * 100).round().toString());
        },
      );
      if (record.failure != null) {
        set(statusTestesAtom, StatusTestes.failureDownloadFile);
      } else if (record.bytes != null) {
        file.bytes = record.bytes;
        set(statusTestesAtom, StatusTestes.successDownloadFile);
      }
    }
  }
});

final deleteTicketTest =
    atomAction2<int, int>((set, idTeste, idHistorico) async {
  set(statusTestesAtom, StatusTestes.loadingDeleteTicket);
  final record = await testeUseCase.deleteTicket(
    idTeste: idTeste,
    idHistorico: idHistorico,
  );
  if (record.failure != null) {
    set(msgAtom, record.failure?.errorMessage.toString());
    set(statusTestesAtom, StatusTestes.failureDeleteTicket);
  } else if (record.success != null) {
    set(statusTestesAtom, StatusTestes.successDeleteTicket);
  }
});

final updateEditingtest =
    atomAction1<bool>((set, newValue) => set(isEditingAtom, newValue));

final showFormSelectedTest = atomAction1<bool>(
  (set, newValue) => set(showFormSelectedTestAtom, newValue),
);

final updateShowFormtest =
    atomAction1<bool>((set, newValue) => set(showFormAtom, newValue));

final showInfoDialog = atomAction((set) {
  set(statusTestesAtom, StatusTestes.showInfoTest);
});

final downloadAllFiles = atomAction(key: 'downloadAllFiles', (set) async {
  final test = selectedTestAtom.state;
  final files = test.arquivos.where((f) => f.bytes != null).toList();
  for (final f in files) {
    HtmlService.donwloadFile(f.nome, f.bytes!);
  }
});

final downloadFile =
    atomAction1<ArquivoEntity>(key: 'downloadFile', (set, file) async {
  HtmlService.donwloadFile(file.nome, file.bytes!);
});

final filterTestsBySituation = atomAction1<SituacaoTeste>((set, situation) {
  final allTests = testesAtom.state;
  set(filterSituationAtom, situation);
  if (situation == SituacaoTeste.todos) {
    set(filteredTestsAtom, allTests);
  } else {
    set(
      filteredTestsAtom,
      allTests.where((t) => t.situacaoTeste == situation).toList(),
    );
  }
});
