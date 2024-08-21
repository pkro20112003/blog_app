import 'package:fpdart/fpdart.dart';
import 'package:zidiointernshipblogapp/core/error/failures.dart';
import 'package:zidiointernshipblogapp/core/common/entity/user.dart';
import 'package:zidiointernshipblogapp/core/usecase/usecase.dart';
import 'package:zidiointernshipblogapp/feature/auth/domain/repository/auth_repository.dart';

class CurrentUser implements Usecase<User, Noparams> {
  final AuthRepository authRepository;
  CurrentUser(this.authRepository);

  @override
  Future<Either<Failures, User>> call(Noparams params) async {
    return await authRepository.currentUser();
  }
}
