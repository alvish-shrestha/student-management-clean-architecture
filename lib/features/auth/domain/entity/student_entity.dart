import 'package:equatable/equatable.dart';

class StudentEntity extends Equatable {
  final String? studentId;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String username;
  final String password;

  const StudentEntity({
    this.studentId,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [studentId, firstName, lastName, phoneNumber, username, password];
}
