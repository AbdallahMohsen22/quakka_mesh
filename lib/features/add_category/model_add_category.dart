
import 'package:image_picker/image_picker.dart';

class AddCategoryModel {
  final String title;
  final XFile image;

  AddCategoryModel({
    required this.title,
    required this.image,
  });

  Future<Map<String, String>> toFormData() async {
    return {
      'Titel': title,
      // 'Image': image.path, // We handle the image differently
    };
  }
}
