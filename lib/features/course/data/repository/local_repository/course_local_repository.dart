import 'package:dartz/dartz.dart';
import 'package:student_management/core/error/failure.dart';
import 'package:student_management/features/course/data/data_source/local_datasource/course_local_data_source.dart';
import 'package:student_management/features/course/domain/entity/course_entity.dart';
import 'package:student_management/features/course/domain/repository/course_repository.dart';

class CourseLocalRepository implements ICourseRepository {
  final CourseLocalDataSource _courseLocalDataSource;

  CourseLocalRepository({required CourseLocalDataSource courseLocalDataSource})
    : _courseLocalDataSource = courseLocalDataSource;

  @override
  Future<Either<Failure, void>> createCourse(CourseEntity course) async {
    try {
      _courseLocalDataSource.createCourse(course);
      return (Right(null));
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCourse(String id) async {
    try {
      _courseLocalDataSource.deleteCourse(id);
      return Right(null);
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, List<CourseEntity>>> getCourses() async {
    try {
      final List<CourseEntity> courses = await _courseLocalDataSource
          .getCourses();
      return Right(courses);
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }
}
