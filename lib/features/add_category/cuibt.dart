

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'model_add_category.dart';

class AddCategoryState {}

class AddCategoryInitial extends AddCategoryState {}

class AddCategoryLoading extends AddCategoryState {}

class AddCategorySuccess extends AddCategoryState {}

class AddCategoryFailure extends AddCategoryState {
  final String error;

  AddCategoryFailure(this.error);
}

class AddCategoryCubit extends Cubit<AddCategoryState> {
  AddCategoryCubit() : super(AddCategoryInitial());

  void addCategory(AddCategoryModel request) async {
    emit(AddCategoryLoading());
    try {
      var uri = Uri.parse('http://backend.quokka-mesh.com/api/Category/Admin/AddCategory');
      var requestMultipart = http.MultipartRequest('POST', uri);

      // Add text fields
      var fields = await request.toFormData();
      fields.forEach((key, value) {
        requestMultipart.fields[key] = value;
      });

      // Add image file
      var imageFile = await http.MultipartFile.fromPath('Image', request.image.path);
      requestMultipart.files.add(imageFile);

      // Send request
      var response = await requestMultipart.send();
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        emit(AddCategorySuccess());
        if (kDebugMode) {
          print("responseBody====>>>>$responseBody");
        }
      } else {
        emit(AddCategoryFailure('Failed to add category'));
      }
    } catch (e) {
      emit(AddCategoryFailure(e.toString()));
    }
  }
}
