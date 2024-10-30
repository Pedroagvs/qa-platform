import 'dart:typed_data';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:quality_assurance_platform/app/testes/controller/atom/teste_atom.dart';
import 'package:quality_assurance_platform/core/common/domain/entities/arquivo_entity.dart';

class ListArquivosTeste extends StatelessWidget {
  final List<ArquivoEntity> files;
  final void Function()? delete;
  final bool isLoading;
  const ListArquivosTeste({
    super.key,
    required this.files,
    required this.delete,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: files.isNotEmpty,
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            },
          ),
          child: Column(
            children: [
              const Divider(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text('Arquivos'),
              ),
              Wrap(
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                runSpacing: 20,
                spacing: 20,
                children: files
                    .map(
                      (f) => Container(
                        constraints: const BoxConstraints(
                          maxHeight: 350,
                          maxWidth: 250,
                        ),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Flexible(
                                  flex: 4,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 5,
                                        horizontal: 3,
                                      ),
                                      child: Visibility(
                                        visible: isLoading,
                                        replacement: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: f.bytes != null
                                              ? Image.memory(
                                                  f.bytes ??
                                                      Uint8List.fromList([]),
                                                )
                                              : const Icon(
                                                  Icons.file_present_rounded,
                                                  size: 48,
                                                ),
                                        ),
                                        child:
                                            const CircularProgressIndicator(),
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      f.nome,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                    ),
                                    child: OutlinedButton.icon(
                                      label: const Text('Remover'),
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        if (delete != null) {
                                          delete?.call();
                                        } else {
                                          removeFileInCache(f.nome);
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const Divider(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
