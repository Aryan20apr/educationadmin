import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:talentsearchenglish/widgets/ProgressIndicatorWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../utils/Controllers/FileDownloadStatusController.dart';

class DownloadsPage extends StatelessWidget {
  DownloadsPage({super.key});
  final FileController fileController = Get.put(FileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Files'),
      ),
      body: FutureBuilder(
        future: fileController.getPdfFiles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            Logger().e("files loaded");
            final pdfFiles = snapshot.data;
            if (pdfFiles!.isNotEmpty) {
              return PdfListView(pdfFiles);
            } else {
              return SizedBox(
                height: Get.height * 0.8,
                child: Center(
                    child: Text(
                  'You have no downloads',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp),
                )),
              );
            }
          }
        },
      ),
    );
  }
}

class PdfListView extends StatefulWidget {
  final List<FileSystemEntity> pdfFiles;

  const PdfListView(this.pdfFiles, {super.key});

  @override
  State<PdfListView> createState() => _PdfListViewState();
}

class _PdfListViewState extends State<PdfListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.pdfFiles.length,
      itemBuilder: (context, index) {
        return PdfListItem(
          pdfFileName: widget.pdfFiles[index].path,
          onTap: () {
            Get.to(() => FileView(
                  file: widget.pdfFiles[index],
                  title: widget.pdfFiles[index].path.substring(
                      widget.pdfFiles[index].path.lastIndexOf("/") + 1),
                ));
          },
          onSelected: (value) {
            if (value == 'remove') {
              // Add code to delete the PDF file here
              // You should remove the file from the list and update the UI accordingly

              setState(() {
                FileController fileController = Get.find<FileController>();
                fileController.deleteFilefromPath(widget.pdfFiles[index].path);
                widget.pdfFiles.removeAt(index);
              });
            }
          },
        );
      },
    );
  }
}

class PdfListItem extends StatefulWidget {
  final String pdfFileName;
  final Function() onTap;
  final Function(dynamic)? onSelected;
  const PdfListItem({
    super.key,
    required this.pdfFileName,
    required this.onTap,
    required this.onSelected,
  });

  @override
  State<PdfListItem> createState() => _PdfListItemState();
}

class _PdfListItemState extends State<PdfListItem> {
  FileController fileController = Get.find<FileController>();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(10),
      child: ListTile(
          leading: const Icon(
            Icons.picture_as_pdf,
            color: Colors.red, // Change the color as desired
          ),
          title: Text(
            widget.pdfFileName
                .substring(widget.pdfFileName.lastIndexOf("/") + 1),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
              color: Colors.blue, // Change the color as desired
            ),
          ),
          trailing: PopupMenuButton(
              itemBuilder: (context) {
                return <PopupMenuEntry>[
                  const PopupMenuItem(
                    value: 'remove',
                    child: Text('Remove'),
                  ),
                ];
              },
              onSelected: widget.onSelected),
          onTap: widget.onTap),
    );
  }
}

class FileView extends StatefulWidget {
  const FileView({super.key, required this.title, required this.file});
  final FileSystemEntity file;
  final String title;

  @override
  State<FileView> createState() => _FileViewState();
}

class _FileViewState extends State<FileView> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  FileController controller = Get.put(FileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<File>(
          future: controller.getDecryptedFile(
              name: widget.file.path, fromDownloads: true),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              log('Read bytes are ${snapshot.data!.path}');
              return SfPdfViewer.file(
                snapshot.data!,
                key: _pdfViewerKey,
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Some error occurred'),
              );
            } else {
              return const ProgressIndicatorWidget();
            }
          }),
    );
  }

  @override
  void dispose() {
    controller.deleteTempFile(path: widget.file.path);
    super.dispose();
  }
}
