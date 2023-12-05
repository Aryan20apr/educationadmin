import 'dart:async';

import 'dart:io';

import 'package:talentsearchenglish/Modals/FileResourcesModal.dart';
import 'package:talentsearchenglish/utils/Controllers/FileDownloadStatusController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfView extends StatefulWidget {
  PdfView({super.key, required this.file});
  Files? file;

  @override
  State<PdfView> createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> with WidgetsBindingObserver {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  //  File? _tempFile;
  late FileController fileController;

  Logger logger = Logger();
  @override
  void initState() {
    fileController = Get.put(FileController(), tag: widget.file!.link!);

    super.initState();
  }
//  void initializeFile() async {
//     final Directory tempPath = await getApplicationDocumentsDirectory();
//     final File tempFile = File('${tempPath.path}/${widget.file!.title}.pdf');
//     final bool checkFileExist = await tempFile.exists();
//     if (checkFileExist) {
//       _tempFile = tempFile;
//     }
//   }

  @override
  Widget build(BuildContext context) {
    logger.i('Build method called');
    //  Widget child;

    // if (_tempFile == null) {
    //   logger.i('Temp file is null');
    //   child = SfPdfViewer.network(
    //       widget.file!.link!,
    //       key: _pdfViewerKey,
    //       onDocumentLoaded: (PdfDocumentLoadedDetails details) async {
    //     final Directory tempPath = await getApplicationDocumentsDirectory();
    //     _tempFile = await File('${tempPath.path}/${widget.file!.title}.pdf')
    //         .writeAsBytes( await details.document.save());
    //   });
    // } else {
    //   logger.i('Temp file is not null');
    //   child = SfPdfViewer.file(
    //     _tempFile!,
    //     key: _pdfViewerKey,
    //   );
    // }
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.file!.title!),
        ),
        body: fileController.isDownloaded.value == false
            ? SfPdfViewer.network(widget.file!.link!, key: _pdfViewerKey,
                onDocumentLoaded: (PdfDocumentLoadedDetails details) async {
                // final Directory tempPath = await getApplicationDocumentsDirectory();
                // _tempFile = await File('${tempPath.path}/${widget.file!.title}.pdf')
                //     .writeAsBytes( await details.document.save());
              })
            : FutureBuilder<File>(
                future: getFileBytes(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    logger.i("Snapshot Data is ${snapshot.data}");
                    if (snapshot.data != null && !snapshot.data!.isBlank!) {
                      logger.i(snapshot.data!.path);
                      return SfPdfViewer.file(
                        snapshot.data!,
                        key: _pdfViewerKey,
                      );
                      //return SfPdfViewer.file(snapshot.data!,key: _pdfViewerKey, );
                      // return  ElevatedButton(onPressed: (){
                      //   Get.to(()=>PDFScreen(path: snapshot.data!.path,));
                      // }, child: Text('Open'));
                    } else {
                      return Text('PDF data is empty or null.');
                    }
                  } else if (snapshot.hasError) {
                    snapshot.printError();
                    return Text('Error');
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }));
  }

  @override
  void dispose() {
    fileController.deleteTempFile(
        name: widget.file!.title!,
        createdAt: widget.file!.createdAt!,
        path: null);

    super.dispose();
  }

  Future<File> getFileBytes() async {
    return await fileController.getDecryptedFile(
        name: widget.file!.title!,
        createdAt: widget.file!.createdAt!,
        fromDownloads: null);
  }
}
