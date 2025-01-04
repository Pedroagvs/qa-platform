import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:quality_assurance_platform/app/common/shared_preferences_atom.dart';

// Atom
final themeAtom = atom<Set<ThemeMode>>({ThemeMode.system});

// Action

final changeThemeAction = atomAction1<Set<ThemeMode>>(
  key: 'changeThemeAction',
  (set, newTheme) {
    set(themeAtom, newTheme);
  },
);

final selectorTheme = selector<Future<ThemeMode>>((set) async {
  final theme = await getTheme();
  if (theme.isNotEmpty) {
    if (theme == 'dart') {
      return ThemeMode.dark;
    } else if (theme == 'light') {
      return ThemeMode.light;
    }
  }
  return themeAtom.state.first;
});
