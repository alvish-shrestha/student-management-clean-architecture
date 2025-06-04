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
  final String studentName;

  StudentHiveModel({String? studentId, required this.studentName})
    : studentId = studentId ?? const Uuid().v4();

  // Initial Constructor
  const StudentHiveModel.initial() : studentId = "", studentName = "";

  // From Entity
  factory StudentHiveModel.fromEntity(StudentEntity entity) {
    return StudentHiveModel(
      studentId: entity.studentId,
      studentName: entity.studentName,
    );
  }

  // To Entity
  StudentEntity toEntity() {
    return StudentEntity(studentId: studentId, studentName: studentName);
  }

  // To Entity List
  static List<StudentHiveModel> fromEntityList(List<StudentEntity> entityList) {
    return entityList
        .map((entity) => StudentHiveModel.fromEntity(entity))
        .toList();
  }

  @override
  List<Object?> get props => [studentId, studentName];
}
