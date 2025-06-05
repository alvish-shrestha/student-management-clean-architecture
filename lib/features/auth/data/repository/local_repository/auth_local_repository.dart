import 'package:dartz/dartz.dart';
import 'package:student_management/core/error/failure.dart';
import 'package:student_management/features/auth/data/data_source/local_datasource/auth_local_data_source.dart';
import 'package:student_management/features/auth/domain/entity/auth_entity.dart';
import 'package:student_management/features/auth/domain/repository/auth_repository.dart';

class AuthLocalRepository implements IAuthRepository {
  final AuthLocalDataSource _authLocalDataSource;

  AuthLocalRepository({required AuthLocalDataSource authLocalDataSource})
    : _authLocalDataSource = authLocalDataSource;

  @override
  Future<Either<Failure, void>> createStudent(AuthEntity student) async {
    try {
      _authLocalDataSource.createStudent(student);
      return (Right(null));
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, void>> deleteStudent(String id) async {
    try {
      _authLocalDataSource.deleteStudent(id);
      return Right(null);
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, List<AuthEntity>>> getStudents() async {
    try {
      final List<AuthEntity> students = await _authLocalDataSource
          .getStudents();
      return Right(students);
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }
}
