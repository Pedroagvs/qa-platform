import 'package:flutter/material.dart';
import 'package:quality_assurance_platform/core/common/domain/entities/test_entity.dart';
import 'package:strings/strings.dart';

class CardTeste extends StatelessWidget {
  final TesteEntity teste;
  const CardTeste({
    super.key,
    required this.teste,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height * 0.1,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.08,
                child: Text(
                  teste.id.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.08,
                child: Text(
                  Strings.toCapitalised(
                    teste.criador,
                  ),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.08,
                child: Text(
                  Strings.toCapitalised(
                    teste.feature,
                  ),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width * 0.08,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: TesteEntity.getColorTagTeste(
                    teste.tagTeste,
                  ),
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    TesteEntity.getTagTeste(teste.tagTeste),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              FittedBox(
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.08,
                  child: Text(
                    Strings.toCapitalised(teste.tester),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.08,
                  child: Text(
                    Strings.toCapitalised(
                      teste.responsavel,
                    ),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width * 0.12,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: TesteEntity.getColorSituacaoTeste(
                    teste.situacaoTeste,
                  ),
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    TesteEntity.getSituacao(
                      teste.situacaoTeste,
                    ),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
