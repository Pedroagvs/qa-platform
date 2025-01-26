import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:quality_assurance_platform/app/common/widgets/file_widget.dart';
import 'package:quality_assurance_platform/app/testes/controller/atom/teste_atom.dart';
import 'package:quality_assurance_platform/core/common/data/dtos/arquivo_dto.dart';

class ListArquivosTeste extends StatelessWidget {
  final List<FileDto> files;
  final int testId;
  const ListArquivosTeste({
    super.key,
    required this.files,
    required this.testId,
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
                                        visible: f.downloading,
                                        replacement: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: FileWidget(fileDto: f),
                                        ),
                                        child: CircularProgressIndicator(
                                          value: f.progress,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      f.name,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
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
                                            deleteFile(
                                              testId,
                                              f.id,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    OutlinedButton.icon(
                                      label: const Text('Baixar'),
                                      icon: const Icon(
                                        Icons.download,
                                      ),
                                      onPressed: () => downloadFile(
                                        f,
                                      ),
                                    ),
                                  ],
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
