
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CategoryCountState extends Equatable {
  const CategoryCountState();

  @override
  List<Object> get props => [];
}

class CategoryCountInitial extends CategoryCountState {}

class CategoryCountLoading extends CategoryCountState {}

class CategoryCountLoaded extends CategoryCountState {
  final int categoryCount;

  const CategoryCountLoaded(this.categoryCount);

  @override
  List<Object> get props => [categoryCount];
}

class CategoryCountError extends CategoryCountState {
  final String error;

  const CategoryCountError(this.error);

  @override
  List<Object> get props => [error];
}

class CategoryCountCubit extends Cubit<CategoryCountState> {
  CategoryCountCubit() : super(CategoryCountInitial());

  Future<void> fetchCategoryCount() async {
    final String url = 'http://quokkamesh-001-site1.etempurl.com/api/Statistics/Admin/CountAllCategory';

    try {
      emit(CategoryCountLoading());
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final int categoryCount = responseBody['numbers'];
        emit(CategoryCountLoaded(categoryCount));
        print("Api Response====>>>>>> ${categoryCount}");
      } else {
        emit(CategoryCountError('Failed to load category count. Status code: ${response.statusCode}'));
      }
    } catch (e) {
      emit(CategoryCountError('Error loading category count: $e'));
    }
  }
}
