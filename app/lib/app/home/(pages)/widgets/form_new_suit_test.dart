import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:quality_assurance_platform/app/common/message_atom.dart';
import 'package:quality_assurance_platform/app/home/controller/atoms/suites_atom.dart';
import 'package:quality_assurance_platform/app/home/controller/states/suites_state.dart';
import 'package:quality_assurance_platform/core/common/domain/entities/test_entity.dart';
import 'package:quality_assurance_platform/core/functions/show_message.dart';

class FormNewSuitTestWidget extends StatefulWidget {
  const FormNewSuitTestWidget({
    super.key,
  });

  @override
  State<FormNewSuitTestWidget> createState() => _FormNewSuitTestWidgetState();
}

class _FormNewSuitTestWidgetState extends State<FormNewSuitTestWidget>
    with HookStateMixin, MessageToast {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final applicationState = useAtomState(applicationSelectAtom);
    final controllerTitle =
        TextEditingController(text: applicationState.application.title);
    final availableHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top + kToolbarHeight);
    useAtomEffect(
      (get) => get(applicationStatusAtom),
      effect: (status) {
        if (status == ApplicationStatus.successCreate ||
            status == ApplicationStatus.successEdit) {
          updateShowFormSuite(false);
          toastSuccessMessage(
            context: context,
            title: 'Sucesso',
            description: msgAtom.state,
          );
          updateApplicationStatus(ApplicationStatus.initial);
          clearGenericSuite();
        } else if (status == ApplicationStatus.failureEdit ||
            status == ApplicationStatus.failureCreate) {
          toastErrorMessage(
            context: context,
            title: 'Erro',
            description: msgAtom.state,
          );
          updateApplicationStatus(ApplicationStatus.initial);
        }
      },
    );
    return SizedBox(
      height: availableHeight,
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Form(
                key: formKey,
                child: TextFormField(
                  controller: controllerTitle,
                  decoration: const InputDecoration(label: Text('Titulo')),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obrigatório';
                    } else if (value.length < 5) {
                      return 'Minímo 5 caracteres';
                    }
                    return null;
                  },
                ),
              ),
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: DropdownButtonFormField<Platform>(
                value: applicationState.application.platform,
                icon: const Icon(Icons.arrow_downward_rounded),
                hint: const Text('Escolha o tipo de aplicação'),
                isExpanded: true,
                items: const [
                  DropdownMenuItem(
                    value: Platform.mobile,
                    child: Text('Mobile'),
                  ),
                  DropdownMenuItem(
                    value: Platform.web,
                    child: Text('Web'),
                  ),
                ],
                onChanged: applicationState.isEdit
                    ? null
                    : (Platform? value) =>
                        updatePlatform(value ?? Platform.mobile),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: SizedBox(
              width: 250,
              height: 40,
              child: ElevatedButton(
                onPressed: applicationState.applicationStatus ==
                        ApplicationStatus.loading
                    ? null
                    : () {
                        if (formKey.currentState!.validate()) {
                          if (applicationState.isEdit) {
                            editSuite(
                              controllerTitle.text,
                              applicationState.application.platform.name,
                              applicationState.application.id,
                            );
                          } else {
                            createSuite(
                              controllerTitle.text,
                              applicationState.application.platform.name,
                            );
                          }
                        }
                      },
                child: Text(applicationState.isEdit ? 'Editar' : 'Criar'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: SizedBox(
              width: 250,
              height: 40,
              child: OutlinedButton(
                onPressed: applicationState.applicationStatus ==
                        ApplicationStatus.loading
                    ? null
                    : () => updateShowFormSuite(false),
                child: const Text('Voltar'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
