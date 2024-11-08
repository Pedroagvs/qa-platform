import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:quality_assurance_platform/app/login/controller/atom/login_atom.dart';
import 'package:quality_assurance_platform/app/routes_atom.dart';
import 'package:quality_assurance_platform/app/testes/(pages)/widgets/bar_info_testes.dart';
import 'package:quality_assurance_platform/app/testes/(pages)/widgets/card_teste.dart';
import 'package:quality_assurance_platform/app/testes/(pages)/widgets/filtro_tickets_status.dart';
import 'package:quality_assurance_platform/app/testes/(pages)/widgets/form_new_test_widget.dart';
import 'package:quality_assurance_platform/app/testes/(pages)/widgets/teste_selecionado_widget.dart';
import 'package:quality_assurance_platform/app/testes/controller/atom/teste_atom.dart';
import 'package:quality_assurance_platform/app/testes/controller/states/testes_state.dart';
import 'package:quality_assurance_platform/core/common/domain/entities/test_entity.dart';
import 'package:quality_assurance_platform/core/functions/show_message.dart';
import 'package:quality_assurance_platform/routes.g.dart';
import 'package:routefly/routefly.dart';

class TestesPage extends StatefulWidget {
  const TestesPage({
    super.key,
  });

  @override
  State<TestesPage> createState() => _TestesPageState();
}

class _TestesPageState extends State<TestesPage>
    with HookStateMixin, MessageToast {
  final formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  String source = '';
  int idHistorico = 0;
  int idApplication = 0;
  bool historicClosed = false;
  @override
  void initState() {
    updateShowFormtest(false);
    showFormSelectedTest(false);
    updateEditingtest(false);
    final query = Routefly.query;
    var args = <String, dynamic>{};
    idHistorico = query['idHistorico'] ?? '0';
    getTestes(idHistorico);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (query.arguments == null) {
        args = await getArgs('T_$idHistorico');
      }
      title = query.arguments?['title'] ?? args['title'] ?? '';
      description =
          query.arguments?['description'] ?? args['description'] ?? '';
      source = query.arguments?['source'] ?? args['source'] ?? '';
      idApplication = query['idApplication'] ?? args['idApplication'] ?? 0;
      historicClosed =
          query.arguments?['historicClosed'] ?? args['historicClosed'] ?? false;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = useAtomState(userAtom);
    final testeState = useAtomState(selectorTestStateAtom);
    final appBar = AppBar(
      leading: Visibility(
        visible: !testeState.showForm && !testeState.showFormSelectedTest,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => Routefly.navigate(
              routePaths.historico.$idApplication
                  .changes({'idApplication': idApplication.toString()}),
            ),
            hoverColor: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: Container(
              color: Theme.of(context).colorScheme.surface,
              child: const Icon(Icons.arrow_circle_left_outlined),
            ),
          ),
        ),
      ),
      title: Text(title),
      actions: [
        Visibility(
          visible: !testeState.showForm && !testeState.showFormSelectedTest,
          child: IconButton(
            onPressed: showInfoDialog,
            hoverColor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            icon: const Icon(Icons.info_outline_rounded),
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(2),
          child: Visibility(
            visible: !testeState.showForm && !testeState.showFormSelectedTest,
            child: Container(
              constraints: const BoxConstraints(minWidth: 200),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white),
              ),
              width: MediaQuery.sizeOf(context).width * 0.2,
              child: FiltroTicketsStatus(
                onChanged: (SituacaoTeste? s) =>
                    filterTestsBySituation(s ?? SituacaoTeste.todos),
                situationSelected: testeState.selectedSituation,
              ),
            ),
          ),
        ),
      ],
    );
    final availableHeight =
        MediaQuery.sizeOf(context).height - appBar.preferredSize.height;

    useAtomEffect(
      (get) => get(statusTestesAtom),
      effect: (status) {
        if (status == StatusTestes.showInfoTest) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  'Features a serem testadas - $source',
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
                content: SizedBox(
                  height: availableHeight * 0.65,
                  width: MediaQuery.sizeOf(context).width * 0.6,
                  child: ListView(
                    children: [
                      Text(
                        description,
                        style: TextStyle(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.black
                                  : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
          updateStatusTeste(StatusTestes.initial);
        } else if (status == StatusTestes.successCreateTeste ||
            status == StatusTestes.successDeleteFile) {
          updateShowFormtest(false);
          showFormSelectedTest(false);
          getTestes(idHistorico);
        } else if (status == StatusTestes.successFinish) {
          toastSuccessMessage(
            context: context,
            description: testeState.msgToast,
          );
          getTestes(idHistorico);
          showFormSelectedTest(false);
        } else if (status == StatusTestes.failureFinish) {
          toastErrorMessage(
            context: context,
            description: testeState.msgToast,
          );
        }
      },
    );

    return Scaffold(
      appBar: appBar,
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: availableHeight,
        child: Visibility(
          visible: testeState.showFormSelectedTest,
          replacement: Visibility(
            visible: testeState.showForm,
            replacement: Column(
              children: [
                SizedBox(
                  height: availableHeight * 0.05,
                  width: MediaQuery.sizeOf(context).width,
                  child: const BarInfoTestes(),
                ),
                SizedBox(
                  height: availableHeight * 0.95,
                  width: MediaQuery.sizeOf(context).width,
                  child: Visibility(
                    visible:
                        testeState.statusTestes == StatusTestes.loadingList,
                    replacement: Visibility(
                      visible: testeState.statusTestes ==
                          StatusTestes.failureLoading,
                      replacement: Visibility(
                        visible: testeState.testes.isNotEmpty,
                        replacement: const Center(
                          child: Text('Nenhum ticket criado ainda...'),
                        ),
                        child: ListView.builder(
                          padding: const EdgeInsets.only(bottom: 100),
                          itemCount: testeState.filteredTests.isNotEmpty
                              ? testeState.filteredTests.length
                              : testeState.testes.length,
                          itemBuilder: (context, index) {
                            if (testeState.filteredTests.isNotEmpty) {
                              return GestureDetector(
                                onTap: () {
                                  updateSelectedTest(
                                    testeState.filteredTests[index],
                                  );
                                  showFormSelectedTest(true);
                                },
                                child: CardTeste(
                                  teste: testeState.filteredTests[index],
                                ),
                              );
                            }
                            return GestureDetector(
                              onTap: () {
                                updateSelectedTest(
                                  testeState.testes[index],
                                );
                                showFormSelectedTest(true);
                              },
                              child: CardTeste(
                                teste: testeState.testes[index],
                              ),
                            );
                          },
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'Erro ao carregar os testes, tente novamente.',
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              await getTestes(idHistorico);
                            },
                            child: const Text('Tentar novamente'),
                          ),
                        ],
                      ),
                    ),
                    child: const Align(
                      alignment: Alignment.topCenter,
                      child: LinearProgressIndicator(),
                    ),
                  ),
                ),
              ],
            ),
            child: FormNewTestPage(
              idHistorico: idHistorico,
            ),
          ),
          child: TesteSelecionadoPage(
            idHistorico: idHistorico,
            idTeste: testeState.selectedTest.id,
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: !testeState.showForm &&
            !testeState.showFormSelectedTest &&
            !historicClosed &&
            (user?.funcionalidades.contains('Criar') ?? false),
        child: FloatingActionButton.extended(
          onPressed: () => updateShowFormtest(true),
          label: const Text('Novo'),
          icon: const Icon(Icons.bug_report),
        ),
      ),
    );
  }
}
