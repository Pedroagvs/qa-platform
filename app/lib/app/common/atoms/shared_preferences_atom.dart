import 'dart:convert';

import 'package:asp/asp.dart';
import 'package:quality_assurance_platform/core/common/data/dtos/user_dto.dart';
import 'package:quality_assurance_platform/core/common/domain/entities/user_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

final prefsAtom = selector((get) async {
  return SharedPreferences.getInstance();
});

final argsAtom = atom<String>('');

final updateArgs =
    atomAction2<String, Map<String, dynamic>>((set, id, args) async {
  final prefs = await prefsAtom.state;
  await prefs.setString(id, jsonEncode(args));
  set(argsAtom, jsonEncode(args));
});

final updateUserCache = atomAction1<UserEntity>((set, user) async {
  final prefs = await prefsAtom.state;
  await prefs.setString('user', jsonEncode(UserDto.toJson(user)));
});

Future<String> getUser() async =>
    (await prefsAtom.state).getString('user') ?? '';

Future<Map<String, dynamic>> getArgs(String id) async =>
    jsonDecode((await prefsAtom.state).getString(id) ?? '{}');

Future<String> getTheme() async =>
    (await prefsAtom.state).getString('theme') ?? 'system';

final clearCache = atomAction((set) async {
  final prefs = await prefsAtom.state;
  await prefs.clear();
});
