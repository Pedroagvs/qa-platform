import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:quality_assurance_platform/app/home/(pages)/widgets/card_aplicacoes.dart';
import 'package:quality_assurance_platform/app/home/(pages)/widgets/form_new_suit_test.dart';
import 'package:quality_assurance_platform/app/home/controller/atoms/suites_atom.dart';

class AplicationsWidget extends StatefulWidget {
  const AplicationsWidget({super.key});

  @override
  State<AplicationsWidget> createState() => _AplicationsWidgetState();
}

class _AplicationsWidgetState extends State<AplicationsWidget>
    with HookStateMixin {
  @override
  void initState() {
    getSuites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final applicationState = useAtomState(applicationSelectAtom);
    final availableHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top + kToolbarHeight);
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: availableHeight,
      child: Visibility(
        visible: applicationState.showForm,
        replacement: ListView(
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              height: availableHeight,
              child: Wrap(
                spacing: 20,
                runSpacing: 20,
                children: applicationState.aplications
                    .map(
                      (a) => Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          constraints: const BoxConstraints(
                            maxHeight: 230,
                            maxWidth: 230,
                            minHeight: 180,
                            minWidth: 180,
                          ),
                          width: MediaQuery.sizeOf(context).width * 0.25,
                          height: availableHeight * 0.2,
                          child: CardAplicacao(
                            application: a,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
        child: const FormNewSuitTestWidget(),
      ),
    );
  }
}
