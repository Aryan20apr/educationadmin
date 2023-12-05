import 'dart:io';
import 'dart:typed_data';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:talentsearchenglish/Modals/FileResourcesModal.dart';

import 'package:encrypt/encrypt.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import 'package:http/http.dart' as http;
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:logger/logger.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FileController extends GetxController {
  final iv2 = IV.fromLength(16);
  final iv = IV.fromBase64("lbG7rdAT+6tD3j6TqMh05w==");
  final key = Key.fromSecureRandom(32);
  Logger logger = Logger();
  RxBool isDownloaded = false.obs;
  RxBool isDownloading = false.obs;
  final String AES_KEY = "Eur91rZ/EKnHbkijT65vK2DKPxoRpASD60SlHkJdXK0=";

  void changeDownloadStatus(bool status) {
    isDownloaded.value = status;
  }

  Future<void> checkFileDownloadStatus(
      {required String filename, required String createdAt}) async {
    final directory = await getApplicationDocumentsDirectory();
    final filesDirectory = Directory('${directory.path}/files');
    String filePath = '${filesDirectory.path}/${filename}_$createdAt.pdf';
    File encryptedfile = File(filePath);
    bool present = await encryptedfile.exists();

    if (present) {
      changeDownloadStatus(true);
    } else {
      changeDownloadStatus(false);
    }
  }

  Future<void> downloadFile({required Files file}) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.wifi &&
        connectivityResult != ConnectivityResult.mobile) {
      Get.showSnackbar(const GetSnackBar(
        message: 'No Internet Connection',
        duration: Duration(seconds: 5),
      ));
      return;
    }
    isDownloading.value = true;
    logger.e("Link of file to be downloaded is ${file.link}");
    try {
      http.Response response = await download(url: file.link!);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final directory = await getApplicationDocumentsDirectory();
        logger.i("Document Diretory path is ${directory.path}");
        final filesDirectory =
            await Directory('${directory.path}/files').create(recursive: true);

        String filePath =
            '${filesDirectory.path}/${file.title!}_${file.createdAt}.pdf';

        logger.i("Length of key is ${key.length} and key is ${key.bytes}");

        final encryptor = Encrypter(AES(
            Key.fromBase64("Eur91rZ/EKnHbkijT65vK2DKPxoRpASD60SlHkJdXK0="),
            mode: AESMode.cbc));

        final encryptedBytes = encryptor.encryptBytes(
          response.bodyBytes,
          iv: iv,
        );

        logger.i("Mime type of saved file is ${lookupMimeType(filePath)}");
        // encrypted file
        final encryptedFile = File(filePath);
        await encryptedFile.writeAsBytes(List.from(encryptedBytes.bytes),
            flush: true);
        isDownloading.value = false;
        changeDownloadStatus(true);
      }
    } on Exception catch (e) {
      logger.i(e);
      Get.showSnackbar(const GetSnackBar(
        message: 'Cannot download pdf, check your internet connection',
      ));
      isDownloaded.value = false;
    }
  }

  Future<File> getDecryptedFile(
      {required String name, String? createdAt, bool? fromDownloads}) async {
    String filePath;
    Directory? filesDirectory;
    if (fromDownloads == null) {
      final directory = await getApplicationDocumentsDirectory();
      filesDirectory = Directory('${directory.path}/files');
      filePath = '${filesDirectory.path}/${name}_$createdAt.pdf';
    } else {
      filePath = name;
    }
    File encryptedfile = File(filePath);
    bool isPresent = await encryptedfile.exists();
    logger.i("File at path $filePath is present $isPresent");

    Uint8List encryptedBytes = await encryptedfile.readAsBytes();
    //logger.i("encrypted bytes: ${encryptedBytes}");

    logger.i("Length of key is ${key.length} and key is ${key.bytes}");

    logger.i('Path of encrypted file obtained is ${encryptedfile.path}');
    // final encryptor=Encrypter(AES(key,padding: null));
    final encryptor = Encrypter(AES(
        Key.fromBase64("Eur91rZ/EKnHbkijT65vK2DKPxoRpASD60SlHkJdXK0="),
        mode: AESMode.cbc));
    final decryptedBytes = encryptor.decryptBytes(
      Encrypted(encryptedBytes),
      iv: iv,
    );
    //logger.i("Length of decrypted bytes are ${decryptedBytes.length}");

    //logger.i(await encryptedfile..readAsString());

    //return encryptedfile;
    if (fromDownloads == null) {
      final decryptedFilePath =
          '${filesDirectory!.path}/${name}_${createdAt}_decryptedfile.pdf';
      final decryptedFile = File(decryptedFilePath);

      await decryptedFile.writeAsBytes(decryptedBytes,
          flush: true /*Uint8List.fromList(decryptedBytes)*/);
      return decryptedFile;
    } //Uint8List.fromList(decryptedBytes);}
    else {
      final decryptedFilePath = '${name}_decryptedfile.pdf';
      final decryptedFile = File(decryptedFilePath);

      await decryptedFile.writeAsBytes(decryptedBytes,
          flush: true /*Uint8List.fromList(decryptedBytes)*/);
      return decryptedFile;
    }
  }

  Future<dynamic> download({required String url}) async {
    try {
      var client = http.Client();
      http.Response response = await http.get(Uri.parse(url), headers: {
        /*"Content-Type": "application/pdf",*/ "Response-Type": "bytes"
      });

      changeDownloadStatus(true);
      return response;
    } on Exception catch (e) {
      logger.e(e.toString());
      isDownloading.value = false;
      isDownloaded.value = false;
    }
  }

  void deleteTempFile({String? name, String? createdAt, String? path}) async {
    final directory = await getApplicationDocumentsDirectory();
    if (path == null) {
      final filesDirectory = Directory('${directory.path}/files');
      final decryptedFilePath =
          '${filesDirectory.path}/${name}_${createdAt}_decryptedfile.pdf';
      final decryptedFile = File(decryptedFilePath);
      logger.i('removing temp file from path:$decryptedFilePath');
      bool exists = await decryptedFile.exists();
      logger.i("File exists:$exists");
      if (exists) {
        logger.i("Decrypted file found");
        decryptedFile.delete(recursive: false);
      }
    } else {
      logger.i('removing temp file from path:$path');
      final decryptedFilePath = '${path}_decrypted.pdf';
      final decryptedFile = File(decryptedFilePath);

      if (await decryptedFile.exists()) {
        decryptedFile.delete(recursive: false);
      }
    }
  }

  void deleteFile({required String name, required String createdAt}) async {
    final directory = await getApplicationDocumentsDirectory();
    final filesDirectory = Directory('${directory.path}/files');
    String filePath = '${filesDirectory.path}/${name}_$createdAt.pdf';
    File encryptedfile = File(filePath);
    encryptedfile.delete(recursive: false);
    changeDownloadStatus(false);
  }

  Future<List<FileSystemEntity>> getPdfFiles() async {
    final directory = await getApplicationDocumentsDirectory();
    // var path = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
    //final directory=await Directory(path);

    final filesDirectory = Directory('${directory.path}/files');
    if (await filesDirectory.exists() == false) {
      await filesDirectory.create(recursive: true);
    }
    logger.e("Application document directory is ${filesDirectory.path}");

    List<FileSystemEntity> files = filesDirectory
        .listSync(); // Get a list of files in the application directory
    logger.e("Size of obtained list: ${files.length}");
    for (var element in files) {
      logger.i(element.path);
    }
    List<FileSystemEntity> pdfFiles = [];
    // pdfFiles = files.whereType<File>().map((entity) => entity as File).toList();
    for (var file in files) {
      if (file is File && file.path.endsWith('.pdf')) {
        logger.e('File is file ${file is File}');
        pdfFiles.add(file);
      }
    }
    logger.e("Size of file list: ${pdfFiles.length}");
    return pdfFiles;
  }

  Future<void> deleteFilefromPath(String path) async {
    File encryptedfile = File(path);
    encryptedfile.delete(recursive: false);
  }
}
