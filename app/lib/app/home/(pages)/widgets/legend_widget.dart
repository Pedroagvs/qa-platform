import 'package:flutter/material.dart';

class LegendWidget extends StatelessWidget {
  final Color color;
  final String label;
  const LegendWidget({super.key, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            color: color,
            height: 10,
            width: 10,
          ),
        ),
        Text(label),
      ],
    );
  }
}
