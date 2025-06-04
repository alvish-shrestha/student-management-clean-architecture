import 'package:equatable/equatable.dart';

class StudentEntity extends Equatable {
  final String? studentId;
  final String studentName;

  const StudentEntity({this.studentId, required this.studentName});

  @override
  List<Object?> get props => [studentId, studentName];
}
