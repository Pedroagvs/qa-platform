import 'package:flutter/material.dart';
import 'package:quality_assurance_platform/routes.g.dart';
import 'package:routefly/routefly.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: Stack(
          children: [
            Image.asset(
              'assets/images/not_found.jpg',
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              fit: BoxFit.contain,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: ElevatedButton(
                  onPressed: () {
                    Routefly.navigate(routePaths.login);
                  },
                  child: const Text('Voltar'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
