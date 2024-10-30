import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String preFix;
  final String suFix;
  const CustomText({super.key, required this.preFix, required this.suFix});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        children: [
          TextSpan(
            text: preFix,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: suFix),
        ],
      ),
    );
  }
}
