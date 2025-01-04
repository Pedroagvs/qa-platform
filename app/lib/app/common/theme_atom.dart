import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:quality_assurance_platform/app/common/shared_preferences_atom.dart';

final theme = atom<ThemeMode>(ThemeMode.system);
final updateThemeCache = atomAction1<ThemeMode>((set, newMode) async {
  final prefs = await prefsAtom.state;
  await prefs.setString('theme', newMode.name);
  set(theme, newMode);
});
