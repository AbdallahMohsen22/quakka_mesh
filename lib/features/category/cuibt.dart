// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// import 'category_model.dart';
//
// // Define states
// abstract class CategoryState extends Equatable {
//   const CategoryState();
//
//   @override
//   List<Object> get props => [];
// }
//
// class CategoryInitial extends CategoryState {}
//
// class CategoryLoading extends CategoryState {}
//
// class CategoryLoaded extends CategoryState {
//   final List<Category> categories;
//
//   const CategoryLoaded(this.categories);
//
//   @override
//   List<Object> get props => [categories];
// }
//
// class CategoryError extends CategoryState {
//   final String message;
//
//   const CategoryError(this.message);
//
//   @override
//   List<Object> get props => [message];
// }
//
// // Define Cubit
// class CategoryCubit extends Cubit<CategoryState> {
//   CategoryCubit() : super(CategoryInitial());
//
//   void fetchCategories() async {
//     emit(CategoryLoading());
//     try {
//       final response = await http.get(Uri.parse('http://backend.quokka-mesh.com/api/Category/Admin/GetAllCategory'));
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//
//         List<Category> categories = (data['categoey'] as List).map((json) => Category.fromJson(json)).toList();
//         print("API Respponse====>>>>> ${categories[categories.length].isActive}");
//         emit(CategoryLoaded(categories));
//       } else {
//         emit(CategoryError('Failed to load categories'));
//       }
//     } catch (e) {
//       emit(CategoryError('Failed to load categories'));
//     }
//   }
// }

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'category_model.dart';

// State
abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<Category> categories;

  const CategoryLoaded(this.categories);

  @override
  List<Object> get props => [categories];
}

class CategoryError extends CategoryState {
  final String error;

  const CategoryError(this.error);

  @override
  List<Object> get props => [error];
}


class DeleteCategoryLoading extends CategoryState {}
class DeleteCategoryLoaded extends CategoryState {}
class DeleteCategoryError extends CategoryState {
  final String error;

  const DeleteCategoryError(this.error);

  @override
  List<Object> get props => [error];
}


// Cubit
class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryLoading());

  Future<void> fetchCategories() async {
    final String url = 'http://backend.quokka-mesh.com/api/Category/Admin/GetAllCategory';

    try {
      emit(CategoryLoading());
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> parsed = json.decode(response.body);
        final List<dynamic> categoryJson = parsed['categoey']; // correct key 'categoey'
        final List<Category> categories = categoryJson.map((json) => Category.fromJson(json)).toList();
        // Filter categories where isActive is true
        final List<Category> activeCategories = categories.where((category) => category.isActive!).toList();
        emit(CategoryLoaded(activeCategories));
        print("Api Response====>>>${categoryJson}");
      } else {
        emit(CategoryError('Failed to load categories'));
      }
    } catch (e) {
      emit(CategoryError('Error: $e'));
    }
  }

  void deleteCategory(int id) async {
    emit(CategoryLoading());
    try {
      final response = await http.delete(
        Uri.parse('http://backend.quokka-mesh.com/api/Category/Admin/DeleteCategory?id=$id'),
      );
      if (response.statusCode == 200) {

        print("Api Response+++++++>>>>>>>>>>>Category deleted successfully");
        emit(DeleteCategoryLoaded());
      } else {
        emit(DeleteCategoryError('Failed to delete Category'));
      }
    } catch (e) {
      emit(DeleteCategoryError(e.toString()));
    }
  }
}
