import 'dart:io';
import 'package:flutter/material.dart';
import 'package:quality_assurance_platform/core/common/data/dtos/arquivo_dto.dart';
import 'package:quality_assurance_platform/externals/service/create_arquivos.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class FileWidget extends StatefulWidget {
  final FileDto fileDto;
  const FileWidget({super.key, required this.fileDto});

  @override
  State<FileWidget> createState() => _FileWidgetState();
}

class _FileWidgetState extends State<FileWidget> {
  Future<String> getPathVideo() async {
    final pathVideo = await DownloadService.create(
      widget.fileDto.name,
      widget.fileDto.bytes!,
    );
    return await VideoThumbnail.thumbnailFile(video: pathVideo) ?? '';
  }

  @override
  Widget build(BuildContext context) {
    if (widget.fileDto.bytes == null) return const SizedBox.shrink();
    if (widget.fileDto.name.toLowerCase().contains('.mp4')) {
      return FutureBuilder(
        future: getPathVideo(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snap.hasError) {
            return const Text('Error');
          }
          return Image.file(File(snap.data ?? ''));
        },
      );
    }
    if (widget.fileDto.name.toLowerCase().contains('.pdf')) {
      return SfPdfViewer.memory(
        widget.fileDto.bytes!,
        enableDocumentLinkAnnotation: false,
        enableDoubleTapZooming: false,
        enableHyperlinkNavigation: false,
        enableTextSelection: false,
        canShowHyperlinkDialog: false,
        canShowPageLoadingIndicator: false,
        canShowPaginationDialog: false,
        canShowPasswordDialog: false,
        canShowScrollHead: false,
        canShowScrollStatus: false,
        canShowSignaturePadDialog: false,
        canShowTextSelectionMenu: false,
        onPageChanged: (details) {},
      );
    }
    if (widget.fileDto.name
        .toLowerCase()
        .contains(RegExp('^.[png|jpg|jpeg]{3,4}'))) {
      return Image.memory(widget.fileDto.bytes!);
    }
    return const Icon(Icons.file_present);
  }
}
