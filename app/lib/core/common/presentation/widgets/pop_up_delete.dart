import 'package:flutter/material.dart';

class PopUp {
  BuildContext context;
  void Function() onAcceptQuestion;
  String message;
  bool? dismissible;
  bool? willPopScope;
  PopUp({
    required this.context,
    required this.onAcceptQuestion,
    required this.message,
    this.dismissible,
    this.willPopScope,
  }) {
    delete(
      context: context,
      onAcceptQuestion: onAcceptQuestion,
      message: message,
      dismissible: dismissible,
      willPopScope: willPopScope,
    );
  }

  void delete({
    required BuildContext context,
    required void Function() onAcceptQuestion,
    required String message,
    required bool? dismissible,
    required bool? willPopScope,
  }) =>
      showDialog(
        context: context,
        barrierDismissible: dismissible ?? true,
        builder: (BuildContext context) {
          return PopScope(
            canPop: willPopScope ?? true,
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.3,
                height: MediaQuery.sizeOf(context).height * 0.2,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        child: Center(
                          child: Text(
                            message,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Não'),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 25,
                              ),
                              child: TextButton(
                                onPressed: () {
                                  onAcceptQuestion();
                                  Navigator.pop(context);
                                },
                                child: const Text('Sim'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
}
