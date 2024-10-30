import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:quality_assurance_platform/app/historico/controller/atom/historico_atom.dart';
import 'package:quality_assurance_platform/app/routes_atom.dart';
import 'package:quality_assurance_platform/core/common/domain/entities/historico_entity.dart';
import 'package:quality_assurance_platform/core/common/presentation/widgets/pop_up_delete.dart';
import 'package:quality_assurance_platform/routes.g.dart';
import 'package:routefly/routefly.dart';

class CardHistorico extends StatelessWidget with HookMixin {
  final HistoricEntity historico;
  final String title;
  final int totalTickets;
  final int totalTicketsFinalizados;
  final int idAplicacao;
  const CardHistorico({
    super.key,
    required this.historico,
    required this.title,
    required this.totalTickets,
    required this.totalTicketsFinalizados,
    required this.idAplicacao,
  });

  @override
  Widget build(BuildContext context) {
    final page = useAtomState(pageAtom);
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 600),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: GestureDetector(
          onTap: () {
            final args = {
              'title': title,
              'description': historico.feature,
              'idHistorico': historico.idHistorico,
              'source': historico.source,
              'historicClosed': historico.closed,
            };
            updateRoutes(
              routePaths.testes,
              args,
            );
            Routefly.pushNavigate(
              routePaths.testes,
              arguments: args,
            ).then((_) {
              getHistorics(page, idAplicacao);
            });
          },
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(LineIcons.codeBranch),
                        Text(
                          historico.source.length > 5
                              ? '${historico.source.substring(0, 5)}...'
                              : historico.source,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                  FittedBox(
                    child: Text(
                      historico.dataCadastro,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Flexible(
                    child: Visibility(
                      visible: totalTicketsFinalizados == totalTickets &&
                          totalTickets != 0,
                      replacement: const Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.red,
                      ),
                      child: const Icon(
                        Icons.check_box,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  FittedBox(
                    child: Text(
                      '$totalTicketsFinalizados / $totalTickets',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Flexible(
                    child: Container(
                      width: 200,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: historico.closed ? Colors.green : Colors.orange,
                      ),
                      child: Text(
                        textAlign: TextAlign.center,
                        historico.closed ? 'Concluído' : 'Em andamento',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Flexible(
                    child: PopupMenuButton(
                      itemBuilder: (BuildContext context) {
                        return [
                          PopupMenuItem<String>(
                            enabled: !historico.closed,
                            value: 'editar',
                            child: const ListTile(
                              leading: Text('Editar'),
                              trailing: Icon(
                                Icons.edit,
                              ),
                            ),
                          ),
                          PopupMenuItem<String>(
                            enabled: historico.arquivoEntity != null,
                            value: 'download',
                            child: const ListTile(
                              leading: Text('Baixar arquivo'),
                              trailing: Icon(
                                Icons.download,
                              ),
                            ),
                          ),
                          const PopupMenuItem<String>(
                            value: 'relatorio',
                            child: ListTile(
                              leading: Text('Baixar relatório'),
                              trailing: Icon(
                                LineIcons.fileCsv,
                              ),
                            ),
                          ),
                          PopupMenuItem<String>(
                            enabled: !historico.closed,
                            value: 'finalizar',
                            child: const ListTile(
                              leading: Text('Finalizar grupo'),
                              trailing: Icon(
                                Icons.check_circle,
                              ),
                            ),
                          ),
                          PopupMenuItem<String>(
                            enabled: !historico.closed,
                            value: 'deletar',
                            child: const ListTile(
                              leading: Text('Deletar'),
                              trailing: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ];
                      },
                      onSelected: (String value) {
                        if (value.contains('deletar')) {
                          PopUp(
                            context: context,
                            onAcceptQuestion: () => deleteHistoric(
                              historico.idHistorico!,
                              idAplicacao,
                            ),
                            message:
                                'Tem certeza de que deseja excluir este histórico ?',
                          );
                        } else if (value.contains('download')) {
                          getFileHistoric(
                            historico.idHistorico ?? 0,
                            historico.arquivoEntity?.id ?? 0,
                            historico.arquivoEntity?.nome ?? 'sem nome',
                          );
                        } else if (value.contains('editar')) {
                          updateHistoricGeneric(
                            HistoricEntity(
                              idHistorico: historico.idHistorico ?? 0,
                              creator: historico.creator,
                              source: historico.source,
                              feature: historico.feature,
                              dataCadastro: historico.dataCadastro,
                              arquivoEntity: historico.arquivoEntity,
                            ),
                          );
                          updateIsEdit(true);
                          updateShowForm(true);
                        } else if (value.contains('relatorio')) {
                          getReport(historico.idHistorico ?? 0);
                        } else if (value.contains('finalizar')) {
                          editHistoric(
                            {
                              'idHistorico': historico.idHistorico ?? 0,
                              'fechado': true,
                            },
                          );
                        }
                      },
                      position: PopupMenuPosition.under,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
