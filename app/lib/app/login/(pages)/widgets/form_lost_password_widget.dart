import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:quality_assurance_platform/app/login/controller/atom/lost_password_atom.dart';
import 'package:quality_assurance_platform/core/functions/validators.dart';

class FormLostPasswordWidget extends StatelessWidget
    with HookMixin, Validators {
  final GlobalKey<FormState> formKey;
  const FormLostPasswordWidget({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    final _emailController = useAtomState(lpEmailAtom);
    final lostPasswordStatus = useAtomState(lostPasswordAtom);
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
              readOnly: lostPasswordStatus == StatusLostPassword.loading,
              controller: _emailController,
              decoration: const InputDecoration(
                label: Text('E-mail:'),
              ),
              validator: isNotEmpty,
            ),
          ),
          if (lostPasswordStatus == StatusLostPassword.failure)
            const Text('Error ao autenticar'),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: SizedBox(
              width: 250,
              child: ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {}
                },
                child: Text(
                  lostPasswordStatus == StatusLostPassword.loading
                      ? 'Enviando...'
                      : 'Solicitar',
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: OutlinedButton.icon(
              onPressed: () => showFormLostPassword(false),
              label: const Text('Voltar'),
              icon: const Icon(Icons.arrow_back),
            ),
          ),
        ],
      ),
    );
  }
}
