import 'package:flutter/material.dart';
import 'package:quality_assurance_platform/core/common/domain/entities/test_entity.dart';

class FiltroTicketsStatus extends StatelessWidget {
  final SituacaoTeste situationSelected;
  final void Function(SituacaoTeste? s) onChanged;
  const FiltroTicketsStatus({
    super.key,
    required this.onChanged,
    required this.situationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<SituacaoTeste>(
        isExpanded: true,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        icon: const Icon(
          Icons.arrow_downward,
        ),
        alignment: AlignmentDirectional.center,
        elevation: 15,
        value: situationSelected,
        borderRadius: BorderRadius.circular(12),
        items: SituacaoTeste.values
            .map<DropdownMenuItem<SituacaoTeste>>(
              (s) => DropdownMenuItem<SituacaoTeste>(
                value: s,
                child: Text(
                  TesteEntity.getSituacao(s),
                ),
              ),
            )
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}
