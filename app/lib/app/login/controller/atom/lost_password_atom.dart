import 'package:asp/asp.dart';
import 'package:flutter/material.dart';

final lostPasswordAtom = atom<StatusLostPassword>(StatusLostPassword.initial);

final lpEmailAtom = atom<TextEditingController>(TextEditingController());

final showFormLostPasswordAtom = atom<bool>(false);

final showFormLostPassword =
    atomAction1(key: 'showFormLostPassword', (set, bool value) {
  set(showFormLostPasswordAtom, value);
});

enum StatusLostPassword {
  initial,
  loading,
  failure,
  success,
}
