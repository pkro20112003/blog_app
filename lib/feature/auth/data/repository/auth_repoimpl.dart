import 'package:fpdart/src/either.dart';
import 'package:zidiointernshipblogapp/core/error/Exception.dart';
import 'package:zidiointernshipblogapp/core/error/failures.dart';
import 'package:zidiointernshipblogapp/feature/auth/data/dataSource/auth_data.dart';
import 'package:zidiointernshipblogapp/feature/auth/domain/entity/user.dart';
import 'package:zidiointernshipblogapp/feature/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthData remoteDataSource;
  const AuthRepositoryImpl(this.remoteDataSource);
  @override
  Future<Either<Failures, User>> signInWithEmailPassword(
      {required String email, required String password}) {
    // TODO: implement signInWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.SignUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      );
      return right(user);
    } on ServerException catch (e) {
      return left(Failures(e.message));
    }
  }
}
