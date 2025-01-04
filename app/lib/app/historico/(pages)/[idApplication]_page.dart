import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:quality_assurance_platform/app/common/message_atom.dart';
import 'package:quality_assurance_platform/app/common/shared_preferences_atom.dart';
import 'package:quality_assurance_platform/app/common/user_atom.dart';
import 'package:quality_assurance_platform/app/historico/(pages)/widgets/card_historico_widget.dart';
import 'package:quality_assurance_platform/app/historico/(pages)/widgets/form_historic_widget.dart';
import 'package:quality_assurance_platform/app/historico/controller/atom/historico_atom.dart';
import 'package:quality_assurance_platform/app/historico/controller/states/historico_state.dart';
import 'package:quality_assurance_platform/core/functions/show_message.dart';
import 'package:quality_assurance_platform/features/historico/data/dto/historico_dto.dart';
import 'package:quality_assurance_platform/routes.g.dart';
import 'package:routefly/routefly.dart';

class HistoricoPage extends StatefulWidget {
  const HistoricoPage({
    super.key,
  });

  @override
  State<HistoricoPage> createState() => _HistoricoPageState();
}

class _HistoricoPageState extends State<HistoricoPage>
    with HookStateMixin, MessageToast {
  final _searchController = TextEditingController();
  String titleApplication = '';
  int idApplication = 0;
  @override
  void initState() {
    super.initState();
    final query = Routefly.query;
    var args = <String, dynamic>{};
    if (query['idApplication'] != null) {
      idApplication = query['idApplication'] ?? '0';
      getHistorics(pageAtom.state, idApplication);
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (query.arguments == null) {
          args = await getArgs('h_$idApplication');
        }
        titleApplication = query.arguments?['title'] ?? args['title'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = useAtomState(userAtom);
    final page = useAtomState(pageAtom);
    final historicState = useAtomState(historicStateAtom);
    final showFormState = useAtomState(showFormHistoricAtom);
    useAtomEffect(
      (get) => get(historicStatusAtom),
      effect: (status) {
        if (status == HistoricoStatus.successEdit ||
            status == HistoricoStatus.successCreate ||
            status == HistoricoStatus.successDelete) {
          toastSuccessMessage(
            context: context,
            description: msgAtom.state,
          );
          getHistorics(page, idApplication);
        }
      },
    );

    final appBar = AppBar(
      leading: Material(
        child: InkWell(
          onTap: () {
            Routefly.navigate(routePaths.home);
            updateHistoricGeneric(HistoricoDto.empty());
            updateIsEdit(false);
            updateShowForm(false);
          },
          child: const Icon(Icons.arrow_circle_left_outlined),
        ),
      ),
      title: Text(
        titleApplication,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 200),
            width: MediaQuery.sizeOf(context).width * 0.3,
            height: 40,
            child: TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                constraints: const BoxConstraints(
                  maxHeight: 250,
                  maxWidth: 250,
                  minHeight: 30,
                  minWidth: 200,
                ),
                filled: true,
                hintText: 'Pesquisar',
                suffixIcon: IconButton(
                  onPressed: () {
                    updateFilter('');
                    updateFilteredHistorics([]);
                    _searchController.clear();
                  },
                  icon: const Icon(Icons.clear),
                ),
              ),
              onChanged: (value) {
                if (value.length > 3) {
                  filterList(value, historicState.historics);
                } else if (value.isEmpty) {
                  updateFilter('');
                  updateFilteredHistorics([]);
                }
              },
            ),
          ),
        ),
      ],
    );
    final availableHeight =
        MediaQuery.sizeOf(context).height - appBar.preferredSize.height;

    return Scaffold(
      appBar: appBar,
      body: SizedBox(
        height: availableHeight,
        width: MediaQuery.sizeOf(context).width,
        child: SingleChildScrollView(
          child: Visibility(
            visible: showFormState,
            replacement: Visibility(
              visible: historicState.historicoStatus == HistoricoStatus.loading,
              replacement: Visibility(
                visible:
                    historicState.historicoStatus == HistoricoStatus.failureGet,
                replacement: Visibility(
                  visible: historicState.historics.isEmpty,
                  replacement: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    itemCount: historicState.filteredHistorics.isNotEmpty
                        ? historicState.filteredHistorics.length
                        : historicState.historics.length,
                    itemBuilder: (context, index) {
                      if (historicState.filteredHistorics.isNotEmpty) {
                        return CardHistorico(
                          totalTickets: historicState
                                  .filteredHistorics[index].closedTickets +
                              historicState
                                  .filteredHistorics[index].openedTickets,
                          totalTicketsFinalizados: historicState
                              .filteredHistorics[index].closedTickets,
                          title: titleApplication,
                          historico: historicState.filteredHistorics[index],
                          idAplicacao: idApplication,
                        );
                      } else {
                        return CardHistorico(
                          totalTickets:
                              historicState.historics[index].closedTickets +
                                  historicState.historics[index].openedTickets,
                          totalTicketsFinalizados:
                              historicState.historics[index].closedTickets,
                          title: titleApplication,
                          historico: historicState.historics[index],
                          idAplicacao: idApplication,
                        );
                      }
                    },
                  ),
                  child: SizedBox(
                    height: availableHeight,
                    width: MediaQuery.sizeOf(context).width,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Nenhum histórico encontrado.',
                        ),
                      ],
                    ),
                  ),
                ),
                child: SizedBox(
                  height: availableHeight,
                  width: MediaQuery.sizeOf(context).width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Houve um problema ao carregar o histórico.',
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            updatePage(0);
                            getHistorics(0, idApplication);
                          },
                          child: const Text('Tentar novamente'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              child: const LinearProgressIndicator(),
            ),
            child: FormHistoricWidget(
              idApplication: idApplication,
              titleApplication: titleApplication,
            ),
          ),
        ),
      ),
      bottomNavigationBar: showFormState
          ? null
          : SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      child: OutlinedButton(
                        onPressed: page == 0 ||
                                historicState.historicoStatus ==
                                    HistoricoStatus.loading
                            ? null
                            : () {
                                updatePage(page - 1);
                                getHistorics(page - 1, idApplication);
                              },
                        child: const Text('Anterior'),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      child: OutlinedButton(
                        onPressed: historicState.historics.length < 10 ||
                                historicState.historicoStatus ==
                                    HistoricoStatus.loading
                            ? null
                            : () {
                                updatePage(page + 1);
                                getHistorics(page + 1, idApplication);
                              },
                        child: const Text('Próximo'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: Visibility(
        visible: !showFormState &&
            (user?.funcionalidades.contains('Criar') ?? false),
        child: FloatingActionButton.extended(
          onPressed: () {
            updateHistoricGeneric(HistoricoDto.empty());
            updateIsEdit(false);
            updateShowForm(true);
          },
          label: const Text('Novo'),
          icon: const Icon(LineIcons.vials),
        ),
      ),
    );
  }
}
