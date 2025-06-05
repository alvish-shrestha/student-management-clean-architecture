import 'package:equatable/equatable.dart';
import 'package:student_management/features/batch/domain/entity/batch_entity.dart';
import 'package:student_management/features/course/domain/entity/course_entity.dart';

class StudentEntity extends Equatable {
  final String? studentId;
  final String firstName;
  final String lastName;
  final BatchEntity batch;
  final List<CourseEntity> courses;
  final String username;
  final String password;

  const StudentEntity({
    this.studentId,
    required this.firstName,
    required this.lastName,
    required this.batch,
    required this.courses,
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [
    studentId,
    firstName,
    lastName,
    batch,
    courses,
    username,
    password,
  ];
}
