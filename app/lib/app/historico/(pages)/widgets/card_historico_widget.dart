import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:quality_assurance_platform/app/common/atoms/shared_preferences_atom.dart';
import 'package:quality_assurance_platform/app/common/atoms/user_atom.dart';
import 'package:quality_assurance_platform/app/historico/controller/atom/historico_atom.dart';
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
    final user = useAtomState(userAtom);
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 600),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: GestureDetector(
          onTap: () {
            final args = {
              'title': title,
              'description': historico.feature,
              'source': historico.source,
              'historicClosed': historico.closed,
              'idApplication': idAplicacao,
            };
            updateArgs('T_${historico.idHistorico}', args);
            Routefly.pushNavigate(
              routePaths.testes.$idHistorico.changes({
                'idHistorico': historico.idHistorico.toString(),
              }),
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
                          if (user?.funcionalidades.contains('Editar') ?? false)
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
                            enabled: historico.fileDto != null,
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
                          if (user?.funcionalidades.contains('Finalizar') ??
                              false)
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
                          if (user?.funcionalidades.contains('Deletar') ??
                              false)
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
                            historico.fileDto?.id ?? 0,
                            historico.fileDto?.name ?? 'sem nome',
                          );
                        } else if (value.contains('editar')) {
                          updateHistoricGeneric(
                            HistoricEntity(
                              idHistorico: historico.idHistorico ?? 0,
                              creator: historico.creator,
                              source: historico.source,
                              feature: historico.feature,
                              dataCadastro: historico.dataCadastro,
                              fileDto: historico.fileDto,
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
