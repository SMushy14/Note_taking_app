import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../data/auth_repository.dart';

class AuthState {
  final User? user;
  final String? error;
  AuthState({this.user, this.error});
}

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepo;
  AuthCubit(this.authRepo) : super(AuthState()) {
    authRepo.userStream.listen((user) {
      emit(AuthState(user: user));
    });
  }

  Future<void> signUp(String email, String password) async {
    try {
      await authRepo.signUp(email, password);
    } on FirebaseAuthException catch (e) {
      emit(AuthState(error: e.code));
    } catch (e) {
      emit(AuthState(error: 'unknown-error'));
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await authRepo.login(email, password);
    } on FirebaseAuthException catch (e) {
      emit(AuthState(error: e.code));
    } catch (e) {
      emit(AuthState(error: 'unknown-error'));
    }
  }

Future<void> logout() async {
  await authRepo.logout();
  emit(AuthState(user: null, error: null));
}
}