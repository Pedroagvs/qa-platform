import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:quality_assurance_platform/app/common/message_atom.dart';
import 'package:quality_assurance_platform/app/common/shared_preferences_atom.dart';
import 'package:quality_assurance_platform/app/common/user_atom.dart';
import 'package:quality_assurance_platform/features/login/domain/usecases/interface/auth_usecase.dart';

final authUseCase = GetIt.I.get<AuthUseCase>();
final statusLoginAtom = atom<LoginStatus>(LoginStatus.initial);
final emailAtom = atom<TextEditingController>(
  TextEditingController(text: 'admin@gmail.com'),
);
final passwordAtom =
    atom<TextEditingController>(TextEditingController(text: 'Senha123@'));

final obscureTextAtom = atom<bool>(true);

final isLoggedAtom = atom<bool>(false);

final updateIslogged = atomAction1<bool>(
  key: 'updateIslogged',
  (set, value) => set(isLoggedAtom, value),
);

final changeObscureFieldLogin =
    atomAction1<bool>(key: 'changeObscureFieldLogin', (set, newValue) {
  set(
    obscureTextAtom,
    newValue,
  );
});

final submitLogin = atomAction2<String, String>(key: 'submitLogin', (
  set,
  String email,
  String password,
) async {
  set(statusLoginAtom, LoginStatus.loading);

  final result = await authUseCase.signInWithEmailAndPassword(
    email: email,
    passWord: password,
  );
  if (result.failure != null) {
    set(msgAtom, result.failure?.errorMessage.toString());
    set(statusLoginAtom, LoginStatus.failure);
    await Future.delayed(
      const Duration(seconds: 2),
      () => set(statusLoginAtom, LoginStatus.initial),
    );
  } else if (result.userEntity != null) {
    updateIslogged(true);
    updateUserCache(result.userEntity!);
    set(userAtom, result.userEntity);
    set(statusLoginAtom, LoginStatus.success);
  }
});

enum LoginStatus {
  initial,
  loading,
  failure,
  success,
  logged,
  unlogged,
}
