import 'package:dartz/dartz.dart';
import 'package:student_management/core/error/failure.dart';

// use case with parameters - takes input and returns a result or failure
abstract interface class UsecaseWithParams<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

// use case without parameters - takes input and returns a result or failure
abstract interface class UsecaseWithoutParams<SuccessType> {
  Future<Either<Failure, SuccessType>> call();
}
