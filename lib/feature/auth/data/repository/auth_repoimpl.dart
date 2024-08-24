import 'package:fpdart/src/either.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;
import 'package:zidiointernshipblogapp/core/error/Exception.dart';
import 'package:zidiointernshipblogapp/core/error/failures.dart';
import 'package:zidiointernshipblogapp/core/network/connection_checker.dart';
import 'package:zidiointernshipblogapp/feature/auth/data/dataSource/auth_data.dart';
import 'package:zidiointernshipblogapp/core/common/entity/user.dart';
import 'package:zidiointernshipblogapp/feature/auth/data/model/user_model.dart';
import 'package:zidiointernshipblogapp/feature/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthData remoteDataSource;
  final ConnectionChecker connectionChecker;
  const AuthRepositoryImpl(this.remoteDataSource, this.connectionChecker);
  @override
  Future<Either<Failures, User>> currentUser() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        final session = remoteDataSource.currentUserSession;
        if (session == null) {
          return left(Failures("User not logged in!"));
        }
        return right(UserModel(
            id: session.user.id, email: session.user.email ?? '', name: ''));
      }
      final user = await remoteDataSource.getCurrentuserData();
      if (user == null) {
        return left(Failures("User not logged in!"));
      }
      return right(user);
    } on ServerException catch (e) {
      return left(Failures(e.message));
    }
  }

  @override
  Future<Either<Failures, User>> signInWithEmailPassword(
      {required String email, required String password}) async {
    return _getUser(
      () async => await remoteDataSource.SignInWithEmailPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failures, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDataSource.SignUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

  Future<Either<Failures, User>> _getUser(
    Future<User> Function() fn,
  ) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failures('No internet connection!'));
      }
      final user = await fn();
      return right(user);
    } on sb.AuthException catch (e) {
      return left(Failures(e.message));
    } on ServerException catch (e) {
      return left(Failures(e.message));
    }
  }
}
