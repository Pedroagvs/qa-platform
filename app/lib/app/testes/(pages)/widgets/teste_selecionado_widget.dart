import 'dart:typed_data';

import 'package:asp/asp.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:quality_assurance_platform/app/login/controller/atom/login_atom.dart';
import 'package:quality_assurance_platform/app/testes/controller/atom/teste_atom.dart';
import 'package:quality_assurance_platform/app/testes/controller/states/testes_state.dart';
import 'package:quality_assurance_platform/core/common/domain/entities/test_entity.dart';
import 'package:quality_assurance_platform/core/common/presentation/widgets/pop_up_delete.dart';
import 'package:quality_assurance_platform/core/functions/show_message.dart';

class TesteSelecionadoPage extends StatefulWidget {
  final int idHistorico;
  final int idTeste;
  const TesteSelecionadoPage({
    super.key,
    required this.idHistorico,
    required this.idTeste,
  });

  @override
  State<TesteSelecionadoPage> createState() => _TesteSelecionadoPageState();
}

class _TesteSelecionadoPageState extends State<TesteSelecionadoPage>
    with HookStateMixin, MessageToast {
  @override
  void initState() {
    getFilesTest(widget.idTeste);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = useAtomState(userAtom);
    final testeState = useAtomState(selectorTestStateAtom);

    final controllerDescricao = TextEditingController(
      text: testeState.selectedTest.descricao,
    );
    final controllerPassos = TextEditingController(
      text: testeState.selectedTest.passos,
    );
    final controllerObservacoes = TextEditingController(
      text: testeState.selectedTest.observacoes,
    );
    final controllerLogin = TextEditingController(
      text: testeState.selectedTest.loginTeste,
    );
    final controllerSenha = TextEditingController(
      text: testeState.selectedTest.senhaTeste,
    );
    final controllerResultadoEsperado = TextEditingController(
      text: testeState.selectedTest.resultadoEsperado,
    );
    final controllerTester = TextEditingController(
      text: testeState.selectedTest.tester,
    );
    final controllerAnalista = TextEditingController(
      text: testeState.selectedTest.responsavel,
    );
    final formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Wrap(
              runSpacing: 20,
              spacing: 20,
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                if (testeState.isEditing)
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 200),
                      width: MediaQuery.sizeOf(context).width * 0.45,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<SituacaoTeste>(
                          isExpanded: true,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          icon: const Icon(
                            Icons.arrow_downward,
                          ),
                          alignment: AlignmentDirectional.center,
                          elevation: 15,
                          value: testeState.selectedTest.situacaoTeste,
                          borderRadius: BorderRadius.circular(12),
                          items: SituacaoTeste.values
                              .where(
                                (s) =>
                                    s != SituacaoTeste.todos &&
                                    s != SituacaoTeste.finalizado,
                              )
                              .toList()
                              .map<DropdownMenuItem<SituacaoTeste>>(
                                (s) => DropdownMenuItem<SituacaoTeste>(
                                  value: s,
                                  child: Text(
                                    TesteEntity.getSituacao(s),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (s) =>
                              updateSituationTeste(s ?? SituacaoTeste.pendente),
                        ),
                      ),
                    ),
                  ),
                if (!testeState.isEditing)
                  Container(
                    constraints: const BoxConstraints(minWidth: 200),
                    width: MediaQuery.sizeOf(context).width * 0.25,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: TesteEntity.getColorSituacaoTeste(
                        testeState.selectedTest.situacaoTeste,
                      ),
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        TesteEntity.getSituacao(
                          testeState.selectedTest.situacaoTeste,
                        ),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 48, 45, 45),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.25,
                  constraints: const BoxConstraints(minWidth: 200),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: TesteEntity.getColorTagTeste(
                      testeState.selectedTest.tagTeste,
                    ),
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      TesteEntity.getTagTeste(testeState.selectedTest.tagTeste),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Wrap(
              runSpacing: 20,
              spacing: 20,
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Container(
                  constraints:
                      const BoxConstraints(minWidth: 400, maxWidth: 600),
                  height: 47,
                  width: MediaQuery.sizeOf(context).width * 0.45,
                  child: TextFormField(
                    controller: controllerLogin,
                    readOnly:
                        !testeState.isEditing || testeState.selectedTest.closed,
                    onSaved: (newValue) => updateLogin(newValue ?? ''),
                    decoration: const InputDecoration(
                      label: Text(
                        'Login',
                      ),
                    ),
                  ),
                ),
                Container(
                  constraints:
                      const BoxConstraints(minWidth: 400, maxWidth: 600),
                  height: 47,
                  width: MediaQuery.sizeOf(context).width * 0.45,
                  child: TextFormField(
                    readOnly:
                        !testeState.isEditing || testeState.selectedTest.closed,
                    controller: controllerSenha,
                    onSaved: (newValue) => updateSenha(newValue ?? ''),
                    decoration: const InputDecoration(
                      label: Text(
                        'Senha',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Wrap(
              runSpacing: 20,
              spacing: 20,
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Container(
                  constraints:
                      const BoxConstraints(minWidth: 400, maxWidth: 600),
                  height: 47,
                  width: MediaQuery.sizeOf(context).width * 0.45,
                  child: TextFormField(
                    controller: controllerTester,
                    onSaved: (newValue) => updateTester(newValue ?? ''),
                    readOnly:
                        !testeState.isEditing || testeState.selectedTest.closed,
                    decoration: const InputDecoration(
                      label: Text(
                        'Tester',
                      ),
                    ),
                  ),
                ),
                Container(
                  constraints:
                      const BoxConstraints(minWidth: 400, maxWidth: 600),
                  height: 47,
                  width: MediaQuery.sizeOf(context).width * 0.45,
                  child: TextFormField(
                    readOnly:
                        !testeState.isEditing || testeState.selectedTest.closed,
                    controller: controllerAnalista,
                    onSaved: (newValue) => updateResponsavel(newValue ?? ''),
                    decoration: const InputDecoration(
                      label: Text(
                        'Analista',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Wrap(
              runSpacing: 20,
              spacing: 20,
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Container(
                  constraints:
                      const BoxConstraints(maxWidth: 600, minWidth: 400),
                  width: MediaQuery.sizeOf(context).width * 0.45,
                  child: TextFormField(
                    controller: controllerPassos,
                    maxLength: 5000,
                    maxLines: 5,
                    minLines: 5,
                    readOnly:
                        !testeState.isEditing || testeState.selectedTest.closed,
                    keyboardType: TextInputType.multiline,
                    onSaved: (newValue) => updatePassos(newValue ?? ''),
                    decoration: const InputDecoration(
                      label: Text('Passos'),
                    ),
                  ),
                ),
                Container(
                  constraints:
                      const BoxConstraints(maxWidth: 600, minWidth: 400),
                  width: MediaQuery.sizeOf(context).width * 0.45,
                  child: TextFormField(
                    controller: controllerObservacoes,
                    maxLength: 5000,
                    maxLines: 5,
                    minLines: 5,
                    onSaved: (newValue) => updateObservation(newValue ?? ''),
                    readOnly:
                        !testeState.isEditing || testeState.selectedTest.closed,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      label: Text('Observações'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Wrap(
              runSpacing: 20,
              spacing: 20,
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Container(
                  constraints:
                      const BoxConstraints(maxWidth: 600, minWidth: 400),
                  width: MediaQuery.sizeOf(context).width * 0.45,
                  child: TextFormField(
                    controller: controllerResultadoEsperado,
                    maxLength: 5000,
                    maxLines: 5,
                    minLines: 5,
                    readOnly:
                        !testeState.isEditing || testeState.selectedTest.closed,
                    onSaved: (newValue) =>
                        updateResultadoEsperado(newValue ?? ''),
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      label: Text('Resultado esperado'),
                    ),
                  ),
                ),
                Container(
                  constraints:
                      const BoxConstraints(maxWidth: 600, minWidth: 400),
                  width: MediaQuery.sizeOf(context).width * 0.45,
                  child: TextFormField(
                    controller: controllerDescricao,
                    maxLength: 5000,
                    maxLines: 5,
                    minLines: 5,
                    onSaved: (newValue) => updateDescription(newValue ?? ''),
                    readOnly:
                        !testeState.isEditing || testeState.selectedTest.closed,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      label: Text('Descrição'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: testeState.selectedTest.arquivos.isNotEmpty,
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                  },
                ),
                child: Column(
                  children: [
                    const Divider(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text('Arquivos'),
                    ),
                    Wrap(
                      alignment: WrapAlignment.center,
                      runAlignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      runSpacing: 20,
                      spacing: 20,
                      children: testeState.selectedTest.arquivos
                          .map(
                            (f) => Container(
                              constraints: const BoxConstraints(
                                maxHeight: 350,
                                maxWidth: 250,
                              ),
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Visibility(
                                            visible:
                                                !testeState.selectedTest.closed,
                                            child: IconButton(
                                              onPressed: () => deleteFile(
                                                testeState.selectedTest.id,
                                                f.id,
                                              ),
                                              icon: const Icon(
                                                Icons.close,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Flexible(
                                        flex: 3,
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 5,
                                              horizontal: 3,
                                            ),
                                            child: Visibility(
                                              visible: testeState
                                                          .statusTestes ==
                                                      StatusTestes
                                                          .loadingDownloadFile &&
                                                  f.bytes == null,
                                              replacement: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: f.bytes != null
                                                    ? Image.memory(
                                                        f.bytes ??
                                                            Uint8List.fromList(
                                                              [],
                                                            ),
                                                      )
                                                    : const Icon(
                                                        Icons
                                                            .file_present_rounded,
                                                        size: 48,
                                                      ),
                                              ),
                                              child:
                                                  const CircularProgressIndicator(),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Text(
                                            f.nome,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 12,
                                          ),
                                          child: Visibility(
                                            visible: f.bytes != null,
                                            child: OutlinedButton.icon(
                                              label: const Text('Baixar'),
                                              icon: const Icon(
                                                Icons.download,
                                              ),
                                              onPressed: () => downloadFile(
                                                f,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    const Divider(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: Wrap(
              runSpacing: 20,
              spacing: 20,
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Visibility(
                  visible: testeState.isEditing,
                  replacement: Visibility(
                    visible: testeState.selectedTest.arquivos.isNotEmpty,
                    child: ElevatedButton(
                      onPressed: testeState.selectedTest.closed ||
                              testeState.statusTestes ==
                                  StatusTestes.baixandoArquivos
                          ? null
                          : () {
                              if (testeState.selectedTest.arquivos.isEmpty) {
                                toastErrorMessage(
                                  context: context,
                                  title: 'Baixar Arquivos',
                                  description: 'Sem arquivos anexados.',
                                );
                              } else {
                                downloadAllFiles();
                              }
                            },
                      child: Visibility(
                        visible: testeState.statusTestes ==
                            StatusTestes.baixandoArquivos,
                        replacement: Visibility(
                          visible: testeState.statusTestes ==
                              StatusTestes.arquivosBaixados,
                          replacement: const Text(
                            'Baixar arquivos',
                          ),
                          child: const Text(
                            'Concluído',
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 15,
                              height: 15,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Text(
                                'Baixando...',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () async => testeState.statusTestes !=
                            StatusTestes.loadingUploadFiles
                        ? {
                            updateFilesTestSelected(),
                          }
                        : null,
                    child: Text(
                      testeState.statusTestes != StatusTestes.loadingUploadFiles
                          ? 'Anexar arquivos'
                          : 'Carregando...',
                    ),
                  ),
                ),
                Visibility(
                  visible: !testeState.selectedTest.closed &&
                      (user?.funcionalidades.contains('Editar') ?? false),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (testeState.isEditing) {
                        formKey.currentState!.save();
                        saveEdit(
                          {
                            'idTeste': testeState.selectedTest.id,
                            'responsavel': controllerAnalista.text,
                            'tester': controllerTester.text,
                            'usuario': controllerLogin.text,
                            'senha': controllerSenha.text,
                            'devolutiva': controllerResultadoEsperado.text,
                            'descricao': controllerObservacoes.text,
                            'passos': controllerPassos.text,
                            'observacoes': controllerObservacoes.text,
                            'situacao': TesteEntity.getSituacao(
                              testeState.selectedTest.situacaoTeste,
                            ),
                          },
                        );

                        updateEditingtest(false);
                      } else {
                        updateEditingtest(true);
                      }
                    },
                    icon: Icon(
                      testeState.isEditing ? Icons.save : Icons.edit,
                    ),
                    label: Text(
                      testeState.isEditing ? 'Salvar' : 'Editar',
                    ),
                  ),
                ),
                Visibility(
                  visible: !testeState.selectedTest.closed &&
                      !testeState.isEditing &&
                      (user?.funcionalidades.contains('Finalizar') ?? false),
                  child: ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.green),
                    ),
                    onPressed: () => PopUp(
                      context: context,
                      onAcceptQuestion: () {
                        finishTest(
                          {
                            'idTeste': testeState.selectedTest.id,
                            'fechado': true,
                            'situacao': 'Finalizado',
                          },
                        );
                      },
                      message: 'Deseja finalizar o ticket?',
                    ),
                    child: const Text(
                      'Finalizar',
                    ),
                  ),
                ),
                Visibility(
                  visible: !testeState.isEditing &&
                      !testeState.selectedTest.closed &&
                      (user?.funcionalidades.contains('Deletar') ?? false),
                  child: ElevatedButton(
                    onPressed: () => PopUp(
                      context: context,
                      onAcceptQuestion: () => deleteTicketTest(
                        testeState.selectedTest.id,
                        widget.idHistorico,
                      ),
                      message: 'Deseja excluir o ticket?',
                    ),
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        Colors.red,
                      ),
                    ),
                    child: const Text(
                      'Deletar Ticket',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: SizedBox(
                width: 200,
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    showFormSelectedTest(false);
                    if (testeState.isEditing) {
                      updateEditingtest(false);
                    }
                  },
                  label: const Text('Voltar'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
