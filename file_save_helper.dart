import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

class FileSaveHelper {
  static Future<String> saveFile(Uint8List bytes, String fileName) async {
    final directory = await getExternalStorageDirectory();
    final filePath = '${directory!.path}/$fileName';
    final File file = File(filePath);
    await file.writeAsBytes(bytes);
    return filePath;
  }
}