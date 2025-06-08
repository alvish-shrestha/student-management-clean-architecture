import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:student_management/app/use_case/usecase.dart';
import 'package:student_management/core/error/failure.dart';
import 'package:student_management/features/course/domain/repository/course_repository.dart';

class DeleteCourseParams extends Equatable {
  final String courseId;
  const DeleteCourseParams({required this.courseId});

  const DeleteCourseParams.empty() : courseId = "_empty.string";

  @override
  List<Object?> get props => [courseId];
}

class DeleteCourseUseCase implements UsecaseWithParams<void, DeleteCourseParams> {
  final ICourseRepository courseRepository;
  const DeleteCourseUseCase({required this.courseRepository});
  
  @override
  Future<Either<Failure, void>> call(DeleteCourseParams params) {
    return courseRepository.deleteCourse(params.courseId);
  }
}
