// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/src/either.dart';

import 'package:zidiointernshipblogapp/core/error/failures.dart';
import 'package:zidiointernshipblogapp/core/usecase/usecase.dart';
import 'package:zidiointernshipblogapp/feature/auth/domain/entity/user.dart';
import 'package:zidiointernshipblogapp/feature/auth/domain/repository/auth_repository.dart';

class UserSignUp implements Usecase<User, UserSignUpParams> {
  final AuthRepository authRepository;
  const UserSignUp(this.authRepository);
  @override
  Future<Either<Failures, User>> call(UserSignUpParams params) async {
    return await authRepository.signUpWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignUpParams {
  final String email;
  final String password;
  final String name;
  UserSignUpParams({
    required this.email,
    required this.password,
    required this.name,
  });
}
