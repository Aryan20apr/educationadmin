import 'dart:io';
import 'dart:typed_data';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:educationadmin/Modals/FileResourcesModal.dart';

import 'package:encrypt/encrypt.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import 'package:http/http.dart' as http; 
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:logger/logger.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';

class FileDownloadStatusController extends GetxController
{

   final iv2=IV.fromLength(16);
   final iv=IV.fromBase64("lbG7rdAT+6tD3j6TqMh05w==");
    final key=Key.fromSecureRandom(32);
  Logger logger=Logger();
  RxBool isDownloaded=false.obs;
 RxBool isDownloading=false.obs;
  final String AES_KEY="Eur91rZ/EKnHbkijT65vK2DKPxoRpASD60SlHkJdXK0=";

  void changeDownloadStatus(bool status)
  {
    isDownloaded.value=status;
  }

  Future<void> checkFileDownloadStatus({required String filename,required String createdAt}) async
  {
      final directory = await getApplicationDocumentsDirectory();
    final filesDirectory = Directory('${directory.path}/files');
    String filePath='${filesDirectory.path}/${filename}_$createdAt.pdf';
    File encryptedfile=File(filePath);
    bool present= await encryptedfile.exists();

    if(present)
    {
      changeDownloadStatus(true);
    }
    else
    {
      changeDownloadStatus(false);
    }
  }

  Future<void> downloadFile({required Files file})async
  {
      final connectivityResult = await (Connectivity().checkConnectivity());
      if(connectivityResult!=ConnectivityResult.wifi&&connectivityResult!=ConnectivityResult.mobile)
      {
        Get.showSnackbar(const GetSnackBar(
          message: 'No Internet Connection',
          duration: Duration(seconds: 5),
        ));
        return;
      }
    isDownloading.value=true;
    logger.e("Link of file to be downloaded is ${file.link}");
    try {
  http.Response response=await download(url: file.link!);

      if(response.statusCode==200||response.statusCode==201)
      {
 //logger.i(response.bodyBytes);
      final directory = await getApplicationDocumentsDirectory();
    final filesDirectory = await Directory('${directory.path}/files').create(recursive: true);
    

    String filePath='${filesDirectory.path}/${file.title!}_${file.createdAt}.pdf';

   
    logger.i("Length of key is ${key.length} and key is ${key.bytes}");
   
    //final encryptor=Encrypter(AES(key,padding: null));
   final encryptor=Encrypter(AES(Key.fromBase64("Eur91rZ/EKnHbkijT65vK2DKPxoRpASD60SlHkJdXK0="),mode: AESMode.cbc));
    
    // logger.i("Unencrypted bytes: ${response.bodyBytes}");
    // logger.i("Unencrypted bytes length: ${response.bodyBytes.length}");
    final encryptedBytes = encryptor.encryptBytes(response.bodyBytes,iv: iv,);
    //final decryptedBytes = encryptor.decryptBytes(encryptedBytes,iv: iv,associatedData: encryptedBytes.bytes);
   // Directory generalDownloadDir =await Directory('/storage/emulated/0/Download/mypdfs').create(recursive: true);
   // final unencryptefFile=File(/*"/storage/emulated/0/Download/mypdfs/${file.title!}.pdf"*/filePath);
  //File writtenFile=  await unencryptefFile.writeAsBytes(response.bodyBytes);
  //logger.i(await writtenFile.length());

  //logger.i(response.bodyBytes);
  logger.i("Mime type of saved file is ${lookupMimeType(filePath)}");
   // encrypted file
    final encryptedFile=File(filePath);
    await encryptedFile.writeAsBytes(List.from(encryptedBytes.bytes),flush: true);
    isDownloading.value=false;
    changeDownloadStatus(true);

      }
} on Exception catch (e) {
  logger.i(e);
      Get.showSnackbar(GetSnackBar(
        message: 'Cannot download pdf, check your internet connection',
      ));
}
   
    
    
  }



 

Future<File> getDecryptedFile({required String name,required String createdAt}) async
{
     final directory = await getApplicationDocumentsDirectory();
    final filesDirectory = Directory('${directory.path}/files');
    String filePath='${filesDirectory.path}/${name}_$createdAt.pdf';
    File encryptedfile=File(filePath );
    bool isPresent=await encryptedfile.exists();
    logger.i("File at path $filePath is present $isPresent");
   
    
      Uint8List encryptedBytes=await encryptedfile.readAsBytes();
      //logger.i("encrypted bytes: ${encryptedBytes}");
      
      logger.i("Length of key is ${key.length} and key is ${key.bytes}");

     

   
    logger.i('Path of encrypted file obtained is ${encryptedfile.path}');
    // final encryptor=Encrypter(AES(key,padding: null));
     final encryptor=Encrypter(AES(Key.fromBase64("Eur91rZ/EKnHbkijT65vK2DKPxoRpASD60SlHkJdXK0="),mode: AESMode.cbc));
    final decryptedBytes=encryptor.decryptBytes(Encrypted(encryptedBytes),iv: iv,);
    //logger.i("Length of decrypted bytes are ${decryptedBytes.length}");

    //logger.i(await encryptedfile..readAsString());

    //return encryptedfile;

     final decryptedFilePath = '${filesDirectory.path}/${name}_${createdAt}_decryptedfile.pdf';
     final decryptedFile = File(decryptedFilePath);
    

     await decryptedFile.writeAsBytes(decryptedBytes,flush: true/*Uint8List.fromList(decryptedBytes)*/);
     return decryptedFile;//Uint8List.fromList(decryptedBytes);
    
   
}
 Future<dynamic> download({required String url}) async
{
  try{
    // String token=url. substring(url.indexOf("token")+7,url.indexOf("_gl"));
    // String alt=url.substring( url.indexOf("alt=")+5,url.indexOf("token="));
    // String gl=url.substring(url.indexOf("_gl=")+5);
    // Map<String,String> query={
    //   "token":token,
    //   "alt":alt,
    //   "_gl":gl
    // };
    // Response response =await Dio().get(url.substring(0,url.indexOf("?")),options: Options(responseType: ResponseType.bytes,
    //         followRedirects: false,contentType: "application/pdf"),queryParameters: query);
    // logger.i(response.data);
    var client=http.Client();
    http.Response response= await http.get(Uri.parse(url),headers: {/*"Content-Type": "application/pdf",*/"Response-Type": "bytes"});
    
    changeDownloadStatus(true);
    return response;
  }
  on Exception catch(e)
  {
    logger.e(e.toString());
  }
}
void deleteTempFile({required String name,required String createdAt}) async
{
  final directory = await getApplicationDocumentsDirectory();
    final filesDirectory = Directory('${directory.path}/files');
    final decryptedFilePath = '${filesDirectory.path}/${name}_${createdAt}_decrypted.pdf';
    final decryptedFile = File(decryptedFilePath);
    if(await decryptedFile.exists())
    decryptedFile.delete(recursive: false);
}
void deleteFile({required String name,required String createdAt}) async
{

  final directory = await getApplicationDocumentsDirectory();
    final filesDirectory = Directory('${directory.path}/files');
    String filePath='${filesDirectory.path}/${name}_$createdAt.pdf';
    File encryptedfile=File(filePath );
    encryptedfile.delete(recursive: false);
    changeDownloadStatus(false);
}
}

