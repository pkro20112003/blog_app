import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zidiointernshipblogapp/feature/auth/domain/entity/user.dart';
import 'package:zidiointernshipblogapp/feature/auth/domain/usecases/User_Sign_Up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  AuthBloc({required UserSignUp userSignUp})
      : _userSignUp = userSignUp,
        super(AuthInitial()) {
    on<AuthSignUp>((event, emit) async {
      emit(AuthLoading());
      final res = await _userSignUp(UserSignUpParams(
        email: event.email,
        password: event.password,
        name: event.name,
      ));
      res.fold(
        (failure) => emit(AuthFailure(failure.message)),
        (user) {
          emit(AuthSuccess(user));
        },
      );
    });
  }
}
