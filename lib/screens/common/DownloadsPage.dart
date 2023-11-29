import 'dart:io';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../utils/Controllers/FileDownloadStatusController.dart';

class DownloadsPage extends StatelessWidget {
  DownloadsPage({super.key});
  FileController fileController = Get.put(FileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('PDF Files'),
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
            final pdfFiles = snapshot.data as List<File>;
            return PdfListView(pdfFiles);
          }
        },
      ),
    );
  }
}

class PdfListView extends StatefulWidget {
  final List<File> pdfFiles;

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
        return PdfListItem(pdfFileName: widget.pdfFiles[index].path,onTap:() {
          Get.to(() => FileView(
                file: widget.pdfFiles[index],
                title: widget.pdfFiles[index]
                    .path
                    .substring(widget.pdfFiles[index].path.lastIndexOf("/") + 1),
           
              ));
        },
           onSelected:   (value) {
            if (value == 'remove') {
              // Add code to delete the PDF file here
              // You should remove the file from the list and update the UI accordingly
             
               setState(() {
                  FileController fileController = Get.find<FileController>();
                 fileController.deleteFilefromPath(widget.pdfFiles[index]
                    .path);
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
  const PdfListItem( {super.key,required this.pdfFileName,required this.onTap,required this.onSelected,});

  @override
  State<PdfListItem> createState() => _PdfListItemState();
}

class _PdfListItemState extends State<PdfListItem> {
  FileController fileController = Get.find<FileController>();
  
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.all(10),
      child: ListTile(
        leading: Icon(
          Icons.picture_as_pdf,
          color: Colors.red, // Change the color as desired
        ),
        title: Text(
          widget.pdfFileName.substring(widget.pdfFileName.lastIndexOf("/") + 1),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12.sp,
            color: Colors.blue, // Change the color as desired
          ),
        ),
        trailing: PopupMenuButton(
          itemBuilder: (context) {
            return <PopupMenuEntry>[
              PopupMenuItem(
                value: 'remove',
                child: Text('Remove'),
              ),
            ];
          },
          onSelected: widget.onSelected
        ),
        onTap: widget.onTap
      ),
    );
  }
}

class FileView extends StatelessWidget {
  FileView({super.key, required this.title, required this.file});
  File file;
  String title;
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.bookmark,
              color: Colors.white,
              semanticLabel: 'Bookmark',
            ),
            onPressed: () {
              //  _pdfViewerKey.currentState?.openBookmarkView();
            },
          ),
        ],
      ),
      body: SfPdfViewer.file(
        file,
        key: _pdfViewerKey,
      ),
    );
  }
}
