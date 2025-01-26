import 'package:asp/asp.dart';
import 'package:get_it/get_it.dart';
import 'package:quality_assurance_platform/app/common/atoms/message_atom.dart';
import 'package:quality_assurance_platform/features/login/domain/usecases/interface/auth_usecase.dart';

final createAccountAtom =
    atom<StatusCreateAccount>(StatusCreateAccount.initial);

final showFormCreateAccountAtom = atom<bool>(false);

final showPasswordAtom = atom<bool>(true);

final cargoAtom = atom<String>('Tester');

final changeShowPassword = atomAction1(key: 'showPassword', (set, bool value) {
  set(showPasswordAtom, value);
});
final changeCargoState =
    atomAction1(key: 'changeCargoState', (set, String value) {
  set(cargoAtom, value);
});

final showFormCreateAccount =
    atomAction1(key: 'showFormCreateAccount', (set, bool value) {
  set(showFormCreateAccountAtom, value);
});

final submitFormCreateAccount = atomAction1((
  set,
  (
    String name,
    String email,
    String password,
    String cargo,
  ) record,
) async {
  set(createAccountAtom, StatusCreateAccount.loading);
  final authUsecase = GetIt.I.get<AuthUseCase>();
  final result = await authUsecase.createUserWithEmailAndPassword(
    nome: record.$1,
    email: record.$2,
    password: record.$3,
    cargo: record.$4,
  );
  if (result.failure != null) {
    set(msgAtom, result.failure!.errorMessage.toString());
    set(createAccountAtom, StatusCreateAccount.failure);
    await Future.delayed(const Duration(seconds: 1), () {
      set(createAccountAtom, StatusCreateAccount.initial);
    });
  } else if (result.success != null) {
    set(msgAtom, 'Conta criada com sucesso.');
    set(createAccountAtom, StatusCreateAccount.success);
  }
});

enum StatusCreateAccount {
  initial,
  loading,
  failure,
  success,
}
