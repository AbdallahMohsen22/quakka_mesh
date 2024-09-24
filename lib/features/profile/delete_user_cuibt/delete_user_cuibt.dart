import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

import 'delete_user_state.dart';

class DeleteUserCubit extends Cubit<DeleteUserState> {
  DeleteUserCubit() : super(DeleteUserInitial());

  Future<void> deleteUser(String userId) async {
    emit(DeleteUserLoading());
    try {
      final url = 'http://backend.quokka-mesh.com/api/Auth/DeleteUser?userId=$userId';
      final response = await http.delete(Uri.parse(url));

      if (response.statusCode == 200) {
        emit(DeleteUserSuccess());
      } else {
        emit(DeleteUserFailure('Failed to delete the user'));
      }
    } catch (e) {
      emit(DeleteUserFailure(e.toString()));
    }
  }
}
