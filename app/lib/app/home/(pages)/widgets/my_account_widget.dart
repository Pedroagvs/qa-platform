import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:quality_assurance_platform/app/home/controller/atoms/home_atom.dart';
import 'package:quality_assurance_platform/app/home/controller/states/home_state.dart';
import 'package:quality_assurance_platform/app/login/controller/atom/login_atom.dart';
import 'package:quality_assurance_platform/core/functions/show_message.dart';
import 'package:quality_assurance_platform/core/functions/validators.dart';
import 'package:strings/strings.dart';

class MyAccountWidget extends StatefulWidget {
  const MyAccountWidget({super.key});

  @override
  State<MyAccountWidget> createState() => _MyAccountWidgetState();
}

class _MyAccountWidgetState extends State<MyAccountWidget>
    with HookStateMixin, Validators, MessageToast {
  final senhaController = TextEditingController();
  final novaSenhaController = TextEditingController();
  final confimarSenhaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final userState = useAtomState(userAtom);
    final homeState = useAtomState(homeAtomSelector);
    final showPassword = useAtomState(showPasswordAtom);
    final availableHeight = MediaQuery.sizeOf(context).height -
        (MediaQuery.paddingOf(context).top + kToolbarHeight);
    final formKey = GlobalKey<FormState>();

    useAtomEffect(
      (get) => get(statusHomeAtom),
      effect: (status) {
        if (status == StatusHome.failureChangePassword) {
          toastErrorMessage(
            context: context,
            description: homeState.msgToast,
          );
          updateStatusHome(StatusHome.initial);
        } else if (status == StatusHome.successChangePassword) {
          toastSuccessMessage(
            context: context,
            description: homeState.msgToast,
          );
          updateStatusHome(StatusHome.initial);
          updateShowformChangePassword(false);
          senhaController.clear();
          novaSenhaController.clear();
          confimarSenhaController.clear();
        }
      },
    );
    return SizedBox(
      height: availableHeight,
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
              height: 100,
              width: 100,
              child: Stack(
                children: [
                  InkWell(
                    onTap: homeState.statusHome ==
                            StatusHome.loadingChangeThumbnail
                        ? null
                        : () => updateThumbnailUser(userState?.id ?? 0),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: userState?.thumbnail != null
                          ? MemoryImage(userState!.thumbnail!)
                          : null,
                    ),
                  ),
                  const Positioned(
                    right: 2,
                    child: Icon(
                      Icons.edit,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(userState?.name.toUpperCase() ?? ''),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(userState?.email.toCapitalised() ?? ''),
          ),
          Visibility(
            visible: homeState.showFormChangePassword,
            replacement: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: OutlinedButton(
                onPressed: () => updateShowformChangePassword(true),
                child: const Text(
                  'Alterar senha',
                ),
              ),
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          controller: senhaController,
                          decoration: InputDecoration(
                            label: const Text('Senha atual'),
                            suffixIcon: IconButton(
                              onPressed: () =>
                                  changeShowPassword(!showPassword),
                              icon: Icon(
                                showPassword
                                    ? LineIcons.lowVision
                                    : LineIcons.eye,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          validator: (v) => concatValidate(v, [
                            (v) => isNotEmpty(v),
                            (v) => hasSixChars(v),
                          ]),
                          obscureText: showPassword,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          controller: novaSenhaController,
                          obscureText: showPassword,
                          decoration: InputDecoration(
                            label: const Text('Nova senha'),
                            suffixIcon: IconButton(
                              onPressed: () =>
                                  changeShowPassword(!showPassword),
                              icon: Icon(
                                showPassword
                                    ? LineIcons.lowVision
                                    : LineIcons.eye,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          validator: (v) => concatValidate(v, [
                            (v) => isNotEmpty(v),
                            (v) => hasSixChars(v),
                          ]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          controller: confimarSenhaController,
                          obscureText: showPassword,
                          decoration: InputDecoration(
                            label: const Text('Confirmar senha'),
                            suffixIcon: IconButton(
                              onPressed: () =>
                                  changeShowPassword(!showPassword),
                              icon: Icon(
                                showPassword
                                    ? LineIcons.lowVision
                                    : LineIcons.eye,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          validator: (v) => concatValidate(v, [
                            (v) => isNotEmpty(v),
                            (v) => hasSixChars(v),
                            (v) =>
                                checkEqualPassword(novaSenhaController.text, v),
                          ]),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: TextButton(
                              onPressed: () {
                                confimarSenhaController.clear();
                                senhaController.clear();
                                novaSenhaController.clear();
                                updateShowformChangePassword(false);
                              },
                              child: const Text(
                                'Cancelar',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: ElevatedButton(
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  await changePassword(
                                    senhaController.text,
                                    novaSenhaController.text,
                                  );
                                }
                              },
                              child: const Text(
                                'Alterar',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
