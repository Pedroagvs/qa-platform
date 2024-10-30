import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:quality_assurance_platform/app/login/controller/atom/login_atom.dart';
import 'package:quality_assurance_platform/core/functions/validators.dart';

class FormLoginWidget extends StatelessWidget with Validators, HookMixin {
  final GlobalKey<FormState> formKey;
  FormLoginWidget({
    super.key,
    required this.formKey,
  });
  @override
  Widget build(BuildContext context) {
    final _emailController = useAtomState(emailAtom);
    final _senhaController = useAtomState(passwordAtom);
    final loginStatus = useAtomState(statusLoginAtom);
    final obscureTextState = useAtomState(obscureTextAtom);
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
            ),
            child: TextFormField(
              decoration: const InputDecoration(
                label: Text('E-mail:'),
              ),
              readOnly: loginStatus == LoginStatus.loading,
              controller: _emailController,
              validator: isNotEmpty,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
            ),
            child: TextFormField(
              readOnly: loginStatus == LoginStatus.loading,
              decoration: InputDecoration(
                label: const Text('Senha:'),
                suffixIcon: IconButton(
                  onPressed: loginStatus == LoginStatus.loading
                      ? null
                      : () => changeObscureFieldLogin(
                            !obscureTextState,
                          ),
                  icon: Icon(
                    obscureTextState ? LineIcons.lowVision : LineIcons.eye,
                    color: Colors.black,
                  ),
                ),
              ),
              controller: _senhaController,
              obscureText: obscureTextState,
              validator: isNotEmpty,
            ),
          ),
          if (loginStatus == LoginStatus.failure)
            const Text('Error ao autenticar'),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
            ),
            child: SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: loginStatus == LoginStatus.loading
                    ? null
                    : () async {
                        if (formKey.currentState!.validate()) {
                          await submitLogin(
                            _emailController.text,
                            _senhaController.text,
                          );
                        }
                      },
                child: Text(
                  loginStatus == LoginStatus.loading
                      ? 'Autenticando...'
                      : 'Entrar',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
