import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/utils/Printer.dart';

class FileProcess {
  static String? pdfUrl;
  static String? pdfName;
  static bool isFolderCreated = true;
  static Directory? directory;
  static Future<void> requestPermission() async {
    if (Platform.isAndroid || Platform.isIOS) {
      var status = await Permission.storage.request();
      if (status.isGranted) {
        Print('Permission granted; you can save the PDF file now.');
      } else {
       Print("Error");
      }
    }
  }
  static createPdf(String pdfUrl,pdfName) async {
    var base64 =pdfUrl
        ;
    var bytes = base64Decode(base64);
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/example.pdf");
    await file.writeAsBytes(bytes.buffer.asUint8List());
    Print("${output.path}.pdf");
    openFile("${output.path}.pdf",pdfName);
  }

  static checkDocumentFolder() async {
    try {
      if (!isFolderCreated) {
        directory = await getApplicationDocumentsDirectory();
        await directory!.exists().then((value) {
          if (value) directory!.create();
          isFolderCreated = true;
        });
      }
    } catch (e) {
      // print(e.toString());
    }
  }



  static Future<void> downloadAndSavePdf(String pdfUrl) async {
    await requestPermission();

      final appDir = await getApplicationDocumentsDirectory();
      final pdfPath = '${appDir.path}/downloaded_file.pdf';
      Uint8List bytes = base64.decode(pdfUrl);


      File file = File(pdfPath);
      await file.writeAsBytes(bytes);



      // You can now open, display, or use the downloaded PDF file as needed.

      // Handle the error, such as showing an error message.
      print('Downloaded');

  }

  static Future<File> downloadFile(pdfUrl, pdfName) async {
    final base64str = pdfUrl;
    Uint8List bytes = base64.decode(base64str);
    await checkDocumentFolder();
    String dir =
        "${directory!.path}/$pdfName.pdf";
    File file = File(dir);
    if (!file.existsSync()) file.create();
    await file.writeAsBytes(bytes);
    // Print("Downloaded");
    return file;
  }
  static void openFile( directory,pdfName,) async{
    final appDir = await getApplicationDocumentsDirectory();
    String dir =
        "${appDir.path}/$pdfName.pdf";
    OpenFile.open(dir);
  }
}