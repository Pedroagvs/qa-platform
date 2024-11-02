import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:quality_assurance_platform/app/home/(pages)/widgets/aplications_widget.dart';
import 'package:quality_assurance_platform/app/home/(pages)/widgets/config_widget.dart';
import 'package:quality_assurance_platform/app/home/(pages)/widgets/dashboard_widget.dart';
import 'package:quality_assurance_platform/app/home/(pages)/widgets/my_account_widget.dart';
import 'package:quality_assurance_platform/app/home/controller/atoms/home_atom.dart';
import 'package:quality_assurance_platform/app/home/controller/atoms/suites_atom.dart';
import 'package:quality_assurance_platform/app/login/controller/atom/login_atom.dart';
import 'package:quality_assurance_platform/core/functions/show_message.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with MessageToast, HookStateMixin {
  @override
  Widget build(BuildContext context) {
    final homeState = useAtomState(homeAtomSelector);
    final user = useAtomState(userAtom);
    final appBar = AppBar(
      title: Text(homeState.title),
    );
    final availableheight =
        MediaQuery.sizeOf(context).height - appBar.preferredSize.height;

    return Scaffold(
      appBar: appBar,
      body: SizedBox(
        height: availableheight,
        width: MediaQuery.sizeOf(context).width,
        child: SingleChildScrollView(
          child: Row(
            children: [
              Container(
                constraints: const BoxConstraints(maxWidth: 80),
                height: availableheight,
                child: NavigationRail(
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home_outlined),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(LineIcons.pieChart),
                      label: Text('Dashboard'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.person),
                      label: Text('Minha Conta'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(LineIcons.cog),
                      label: Text('Configuração'),
                    ),
                  ],
                  onDestinationSelected: updateIndex,
                  selectedIndex: homeState.selectedIndex,
                ),
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width - 80,
                height: availableheight,
                child: Column(
                  children: [
                    if (homeState.selectedIndex == 0) const AplicationsWidget(),
                    if (homeState.selectedIndex == 1) const DashboardWidget(),
                    if (homeState.selectedIndex == 2) const MyAccountWidget(),
                    if (homeState.selectedIndex == 3) const ConfigWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: homeState.selectedIndex == 0 &&
            (user?.funcionalidades.contains('Criar') ?? false),
        child: FloatingActionButton.extended(
          onPressed: () {
            updateShowFormSuite(true);
            clearGenericSuite();
            updateEditSuite(false);
          },
          label: const Text('Novo'),
          icon: const Icon(LineIcons.vial),
        ),
      ),
    );
  }
}
