import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:quality_assurance_platform/app/login/controller/atom/login_atom.dart';
import 'package:quality_assurance_platform/app/routes_atom.dart';
import 'package:quality_assurance_platform/core/common/presentation/atom/theme_atom.dart';
import 'package:quality_assurance_platform/routes.g.dart';
import 'package:routefly/routefly.dart';

class ConfigWidget extends StatelessWidget with HookMixin {
  const ConfigWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final availableHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top + kToolbarHeight);
    final themeState = useAtomState(themeAtom);
    return SizedBox(
      height: availableHeight,
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: availableHeight * 0.9,
            child: Column(
              children: [
                const Text(
                  'Tema',
                ),
                SegmentedButton<ThemeMode>(
                  segments: const [
                    ButtonSegment<ThemeMode>(
                      label: Text('Claro'),
                      value: ThemeMode.light,
                    ),
                    ButtonSegment<ThemeMode>(
                      label: Text('Sistema'),
                      value: ThemeMode.system,
                    ),
                    ButtonSegment<ThemeMode>(
                      label: Text('Escuro'),
                      value: ThemeMode.dark,
                    ),
                  ],
                  showSelectedIcon: false,
                  selected: themeState,
                  onSelectionChanged: (t) {
                    updateThemeCache(t.first);
                    changeThemeAction(t);
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: availableHeight * 0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {
                    updateIslogged(false);
                    updateUser(null);
                    clearCache();
                    Routefly.navigate(routePaths.login);
                  },
                  child: const Text('Sair'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
