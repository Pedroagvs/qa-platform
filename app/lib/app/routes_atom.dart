import 'dart:convert';

import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:quality_assurance_platform/core/common/data/dtos/user_dto.dart';
import 'package:quality_assurance_platform/core/common/domain/entities/user_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

final prefsAtom = selector((get) async {
  return SharedPreferences.getInstance();
});

final routeAtom = atom<String>('');
final argsAtom = atom<String>('');
final theme = atom<ThemeMode>(ThemeMode.system);
final user = atom<UserEntity?>(UserDto.empty());

final updateRoutes =
    atomAction2<String, Map<String, dynamic>>((set, route, args) async {
  final prefs = await prefsAtom.state;
  await prefs.setString('route', route);
  await prefs.setString('args', jsonEncode(args));
  set(routeAtom, route);
  set(argsAtom, jsonEncode(args));
});
final updateThemeCache = atomAction1<ThemeMode>((set, newMode) async {
  final prefs = await prefsAtom.state;
  await prefs.setString('theme', newMode.name);
  set(theme, newMode);
});
final updateUserCache = atomAction1<UserEntity>((set, user) async {
  final prefs = await prefsAtom.state;
  await prefs.setString('user', jsonEncode(UserDto.toJson(user)));
});
Future<String> getUser() async =>
    (await prefsAtom.state).getString('user') ?? '';
Future<String> getRoute() async =>
    (await prefsAtom.state).getString('route') ?? '';
Future<String> getArgs() async =>
    (await prefsAtom.state).getString('args') ?? '';
Future<String> getTheme() async =>
    (await prefsAtom.state).getString('theme') ?? 'system';

final clearCache = atomAction((set) async {
  final prefs = await prefsAtom.state;
  await prefs.clear();
});
