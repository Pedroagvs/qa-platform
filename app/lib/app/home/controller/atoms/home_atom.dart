import 'package:asp/asp.dart';
import 'package:get_it/get_it.dart';
import 'package:quality_assurance_platform/app/home/controller/states/home_state.dart';
import 'package:quality_assurance_platform/app/login/controller/atom/login_atom.dart';
import 'package:quality_assurance_platform/core/common/domain/usecases/interface/users_usecase.dart';
import 'package:quality_assurance_platform/externals/service/anexar_arquivos.dart';

final anexarArquivosService = GetIt.I.get<AnexarArquivosService>();
final usersUseCase = GetIt.I.get<UsersUseCase>();
final selectedIndexAtom = atom<int>(0);
final statusHomeAtom = atom<StatusHome>(StatusHome.initial);
final showFormChangePasswordAtom = atom<bool>(false);
final showPasswordAtom = atom<bool>(true);
final msgToastAtom = atom<String>('');
final updateIndex = atomAction1<int>(
  key: 'updateIndex',
  (set, newIndex) {
    set(selectedIndexAtom, newIndex);
    var title = '';
    switch (newIndex) {
      case 0:
        title = 'Aplicações';
        break;
      case 1:
        title = 'Dashboard';
        break;
      case 2:
        title = 'Minha Conta';
        break;
      case 3:
        title = 'Configurações';
        break;
    }

    updateTitle(title);
  },
);

final selectedIndexTitleAtom = atom<String>('Home');

final updateTitle = atomAction1<String>(
  key: 'updateTitle',
  (set, newTitle) => set(selectedIndexTitleAtom, newTitle),
);

final updateStatusHome = atomAction1<StatusHome>((set, newValue) {
  set(statusHomeAtom, newValue);
});

final homeAtomSelector = selector(key: 'updateHomeState', (get) {
  return HomeState(
    title: get(selectedIndexTitleAtom),
    selectedIndex: get(selectedIndexAtom),
    statusHome: get(statusHomeAtom),
    showFormChangePassword: get(showFormChangePasswordAtom),
  );
});

final updateThumbnailUser = atomAction1<int>((
  set,
  idUser,
) async {
  set(statusHomeAtom, StatusHome.loadingChangeThumbnail);
  final map = await anexarArquivosService.buscarAquivo();
  if (map.isNotEmpty) {
    final record =
        await usersUseCase.setThumbnail(bytes: map['bytes'], idUser: idUser);
    if (record.failure != null) {
      set(statusHomeAtom, StatusHome.failureSetThumbnail);
    } else if (record.success != null) {
      final user = userAtom.state?..thumbnail = map['bytes'];
      set(userAtom, user);
      set(statusHomeAtom, StatusHome.succesSetThumbnail);
    }
  }
  set(statusHomeAtom, StatusHome.initial);
});

final changePassword =
    atomAction2<String, String>((set, password, newPassword) async {
  set(statusHomeAtom, StatusHome.loadingChangePassword);
  final record = await authUseCase.changePassword(
    password: password,
    newPassword: newPassword,
    idUser: userAtom.state?.id ?? 0,
  );
  if (record.failure != null) {
    set(msgToastAtom, record.failure!.errorMessage.toString());
    set(statusHomeAtom, StatusHome.failureChangePassword);
  } else if (record.success != null) {
    set(msgToastAtom, 'Senha altera com sucesso.');
    set(statusHomeAtom, StatusHome.successChangePassword);
  }
});

final updateShowformChangePassword = atomAction1<bool>((set, newValue) {
  set(showFormChangePasswordAtom, newValue);
});
final changeShowPassword = atomAction1<bool>((set, newValue) {
  set(showPasswordAtom, newValue);
});
