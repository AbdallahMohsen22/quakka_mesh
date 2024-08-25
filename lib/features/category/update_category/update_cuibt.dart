import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';


class CategoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CategoryUpdating extends CategoryState {}

class CategoryUpdated extends CategoryState {
  final String message;

  CategoryUpdated(this.message);

  @override
  List<Object?> get props => [message];
}

class CategoryUpdateError extends CategoryState {
  final String error;

  CategoryUpdateError(this.error);

  @override
  List<Object?> get props => [error];
}

class UpdateCategoryCubit extends Cubit<CategoryState> {
  UpdateCategoryCubit() : super(CategoryUpdating());

  Future<void> updateCategory({
    required int id,
    required String title,
    required File image,
  }) async {
    final String url = 'http://quokkamesh-001-site1.etempurl.com/api/Category/Admin/UpdateCategory?id=$id';

    try {
      emit(CategoryUpdating());

      var request = http.MultipartRequest('PUT', Uri.parse(url))
        ..fields['Titel'] = title;

      request.files.add(await http.MultipartFile.fromPath(
        'Image',
        image.path,
        filename: basename(image.path),
      ));

      var response = await request.send();

      if (response.statusCode == 200) {
        emit(CategoryUpdated('Cart updated successfully'));
      } else {
        emit(CategoryUpdateError('Failed to update cart. Status code: ${response.statusCode}'));
      }
    } catch (e) {
      emit(CategoryUpdateError('Error updating cart: $e'));
    }
  }
}