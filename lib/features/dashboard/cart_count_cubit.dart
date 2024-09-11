
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CartCountState extends Equatable {
  const CartCountState();

  @override
  List<Object> get props => [];
}

class CartCountInitial extends CartCountState {}

class CartCountLoading extends CartCountState {}

class CartCountLoaded extends CartCountState {
  final int cartCount;

  const CartCountLoaded(this.cartCount);

  @override
  List<Object> get props => [cartCount];
}

class CartCountError extends CartCountState {
  final String error;

  const CartCountError(this.error);

  @override
  List<Object> get props => [error];
}

class CartCountCubit extends Cubit<CartCountState> {
  CartCountCubit() : super(CartCountInitial());

  Future<void> fetchCartCount() async {
    final String url = 'http://backend.quokka-mesh.com/api/Statistics/Admin/CountAllCart';

    try {
      emit(CartCountLoading());
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final int cartCount = responseBody['numbers'];
        emit(CartCountLoaded(cartCount));
      } else {
        emit(CartCountError('Failed to load cart count. Status code: ${response.statusCode}'));
      }
    } catch (e) {
      emit(CartCountError('Error loading cart count: $e'));
    }
  }
}
