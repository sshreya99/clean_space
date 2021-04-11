import 'dart:io';
import 'package:image_picker/image_picker.dart';
class ImageService {
  static final picker = ImagePicker();

  static Future<File> openCameraForImage() async {
    try {
      final pickedFile = await picker.getImage(
          source: ImageSource.camera,
          maxHeight: 500,
          maxWidth: 500,
          preferredCameraDevice: CameraDevice.front);
      if (pickedFile == null) throw Exception("File is not available!");
      return File(pickedFile.path);
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<File> openGalleryForImage() async {
    try {
      final pickedFile = await picker.getImage(
          source: ImageSource.gallery,
          maxHeight: 500,
          maxWidth: 500,
          preferredCameraDevice: CameraDevice.front);
      if (pickedFile == null) throw Exception("File is not available!");
      return File(pickedFile.path);
    } catch (e) {
      print(e);
      return null;
    }
  }


}