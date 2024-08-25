
import 'package:image_picker/image_picker.dart';

class AddCartModel {
  final String title;
  final XFile imageDesign;
  final String sender;
  final String receiver;
  final String content;
  final String created;
  final int numberOfPoints;
  final bool isPremium;

  AddCartModel({
    required this.title,
    required this.imageDesign,
    required this.sender,
    required this.receiver,
    required this.content,
    required this.created,
    required this.numberOfPoints,
    required this.isPremium,
  });

  Future<Map<String, String>> toFormData() async {
    return {
      'Titel': title,
      'Sender': sender,
      'Receiver': receiver,
      'Content': content,
      'Created': created,
      'NumberOfPoint': numberOfPoints.toString(),
      'IsPremium': isPremium.toString(),
    };
  }
}
