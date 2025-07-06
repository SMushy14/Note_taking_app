import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../data/auth_repository.dart';

class AuthState {
  final User? user;
  final String? error;
  final bool isLoading;
  AuthState({this.user, this.error, this.isLoading = false});

  AuthState copyWith({User? user, String? error, bool? isLoading}) {
    return AuthState(
      user: user ?? this.user,
      error: error,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepo;

  AuthCubit(this.authRepo) : super(AuthState()) {
    authRepo.userStream.listen((user) {
      emit(AuthState(user: user));
    });
  }

  Future<void> signUp(String email, String password) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await authRepo.signUp(email, password);
      emit(state.copyWith(isLoading: false));
    } on FirebaseAuthException catch (e) {
      emit(state.copyWith(error: e.code, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: 'unknown-error', isLoading: false));
    }
  }

  Future<void> login(String email, String password) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await authRepo.login(email, password);
      emit(state.copyWith(isLoading: false));
    } on FirebaseAuthException catch (e) {
      emit(state.copyWith(error: e.code, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: 'unknown-error', isLoading: false));
    }
  }

  Future<void> logout() async {
    await authRepo.logout();
    emit(AuthState(user: null, error: null));
  }
}
