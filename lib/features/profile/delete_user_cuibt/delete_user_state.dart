abstract class DeleteUserState {}

class DeleteUserInitial extends DeleteUserState {}

class DeleteUserLoading extends DeleteUserState {}

class DeleteUserSuccess extends DeleteUserState {}

class DeleteUserFailure extends DeleteUserState {
  final String error;

  DeleteUserFailure(this.error);
}
