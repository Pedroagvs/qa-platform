// ignore_for_file: parameter_assignments

class RegexApp {
  static String removerAcentos(String str) {
    const comAcento =
        'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
    const semAcento =
        'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz';
    for (var i = 0; i < comAcento.length; i++) {
      str = str.replaceAll(comAcento[i], semAcento[i]);
    }
    return str;
  }

  static String removeEspacos(String str) => str.trim().replaceAll(' ', '');
  static String removeTracos(String str) => str.trim().replaceAll('-', '');

  static bool isImage(String str) =>
      RegExp(r'^(\S)+.(jpg|jpeg|png)$').hasMatch(str);
}
