import 'package:fpdart/fpdart.dart';
import 'package:zidiointernshipblogapp/core/error/failures.dart';
import 'package:zidiointernshipblogapp/feature/auth/domain/entity/user.dart';

abstract interface class AuthRepository {
  Future<Either<Failures, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failures, User>> signInWithEmailPassword({
    required String email,
    required String password,
  });
}
