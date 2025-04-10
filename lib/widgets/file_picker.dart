import 'package:file_picker/file_picker.dart';
import 'dart:io';

String? fileName;
Future<File?> filePicker() async {
  final pickedFile = await FilePicker.platform.pickFiles(
    allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png'],
    type: FileType.custom,
    withData: false,
    allowMultiple: false,
  );

  if (pickedFile == null || pickedFile.files.single.path == null) {
    throw Exception("No file selected.");
  }

  final fileSize = pickedFile.files.single.size;
  if (fileSize > 3 * 1024 * 1024) {
    throw Exception("File is too large. Must be under 3MB.");
  }
  fileName = pickedFile.files.single.name;
  return File(pickedFile.files.single.path!);
}
