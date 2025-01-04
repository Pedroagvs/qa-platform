import 'package:asp/asp.dart';
import 'package:get_it/get_it.dart';
import 'package:quality_assurance_platform/app/common/message_atom.dart';
import 'package:quality_assurance_platform/app/home/controller/states/suites_state.dart';
import 'package:quality_assurance_platform/core/common/domain/entities/application_entity.dart';
import 'package:quality_assurance_platform/core/common/domain/entities/test_entity.dart';
import 'package:quality_assurance_platform/features/home/data/dtos/suite_teste_dto.dart';
import 'package:quality_assurance_platform/features/home/domain/usecases/interface/aplicacoes_usecase.dart';

final aplicacaoUsecase = GetIt.I.get<ApplicationUseCase>();
//Atoms
final applicationStatusAtom =
    atom<ApplicationStatus>(ApplicationStatus.initial);
final aplicationsAtom = atom<List<ApplicationEntity>>([]);
final titleAtom = atom<String>('');
final platformAtom = atom<Platform>(Platform.mobile);
final idAtom = atom<int>(0);
//Actions
final showFormSuiteAtom = atom<bool>(false);
final isEditSuiteAtom = atom<bool>(false);

final updateShowFormSuite = atomAction1<bool>(
  key: 'updateShowFormSuite',
  (set, value) => set(showFormSuiteAtom, value),
);

final updateEditSuite = atomAction1<bool>(
  key: 'updateEditSuite',
  (set, value) => set(isEditSuiteAtom, value),
);
final updateId = atomAction1<int>(
  key: 'updateId',
  (set, value) => set(idAtom, value),
);

final updateTitle = atomAction1<String>(
  key: 'updateTitle',
  (set, suite) => set(titleAtom, suite),
);

final updatePlatform = atomAction1<Platform>(
  key: 'updatePlatform',
  (set, value) => set(platformAtom, value),
);

final getSuites = atomAction(key: 'getSuites', (set) async {
  set(applicationStatusAtom, ApplicationStatus.loading);
  final result = await aplicacaoUsecase.getAplications();
  if (result.failure != null) {
    set(applicationStatusAtom, ApplicationStatus.failureGet);
  } else if (result.aplications != null) {
    set(applicationStatusAtom, ApplicationStatus.successGet);
    set(aplicationsAtom, result.aplications);
  }
});

final editSuite = atomAction3<String, String, int>(key: 'editSuite',
    (set, String title, String platform, int id) async {
  set(applicationStatusAtom, ApplicationStatus.loading);
  final result = await aplicacaoUsecase.editApplication(
    idApplication: id,
    title: title,
    platform: platform,
  );
  if (result.failure != null) {
    set(msgAtom, result.failure?.errorMessage.toString());
    set(applicationStatusAtom, ApplicationStatus.failureEdit);
  } else if (result.message != null) {
    set(msgAtom, result.message.toString());
    set(applicationStatusAtom, ApplicationStatus.successEdit);
    getSuites();
  }
});

final createSuite = atomAction2<String, String>(key: 'createSuite',
    (set, String title, String platform) async {
  set(applicationStatusAtom, ApplicationStatus.loading);
  final result = await aplicacaoUsecase.createApplication(
    title: title,
    platform: platform,
  );
  if (result.failure != null) {
    set(msgAtom, result.failure?.errorMessage.toString());
    set(applicationStatusAtom, ApplicationStatus.failureCreate);
  } else if (result.message != null) {
    set(msgAtom, result.message.toString());
    set(applicationStatusAtom, ApplicationStatus.successCreate);
    getSuites();
  }
});

final deleteSuite = atomAction1<int>(key: 'deleteSuite', (set, int id) async {
  set(applicationStatusAtom, ApplicationStatus.loading);
  final result = await aplicacaoUsecase.deleteApplication(
    idApplication: id,
  );
  if (result.failure != null) {
    set(msgAtom, result.failure?.errorMessage.toString());
    set(applicationStatusAtom, ApplicationStatus.failureDelete);
  } else if (result.message != null) {
    set(msgAtom, result.message.toString());
    set(applicationStatusAtom, ApplicationStatus.successDelete);
    getSuites();
  }
});

final clearGenericSuite =
    atomAction((set) => set(genericSelectorAtom, ApplicationDto.empty()));
final updateApplicationStatus = atomAction1<ApplicationStatus>(
  (set, newStatus) => set(applicationStatusAtom, newStatus),
);

final genericSelectorAtom = selector(key: 'genericSelectorAtom', (get) {
  final title = get(titleAtom);
  final platform = get(platformAtom);
  final id = get(idAtom);
  return ApplicationEntity(title: title, platform: platform, id: id);
});

final applicationSelectAtom =
    selector<ApplicationState>(key: 'suiteSelectAtom', (get) {
  final status = get(applicationStatusAtom);
  final aplications = get(aplicationsAtom);
  final isEdit = get(isEditSuiteAtom);
  final showForm = get(showFormSuiteAtom);
  final genericAplication = get(genericSelectorAtom);
  return ApplicationState(
    applicationStatus: status,
    aplications: aplications,
    isEdit: isEdit,
    showForm: showForm,
    application: genericAplication,
  );
});
