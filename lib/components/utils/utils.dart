import 'package:image_picker/image_picker.dart';

class Utils {
  // image picker for picking the profile picture
  pickImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: source);
    if (file != null) {
      // return type of read as Bytes is future, it will return uint8list
      return await file.readAsBytes();
    }
  }
}
