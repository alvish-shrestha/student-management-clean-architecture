import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:student_management/app/constant/hive/hive_table_constant.dart';
import 'package:student_management/features/auth/domain/entity/student_entity.dart';
import 'package:uuid/uuid.dart';

part "student_hive_model.g.dart";

@HiveType(typeId: HiveTableConstant.courseTableId)
class StudentHiveModel extends Equatable {
  @HiveField(0)
  final String? studentId;
  @HiveField(1)
  final String firstName;
  @HiveField(2)
  final String lastName;
  @HiveField(3)
  final String phoneNumber;
  @HiveField(4)
  final String username;
  @HiveField(5)
  final String password;

  StudentHiveModel({
    String? studentId,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.username,
    required this.password,
  }) : studentId = studentId ?? const Uuid().v4();

  // Initial Constructor
  const StudentHiveModel.initial()
    : studentId = "",
      firstName = "",
      lastName = "",
      phoneNumber = "",
      username = "",
      password = "";

  // From Entity
  factory StudentHiveModel.fromEntity(StudentEntity entity) {
    return StudentHiveModel(
      studentId: entity.studentId,
      firstName: entity.firstName,
      lastName: entity.lastName,
      phoneNumber: entity.phoneNumber,
      username: entity.username,
      password: entity.password,
    );
  }

  // To Entity
  StudentEntity toEntity() {
    return StudentEntity(
      studentId: studentId,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      username: username,
      password: password,
    );
  }

  // To Entity List
  static List<StudentHiveModel> fromEntityList(List<StudentEntity> entityList) {
    return entityList
        .map((entity) => StudentHiveModel.fromEntity(entity))
        .toList();
  }

  @override
  List<Object?> get props => [
    studentId,
    firstName,
    lastName,
    phoneNumber,
    username,
    password,
  ];
}
