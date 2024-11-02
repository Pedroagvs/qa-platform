import 'package:flutter/material.dart';

class LegendWidget extends StatelessWidget {
  final Color color;
  final String label;
  const LegendWidget({super.key, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      width: 170,
      child: Row(
        mainAxisSize: MainAxisSize.min,
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
      ),
    );
  }
}
