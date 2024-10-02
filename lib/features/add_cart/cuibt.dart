

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'cart_model.dart';

class AddCartState {}

class AddCartInitial extends AddCartState {}

class AddCartLoading extends AddCartState {}

class AddCartSuccess extends AddCartState {}

class AddCartFailure extends AddCartState {
  final String error;

  AddCartFailure(this.error);
}

class AddCartCubit extends Cubit<AddCartState> {
  AddCartCubit() : super(AddCartInitial());

  void addCart(AddCartModel request, int categoryId) async {
    emit(AddCartLoading());
    try {
      var uri = Uri.parse('http://backend.quokka-mesh.com/api/Cart/Admin/AddCart?categoryId=$categoryId');
      var requestMultipart = http.MultipartRequest('POST', uri);

      // Add text fields
      var fields = await request.toFormData();
      fields.forEach((key, value) {
        requestMultipart.fields[key] = value;
      });

      // Add image file
      var imageFile = await http.MultipartFile.fromPath('ImageDesign', request.imageDesign.path);
      requestMultipart.files.add(imageFile);

      // Send request
      var response = await requestMultipart.send();
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        emit(AddCartSuccess());
        print("Api Response AddCart======>>>>>>>> ${responseBody}");
      } else {
        emit(AddCartFailure('Failed to add cart'));
      }
    } catch (e) {
      emit(AddCartFailure(e.toString()));
    }
  }
}
