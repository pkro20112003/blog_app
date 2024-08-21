import 'package:fpdart/fpdart.dart';
import 'package:zidiointernshipblogapp/core/error/failures.dart';

abstract interface class Usecase<SuccessType, Params> {
  Future<Either<Failures, SuccessType>> call(Params params);
}

class Noparams {}
