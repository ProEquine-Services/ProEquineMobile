import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageHelper {
  ImageHelper({ImagePicker? imagePicker, ImageCropper? imageCropper})
      : _imageCropper = imageCropper ?? ImageCropper(),
        _imagePicker = imagePicker ?? ImagePicker();

  final ImagePicker _imagePicker;
  final ImageCropper _imageCropper;

  Future<XFile?> pickImage({
    int imageQuality = 100,
    ImageSource source = ImageSource.gallery,
  }) async {
    final file = await _imagePicker.pickImage(
        source: source, imageQuality: imageQuality);
    if (file != null) return file;

    return file;
  }

  Future<CroppedFile?> crop(
          {required XFile file,
            CropAspectRatio? aspectRatio,
            int? maxWidth,
            int? maxHeight,
          CropStyle cropStyle = CropStyle.rectangle}) async =>
      await _imageCropper.cropImage(
          sourcePath: file.path,
          compressQuality: 100,
          cropStyle: cropStyle,
          uiSettings: [
            IOSUiSettings(),
            AndroidUiSettings(),
          ]);
}
