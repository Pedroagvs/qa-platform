import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:quality_assurance_platform/app/common/atoms/shared_preferences_atom.dart';
import 'package:quality_assurance_platform/app/common/atoms/user_atom.dart';
import 'package:quality_assurance_platform/app/home/controller/atoms/suites_atom.dart';
import 'package:quality_assurance_platform/core/common/domain/entities/application_entity.dart';
import 'package:quality_assurance_platform/core/common/domain/entities/test_entity.dart';
import 'package:quality_assurance_platform/core/common/presentation/widgets/pop_up_delete.dart';
import 'package:quality_assurance_platform/routes.g.dart';
import 'package:routefly/routefly.dart';

class CardAplicacao extends StatelessWidget with HookMixin {
  final ApplicationEntity application;
  const CardAplicacao({
    super.key,
    required this.application,
  });

  @override
  Widget build(BuildContext context) {
    final user = useAtomState(userAtom);
    return GestureDetector(
      onTap: () {
        final args = {
          'title': application.title,
        };
        updateArgs('h_${application.id}', args);
        Routefly.navigate(
          routePaths.historico.$idApplication.changes({
            'idApplication': application.id.toString(),
          }),
          arguments: args,
        );
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    application.title,
                    textAlign: TextAlign.center,
                  ),
                  Visibility(
                    visible: application.platform != Platform.web,
                    replacement: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          LineIcons.chrome,
                          size: 26,
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.apple,
                          size: 26,
                        ),
                        Icon(
                          LineIcons.android,
                          size: 26,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 2,
            ),
            Expanded(
              child: Visibility(
                visible: user?.funcionalidades.contains('Editar') ?? false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      child: IconButton(
                        onPressed: () {
                          updateTitle(application.title);
                          updatePlatform(application.platform);
                          updateId(application.id);
                          updateEditSuite(true);
                          updateShowFormSuite(true);
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Visibility(
                        visible:
                            user?.funcionalidades.contains('Deletar') ?? false,
                        child: IconButton(
                          onPressed: () {
                            PopUp(
                              context: context,
                              onAcceptQuestion: () => deleteSuite(
                                application.id,
                              ),
                              message:
                                  'Tem certeza de que deseja prosseguir com a exclusão?',
                            );
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
