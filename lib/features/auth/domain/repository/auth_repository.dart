import 'package:dartz/dartz.dart';
import 'package:student_management/core/error/failure.dart';
import 'package:student_management/features/auth/domain/entity/auth_entity.dart';

abstract interface class IAuthRepository {
  Future<Either<Failure, List<AuthEntity>>> getStudents();
  Future<Either<Failure, void>> createStudent(AuthEntity student);
  Future<Either<Failure, void>> deleteStudent(String id);
}
