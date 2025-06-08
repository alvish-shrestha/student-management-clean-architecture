import 'package:equatable/equatable.dart';

sealed class CourseViewEvent extends Equatable {
  const CourseViewEvent();

  @override
  List<Object> get props => [];
}

final class LoadCourses extends CourseViewEvent {}

final class AddCourse extends CourseViewEvent {
  final String courseName;
  const AddCourse(this.courseName);

  @override
  List<Object> get props => [courseName];
}

final class DeleteCourse extends CourseViewEvent {
  final String courseId;

  const DeleteCourse(this.courseId);

  @override
  List<Object> get props => [courseId];
}
