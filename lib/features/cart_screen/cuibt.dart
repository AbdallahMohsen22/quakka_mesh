
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../../core/network/api_constants.dart';
import '../../core/shared_constabts.dart';
import 'model.dart'; // Import your Cart model

class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartSuccess extends CartState {
  final List<Cart> carts;

  CartSuccess(this.carts);
}

class CartFailure extends CartState {
  final String error;

  CartFailure(this.error);
}

////////////////////////////////////////////

class DeleteCategoryInitial extends CartState {}

class DeleteCategoryLoading extends CartState {}

class DeleteCategorySuccess extends CartState {
}

class DeleteCategoryFailure extends CartState {
  final String error;

  DeleteCategoryFailure(this.error);
}


class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  void fetchCarts(int categoryId) async {
    emit(CartLoading());
    try {
      var response = await http.get(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.categoryGetAllCart}?categoryId=$categoryId'));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        List<dynamic> cartData = data['cart'];
        List<Cart> carts = cartData.map((item) => Cart.fromJson(item)).toList();
        emit(CartSuccess(carts));
        print("Api Response carts =====>>>>> ${cartData}");

      } else {
        emit(CartFailure('Failed to fetch carts'));
      }
    } catch (e) {
      emit(CartFailure(e.toString()));
    }
  }


  Future<void> deleteCategory(int categoryId) async {
    emit(DeleteCategoryLoading());
    try {
    var url = 'http://backend.quokka-mesh.com/api/Category/Admin/DeleteCategory';
    final response = await http.delete(
      Uri.parse(url),

      body: {
        'id': categoryId,
      },
    );

    if (response.statusCode == 200) {
      emit(DeleteCategoryLoading());
      Constants.showToast(msg: 'Category deleted successfully',
          gravity: ToastGravity.BOTTOM,
          color: Colors.green);

    } else {
      emit(DeleteCategoryFailure('Failed to fetch carts'));
      Constants.showToast(msg: 'Cart added successfully',
          gravity: ToastGravity.BOTTOM,
          color: Colors.red);
    }
    } catch (e) {
      emit(CartFailure(e.toString()));
    }
  }


}
