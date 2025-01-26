import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:quality_assurance_platform/app/common/atoms/message_atom.dart';
import 'package:quality_assurance_platform/app/login/(pages)/widgets/form_create_account_widget.dart';
import 'package:quality_assurance_platform/app/login/(pages)/widgets/form_login_widget.dart';
import 'package:quality_assurance_platform/app/login/(pages)/widgets/form_lost_password_widget.dart';
import 'package:quality_assurance_platform/app/login/controller/atom/create_account_atom.dart';
import 'package:quality_assurance_platform/app/login/controller/atom/login_atom.dart';
import 'package:quality_assurance_platform/app/login/controller/atom/lost_password_atom.dart';
import 'package:quality_assurance_platform/core/functions/show_message.dart';
import 'package:quality_assurance_platform/core/functions/validators.dart';
import 'package:quality_assurance_platform/routes.g.dart';
import 'package:routefly/routefly.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with
        Validators,
        HookStateMixin,
        SingleTickerProviderStateMixin,
        MessageToast {
  final _formKey = GlobalKey<FormState>();

  late final AssetImage img;
  @override
  void initState() {
    img = const AssetImage(
      'assets/images/background_login.jpg',
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    precacheImage(
      img,
      context,
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final showFormCreateAccountState = useAtomState(showFormCreateAccountAtom);
    final showFormLostPasswordState = useAtomState(showFormLostPasswordAtom);
    final loginStatus = useAtomState(statusLoginAtom);
    useAtomEffect(
      (get) => get(statusLoginAtom),
      effect: (status) {
        if (status == LoginStatus.success) {
          Routefly.navigate(routePaths.home);
        } else if (status == LoginStatus.failure) {
          toastErrorMessage(context: context, description: msgAtom.state);
        }
      },
    );
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            Image(
              image: img,
              fit: BoxFit.cover,
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
            ),
            Center(
              child: SingleChildScrollView(
                child: Card(
                  elevation: 30,
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            'Quality Assurance \n Platform',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Orbitron',
                              fontSize: 32,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        if (showFormLostPasswordState)
                          Container(
                            constraints: const BoxConstraints(maxWidth: 300),
                            width: size.width * 0.5,
                            child: FormLostPasswordWidget(formKey: _formKey),
                          ),
                        if (showFormCreateAccountState)
                          Container(
                            constraints: const BoxConstraints(maxWidth: 300),
                            width: size.width * 0.5,
                            child: FormCreateAccountWidget(formKey: _formKey),
                          ),
                        if (!showFormLostPasswordState &&
                            !showFormCreateAccountState)
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                constraints:
                                    const BoxConstraints(maxWidth: 300),
                                width: size.width * 0.5,
                                child: FormLoginWidget(
                                  formKey: _formKey,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                ),
                                child: SizedBox(
                                  width: 200,
                                  child: OutlinedButton(
                                    onPressed:
                                        loginStatus == LoginStatus.loading
                                            ? null
                                            : () => showFormLostPassword(
                                                  true,
                                                ),
                                    child: const Text(
                                      'Esqueci senha',
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                ),
                                child: SizedBox(
                                  width: 200,
                                  child: OutlinedButton(
                                    onPressed:
                                        loginStatus == LoginStatus.loading
                                            ? null
                                            : () => showFormCreateAccount(
                                                  true,
                                                ),
                                    child: const Text(
                                      'Criar conta',
                                    ),
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
      ),
    );
  }
}
