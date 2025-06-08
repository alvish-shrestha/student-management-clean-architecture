import 'package:equatable/equatable.dart';
import 'package:student_management/features/course/domain/entity/course_entity.dart';

class CourseViewState extends Equatable {
  final List<CourseEntity> courses;
  final bool isLoading;
  final String? error;

  const CourseViewState({
    required this.courses,
    required this.isLoading,
    this.error,
  });

  factory CourseViewState.initial() {
    return CourseViewState(courses: [], isLoading: false);
  }

  CourseViewState copyWith({
    List<CourseEntity>? courses,
    bool? isLoading,
    String? error,
  }) {
    return CourseViewState(
      courses: courses ?? this.courses,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [courses, isLoading, error];
}
