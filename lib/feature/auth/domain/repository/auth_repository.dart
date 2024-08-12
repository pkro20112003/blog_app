import 'package:fpdart/fpdart.dart';
import 'package:zidiointernshipblogapp/core/error/failures.dart';

abstract interface class AuthRepository {
  Future<Either<Failures, String>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failures, String>> signInWithEmailPassword({
    required String email,
    required String password,
  });
}
