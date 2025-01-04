import 'dart:typed_data';

import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:quality_assurance_platform/app/common/message_atom.dart';
import 'package:quality_assurance_platform/app/common/user_atom.dart';
import 'package:quality_assurance_platform/app/historico/controller/atom/historico_atom.dart';
import 'package:quality_assurance_platform/app/historico/controller/states/historico_state.dart';
import 'package:quality_assurance_platform/core/common/data/dtos/arquivo_dto.dart';
import 'package:quality_assurance_platform/core/functions/regex.dart';
import 'package:quality_assurance_platform/core/functions/show_message.dart';
import 'package:quality_assurance_platform/core/functions/validators.dart';
import 'package:quality_assurance_platform/features/historico/data/dto/historico_dto.dart';

class FormHistoricWidget extends StatefulWidget {
  final int idApplication;
  final String titleApplication;
  const FormHistoricWidget({
    super.key,
    required this.idApplication,
    required this.titleApplication,
  });

  @override
  State<FormHistoricWidget> createState() => _FormHistoricWidgetState();
}

class _FormHistoricWidgetState extends State<FormHistoricWidget>
    with HookStateMixin, MessageToast, Validators {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final historicState = useAtomState(historicStateAtom);
    final page = useAtomState(pageAtom);
    useAtomEffect(
      (get) => get(historicStateAtom),
      effect: (status) {
        if (status.historicoStatus == HistoricoStatus.successCreate ||
            status.historicoStatus == HistoricoStatus.successEdit) {
          updateHistoricStatus(HistoricoStatus.initial);
          toastSuccessMessage(
            context: context,
            description: msgAtom.state,
          );
          updateHistoricGeneric(HistoricoDto.empty());
          updateShowForm(false);
          getHistorics(page, widget.idApplication);
        } else if (status.historicoStatus == HistoricoStatus.failureEdit ||
            status.historicoStatus == HistoricoStatus.failureCreate) {
          toastErrorMessage(
            context: context,
            description: msgAtom.state,
          );
          updateHistoricStatus(HistoricoStatus.initial);
        }
      },
    );
    final userState = useAtomState(userAtom);

    final availableHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top + kToolbarHeight);

    return SizedBox(
      height: availableHeight,
      width: MediaQuery.sizeOf(context).width,
      child: Visibility(
        visible: historicState.historicoStatus == HistoricoStatus.loading,
        replacement: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            Center(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Versão ou Branch:'),
                    SizedBox(
                      height: 70,
                      width: 250,
                      child: TextFormField(
                        maxLength: 13,
                        initialValue: historicState.historicEntity.source,
                        onChanged: (v) => updateVersionAppOrBranch(v),
                        onSaved: (v) => updateVersionAppOrBranch(v ?? ''),
                        decoration: const InputDecoration(
                          helperText: ' ',
                          prefixIcon: Icon(LineIcons.codeBranch),
                        ),
                        validator: (v) => concatValidate(v, [
                          (v) => isNotEmpty(v),
                          (v) => hasSixChars(v),
                        ]),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Features a serem testadas:'),
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxHeight: 220,
                            minHeight: 100,
                            maxWidth: 600,
                          ),
                          child: TextFormField(
                            maxLength: 5000,
                            maxLines: null,
                            minLines: 15,
                            keyboardType: TextInputType.multiline,
                            initialValue: historicState.historicEntity.feature,
                            onChanged: (v) => updateFeaturesTestadas(v),
                            onSaved: (v) => updateFeaturesTestadas(v ?? ''),
                            validator: isNotEmpty,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: historicState.historicEntity.arquivoEntity != null &&
                  historicState.historicEntity.arquivoEntity!.nome.isNotEmpty &&
                  historicState.historicEntity.arquivoEntity!.path.isNotEmpty,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ConstrainedBox(
                    constraints:
                        const BoxConstraints(maxWidth: 400, maxHeight: 350),
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Flexible(
                            flex: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(2),
                              child: Visibility(
                                visible: !RegexApp.isImage(
                                  historicState
                                          .historicEntity.arquivoEntity?.nome ??
                                      '',
                                ),
                                replacement:
                                    const Icon(Icons.file_present_rounded),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.memory(
                                    historicState.historicEntity.arquivoEntity
                                            ?.bytes ??
                                        Uint8List.fromList([]),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              historicState
                                      .historicEntity.arquivoEntity?.nome ??
                                  '',
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const Divider(
                            height: 20,
                          ),
                          Flexible(
                            child: OutlinedButton.icon(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              label: const Text('Excluir'),
                              onPressed: () {
                                if (historicState.isEdit &&
                                    historicState
                                            .historicEntity.arquivoEntity?.id !=
                                        -1) {
                                  deleteFileHistoric(
                                    historicState.historicEntity.idHistorico ??
                                        0,
                                  );
                                }
                                updateFile(ArquivoDto.empty());
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState?.save();
                            if (historicState.isEdit) {
                              editHistoric(
                                {
                                  'idHistorico': historicState
                                          .historicEntity.idHistorico ??
                                      0,
                                  'fonte': historicState.historicEntity.source,
                                  'descricao':
                                      historicState.historicEntity.feature,
                                },
                              );
                            } else {
                              createHistoric(
                                (
                                  widget.idApplication,
                                  userState?.name ?? '',
                                  historicState.historicEntity.source,
                                  historicState.historicEntity.feature,
                                  widget.titleApplication,
                                  historicState.historicEntity.arquivoEntity
                                ),
                              );
                            }
                          }
                        },
                        child: Text(
                          historicState.isEdit ? 'Salvar' : 'Criar',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: historicState.historicoStatus !=
                                HistoricoStatus.anexarArquivo
                            ? () async => getFile()
                            : null,
                        child: Text(
                          historicState.historicoStatus ==
                                  HistoricoStatus.anexarArquivo
                              ? 'Carregando...'
                              : 'Adicionar arquivo',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {
                        updateFile(ArquivoDto.empty());
                        updateHistoricGeneric(HistoricoDto.empty());
                        updateIsEdit(false);
                        updateShowForm(false);
                      },
                      label: const Text('Voltar'),
                      icon: const Icon(Icons.arrow_back_rounded),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                historicState.isEdit
                    ? 'Salvando a alteração...'
                    : 'Criando o histórico aguarde...',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
