import 'dart:async';
import 'dart:convert';

import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:quality_assurance_platform/app/common/atoms/shared_preferences_atom.dart';
import 'package:quality_assurance_platform/app/common/atoms/user_atom.dart';
import 'package:quality_assurance_platform/app/login/controller/atom/login_atom.dart';
import 'package:quality_assurance_platform/core/common/data/dtos/user_dto.dart';
import 'package:quality_assurance_platform/core/common/presentation/atom/theme_atom.dart';
import 'package:quality_assurance_platform/core/config/colors/theme.dart';
import 'package:quality_assurance_platform/core/config/text/util.dart';
import 'package:quality_assurance_platform/core/functions/show_message.dart';
import 'package:quality_assurance_platform/core/inject/inject_container.dart';
import 'package:routefly/routefly.dart';
import 'package:url_strategy/url_strategy.dart';

import '../routes.g.dart';

GetIt getIt = GetIt.instance;
Future<void> main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  injectContainer(getIt);
  // AtomObserver.changes((status) {
  //   log(status.toString());
  // });
  runApp(const MyApp());
}

Timer? timer;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with HookStateMixin, MessageToast {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final theme = await useAtomState(selectorTheme);
      changeThemeAction({theme});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = useAtomState(themeAtom);
    final themeApp =
        MaterialTheme(createTextTheme(context, 'Nunito Sans', 'Montserrat'));

    FutureOr<RouteInformation> checkAuthRouteFly(
      RouteInformation routeInformation,
    ) async {
      final jsonUser = await getUser();
      if (jsonUser.isNotEmpty) {
        updateUser(UserDto.fromJson(jsonDecode(jsonUser)));
        updateIslogged(true);
      }
      if (!isLoggedAtom.state &&
          !routeInformation.uri.path.contains('/login')) {
        return routeInformation.redirect(Uri.parse(routePaths.login));
      }
      return routeInformation;
    }

    return Listener(
      onPointerMove: (event) {
        if (timer != null) {
          timer?.cancel();
          timer = null;
        }
      },
      onPointerDown: (event) {
        if (!(Routefly.currentUri.path.compareTo('/login') == 0)) {
          if (timer != null) {
            timer?.cancel();
            timer = null;
          }
          timer = Timer(const Duration(minutes: 30), () {
            updateIslogged(false);
            updateUser(null);
            Routefly.navigate(routePaths.login);
            timer?.cancel();
            timer = null;
          });
        }
      },
      child: MaterialApp.router(
        title: 'Quality Assurance Platform',
        debugShowCheckedModeBanner: false,
        theme: themeApp.light(),
        darkTheme: themeApp.dark(),
        themeMode: theme.first,
        routerConfig: Routefly.routerConfig(
          routes: routes,
          initialPath: routePaths.login,
          notFoundPath: routePaths.notFound,
          middlewares: [
            checkAuthRouteFly,
          ],
        ),
      ),
    );
  }
}
