
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_bloc/flutter_bloc.dart';

// Define Cart State
abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<dynamic> carts;

  const CartLoaded(this.carts);

  @override
  List<Object> get props => [carts];
}

class CartError extends CartState {
  final String error;

  const CartError(this.error);

  @override
  List<Object> get props => [error];
}

// Define Cart Cubit
class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartLoading());

  Future<void> fetchReceivedCarts(String userId) async {
    final String url = 'http://quokkamesh-001-site1.etempurl.com/api/SendCart/User/ViewMyCartrecevied?userId=$userId';

    try {
      emit(CartLoading());
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final List<dynamic> cartData = responseBody['cart'];
        emit(CartLoaded(cartData));
        print("Api Response ReceivedCarts ======>>>>${cartData}");
      } else {
        emit(CartError('Failed to load received carts. Status code: ${response.statusCode}'));
      }
    } catch (e) {
      emit(CartError('Error loading received carts: $e'));
    }
  }

  Future<void> fetchSentCarts(String userId) async {
    final String url = 'http://quokkamesh-001-site1.etempurl.com/api/SendCart/User/ViewMyCartsended?userId=$userId';

    try {
      emit(CartLoading());
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final List<dynamic> cartData = responseBody['cart'];
        emit(CartLoaded(cartData));
        print("Api Response SentCarts ======>>>>${cartData}");
      } else {
        emit(CartError('Failed to load sent carts. Status code: ${response.statusCode}'));
      }
    } catch (e) {
      emit(CartError('Error loading sent carts: $e'));
    }
  }
}
