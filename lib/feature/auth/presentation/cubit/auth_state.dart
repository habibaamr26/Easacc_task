abstract class GoogleAuthState {}

class GoogleAuthInitial extends GoogleAuthState {}

class GoogleAuthLoading extends GoogleAuthState {}

class GoogleAuthSuccess extends GoogleAuthState {}

class GoogleAuthFailure extends GoogleAuthState {
  final String message;
  GoogleAuthFailure(this.message);
}
