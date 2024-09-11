import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';


class CartState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CartUpdating extends CartState {}

class CartUpdated extends CartState {
  final String message;

  CartUpdated(this.message);

  @override
  List<Object?> get props => [message];
}

class CartUpdateError extends CartState {
  final String error;

  CartUpdateError(this.error);

  @override
  List<Object?> get props => [error];
}

class UpdateCartCubit extends Cubit<CartState> {
  UpdateCartCubit() : super(CartUpdating());

  Future<void> updateCart({
    required int id,
    required String title,
    required File imageDesign,
    required String sender,
    required String receiver,
    required String content,
    required DateTime created,
    required int numberOfPoint,
    required bool isPremium,
  }) async {
    final String url = 'http://backend.quokka-mesh.com/api/Cart/Admin/UpdateCart?id=$id';

    try {
      emit(CartUpdating());

      var request = http.MultipartRequest('PUT', Uri.parse(url))
        ..fields['Titel'] = title
        ..fields['Sender'] = sender
        ..fields['Receiver'] = receiver
        ..fields['Content'] = content
        ..fields['Created'] = created.toIso8601String()
        ..fields['NumberOfPoint'] = numberOfPoint.toString()
        ..fields['IsPremium'] = isPremium.toString();

      request.files.add(await http.MultipartFile.fromPath(
        'ImageDesign',
        imageDesign.path,
        filename: basename(imageDesign.path),
      ));

      var response = await request.send();

      if (response.statusCode == 200) {
        emit(CartUpdated('Cart updated successfully'));
      } else {
        emit(CartUpdateError('Failed to update cart. Status code: ${response.statusCode}'));
      }
    } catch (e) {
      emit(CartUpdateError('Error updating cart: $e'));
    }
  }
}