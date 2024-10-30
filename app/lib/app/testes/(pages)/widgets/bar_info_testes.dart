import 'package:flutter/material.dart';

class BarInfoTestes extends StatelessWidget {
  const BarInfoTestes({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(15),
          bottomLeft: Radius.circular(15),
        ),
      ),
      color: Theme.of(context).brightness == Brightness.light
          ? Theme.of(context).colorScheme.onPrimaryFixedVariant
          : Theme.of(context).colorScheme.inversePrimary,
      elevation: 15,
      child: SizedBox(
        height: 45,
        width: MediaQuery.sizeOf(context).width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.10,
              child: const FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'Ticket',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.14,
              child: const FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'Solicitante',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.10,
              child: const FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'Tela',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.10,
              child: const FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'Tag',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.10,
              child: const FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'Tester',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.14,
              child: const FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'Analista',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.14,
              child: const FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'Situação',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
