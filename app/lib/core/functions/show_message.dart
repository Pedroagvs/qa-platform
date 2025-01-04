import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';

mixin MessageToast {
  void toastErrorMessage({
    required BuildContext context,
    String title = 'Error',
    required String description,
  }) {
    CherryToast.error(
      title: Text(title),
      description: Text(
        description,
        style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
      ),
      animationType: AnimationType.fromRight,
      animationDuration: const Duration(
        milliseconds: 1000,
      ),
    ).show(context);
  }

  void toastSuccessMessage({
    required BuildContext context,
    String title = 'Successo',
    required String description,
  }) {
    CherryToast.success(
      title: Text(title),
      description: Text(
        description,
        style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
      ),
      animationType: AnimationType.fromRight,
      animationDuration: const Duration(
        milliseconds: 1000,
      ),
    ).show(context);
  }
}
