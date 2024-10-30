import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:quality_assurance_platform/app/login/controller/atom/create_account_atom.dart';
import 'package:quality_assurance_platform/core/functions/show_message.dart';
import 'package:quality_assurance_platform/core/functions/validators.dart';

class FormCreateAccountWidget extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  const FormCreateAccountWidget({
    super.key,
    required this.formKey,
  });

  @override
  State<FormCreateAccountWidget> createState() =>
      _FormCreateAccountWidgetState();
}

class _FormCreateAccountWidgetState extends State<FormCreateAccountWidget>
    with HookStateMixin, Validators, MessageToast {
  @override
  Widget build(BuildContext context) {
    final nomeController = useAtomState(nomeCreateAccountAtom);
    final cargoState = useAtomState(cargoAtom);
    final emailController = useAtomState(emailCreateAccountAtom);
    final senhaController = useAtomState(senhaCreateAccountAtom);
    final showPassword = useAtomState(showPasswordAtom);
    final confirmarSenhaController =
        useAtomState(confirmarSenhaCreateAccountAtom);
    final statusCreateAccount = useAtomState(createAccountAtom);
    final toastMsg = useAtomState(toastMsgAtom);
    useAtomEffect(
      (get) => get(createAccountAtom),
      effect: (status) {
        if (status == StatusCreateAccount.success) {
          toastSuccessMessage(context: context, description: toastMsg);
          showFormCreateAccount(false);
        } else if (status == StatusCreateAccount.failure) {
          toastErrorMessage(context: context, description: toastMsg);
        }
      },
    );

    if (statusCreateAccount == StatusCreateAccount.loading) {
      return const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'Cadastrando usuário aguarde um momento...',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          CircularProgressIndicator(),
        ],
      );
    }

    return Form(
      key: widget.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: TextFormField(
              decoration: const InputDecoration(
                label: Text('Nome:'),
              ),
              controller: nomeController,
              validator: (value) => concatValidate(
                value,
                [
                  isNotEmpty,
                  hasFourChars,
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                label: Text('E-mail:'),
              ),
              validator: (value) => concatValidate(
                value,
                [
                  isNotEmpty,
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: DropdownButtonFormField<String>(
              value: cargoState,
              icon: const Icon(Icons.arrow_downward_rounded),
              hint: const Text('Escolha o cargo'),
              isExpanded: true,
              items: const [
                DropdownMenuItem(
                  value: 'Tester',
                  child: Text('Tester'),
                ),
                DropdownMenuItem(
                  value: 'Desenvolvedor',
                  child: Text('Desenvolvedor'),
                ),
              ],
              onChanged: (v) => changeCargoState(v ?? 'Tester'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: TextFormField(
              decoration: InputDecoration(
                label: const Text('Senha:'),
                suffixIcon: IconButton(
                  onPressed: () => changeShowPassword(!showPassword),
                  icon: Icon(
                    showPassword ? LineIcons.lowVision : LineIcons.eye,
                    color: Colors.black,
                  ),
                ),
              ),
              controller: senhaController,
              obscureText: showPassword,
              validator: (value) => concatValidate(
                value,
                [
                  isNotEmpty,
                  hasSixChars,
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: TextFormField(
              decoration: InputDecoration(
                label: const Text('Confirmar senha:'),
                suffixIcon: IconButton(
                  onPressed: () => changeShowPassword(!showPassword),
                  icon: Icon(
                    showPassword ? LineIcons.lowVision : LineIcons.eye,
                    color: Colors.black,
                  ),
                ),
              ),
              controller: confirmarSenhaController,
              obscureText: showPassword,
              validator: (value) => concatValidate(
                value,
                [
                  isNotEmpty,
                  hasSixChars,
                  (value) => checkEqualPassword(
                        senhaController.text,
                        confirmarSenhaController.text,
                      ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: SizedBox(
              height: 35,
              child: ElevatedButton(
                onPressed: () async {
                  if (widget.formKey.currentState!.validate()) {
                    await submitFormCreateAccount(
                      (
                        nomeController.text,
                        emailController.text,
                        senhaController.text,
                        cargoState
                      ),
                    );
                  }
                },
                child: const Text('Criar conta'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: SizedBox(
              child: OutlinedButton.icon(
                onPressed: () => showFormCreateAccount(false),
                label: const Text('Voltar'),
                icon: const Icon(Icons.arrow_back),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
