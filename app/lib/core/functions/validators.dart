import 'package:strings/strings.dart';

mixin Validators {
  String? isNotEmpty(String? value) =>
      value == null || value.isEmpty ? 'Campo obrigatório.' : null;

  String? hasSixChars(String? value) =>
      value!.length < 6 ? 'Minímo 6 caracteres.' : null;
  String? hasFourChars(String? value) =>
      value!.length <= 4 ? 'Minímo 4 caracteres.' : null;

  String? concatValidate(
    String? value,
    List<String? Function(String?)> functions,
  ) {
    final results = <String?>[];
    for (final function in functions) {
      results.add(function(value));
    }
    for (final res in results) {
      if (res != null) {
        return res;
      }
    }
    return null;
  }

  String? checkEqualPassword(String? val1, String? val2) => val1 != null &&
          val2 != null &&
          val1.isNotEmpty &&
          val2.isNotEmpty &&
          Strings.equals(val1, val2)
      ? null
      : 'As senhas não conferem.';
}
