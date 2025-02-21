import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  final ImagePicker picker = ImagePicker();
  File? userImage;

  Future<File?> userPickImageFrom(ImageSource source) async {
    final pickedImage =
        await picker.pickImage(source: source, imageQuality: 60);
    if (pickedImage == null) {
      return null;
    }
    userImage = File(pickedImage.path);
    return userImage;
  }

  
}
