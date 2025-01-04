import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:quality_assurance_platform/app/common/user_atom.dart';
import 'package:quality_assurance_platform/app/testes/(pages)/widgets/list_arquivos_teste.dart';
import 'package:quality_assurance_platform/app/testes/controller/atom/teste_atom.dart';
import 'package:quality_assurance_platform/app/testes/controller/states/testes_state.dart';
import 'package:quality_assurance_platform/core/common/domain/entities/test_entity.dart';
import 'package:quality_assurance_platform/core/functions/validators.dart';

class FormNewTestPage extends StatefulWidget {
  final int idHistorico;
  const FormNewTestPage({super.key, required this.idHistorico});

  @override
  State<FormNewTestPage> createState() => _FormNewTestPageState();
}

class _FormNewTestPageState extends State<FormNewTestPage>
    with HookStateMixin, Validators {
  final formKey = GlobalKey<FormState>();
  final controllerDescricao = TextEditingController();
  final controllerObservacao = TextEditingController();
  final controllerPassos = TextEditingController();
  final controllerFeature = TextEditingController();
  final controllerLogin = TextEditingController();
  final controllerSenha = TextEditingController();
  final controllerResultadoEsperado = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final testeState = useAtomState(selectorTestStateAtom);
    final tagSelected = useAtomState(tagTesteAtom);
    return SizedBox(
      height: MediaQuery.sizeOf(context).height,
      width: MediaQuery.sizeOf(context).width,
      child: Visibility(
        visible: testeState.statusTestes == StatusTestes.loadingAddTeste,
        replacement: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.all(30),
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  runSpacing: 20,
                  spacing: 20,
                  children: [
                    Container(
                      constraints: const BoxConstraints(minWidth: 180),
                      width: MediaQuery.sizeOf(context).width * 0.25,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: TesteEntity.getColorSituacaoTeste(
                          SituacaoTeste.pendente,
                        ),
                      ),
                      child: Text(
                        TesteEntity.getSituacao(
                          SituacaoTeste.pendente,
                        ),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 380,
                      height: 80,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: TagTeste.values.length,
                        itemBuilder: (context, index) {
                          return ChoiceChip(
                            onSelected: (_) =>
                                updateTagSelected(TagTeste.values[index]),
                            label: Text(
                              TesteEntity.getTagTeste(
                                TagTeste.values[index],
                              ),
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            color: const WidgetStatePropertyAll(
                              null,
                            ),
                            selectedColor: TesteEntity.getColorTagTeste(
                              TagTeste.values[index],
                            ),
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .surfaceContainerHighest,
                            selected: TagTeste.values[index] == tagSelected,
                          );
                        },
                        separatorBuilder: (context, index) => const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  runSpacing: 20,
                  spacing: 20,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(minWidth: 135),
                        child: SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.15,
                          child: TextFormField(
                            controller: controllerFeature,
                            decoration: const InputDecoration(
                              label: Text('Tela'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(minWidth: 135),
                        child: SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.15,
                          child: TextFormField(
                            validator: isNotEmpty,
                            controller: controllerLogin,
                            decoration: const InputDecoration(
                              label: Text('Login'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(minWidth: 135),
                        child: SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.15,
                          child: TextFormField(
                            validator: isNotEmpty,
                            controller: controllerSenha,
                            decoration: const InputDecoration(
                              label: Text('Senha'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  runSpacing: 20,
                  spacing: 20,
                  children: [
                    Container(
                      constraints: const BoxConstraints(maxWidth: 500),
                      width: MediaQuery.sizeOf(context).width * 0.5,
                      child: TextFormField(
                        validator: isNotEmpty,
                        controller: controllerDescricao,
                        maxLength: 5000,
                        maxLines: null,
                        minLines: 5,
                        decoration: const InputDecoration(
                          label: Text('Descricão:'),
                        ),
                      ),
                    ),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 500),
                      width: MediaQuery.sizeOf(context).width * 0.5,
                      child: TextFormField(
                        validator: isNotEmpty,
                        controller: controllerPassos,
                        maxLength: 5000,
                        maxLines: null,
                        minLines: 5,
                        decoration: const InputDecoration(
                          label: Text('Passos:'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  runSpacing: 20,
                  spacing: 20,
                  children: [
                    Container(
                      constraints: const BoxConstraints(maxWidth: 500),
                      width: MediaQuery.sizeOf(context).width * 0.5,
                      child: TextFormField(
                        validator: isNotEmpty,
                        controller: controllerResultadoEsperado,
                        maxLength: 5000,
                        maxLines: null,
                        minLines: 5,
                        decoration: const InputDecoration(
                          label: Text('Resultado esperado:'),
                        ),
                      ),
                    ),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 500),
                      width: MediaQuery.sizeOf(context).width * 0.5,
                      child: TextFormField(
                        validator: isNotEmpty,
                        controller: controllerObservacao,
                        maxLength: 5000,
                        maxLines: null,
                        minLines: 5,
                        decoration: const InputDecoration(
                          label: Text('Observações:'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListArquivosTeste(
                files: testeState.cacheFiles,
                delete: null,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () async => testeState.statusTestes !=
                                StatusTestes.anexandoArquivos
                            ? getFiles()
                            : null,
                        child: Text(
                          testeState.statusTestes !=
                                  StatusTestes.anexandoArquivos
                              ? 'Anexar arquivos'
                              : 'Carregando...',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.green),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            createTicketTeste(
                              widget.idHistorico,
                              TesteEntity(
                                criador: useAtomState(userAtom)?.name ?? '',
                                responsavel: '',
                                tagTeste: tagSelected,
                                feature: controllerFeature.text,
                                situacaoTeste: SituacaoTeste.pendente,
                                descricao: controllerDescricao.text,
                                passos: controllerPassos.text,
                                arquivos: testeState.cacheFiles,
                                observacoes: controllerObservacao.text,
                                loginTeste: controllerLogin.text,
                                senhaTeste: controllerSenha.text,
                                tester: '',
                                id: -1,
                                devolutiva: '',
                                closed: false,
                                resultadoEsperado:
                                    controllerResultadoEsperado.text,
                              ),
                            );
                          }
                        },
                        child: const Text('Criar'),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () => updateShowFormtest(false),
                      label: const Text('Voltar'),
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Adicionando o ticket de teste aguarde...',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
